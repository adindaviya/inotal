import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> jobs = [
    {
      "title": "Backend Developer",
      "applicants": 5,
      "seen": 0,
    },
    {
      "title": "UI/UX Designer",
      "applicants": 2,
      "seen": 0,
    },
    {
      "title": "Mobile Developer",
      "applicants": 0,
      "seen": 0,
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void updateSeen(String title, int seenCount) {
    final index =
    jobs.indexWhere((element) => element["title"] == title);
    if (index != -1) {
      setState(() {
        jobs[index]["seen"] = seenCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text("Company Chat"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.orange,
          tabs: const [
            Tab(text: "Chat"),
            Tab(text: "Lamaran"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _chatTab(),
          _lamaranTab(),
        ],
      ),
    );
  }

  Widget _chatTab() {
    return Column(
      children: [
        _buildSearchBar(),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: const [
              ChatTile(
                initials: 'AL',
                name: 'Alya Nur',
                role: 'Frontend Developer Applicant',
                message: 'Saya tertarik dengan posisi ini',
                time: '10:30',
                unread: 2,
              ),
              ChatTile(
                initials: 'RA',
                name: 'Rafi Ahmad',
                role: 'Backend Developer Applicant',
                message: 'Apakah masih open recruitment?',
                time: '09:12',
                unread: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _lamaranTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        final int applicants = job["applicants"] as int;
        final int seen = job["seen"] as int;
        final int remaining = applicants - seen;

        return InkWell(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ApplicantListScreen(
                  jobTitle: job["title"] as String,
                  totalApplicants: applicants,
                  initialSeen: seen,
                ),
              ),
            );

            if (result != null) {
              updateSeen(job["title"] as String, result as int);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: remaining == 0
                  ? Colors.grey[200]
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: remaining == 0
                    ? Colors.grey.shade300
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: remaining == 0
                      ? Colors.grey
                      : Colors.orangeAccent,
                  child:
                  const Icon(Icons.work, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    job["title"] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: remaining == 0
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ),
                if (remaining > 0)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      remaining.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Cari kandidat atau chat lamaran...',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Icon(Icons.filter_list, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String initials;
  final String name;
  final String role;
  final String message;
  final String time;
  final int unread;

  const ChatTile({
    super.key,
    required this.initials,
    required this.name,
    required this.role,
    required this.message,
    required this.time,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orangeAccent,
            child: Text(
              initials,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow:
                        TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        overflow:
                        TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.grey),
                      ),
                    ),
                    if (unread > 0)
                      Container(
                        margin:
                        const EdgeInsets.only(
                            left: 8),
                        padding:
                        const EdgeInsets.all(6),
                        decoration:
                        const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          unread.toString(),
                          style:
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ApplicantListScreen extends StatefulWidget {
  final String jobTitle;
  final int totalApplicants;
  final int initialSeen;

  const ApplicantListScreen({
    super.key,
    required this.jobTitle,
    required this.totalApplicants,
    required this.initialSeen,
  });

  @override
  State<ApplicantListScreen> createState() =>
      _ApplicantListScreenState();
}

class _ApplicantListScreenState
    extends State<ApplicantListScreen> {
  late List<bool> seenList;

  final List<String> names = [
    "Ahmad Fauzan",
    "Rina Putri",
    "Budi Santoso",
    "Dewi Lestari",
    "Andi Saputra",
    "Siti Rahma",
    "Fajar Nugroho",
    "Nabila Putri",
    "Rizky Pratama",
    "Intan Permata"
  ];

  @override
  void initState() {
    super.initState();
    seenList = List.generate(
      widget.totalApplicants,
          (index) => index < widget.initialSeen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final workers =
    List.generate(widget.totalApplicants, (index) {
      return {
        "name": names[index % names.length],
        "role": widget.jobTitle,
        "experience": "${(index % 3) + 1} tahun",
        "location": "Indonesia",
        "date": "${10 + index} Mei 2026",
        "skills": ["Flutter", "UI Design", "API"]
      };
    });

    return WillPopScope(
      onWillPop: () async {
        final totalSeen =
            seenList.where((e) => e).length;
        Navigator.pop(context, totalSeen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.jobTitle),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        backgroundColor: Colors.grey[100],
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: workers.length,
          itemBuilder: (context, index) {
            final worker = workers[index];
            final isSeen = seenList[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isSeen
                    ? Colors.grey[200]
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: isSeen
                              ? Colors.grey
                              : Colors.orangeAccent,
                          child: Text(
                            (worker["name"] as String)
                                .substring(0, 1),
                            style: const TextStyle(
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            worker["name"] as String,
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color: isSeen
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(worker["role"] as String),
                    const SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${worker["experience"] as String} • ${worker["location"] as String}",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "CV Masuk: ${worker["date"]}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: (worker["skills"]
                      as List<String>)
                          .map(
                            (e) => Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration:
                          BoxDecoration(
                            color: Colors.orange
                                .withOpacity(
                                0.12),
                            borderRadius:
                            BorderRadius
                                .circular(20),
                          ),
                          child: Text(
                            e,
                            style:
                            const TextStyle(
                                fontSize: 12),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment:
                      Alignment.centerRight,
                      child: ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          isSeen
                              ? Colors.grey
                              : Colors.orange,
                        ),
                        onPressed: () {
                          if (!seenList[index]) {
                            setState(() {
                              seenList[index] = true;
                            });
                          }
                        },
                        child: Text(
                          isSeen
                              ? "Sudah Dilihat"
                              : "Lihat CV",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}