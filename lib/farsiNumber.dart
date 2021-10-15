class Farsi{
  String replaceFarsiNumber(String input){

    const en=['1','2','3','4','5','6','7','8','9','0'];
    const fa=['۱','۲','۳','۴','۵','۶','۷','۸','۹','۰'];

    for(int i=0;i<en.length;i++){
      input=input.replaceAll(en[i],fa[i]);
    }

    return input;
  }
}