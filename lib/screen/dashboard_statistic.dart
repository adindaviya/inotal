import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'ApplicantByDateScreen.dart';
import 'ApplicationByDivisionScreen.dart';

class DashboardStatistic extends StatefulWidget {
  const DashboardStatistic({super.key});

  @override
  State<DashboardStatistic> createState() => _DashboardStatisticState();
}

class _DashboardStatisticState extends State<DashboardStatistic> {
  bool _isNavigating = false;
  DateTimeRange? selectedRange;

  final List<Map<String, dynamic>> divisionData = [
    {
      "date": DateTime(2026, 5, 10),
      "name": "Andi Saputra",
      "division": "Frontend Developer",
      "location": "Jakarta",
      "experience": "2 Tahun",
      "type": "Full Time",
    },
    {
      "date": DateTime(2026, 5, 10),
      "name": "Budi Santoso",
      "division": "Backend Developer",
      "location": "Bandung",
      "experience": "1 Tahun",
      "type": "Internship",
    },
    {
      "date": DateTime(2026, 5, 10),
      "name": "Citra Dewi",
      "division": "UI/UX Designer",
      "location": "Bekasi",
      "experience": "Fresh Graduate",
      "type": "Contract",
    },

    {
      "date": DateTime(2026, 5, 11),
      "name": "Deni Pratama",
      "division": "Mobile Developer",
      "location": "Jakarta",
      "experience": "3 Tahun",
      "type": "Full Time",
    },
    {
      "date": DateTime(2026, 5, 11),
      "name": "Eka Putri",
      "division": "QA Engineer",
      "location": "Bogor",
      "experience": "2 Tahun",
      "type": "Full Time",
    },
    {
      "date": DateTime(2026, 5, 11),
      "name": "Fajar Nugraha",
      "division": "Business Analyst",
      "location": "Depok",
      "experience": "1 Tahun",
      "type": "Contract",
    },
    {
      "date": DateTime(2026, 5, 11),
      "name": "Gina Amelia",
      "division": "Frontend Developer",
      "location": "Tangerang",
      "experience": "Fresh Graduate",
      "type": "Internship",
    },

    {
      "date": DateTime(2026, 5, 12),
      "name": "Hendra Wijaya",
      "division": "Backend Developer",
      "location": "Jakarta",
      "experience": "4 Tahun",
      "type": "Full Time",
    },
    {
      "date": DateTime(2026, 5, 12),
      "name": "Indah Permata",
      "division": "UI/UX Designer",
      "location": "Bandung",
      "experience": "2 Tahun",
      "type": "Contract",
    },

    {
      "date": DateTime(2026, 5, 13),
      "name": "Joko Susilo",
      "division": "Mobile Developer",
      "location": "Jakarta",
      "experience": "5 Tahun",
      "type": "Full Time",
    },
    {
      "date": DateTime(2026, 5, 13),
      "name": "Karin Putri",
      "division": "QA Engineer",
      "location": "Bekasi",
      "experience": "1 Tahun",
      "type": "Contract",
    },
    {
      "date": DateTime(2026, 5, 13),
      "name": "Lutfi Ramadhan",
      "division": "Business Analyst",
      "location": "Bogor",
      "experience": "Fresh Graduate",
      "type": "Internship",
    },

    {
      "date": DateTime(2026, 5, 14),
      "name": "Maya Sari",
      "division": "Frontend Developer",
      "location": "Jakarta",
      "experience": "2 Tahun",
      "type": "Full Time",
    },
    {
      "date": DateTime(2026, 5, 14),
      "name": "Nanda Putra",
      "division": "Backend Developer",
      "location": "Depok",
      "experience": "3 Tahun",
      "type": "Contract",
    },
    {
      "date": DateTime(2026, 6, 1),
      "name": "Olivia Ananda",
      "division": "UI/UX Designer",
      "location": "Bandung",
      "experience": "1 Tahun",
      "type": "Full Time",
    },
  ];

  List<Map<String, dynamic>> get applicantData {
    final Map<DateTime, int> grouped = {};

    for (var item in divisionData) {
      final date = item["date"] as DateTime;

      final key = DateTime(
        date.year,
        date.month,
        date.day,
      );

      grouped[key] = (grouped[key] ?? 0) + 1;
    }

    return grouped.entries.map((e) {
      return {
        "date": e.key,
        "count": e.value,
      };
    }).toList();
  }

  List<Map<String, dynamic>> getApplicantsByDivision(String division) {
    return filteredDivisionData.where((item) {
      return item["division"] == division;
    }).toList();
  }

  List<Map<String, dynamic>> filteredDivisionData = [];

  List<Map<String, dynamic>> filteredData = [];

  final List<Color> pieColors = [
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();
    filteredData = List.from(applicantData);
    filteredDivisionData = List.from(divisionData);
  }

  List<Map<String, dynamic>> getApplicantsByDate(DateTime date) {
    return divisionData.where((item) {
      final d = item["date"] as DateTime;
      return d.year == date.year &&
          d.month == date.month &&
          d.day == date.day;
    }).toList();
  }

  int get totalApplicant {
    return filteredData.fold(
      0,
          (sum, item) => sum + (item["count"] as int),
    );
  }

  Future<void> pickDateRange() async {
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      initialDateRange: selectedRange,
    );

    if (result != null) {
      setState(() {
        selectedRange = result;

        filteredData = applicantData.where((item) {
          final date = item["date"] as DateTime;

          return date.isAfter(
            result.start.subtract(const Duration(days: 1)),
          ) &&
              date.isBefore(
                result.end.add(const Duration(days: 1)),
              );
        }).toList();
        filteredDivisionData = divisionData.where((item) {
          final date = item["date"] as DateTime;

          return date.isAfter(
            result.start.subtract(const Duration(days: 1)),
          ) &&
              date.isBefore(
                result.end.add(const Duration(days: 1)),
              );
        }).toList();
      });
    }
  }

  void resetFilter() {
    setState(() {
      selectedRange = null;
      filteredData = List.from(applicantData);
      filteredDivisionData = List.from(divisionData);
    });
  }

  @override
  void dispose() {
    _isNavigating = false;
    super.dispose();
  }

  String get rangeText {
    if (selectedRange == null) {
      return "Pilih Periode";
    }

    return "${selectedRange!.start.day}/${selectedRange!.start.month}/${selectedRange!.start.year}"
        " - "
        "${selectedRange!.end.day}/${selectedRange!.end.month}/${selectedRange!.end.year}";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          // BAR CHART
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black12,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Statistik CV Masuk",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (selectedRange != null)
                      TextButton(
                        onPressed: resetFilter,
                        child: const Text(
                          "Reset",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 15),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.08),
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.people_alt,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total CV Masuk",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "$totalApplicant Pelamar",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                InkWell(
                  onTap: pickDateRange,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                      ),
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            rangeText,
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.w500,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 300,
                  child: filteredData.isEmpty
                      ? const Center(
                    child: Text(
                      "Tidak ada data pada periode ini",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  )
                      : BarChart(
                    BarChartData(
                      alignment:
                      BarChartAlignment.spaceAround,

                      barTouchData: BarTouchData(
                        enabled: true,
                        touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
                          if (response == null || response.spot == null) return;

                          if (event is FlTapUpEvent) {
                            if (_isNavigating) return;

                            _isNavigating = true;

                            final index = response.spot!.touchedBarGroupIndex;
                            final date = filteredData[index]["date"] as DateTime;
                            final result = getApplicantsByDate(date);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ApplicantByDateScreen(
                                  date: date,
                                  applicants: result,
                                ),
                              ),
                            ).whenComplete(() {
                              if (mounted) {
                                setState(() {
                                  _isNavigating = false;
                                });
                              }
                            });
                          }
                        },
                      ),

                      maxY: (filteredData
                          .map((e) =>
                      e["count"] as int)
                          .reduce((a, b) =>
                      a > b ? a : b) +
                          3)
                          .toDouble(),

                      borderData: FlBorderData(
                        show: false,
                      ),

                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 2,
                      ),

                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 35,
                            interval: 2,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget:
                                (value, meta) {
                              final index =
                              value.toInt();

                              if (index >=
                                  filteredData
                                      .length) {
                                return const SizedBox();
                              }

                              final date =
                              filteredData[index]
                              ["date"]
                              as DateTime;

                              return Padding(
                                padding:
                                const EdgeInsets
                                    .only(
                                  top: 8,
                                ),
                                child: Text(
                                  "${date.day}/${date.month}",
                                  style:
                                  const TextStyle(
                                    fontSize: 11,
                                    fontWeight:
                                    FontWeight
                                        .w500,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      barGroups: List.generate(
                        filteredData.length,
                            (index) {
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: (filteredData[
                                index]
                                ["count"]
                                as int)
                                    .toDouble(),
                                width: 24,
                                color:
                                Colors.orange,
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  8,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // PIE CHART
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black12,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Divisi Paling Diminati",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 250,
                  child: filteredDivisionData.isEmpty
                      ? const Center(
                    child: Text(
                      "Tidak ada data pada periode ini",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  )
                      : Builder(
                    builder: (context) {
                      final Map<String, int> divisionCount = {};

                      for (var item in filteredDivisionData) {
                        final div = item["division"] as String;
                        divisionCount[div] =
                            (divisionCount[div] ?? 0) + 1;
                      }

                      final entries = divisionCount.entries.toList();

                      final total = entries.fold<int>(
                        0,
                            (sum, e) => sum + e.value,
                      );

                      return PieChart(
                        PieChartData(
                          sectionsSpace: 3,
                          centerSpaceRadius: 55,

                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, PieTouchResponse? response) {

                              if (event is! FlTapUpEvent) return;

                              if (response == null ||
                                  response.touchedSection == null) {
                                return;
                              }

                              if (_isNavigating) return;

                              _isNavigating = true;

                              final index =
                                  response.touchedSection!.touchedSectionIndex;

                              final division = entries[index].key;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ApplicationByDivisionScreen(
                                    division: division,
                                    applicants: getApplicantsByDivision(
                                      division,
                                    ),
                                  ),
                                ),
                              ).then((_) {
                                _isNavigating = false;
                              });
                            },
                          ),

                          sections: List.generate(entries.length, (i) {
                            final percent =
                                (entries[i].value / total) * 100;

                            return PieChartSectionData(
                              value: entries[i].value.toDouble(),
                              color: pieColors[i % pieColors.length],
                              title: "${percent.toStringAsFixed(0)}%",
                              radius: 60,
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Builder(
                  builder: (context) {
                    final Map<String, int> divisionCount = {};

                    for (var item in filteredDivisionData) {
                      final div = item["division"] as String;
                      divisionCount[div] =
                          (divisionCount[div] ?? 0) + 1;
                    }

                    final entries = divisionCount.entries.toList();

                    return Wrap(
                      spacing: 16,
                      runSpacing: 10,
                      children: List.generate(entries.length, (i) {
                        return LegendItem(
                          color: pieColors[i % pieColors.length],
                          text:
                          "${entries[i].key} (${entries[i].value})",
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
            BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}