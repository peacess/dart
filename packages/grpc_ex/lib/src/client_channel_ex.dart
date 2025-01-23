import 'package:grpc/grpc.dart';
import 'package:grpc/src/client/connection.dart';
import 'package:grpc_ex/src/client_channel_base_ex.dart';
import 'package:grpc/src/client/http2_connection.dart' show Http2ClientConnection;

typedef Params = ({String host, int port, ChannelOptions options});

class ClientChannelEx extends ClientChannelBaseEx {
  final List<Params> _params;
  int currentIndex = 0;
  ClientChannelEx(this._params, {super.channelShutdownHandler});

  @override
  ClientConnection createConnection() {
    var p = nextParams();
    return Http2ClientConnection(p.host, p.port, p.options);
  }

  Params nextParams() {
    if (currentIndex >= _params.length) {
      currentIndex = 0;
    }
    var p = _params[currentIndex];
    currentIndex++;
    return p;
  }
}
