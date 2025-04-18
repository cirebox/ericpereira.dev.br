import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/domain/exceptions/exceptions.dart';

abstract class IEmailService {
  Future<Either<Failure, void>> sendEmail({
    required String name,
    required String email,
    String? phone,
    required String subject,
    required String message,
  });
}

class EmailService implements IEmailService {
  // URL de um serviço de API para envio de e-mail (exemplo: EmailJS, Formspree, etc.)
  final String _apiUrl = 'https://api.emailjs.com/api/v1.0/email/send';
  // Nota: Em um ambiente de produção, estes valores devem vir de variáveis de ambiente
  final String _serviceId = 'service_ericpereira'; // ID do serviço EmailJS
  final String _templateId = 'contact_form'; // ID do template EmailJS
  final String _userId = 'user_ericpereira'; // ID de usuário EmailJS

  @override
  Future<Either<Failure, void>> sendEmail({
    required String name,
    required String email,
    String? phone,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _userId,
          'template_params': {
            'name': name,
            'email': email,
            'phone': phone ?? 'Não informado',
            'subject': subject,
            'message': message,
          },
        }),
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(FailureRequest(
          errorMessage: 'Erro ao enviar e-mail: ${response.body}',
        ));
      }
    } catch (e) {
      return Left(FailureRequest(
        errorMessage: 'Erro ao enviar e-mail',
        exception: e,
      ));
    }
  }
}

// Extensão do EmailService para ser usado como bind no Modular
final $EmailService = BindInject(
  (i) => EmailService(),
  isSingleton: true,
  isLazy: true,
);
