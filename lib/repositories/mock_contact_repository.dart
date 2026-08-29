import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ripple/repositories/interfaces/contact_repository.dart';
import 'package:ripple/models/contact.dart';

/// In-memory mock of [ContactRepository] for development and testing.
///
/// Emits a fixed, pre-populated list of contacts on [getContacts]
/// subscription with a short simulated network delay
@visibleForTesting
class MockContactRepository implements ContactRepository {
  final _controller = StreamController<List<Contact>>.broadcast();

  final List<Contact> _contacts = [
    Contact(id: "1", name: "TestPer", lastSeen: DateTime.now().subtract(const Duration(hours: 2))),
    Contact(id: "2", name: "TestPer2", lastSeen: DateTime.now().subtract(const Duration(minutes: 5)))
  ];

  @override
  Contact? getContact(String contactId) =>
      _contacts.where((c) => c.id == contactId).firstOrNull;

  @override
  Stream<List<Contact>> getContacts() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!_controller.isClosed) _controller.add(List.unmodifiable(_contacts));
    });
    return _controller.stream;
  }

  @override
  void dispose() => _controller.close();
}