import 'package:ripple/models/contact.dart';

/// Abstraction over the current user's contact list
abstract class ContactRepository {
  /// Returns the contact with the given [contactId], or null if not found
  Contact? getContact(String contactId);

  /// Returns a stream of the current user's contacts.
  ///
  /// The stream emits a new list whenever a contact is added, removed,
  /// or its details (e.g. [Contact.lastSeen]) change
  Stream<List<Contact>> getContacts();

  /// Release resources held by the repository
  void dispose();
}
