import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/models/repositories/restClient.dart';

class RetrofitProvider extends Cubit<RestClient> {
  RetrofitProvider(super.initialState);
  void newClient(RestClient client) => emit(client);
}
