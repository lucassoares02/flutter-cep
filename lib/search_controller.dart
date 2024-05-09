import 'package:cep/cep_model.dart';
import 'package:cep/search_repository.dart';
import 'package:cep/state_app.dart';
import 'package:flutter/material.dart';

class SearchCepController extends ValueNotifier<StateApp> {
  SearchCepController(super.value, this._searchRepository);
  final SearchCepRepository _searchRepository;

  ValueNotifier<StateApp> stateSearch = ValueNotifier(StateApp.start);
  CepModel? data;

  getCep(String code) async {
    try {
      stateSearch.value = StateApp.loading;
      data = await _searchRepository.getCepRequest(code);
      stateSearch.value = StateApp.success;
    } catch (e) {
      debugPrint("Get Cep (SearchController) Error: $e");
    }
  }
}
