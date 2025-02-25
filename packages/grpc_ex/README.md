# dart grpc extension
## reconnect other server after rpc request is error

```dart
import 'package:grpc/grpc.dart';
import 'package:grpc_ex/grpc_ex.dart';

import 'rpc_gen/rpc.pbgrpc.dart';

void main() async {
  var timeOut = Duration(seconds: 12);
  var channelOptions = ChannelOptions(credentials: ChannelCredentials.insecure(), connectTimeout: timeOut, connectionTimeout: timeOut, proxy: null);

  var params = [(host: "127.0.0.1", port: 6666, options: channelOptions), (host: "127.0.0.1", port: 6688, options: channelOptions)];
  var channel = ClientChannelEx(params);
  var client = SampleClient(channel);
  {
    // show current channel
    var temp = channel.currentClientChannelParams();
    print("server ip-port: ${temp.host}-${temp.port}"); // 6666, the first
  }
  try {
    await client.name(Req()); //if the grpc request error, the channel will change to the next
  } catch (e) {
    //
  }
  {
    // show current channel
    var temp = channel.currentClientChannelParams();
    print("server ip-port: ${temp.host}-${temp.port}"); // 6688, the second
  }
  try {
    await client.name(Req());
  } catch (e) {
    //
  }

  // ......

  // if don't use the channel, shutdown it
  await channel.shutdown();
}

```

