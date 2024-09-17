class quizmodel{
  quizmodel({
    required this.quiz_image, required this.quiz_title ,
    required this.quiz_des, required this.quiz_id , required this.questions});
  String? quiz_image ;
  String? quiz_title;
  String? quiz_des;
  String? quiz_id;
  List<Map> questions;



}