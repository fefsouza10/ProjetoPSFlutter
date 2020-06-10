import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase  {
  
  var _controllerLoading = BehaviorSubject<bool>(seedValue: false);
  Stream<bool> get outLoading => _controllerLoading.stream;
  
  onClickTelefone(){

  }

  onClickFacebook(){
    
  }
  onClickGoogle(){
    
  }
  
  
  
  
  @override
  void dispose() {
    _controllerLoading.close();   
  }
}