import 'package:hive/hive.dart';
import 'package:note_app/home/model/word_model.dart';

class WordTypeAdptor extends TypeAdapter<WordModel> {
  @override
  final typeId = 0;

  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
      text: reader.readString(),
      isArabic: reader.readBool(), 
      indexAtDatabase: reader.readInt(),
      colorCode: reader.readInt(),
      arabicSimilarWords: reader.readList().cast<String>(),
      englishSimilarWords: reader.readList().cast<String>(),
      arabicExamples: reader.readList().cast<String>(),
      englishExamples: reader.readList().cast<String>()
    );
  }

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer.writeString(obj.text);
    writer.writeBool(obj.isArabic);
    writer.writeInt(obj.indexAtDatabase);
    writer.writeInt(obj.colorCode);
    writer.writeList(obj.arabicSimilarWords ?? []);
    writer.writeList(obj.englishSimilarWords ?? []);
    writer.writeList(obj.arabicExamples ?? []);
    writer.writeList(obj.englishExamples ?? []);
  }
}