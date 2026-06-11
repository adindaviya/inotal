import 'package:flutter/material.dart';

class ApplicantByDateScreen extends StatelessWidget {
  final DateTime date;
  final List<Map<String, dynamic>> applicants;

  const ApplicantByDateScreen({
    super.key,
    required this.date,
    required this.applicants,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pelamar ${date.day}/${date.month}/${date.year}",
        ),
      ),
      body: applicants.isEmpty
          ? const Center(
        child: Text(
          "Tidak ada pelamar pada tanggal ini",
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: applicants.length,
        itemBuilder: (context, index) {
          final applicant = applicants[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 24,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          applicant["name"] ?? "-",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(
                              Icons.work_outline,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                applicant["division"] ?? "-",
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                applicant["location"] ?? "-",
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            const Icon(
                              Icons.badge_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                "Pengalaman: ${applicant["experience"] ?? "-"}",
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            const Icon(
                              Icons.business_center_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                applicant["type"] ?? "-",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Tanggal Apply: ${date.day}/${date.month}/${date.year}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}