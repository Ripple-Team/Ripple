// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:hive_ce/hive_ce.dart';

enum MessageType { text, image, video }

// TODO: mb put it in dir 'adapters'?

/// Current delivery state of a message in the conversation.
///
/// The typical lifecycle is: [sending] -> [sent] -> [read].
enum MessageStatus { sending, sent, read }

/// Hive type adapter for [MessageStatus] enum.
class MessageStatusAdapter extends TypeAdapter<MessageStatus> {
  @override
  final int typeId = 3;

  @override
  MessageStatus read(BinaryReader reader) {
    final byte = reader.readByte();
    return byte < MessageStatus.values.length
        ? MessageStatus.values[byte]
        : MessageStatus.sent;
  }

  @override
  void write(BinaryWriter writer, MessageStatus obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageStatusAdapter && typeId == other.typeId;
}
