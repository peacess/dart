import 'dart:async';
import 'dart:developer';

import 'package:grpc/grpc.dart' hide ClientChannel;
import 'package:grpc/grpc_connection_interface.dart' hide ClientChannel;
import 'package:grpc/src/shared/profiler.dart' show clientTimelineFilterKey;
import 'package:grpc/src/client/channel.dart' show ClientChannel;

// see: grpc-4.0.1/lib/src/client/channel.dart ClientChannelBase
abstract class ClientChannelBaseEx implements ClientChannel {
  // TODO(jakobr): Multiple connections, load balancing.
  late ClientConnection _connection;
  var _connected = false;
  bool _isShutdown = false;
  final StreamController<ConnectionState> _connectionStateStreamController = StreamController.broadcast();
  final void Function()? _channelShutdownHandler;

  ClientChannelBaseEx({void Function()? channelShutdownHandler}) : _channelShutdownHandler = channelShutdownHandler;

  @override
  Future<void> shutdown() async {
    if (_isShutdown) return;
    _isShutdown = true;
    if (_connected) {
      await _connection.shutdown();
      await _connectionStateStreamController.close();
    }
    _channelShutdownHandler?.call();
  }

  @override
  Future<void> terminate() async {
    _isShutdown = true;
    if (_connected) {
      await _connection.terminate();
      await _connectionStateStreamController.close();
    }
    _channelShutdownHandler?.call();
  }

  ClientConnection createConnection();

  /// Returns a connection to this [Channel]'s RPC endpoint.
  ///
  /// The connection may be shared between multiple RPCs.
  Future<ClientConnection> getConnection() async {
    if (_isShutdown) throw GrpcError.unavailable('Channel shutting down.');
    if (!_connected) {
      _connection = createConnection();
      _connection.onStateChanged = (state) {
        if (_connectionStateStreamController.isClosed) {
          return;
        }
        _connectionStateStreamController.add(state);
      };
      _connected = true;
    }
    return _connection;
  }

  @override
  ClientCall<Q, R> createCall<Q, R>(ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options) {
    final call = ClientCall(method, requests, options, isTimelineLoggingEnabled ? TimelineTask(filterKey: clientTimelineFilterKey) : null);
    getConnection().then((connection) {
      if (call.isCancelled) return;
      connection.dispatchCall(call);
    }, onError: (error) {
      _onConnectionError(error);
      call.onConnectionError(error);
    });
    return call;
  }

  //连接出错时，reset ConnectParameter
  void _onConnectionError(error) {
    _connected = false;
  }

  @override
  Stream<ConnectionState> get onConnectionStateChanged => _connectionStateStreamController.stream;
}
