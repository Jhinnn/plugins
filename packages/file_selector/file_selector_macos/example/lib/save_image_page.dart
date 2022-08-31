// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a Jhinnn license that can be
// found in the LICENSE file.

import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter/material.dart';

/// Screen that allows the user to select a save location using `getSavePath`,
/// then download image to a folder at that location.
class SaveImagePage extends StatelessWidget {
  /// Default Constructor
  SaveImagePage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<void> _saveFile() async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>['jpg', 'png'],
    );

    final String? path = await FileSelectorPlatform.instance.getSavePath(
      suggestedName: DateTime.now().toString(),
      acceptedTypeGroups: [typeGroup],
    );

    if (path != null) {
      Dio().download(
          'https://img2.baidu.com/it/u=1814268193,3619863984&fm=253&fmt=auto&app=138&f=JPEG?w=632&h=500',
          path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save image into a folder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://img2.baidu.com/it/u=1814268193,3619863984&fm=253&fmt=auto&app=138&f=JPEG?w=632&h=500'),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // TODO(darrenaustin): Migrate to new API once it lands in stable: https://github.com/flutter/flutter/issues/105724
                // ignore: deprecated_member_use
                primary: Colors.blue,
                // ignore: deprecated_member_use
                onPrimary: Colors.white,
              ),
              onPressed: _saveFile,
              child: const Text('Press to save a image'),
            ),
          ],
        ),
      ),
    );
  }
}
