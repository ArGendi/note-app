import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/controllers/lang/lang_state.dart';
import 'package:revision/local/shared_pref.dart';

class LangCubit extends Cubit<LangState>{
  String lang = 'en';

  LangCubit() : super(InitLangState());
  static LangCubit get(context) => BlocProvider.of(context);

  void changeLang(String langCode){
    lang = langCode;
    SharedPref.setLang(langCode);
    emit(ChangeLangState());
  }

}