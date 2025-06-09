  import 'package:flutter/material.dart';
  import 'package:kuri_app/utilities/util.dart';

  class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    
   

  final nameCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final peopleCountCtrl = TextEditingController();
  List<TextEditingController> peopleCtrl = [];

    List kuriList = [
      ["Test Kuri", 10, 1500],
    ];

    int activeKuri = 0;
    num monthlyCommitment = 0;

void addKuri() {
  setState(() {
    kuriList.add([nameCtrl.text, int.parse(peopleCountCtrl.text.trim()), int.parse(amountCtrl.text.trim())]);
    print("Kuri added: ${kuriList.last}");
    print("Full Kuri List: $kuriList");
    activeKuri = kuriList.length;
    monthlyCommitment = calcMonthlyCommitments();
  });

}

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddKuriDialog(onSubmit: (name, amount, people) {
          
        }, nameController: nameCtrl, amountController: amountCtrl, peopleCountController: peopleCountCtrl, peopleControllers: peopleCtrl, onSave: addKuri,);
      },
    );
  }

num calcMonthlyCommitments() {
  num sum = 0;
  for (int i=0; i<kuriList.length; i++) {
    sum += kuriList[i][2];
  }
  return sum;
}

    @override
    void initState() {
      super.initState();
      activeKuri = kuriList.length;
      monthlyCommitment = calcMonthlyCommitments();
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildStatCard(
                  title: 'Active Kuris',
                  value: activeKuri.toString(),
                  icon: Icons.people,
                  color: Colors.blue,
                ),
                _buildStatCard(
                  title: 'Monthly Commitment',
                  value: '₹$monthlyCommitment',
                  icon: Icons.attach_money,
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                onPressed: createNewTask,
                child: Text(
                  "Add Kuri",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            ListView.builder(
              itemCount: kuriList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                return KuriKard(name: kuriList[index][0], members: kuriList[index][1], monthlyAmount: kuriList[index][2]);
              },
            )

          ],
        ),
      );
    }


  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 18,
      padding: const EdgeInsets.all(16),
      height: 150,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
  }
