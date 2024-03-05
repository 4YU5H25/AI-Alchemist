import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  List<JournalEntry> entries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
              child: Text(
            'Journal',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1)),
          )),
          backgroundColor: Color.fromARGB(150, 131, 7, 255)),
      body: Container(
        // color: const Color.fromARGB(255, 89, 0, 105),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/journal.jpg'), fit: BoxFit.fitWidth)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color.fromARGB(99, 101, 32, 170),
          ),
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  entries[index].title,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(entries[index].date.toString(),
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Navigate to a page to view the full journal entry
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JournalEntryViewPage(
                        entry: entries[index],
                        onDelete: () {
                          _deleteEntry(index);
                        },
                        onUpdate: (updatedEntry) {
                          _updateEntry(updatedEntry, index);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: Container(
        color: Colors.transparent,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            // Navigate to the page to create a new journal entry
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewJournalEntryPage(),
              ),
            ).then((newEntry) {
              if (newEntry != null) {
                setState(() {
                  entries.add(newEntry);
                });
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _deleteEntry(int index) {
    setState(() {
      entries.removeAt(index);
    });
  }

  void _updateEntry(JournalEntry updatedEntry, int index) {
    setState(() {
      entries[index] = updatedEntry;
    });
  }
}

class JournalEntry {
  final String title;
  final DateTime date;
  final String content;

  JournalEntry({
    required this.title,
    required this.date,
    required this.content,
  });
}

class NewJournalEntryPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'New Journal Entry',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          backgroundColor: Color.fromARGB(255, 72, 0, 161)),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/journal.jpg'), fit: BoxFit.fitWidth)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4.5,
                  // padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: 'Content',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _contentController.text.isNotEmpty) {
                    Navigator.pop(
                      context,
                      JournalEntry(
                        title: _titleController.text,
                        date: DateTime.now(),
                        content: _contentController.text,
                      ),
                    );
                  } else {
                    // Show a snackbar indicating that title and content are required
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Title and content are required.'),
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JournalEntryViewPage extends StatelessWidget {
  final JournalEntry entry;
  final Function onDelete;
  final Function(JournalEntry) onUpdate;

  JournalEntryViewPage({
    required this.entry,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _confirmDelete(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _navigateToUpdateJournalEntryPage(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              entry.content,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Date: ${entry.date}',
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this entry?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onDelete();
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToUpdateJournalEntryPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateJournalEntryPage(entry: entry),
      ),
    ).then((updatedEntry) {
      if (updatedEntry != null) {
        onUpdate(updatedEntry);
      }
    });
  }
}

class UpdateJournalEntryPage extends StatelessWidget {
  final JournalEntry entry;
  final TextEditingController _titleController;
  final TextEditingController _contentController;

  UpdateJournalEntryPage({required this.entry})
      : _titleController = TextEditingController(text: entry.title),
        _contentController = TextEditingController(text: entry.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Journal Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _updateEntry(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateEntry(BuildContext context) {
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      JournalEntry updatedEntry = JournalEntry(
        title: _titleController.text,
        date: DateTime.now(),
        content: _contentController.text,
      );
      Navigator.pop(context, updatedEntry);
    } else {
      // Show a snackbar indicating that title and content are required
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title and content are required.'),
        ),
      );
    }
  }
}
