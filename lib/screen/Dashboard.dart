import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = "Semua";
  String selectedRole = "Semua";
  String selectedLocation = "Semua";
  String selectedExperience = "Semua";

  final List<Map<String, dynamic>> workers = [
    {
      "name": "Ahmad Fauzan",
      "experience": "2 tahun",
      "education": "2022–sekarang • Telkom University",
      "skills": ["Flutter", "Dart", "Firebase", "UI Design", "Git", "REST API"],
      "location": "Bandung",
      "type": "Full Time",
      "role": "UI/UX Designer",
      "about":
      "UI/UX designer dengan fokus pada desain mobile modern yang clean dan user-friendly. Berpengalaman membuat prototype hingga implementasi UI ke aplikasi Flutter dengan performa optimal.",
      "portfolio": ["App UI 1", "App UI 2"],
      "date": "10 Mei 2026"
    },
    {
      "name": "Rina Putri",
      "experience": "1 tahun",
      "education": "2023–sekarang • Universitas Indonesia",
      "skills": ["HTML", "CSS", "JavaScript", "Bootstrap", "Figma", "Responsive Design"],
      "location": "Jakarta",
      "type": "Magang",
      "role": "Web Developer",
      "about":
      "Frontend developer yang fokus pada pembuatan website responsif dan modern. Terbiasa mengubah desain UI menjadi website interaktif yang optimal di semua perangkat.",
      "portfolio": ["Website A", "Website B"],
      "date": "11 Mei 2026"
    },
    {
      "name": "Budi Santoso",
      "experience": "3 tahun",
      "education": "2020–2024 • Institut Teknologi Bandung",
      "skills": ["NodeJS", "ExpressJS", "MongoDB", "Docker", "Microservices", "REST API"],
      "location": "Surabaya",
      "type": "Part Time",
      "role": "Backend Developer",
      "about":
      "Backend developer berpengalaman dalam membangun API scalable dan sistem backend yang aman. Terbiasa menggunakan arsitektur modern seperti microservices dan containerization.",
      "portfolio": ["API Project A"],
      "date": "12 Mei 2026"
    },
  ];

  List<Map<String, dynamic>> get filteredWorkers {
    return workers.where((w) {
      final typeMatch =
          selectedCategory == "Semua" || w["type"] == selectedCategory;

      final roleMatch =
          selectedRole == "Semua" || w["role"] == selectedRole;

      final locationMatch =
          selectedLocation == "Semua" || w["location"] == selectedLocation;

      final expMatch =
          selectedExperience == "Semua" || w["experience"] == selectedExperience;

      return typeMatch && roleMatch && locationMatch && expMatch;
    }).toList();
  }

  void openFilterSheet() {
    final roles = ["Semua", "UI/UX Designer", "Web Developer", "Backend Developer"];
    final locations = ["Semua", "Bandung", "Jakarta", "Surabaya"];
    final experiences = ["Semua", "1 tahun", "2 tahun", "3 tahun"];

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Filter",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  DropdownButton(
                    value: selectedRole,
                    isExpanded: true,
                    items: roles
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setModalState(() => selectedRole = v!),
                  ),

                  DropdownButton(
                    value: selectedLocation,
                    isExpanded: true,
                    items: locations
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setModalState(() => selectedLocation = v!),
                  ),

                  DropdownButton(
                    value: selectedExperience,
                    isExpanded: true,
                    items: experiences
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setModalState(() => selectedExperience = v!),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text("Terapkan"),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = filteredWorkers;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text("Daftar Pekerja"),
        actions: [
          IconButton(
            onPressed: openFilterSheet,
            icon: const Icon(Icons.filter_list),
          )
        ],
      ),

      body: Column(
        children: [
          _buildTabs(),

          Expanded(
            child: list.isEmpty
                ? const Center(child: Text("Tidak ada data"))
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final worker = list[index];

                return InkWell(
                  onTap: () {
                  },
                  child: WorkerCard(
                    name: worker["name"],
                    role: worker["role"],
                    type: worker["type"],
                    experience: worker["experience"],
                    location: worker["location"],
                    skills: List<String>.from(worker["skills"]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final categories = ["Semua", "Magang", "Full Time", "Part Time"];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: categories.map((cat) {
          final active = selectedCategory == cat;

          return GestureDetector(
            onTap: () => setState(() => selectedCategory = cat),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Text(
                cat,
                style: TextStyle(
                  color: active ? Colors.orange : Colors.grey,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class WorkerCard extends StatelessWidget {
  final String name;
  final String role;
  final String type;
  final String experience;
  final String location;
  final List<String> skills;

  const WorkerCard({
    super.key,
    required this.name,
    required this.role,
    required this.type,
    required this.experience,
    required this.location,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(role),

            const SizedBox(height: 6),

            Text(
              "$type • $experience",
              style: const TextStyle(color: Colors.grey),
            ),

            Text(
              location,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: skills
                  .take(4)
                  .map(
                    (e) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}