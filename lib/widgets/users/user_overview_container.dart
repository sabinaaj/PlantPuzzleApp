import 'package:flutter/material.dart';
import '../../services/data_service_visitors.dart';
import '../border_container.dart';
import '../../../models/visitors.dart';

class UserOverviewContainer extends StatelessWidget {
  final DataServiceVisitors dataService = DataServiceVisitors();
  final Visitor visitor;

  UserOverviewContainer({
    super.key,
    required this.visitor,
  });

  List<Widget> _getCardContent(int index) {
    final visitorStats = dataService.getVisitorStats(visitor.id?? 0);
    final worksheetCount = visitorStats['worksheet_count'] ?? 0;
    final doneWorksheetCount = visitorStats['done_worksheet_count'] ?? 0;
    final avgSuccessRate = visitorStats['average_success_rate'].toInt() ?? 0;

    switch (index){
      case 0:
        return [
          Text(
            '$doneWorksheetCount/$worksheetCount',
            style: const TextStyle(
                fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Text(
            'Hotových \n testů',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, height: 1.1),
          ),
        ];

      case 1:
        return [
          Text(
            avgSuccessRate > 0 ? '$avgSuccessRate %' : '- %',
            style: const TextStyle(
                fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Text(
            'Průměrná \n úspěšnost',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, height: 1.1),
          )
        ];

      case 2:
        return [
          Text(
            '$doneWorksheetCount/$worksheetCount',
            style: const TextStyle(
                fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Text(
            'Získaných \n pohárů',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, height: 1.1),
          )
        ];

      case 3:
        return [
          Text(
            'Jsi lepší než',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, height: 1.1),
          ),
          Text(
            avgSuccessRate > 0 ? '$avgSuccessRate %' : '- %',
            style: const TextStyle(
                fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Text(
            'uživatelů',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, height: 1.1),
          )
        ];

      default:
        return [];
    } 
      
  }

 @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: 
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/graph.png',
                width: 28.0,
                height: 28.0,
              ),
              const SizedBox(width: 8.0),
              Text(
            'Přehled',
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
            ),
          ),
            ],
          )
        ),

        GridView.builder(
          shrinkWrap: true, 
          physics:
              NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.5,
          ),
          itemCount: 4, 
          itemBuilder: (context, index) {
            return Card(
              child: BorderContainer(padding: 16, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getCardContent(index)
                ),
              ]),
            );
          },
        ),
      ],
    );
  }
}
