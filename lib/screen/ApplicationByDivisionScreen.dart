import 'package:flutter/material.dart';

class ApplicationByDivisionScreen extends StatelessWidget {
  final String division;
  final List<Map<String, dynamic>> applicants;

  const ApplicationByDivisionScreen({
    super.key,
    required this.division,
    required this.applicants,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Divisi $division"),
      ),
      body: applicants.isEmpty
          ? const Center(
        child: Text("Tidak ada pelamar pada divisi ini"),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: applicants.length,
        itemBuilder: (context, index) {
          final applicant = applicants[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(
                applicant["name"] ?? "Tanpa Nama",
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Divisi: ${applicant["division"]}"),
                  Text(
                    "Tanggal: ${applicant["date"].day}/${applicant["date"].month}/${applicant["date"].year}",
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