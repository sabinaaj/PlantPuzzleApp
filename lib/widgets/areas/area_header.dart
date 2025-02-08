import 'package:flutter/material.dart';
import '../../services/data_service_areas.dart';
import '../../models/area.dart';

class AreaHeader extends StatelessWidget {
  final DataServiceAreas dataService = DataServiceAreas();
  final Area area;

  AreaHeader({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    final areaStats = dataService.getAreaStats(area.id);
    final worksheetCount = areaStats['worksheet_count'] ?? 0;
    final doneWorksheetCount = areaStats['done_worksheet_count'] ?? 0;
    final avgSuccessRate = areaStats['average_success_rate'].toInt() ?? 0;

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: area.iconUrl != null
                ? Image.network(
                    area.iconUrl!,
                    height: 115,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/area_placeholder.png',
                    height: 100,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              children: [
                SizedBox(
                  width: 215.0,
                  child: Center(
                    child: Text(
                      area.title,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6.0),

                Row(children: [
                  Column(
                    children: [
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
                    ],
                  ),
                  SizedBox(
                      height: 50,
                      width: 30,
                      child: VerticalDivider(
                        color: Colors.grey.shade400,
                        thickness: 2,
                      )),
                  Column(
                    children: [
                      Text(
                        avgSuccessRate > 0 ? '$avgSuccessRate %' : '- %',
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Průměrná \n úspěšnost',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, height: 1.1),
                      ),
                    ],
                  )
                ]),
              ],
            ),
          )
        ],
      );
  }
}
