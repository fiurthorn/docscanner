import 'dart:io';

import 'package:document_scanner/core/lib/logger.dart';
import 'package:document_scanner/core/service_locator/service_locator.dart';
import 'package:document_scanner/scanner/data/datasources/native.dart';
import 'package:document_scanner/scanner/domain/repositories/media_store.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:path/path.dart' as p;

class MediaStoreImpl implements MediaStore {
  final df = DateFormat("yyyy-MM-dd");

  @override
  Future<void> upload(
    String area,
    String senderName,
    String documentType,
    DateTime documentDate,
    List<ExportAttachmentModel> attachments,
  ) async {
    final downloadsDirectory = await sl<Native>().getTempDir();

    for (var element in attachments) {
      final extension = p.extension(element.name);

      final file = File("$downloadsDirectory/tmpfile");
      file.writeAsBytesSync(element.image);

      final structure = "docscan/$area/$senderName/$documentType";
      final fileName = "${documentType}_${df.format(documentDate)}.$extension";

      await sl<Native>().saveFileInMediaStore(file.path, structure, fileName);
      Log.high("filepath: $fileName");

      file.deleteSync();
    }
  }
}
