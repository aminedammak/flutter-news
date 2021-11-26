import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
  final _itemsFetcher = PublishSubject<int>();

  Stream<Map<int, Future<ItemModel?>>> get items => _itemsOutput.stream;

  final _repository = Repository();

  Stream<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      /** 
       * Invoked each time a new data event comes accross the steam
       * what ever we return from this function will be carried over to the next time this function gets invoked 
       * cache: map that will carry out the data 
       * id: the event data that comes in
       * index
       */
      (Map<int, Future<ItemModel?>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      /**initial value for the transformer so empty cache map */
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
