import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:ycsh/model/interface.dart';

class SocketService{

  //static SocketService? _instance;

  IO.Socket? _socket;
  SocketMessageHandler? _handler;

  final String url;

 // SocketService._();

  SocketService(this.url,);

  /*factory SocketService() {
    return _instance??=SocketService._();
  }*/

/*  void setMessageHandler(MessageHandler handler){
    _handler=handler;
  }*/

  bool get isConnected => _socket!.connected;


  void connect(SocketMessageHandler handler,{List<String> events= const []}){

    print("socket url: $url");
    _socket = IO.io(url, IO.OptionBuilder().
    setTransports(['websocket']).disableAutoConnect().build());

    _handler=handler;
    //final String event=SocketEvent.GET_MESSAGE;

    _socket!.onConnect(_handler!.onConnect);
    _socket!.onDisconnect(_handler!.onDisconnect);
    _socket!.onConnectError(_handler!.onConnectionError);
    _socket!.onError(_handler!.onError);

    events.forEach((event) {
      _socket!.on(event, (data) {
        _handler!.onEvent(event, data);
      });
    });

    _socket!.connect();

  }

  void emitData(String event,dynamic data){
    _socket!.emit(event,data);
  }


  void disconnect(){
    _socket!.dispose();
   // _socket!.disconnect();
   // _socket!.close();
  }

}

class SocketEvent{
  static const SEND_LOCATION="send-location";
}