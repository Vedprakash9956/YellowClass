

class Movie{
  int _id;
  String _moviename;
  String _director;
 Movie(this._moviename,this._director);
  Movie.withId(this._id,this._moviename,this._director);

 int get id=>_id;
 String get moviename=>_moviename;
 String get director=>_director;

 set moviename(String newMovie){

   this._moviename=newMovie;
 }
 set director(String newMovie){
   this._director=newMovie;
 }
 Map<String, dynamic>toMap() {
 var map=Map<String, dynamic>();
 if (id != null) {
   map['id'] = _id;
 }
 map['movie']=_moviename;
 map['director']=_director;
 return map;
 }
 Movie.fromMapObject(Map<String,dynamic>map){
   this._id = map['id'];
   this._moviename=map['movie'];
   this._director=map['director'];
 }
}