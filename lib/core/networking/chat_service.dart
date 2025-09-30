import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:bayt_aura/core/networking/api_constants.dart';
import 'package:bayt_aura/features/chat/model/chat_response.dart';
//***********ChatBot Endpoint*********************/

part 'chat_service.g.dart';

@RestApi(baseUrl: ApiConstants.chatBaseUrl)
abstract class ChatService {
  factory ChatService(Dio dio, {String baseUrl}) = _ChatService;

  @POST("chat")
  Future<ChatResponse> sendMessage(@Body() Map<String, dynamic> body);
}
