// ignore_for_file: library_prefixes, avoid_print

import 'package:hand_by_hand_app/service_locator.dart.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  final IO.Socket socket = getIt<IO.Socket>();

  SocketService() {
    _initializeSocket();
  }

  // Initialize the socket connection
  void _initializeSocket() {
    socket.connect();

    // Handle connection event
    socket.onConnect((_) {
      print('Connected to the server');
    });

    // Handle server messages
    socket.on('message', (data) {
      print('Message from server: $data');
    });

    // Handle disconnection
    socket.onDisconnect((_) {
      print('Disconnected from the server');
    });

    // Handle connection errors
    socket.onConnectError((data) {
      print('Connection Error: $data');
    });

    socket.onError((error) {
      print('Socket Error: $error');
    });
  }

  // Join a room
  void joinRoom(String room) {
    if (socket.connected) {
      socket.emit('join_room', {'room': room});
      print('Joined room: $room');
    } else {
      print('Socket is not connected, cannot join room: $room');
    }
  }

  // Leave a room
  void leaveRoom(String room) {
    if (socket.connected) {
      socket.emit('leave_room', {'room': room});
      print('Left room: $room');
    } else {
      print('Socket is not connected, cannot leave room: $room');
    }
  }

  // Send message to a room
  void sendMessage(String room) {
    if (socket.connected) {
      socket.emit('send_message', {'room': room});
    } else {
      print('Socket is not connected, cannot send message to room: $room');
    }
  }

  // Dispose the socket connection
  void dispose() {
    // Remove any existing event listeners to prevent memory leaks
    socket.off('message');
    socket.off('connect');
    socket.off('disconnect');
    socket.off('connect_error');
    socket.off('error');

    // Dispose the socket connection
    socket.dispose();
    print('Socket connection disposed');
  }
}
