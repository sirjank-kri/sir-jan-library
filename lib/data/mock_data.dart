class MockData {
  static final List<Map<String, dynamic>> authors = [
    {'id': 'A001', 'name': 'J.K. Rowling', 'bio': 'British author, Harry Potter series.'},
    {'id': 'A002', 'name': 'George R.R. Martin', 'bio': 'A Song of Ice and Fire.'},
  ];

  static final List<Map<String, dynamic>> books = [
    {'id': 'B001', 'title': 'Harry Potter & Philosopher Stone', 'authorId': 'A001', 'genre': 'Fantasy', 'isbn': '978-0747532699', 'qty': '15'},
    {'id': 'B002', 'title': 'A Game of Thrones', 'authorId': 'A002', 'genre': 'Epic Fantasy', 'isbn': '978-0553103540', 'qty': '8'},
  ];

  static final List<Map<String, dynamic>> students = [
    {'id': 'S001', 'name': 'John Doe', 'faculty': 'Computer Science', 'email': 'john@sirjan.edu', 'contact': '+1 555-0192'},
    {'id': 'S002', 'name': 'Sarah Smith', 'faculty': 'Management', 'email': 'sarah@sirjan.edu', 'contact': '+1 555-0148'},
  ];

  static final List<Map<String, dynamic>> transactions = [
    {'tid': 'T001', 'uid': 'U001', 'sid': 'S001', 'bid': 'B001', 'type': 'Borrow', 'date': '2024-03-01 10:30'},
  ];
}