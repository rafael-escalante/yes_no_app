import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer {
  //instancia de la clase dio para manejar peticiones http
  final _dio = Dio();

  Future<Message> getAnswer() async {
    //Almacenar el resultado de la petición
    final response = await _dio.get('https://yesno.wtf/api');

    //almacenar la data de la repsuesta
    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    //retornar la instancia de Message
    return yesNoModel.toMessageEntity();
  }
}
