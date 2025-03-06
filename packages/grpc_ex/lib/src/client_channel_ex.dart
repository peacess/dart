import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/connection.dart' show ClientConnection;
import 'package:grpc_ex/src/client_channel_base_ex.dart';
import 'package:grpc/src/client/http2_connection.dart' show Http2ClientConnection;

typedef ClientChannelParams = ({String host, int port, ChannelOptions options});

class ClientChannelEx extends ClientChannelBaseEx {
  List<ClientChannelParams> _params;
  int _currentIndex = 0;
  bool _isFirst = true;
  ClientChannelEx(this._params, {super.channelShutdownHandler});

  @override
  ClientConnection createConnection() {
    var p = nextClientChannelParams();
    return Http2ClientConnection(p.host, p.port, p.options);
  }

  ClientChannelParams nextClientChannelParams() {
    if (_isFirst) {
      _isFirst = false;
    } else {
      _currentIndex++;
    }
    if (_currentIndex >= _params.length) {
      _currentIndex = 0;
    }
    var p = _params[_currentIndex];
    return p;
  }

  ClientChannelParams currentClientChannelParams() {
    if (_currentIndex >= _params.length) {
      _currentIndex = 0;
    }
    return _params[_currentIndex];
  }

  void setClientChannelParams(List<ClientChannelParams> params) {
    _params = params;
    _currentIndex = 0;
  }
}
