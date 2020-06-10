import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase  {
  
  var _controllerLoading = BehaviorSubject<bool>();
  
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