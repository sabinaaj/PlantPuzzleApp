import 'package:flutter/material.dart';
import '../../services/api_service_areas.dart';
import '../../models/area.dart';

class AreaHeader extends StatefulWidget {
  final Area area;

  const AreaHeader({super.key, required this.area});

  @override
  State<AreaHeader> createState() => _AreaHeaderState();
}

class _AreaHeaderState extends State<AreaHeader> {
  final ApiService _apiService = ApiService();
  int worksheetCount = 0;
  int doneWorksheetCount = 0;
  int avgSuccessRate = 0;

  @override
  void initState() {
    super.initState();
    _loadAreaStats();
  }

  void _loadAreaStats() async {
  try {
    final stats = await _apiService.getAreaStats(widget.area.id);

    setState(() {
      worksheetCount = stats['worksheet_count'] ?? 0;
      doneWorksheetCount = stats['done_worksheet_count'] ?? 0;
      avgSuccessRate = stats['average_success_rate'].toInt() ?? 0;
    });

  } catch (e) {
    setState(() {
      worksheetCount = 0;
      doneWorksheetCount = 0;
      avgSuccessRate = 0;
    });
  }
}

void reloadData() {
    _loadAreaStats();
  }


  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: widget.area.iconUrl != null
                ? Image.network(
                    widget.area.iconUrl!,
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
                      widget.area.title,
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
