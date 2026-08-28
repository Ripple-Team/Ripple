enum MessageType {text, image, video}

/// Current delivery state of a message in the conversation.
///
/// The typical lifecycle is: [sending] -> [sent] -> [read].
enum MessageStatus {sending, sent, read}
