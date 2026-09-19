import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../data/mock_data.dart';
import '../../auth/presentation/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 1;

  final List<Map<String, dynamic>> _authors = List.from(MockData.authors);
  final List<Map<String, dynamic>> _books = List.from(MockData.books);
  final List<Map<String, dynamic>> _students = List.from(MockData.students);
  final List<Map<String, dynamic>> _transactions = List.from(MockData.transactions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 220, color: AppTheme.primaryBlue,
            child: Column(
              children: [
                const SizedBox(height: 30), const Icon(Icons.menu_book_rounded, color: Colors.white, size: 48), const SizedBox(height: 8),
                const Text('SIR JAN\nLIBRARY', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                const SizedBox(height: 30),
                _navTile(0, Icons.person_outline, 'Author'), _navTile(1, Icons.book_outlined, 'Books'), _navTile(2, Icons.people_outline, 'Students'), _navTile(3, Icons.receipt_long_outlined, 'Transaction'), _navTile(4, Icons.outbox_outlined, 'Issuing'),
                const Spacer(),
                ListTile(leading: const Icon(Icons.logout, color: Colors.white70, size: 20), title: const Text('Log Out', style: TextStyle(color: Colors.white70, fontSize: 14)), onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(child: Container(color: AppTheme.bgGray, padding: const EdgeInsets.all(24.0), child: _buildCurrentTab())),
        ],
      ),
    );
  }

  Widget _navTile(int index, IconData icon, String title) {
    final isSelected = _selectedTab == index;
    return Container(
      color: isSelected ? Colors.white.withValues(alpha: 0.15) : Colors.transparent,
      child: ListTile(leading: Icon(icon, color: Colors.white, size: 20), title: Text(title, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)), onTap: () => setState(() => _selectedTab = index)),
    );
  }

  Widget _buildCurrentTab() {
    switch (_selectedTab) {
      case 0: return _buildAuthorTab();
      case 1: return _buildBooksTab();
      case 2: return _buildStudentsTab();
      case 3: return _buildTransactionTab();
      case 4: return _buildIssuingTab();
      default: return const SizedBox();
    }
  }

  // --- TAB 0: AUTHOR ---
  final _authorIdCtrl = TextEditingController(); final _authorNameCtrl = TextEditingController(); final _authorBioCtrl = TextEditingController();
  Widget _buildAuthorTab() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionHeader('Author Info'),
        _formCard([
          Row(children: [Expanded(child: _field('Author ID', _authorIdCtrl)), const SizedBox(width: 16), Expanded(child: _field('Author Name', _authorNameCtrl))]), const SizedBox(height: 12), _field('Bio', _authorBioCtrl), const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_authorNameCtrl.text.isNotEmpty) setState(() { _authors.add({'id': _authorIdCtrl.text.isEmpty ? 'A00${_authors.length + 1}' : _authorIdCtrl.text, 'name': _authorNameCtrl.text, 'bio': _authorBioCtrl.text}); _authorIdCtrl.clear(); _authorNameCtrl.clear(); _authorBioCtrl.clear(); });
            }, child: const Text('ADD AUTHOR'),
          ),
        ]), const SizedBox(height: 24), _sectionHeader('Author Details'),
        _dataTable(headers: ['Author ID', 'Author Name', 'Bio', 'Action'], rows: _authors.map((a) => [a['id'], a['name'], a['bio'], _actions(() => setState(() => _authors.remove(a)))]).toList()),
      ]),
    );
  }

  // --- TAB 1: BOOKS ---
  final _bIdCtrl = TextEditingController(); final _bIsbnCtrl = TextEditingController(); final _bTitleCtrl = TextEditingController(); final _bGenreCtrl = TextEditingController(); final _bAuthIdCtrl = TextEditingController(); final _bQtyCtrl = TextEditingController();
  Widget _buildBooksTab() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionHeader('Books Details'),
        _formCard([
          Row(children: [Expanded(child: _field('Book ID', _bIdCtrl)), const SizedBox(width: 16), Expanded(child: _field('ISBN', _bIsbnCtrl))]), const SizedBox(height: 12),
          Row(children: [Expanded(child: _field('Title', _bTitleCtrl)), const SizedBox(width: 16), Expanded(child: _field('Genre', _bGenreCtrl))]), const SizedBox(height: 12),
          Row(children: [Expanded(child: _field('Author ID', _bAuthIdCtrl)), const SizedBox(width: 16), Expanded(child: _field('Quantity', _bQtyCtrl))]), const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_bTitleCtrl.text.isNotEmpty) setState(() { _books.add({'id': _bIdCtrl.text.isEmpty ? 'B00${_books.length + 1}' : _bIdCtrl.text, 'title': _bTitleCtrl.text, 'authorId': _bAuthIdCtrl.text, 'genre': _bGenreCtrl.text, 'isbn': _bIsbnCtrl.text, 'qty': _bQtyCtrl.text}); _bIdCtrl.clear(); _bIsbnCtrl.clear(); _bTitleCtrl.clear(); _bGenreCtrl.clear(); _bAuthIdCtrl.clear(); _bQtyCtrl.clear(); });
            }, child: const Text('ADD BOOK'),
          ),
        ]), const SizedBox(height: 24), _sectionHeader('Book Lists'),
        _dataTable(headers: ['Book ID', 'Title', 'AuthorID', 'Genre', 'ISBN', 'Quantity', 'Action'], rows: _books.map((b) => [b['id'], b['title'], b['authorId'], b['genre'], b['isbn'], b['qty'].toString(), _actions(() => setState(() => _books.remove(b)))]).toList()),
      ]),
    );
  }

  // --- TAB 2: STUDENTS ---
  final _sIdCtrl = TextEditingController(); final _sFacCtrl = TextEditingController(); final _sNameCtrl = TextEditingController(); final _sEmailCtrl = TextEditingController(); final _sContCtrl = TextEditingController();
  Widget _buildStudentsTab() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionHeader('Add Students'),
        _formCard([
          Row(children: [Expanded(child: _field('Student ID', _sIdCtrl)), const SizedBox(width: 16), Expanded(child: _field('Faculty', _sFacCtrl))]), const SizedBox(height: 12), _field('Full Name', _sNameCtrl), const SizedBox(height: 12),
          Row(children: [Expanded(child: _field('Email', _sEmailCtrl)), const SizedBox(width: 16), Expanded(child: _field('Contact No.', _sContCtrl))]), const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_sNameCtrl.text.isNotEmpty) setState(() { _students.add({'id': _sIdCtrl.text.isEmpty ? 'S00${_students.length + 1}' : _sIdCtrl.text, 'name': _sNameCtrl.text, 'faculty': _sFacCtrl.text, 'email': _sEmailCtrl.text, 'contact': _sContCtrl.text}); _sIdCtrl.clear(); _sFacCtrl.clear(); _sNameCtrl.clear(); _sEmailCtrl.clear(); _sContCtrl.clear(); });
            }, child: const Text('Add Student'),
          ),
        ]), const SizedBox(height: 24), _sectionHeader('Student Lists'),
        _dataTable(headers: ['StudentID', 'Name', 'Faculty', 'Email', 'Contact No.', 'Action'], rows: _students.map((s) => [s['id'], s['name'], s['faculty'], s['email'], s['contact'], _actions(() => setState(() => _students.remove(s)))]).toList()),
      ]),
    );
  }

  // --- TAB 3: TRANSACTION ---
  Widget _buildTransactionTab() {
    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_sectionHeader('Transaction'), _dataTable(headers: ['T_ID', 'User ID', 'S_ID', 'Book ID', 'Transaction Type', 'Date'], rows: _transactions.map((t) => [t['tid'], t['uid'], t['sid'], t['bid'], t['type'], t['date']]).toList())]));
  }

  // --- TAB 4: ISSUING ---
  final _iBookId = TextEditingController(); final _iUserId = TextEditingController(); final _iTitle = TextEditingController(); final _iIsbn = TextEditingController(); final _iDate = TextEditingController();
  Widget _buildIssuingTab() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionHeader('Issue Book'),
        _formCard([
          Row(children: [Expanded(child: _field('Book ID', _iBookId)), const SizedBox(width: 16), Expanded(child: _field('User ID', _iUserId))]), const SizedBox(height: 12),
          Row(children: [Expanded(child: _field('Book Title', _iTitle)), const SizedBox(width: 16), Expanded(child: _field('ISBN', _iIsbn))]), const SizedBox(height: 12), _field('Date', _iDate), const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_iBookId.text.isNotEmpty) setState(() { _transactions.add({'tid': 'T00${_transactions.length + 1}', 'uid': _iUserId.text.isEmpty ? 'U001' : _iUserId.text, 'sid': 'S001', 'bid': _iBookId.text, 'type': 'Borrow', 'date': _iDate.text.isEmpty ? DateTime.now().toString().substring(0, 16) : _iDate.text}); _iBookId.clear(); _iUserId.clear(); _iTitle.clear(); _iIsbn.clear(); _iDate.clear(); });
            }, child: const Text('Borrow'),
          ),
        ]),
      ]),
    );
  }

  // --- UI HELPERS ---
  Widget _sectionHeader(String title) => Padding(padding: const EdgeInsets.only(bottom: 12.0), child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  Widget _formCard(List<Widget> children) => Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppTheme.fieldGray, borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children));
  Widget _field(String label, TextEditingController controller) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)), const SizedBox(height: 4), Container(height: 38, decoration: BoxDecoration(color: const Color(0xFFCCCCCC), borderRadius: BorderRadius.circular(6)), child: TextField(controller: controller, style: const TextStyle(fontSize: 13), decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12))))]);
    Widget _dataTable({required List<String> headers, required List<List<dynamic>> rows}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      // THIS SCROLLVIEW PREVENTS THE OVERFLOW ERROR!
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFF6B6B6B)),
          dataRowHeight: 48,
          columns: headers.map((h) => DataColumn(
            label: Text(h, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
          )).toList(),
          rows: rows.map((row) {
            return DataRow(
              cells: row.map((cell) {
                if (cell is Widget) return DataCell(cell);
                return DataCell(Text(cell.toString(), style: const TextStyle(fontSize: 12)));
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
  Widget _actions(VoidCallback onDelete) => Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.edit, size: 16, color: Colors.white)), const SizedBox(width: 6), InkWell(onTap: onDelete, child: Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.delete, size: 16, color: Colors.white)))]);
}