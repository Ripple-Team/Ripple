// Copyright 2026 Ripple Team
// Licensed under the Apache License, Version 2.0.
import 'package:ripple/models/message.dart';

/// Convenience methods for [Message] that require external context.
///
/// Operations like ownership checks need access to the current user ID,
/// which the [Message] model itself does not know about.
extension MessageHelper on Message {
  /// Returns `true` if this message was sent by the user with [currentUserId].
  ///
  /// Used by chat UI to decide whether to render the message bubble
  /// on the right (mine) or left (theirs) side.
  bool isMine(String currentUserId) => senderId == currentUserId;
}