
import 'package:hive/hive.dart';
import 'package:note_app/home/model/word_model.dart';

class WordTypeAdptor extends TypeAdapter<WordModel>{
  @override
  WordModel read(BinaryReader reader) {
    // TODO: implement read
    return WordModel(
        arabicExamples:reader.readList().cast<String>(),
        arabicSimilarWords: reader.readList().cast<String>(),
         isArabic:reader.readBool(),
        englishSimilarWords:reader.readList().cast<String>() ,
        text: reader.readString(),
        indexAtDatabase: reader.readInt(),
        colorCode: reader.readInt(),
        englishExamples: reader.readList().cast());
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, obj) {
    writer.writeList(obj.arabicExamples??[]);
    writer.writeList(obj.arabicSimilarWords??[]);
    writer.writeBool(obj.isArabic);
    writer.writeList(obj.englishSimilarWords??[]);
    writer.writeList(obj.englishExamples??[]);
    writer.writeString(obj.text);
    writer.writeInt(obj.colorCode);
    writer.writeInt(obj.indexAtDatabase);


  }
}

