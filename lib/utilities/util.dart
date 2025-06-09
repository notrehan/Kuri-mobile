import 'package:flutter/material.dart';

class AddKuriDialog extends StatefulWidget {
  final Function(String name, String amount, List<String> people) onSubmit;

  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController peopleCountController;
  final List<TextEditingController> peopleControllers;

  final VoidCallback onSave;

  const AddKuriDialog({
    super.key,
    required this.onSubmit,
    required this.nameController,
    required this.amountController,
    required this.peopleCountController,
    required this.peopleControllers,
    required this.onSave,
  });

  @override
  State<AddKuriDialog> createState() => _AddKuriDialogState();
}

class _AddKuriDialogState extends State<AddKuriDialog> {
  bool showNameFields = false;

  void generatePeopleFields() {
    int count = int.tryParse(widget.peopleCountController.text) ?? 0;
    if (count > 0) {
      setState(() {
        widget.peopleControllers.clear();
        widget.peopleControllers.addAll(
          List.generate(count, (_) => TextEditingController()),
        );
        showNameFields = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Add New Kuri", style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: widget.nameController,
              decoration: const InputDecoration(
                labelText: 'Kuri Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: widget.amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: widget.peopleCountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of People',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: generatePeopleFields,
              icon: const Icon(Icons.group_add),
              label: const Text("Add People Fields"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: Colors.black54,
              ),
            ),
            if (showNameFields)
              ...widget.peopleControllers.asMap().entries.map((entry) {
                int index = entry.key;
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: entry.value,
                    decoration: InputDecoration(
                      labelText: 'Person ${index + 1} Name',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave();
            Navigator.of(context).pop();
          },
          child: const Text("Add", style: TextStyle(color: Colors.green)),
        )
      ],
    );
  }
}

class KuriKard extends StatelessWidget {
  final String name;
  final int members;
  final int monthlyAmount;

  const KuriKard({
    super.key,
    required this.name,
    required this.members,
    required this.monthlyAmount,
  });

 @override
 Widget build(BuildContext context) {

  return Container(
  padding: const EdgeInsets.all(16),
  margin: EdgeInsets.only(bottom: 16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Top Row: Title and Arrow
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
        ],
      ),
      const SizedBox(height: 8),
      
      // Members and Status
      Row(
        children: [
          Icon(Icons.people, size: 18, color: Colors.black54),
          SizedBox(width: 6),
          Text("$members members", style: TextStyle(fontSize: 14)),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "active",
              style: TextStyle(
                color: Colors.green.shade800,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),

      // Monthly Amount & Progress
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Monthly Amount", style: TextStyle(color: Colors.black54)),
              Text(monthlyAmount.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Progress", style: TextStyle(color: Colors.black54)),
              Text("0/10", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),

      // Next Date
      Row(
        children: [
          Icon(Icons.calendar_today, size: 16, color: Colors.black54),
          SizedBox(width: 6),
          Text("Next: July 15, 2025", style: TextStyle(fontSize: 13)),
        ],
      ),
    ],
  ),
);
}
}