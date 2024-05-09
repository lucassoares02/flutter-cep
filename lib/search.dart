import 'package:cep/search_controller.dart';
import 'package:cep/search_repository.dart';
import 'package:cep/state_app.dart';
import 'package:flutter/material.dart';
import 'package:mask/mask/mask.dart';
import 'package:mask/models/hashtag_is.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchCepController _searchController = SearchCepController(StateApp.start, SearchCepRepository());
  TextEditingController controllerCep = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Busca CEP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) => Mask.validations.generic(value, min: 8, error: 'info erro'),
                inputFormatters: [
                  Mask.generic(
                    masks: ['#####-###'],
                    hashtag: Hashtag.numbers,
                  ),
                ],
                decoration: const InputDecoration(labelText: "CEP", hintText: "Digite o CEP"),
                keyboardType: TextInputType.number,
                maxLength: 9,
                controller: controllerCep,
              ),
              ValueListenableBuilder(
                  valueListenable: _searchController.stateSearch,
                  builder: (context, state, child) {
                    return state == StateApp.loading
                        ? const CircularProgressIndicator()
                        : state == StateApp.success && _searchController.data != null
                            ? _searchController.data?.bairro == null
                                ? const Text("CEP não encontrado!")
                                : Text(
                                    "${_searchController.data?.logradouro},${_searchController.data?.bairro},${_searchController.data?.localidade},${_searchController.data?.uf}",
                                  )
                            : Container();
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controllerCep.text.length == 9) {
            _searchController.getCep(controllerCep.text);
          }
        },
        tooltip: 'Buscar',
        child: const Icon(Icons.search),
      ),
    );
    ;
  }
}
