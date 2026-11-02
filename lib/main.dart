import 'package:flutter/material.dart';

void main() {
  runApp(const CampusEventsApp());
}

// ================= COLORS =================

const Color navy = Color(0xFF18243A);
const Color purple = Color(0xFF7566C8);
const Color lightPurple = Color(0xFFF1EEFF);
const Color background = Color(0xFFF7F7FB);

// ================= DATA =================

List<Map<String, String>> events = [
  {
    'name': 'Tech Fest 2026',
    'date': '10 October 2026',
    'venue': 'College Auditorium',
    'category': 'Technical',
    'description':
        'A technical festival with coding, quiz and project competitions.',
  },
  {
    'name': 'Cultural Fest',
    'date': '15 October 2026',
    'venue': 'Main Ground',
    'category': 'Cultural',
    'description':
        'A cultural event with music, dance and performances.',
  },
  {
    'name': 'Sports Day',
    'date': '20 October 2026',
    'venue': 'College Ground',
    'category': 'Sports',
    'description':
        'Annual sports event with various indoor and outdoor games.',
  },
];

List<Map<String, String>> registrations = [];

// ================= APP =================

class CampusEventsApp extends StatelessWidget {
  const CampusEventsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Events',
      theme: ThemeData(
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: purple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/events': (context) => const EventsPage(),
        '/about': (context) => const AboutPage(),
        '/admin': (context) => const AdminPage(),
        '/register': (context) => const RegistrationPage(),
        '/details': (context) => const EventDetailsPage(),
      },
    );
  }
}

// ================= BOTTOM NAVIGATION =================

class BottomNav extends StatelessWidget {
  final int selectedIndex;

  const BottomNav({
    super.key,
    required this.selectedIndex,
  });

  void navigate(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/events');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/about');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/admin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: purple,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        navigate(context, index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          label: 'Admin',
        ),
      ],
    );
  }
}

// ================= HOME PAGE =================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Campus Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double horizontalPadding =
              constraints.maxWidth > 700 ? 100 : 25;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 70,
                  ),
                  color: navy,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.event_available,
                        size: 80,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'CAMPUS EVENTS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Discover. Participate. Experience.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/events',
                          );
                        },
                        child: const Text(
                          'Explore Events',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  'Featured Events',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: events.map((event) {
                    return EventCard(
                      event: event,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNav(
        selectedIndex: 0,
      ),
    );
  }
}

// ================= EVENT CARD =================

class EventCard extends StatelessWidget {
  final Map<String, String> event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0.8,
        end: 1.0,
      ),
      duration: const Duration(
        milliseconds: 500,
      ),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: SizedBox(
            width: 300,
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.event,
                      size: 45,
                      color: purple,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      event['name']!,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('📅 ${event['date']}'),
                    const SizedBox(height: 5),
                    Text('📍 ${event['venue']}'),
                    const SizedBox(height: 5),
                    Text(
                      'Category: ${event['category']}',
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: event,
                        );
                      },
                      child: const Text(
                        'View Details',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ================= EVENTS PAGE =================

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int columns =
              constraints.maxWidth > 900 ? 3 : 1;

          return GridView.builder(
            padding: const EdgeInsets.all(25),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.3,
            ),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventCard(
                event: events[index],
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNav(
        selectedIndex: 1,
      ),
    );
  }
}

// ================= EVENT DETAILS =================

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final event =
        ModalRoute.of(context)!.settings.arguments
            as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 600,
            margin: const EdgeInsets.all(25),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const Icon(
                      Icons.event_available,
                      size: 80,
                      color: purple,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      event['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      '📅 ${event['date']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '📍 ${event['venue']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Category: ${event['category']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      event['description']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/register',
                          arguments: event,
                        );
                      },
                      child: const Text(
                        'Register for Event',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= REGISTRATION PAGE =================

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState
    extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  String? selectedDepartment;

  final departments = [
    'CSE',
    'ECE',
    'EEE',
    'IT',
    'CSD',
  ];

  @override
  Widget build(BuildContext context) {
    final event =
        ModalRoute.of(context)!.settings.arguments
            as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Registration'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(25),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        'Register for ${event['name']}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                      const SizedBox(height: 25),

                      TextFormField(
                        controller: nameController,
                        decoration:
                            const InputDecoration(
                          labelText: 'Student Name',
                          prefixIcon:
                              Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: emailController,
                        decoration:
                            const InputDecoration(
                          labelText: 'Email',
                          prefixIcon:
                              Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please enter email';
                          }

                          if (!value.contains('@')) {
                            return 'Enter a valid email';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      TextFormField(
                        controller: phoneController,
                        keyboardType:
                            TextInputType.phone,
                        decoration:
                            const InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon:
                              Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please enter phone number';
                          }

                          if (value.length != 10) {
                            return 'Phone number must contain 10 digits';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration(
                          labelText: 'Department',
                        ),
                        value: selectedDepartment,
                        items: departments.map(
                          (department) {
                            return DropdownMenuItem(
                              value: department,
                              child: Text(department),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDepartment =
                                value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select department';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 25),

                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!
                              .validate()) {
                            registrations.add({
                              'name':
                                  nameController.text,
                              'email':
                                  emailController.text,
                              'phone':
                                  phoneController.text,
                              'department':
                                  selectedDepartment!,
                              'event':
                                  event['name']!,
                            });

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Registration Successful!',
                                  ),
                                  content: Text(
                                    'You have registered for '
                                    '${event['name']}.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context);
                                        Navigator.pop(
                                            context);
                                      },
                                      child:
                                          const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text('REGISTER'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= ADMIN DASHBOARD =================

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() =>
      _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final formKey = GlobalKey<FormState>();

  final nameController =
      TextEditingController();

  final dateController =
      TextEditingController();

  final venueController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  String? selectedCategory;

  final categories = [
    'Technical',
    'Cultural',
    'Sports',
    'Workshop',
  ];

  // ================= REGISTRATION COUNT =================

  int getRegistrationCount(String eventName) {
    return registrations
        .where(
          (registration) =>
              registration['event'] == eventName,
        )
        .length;
  }

  int get totalRegistrations {
    return registrations.length;
  }

  String get mostRegisteredEvent {
    if (events.isEmpty) {
      return 'No events';
    }

    String mostEvent = events.first['name']!;
    int maxCount =
        getRegistrationCount(mostEvent);

    for (var event in events) {
      int count =
          getRegistrationCount(event['name']!);

      if (count > maxCount) {
        maxCount = count;
        mostEvent = event['name']!;
      }
    }

    return mostEvent;
  }

  double get averageRegistrations {
    if (events.isEmpty) {
      return 0;
    }

    return registrations.length / events.length;
  }

  // ================= ADD EVENT =================

  void addEvent() {
    if (formKey.currentState!.validate()) {
      setState(() {
        events.add({
          'name': nameController.text,
          'date': dateController.text,
          'venue': venueController.text,
          'category': selectedCategory!,
          'description':
              descriptionController.text,
        });
      });

      nameController.clear();
      dateController.clear();
      venueController.clear();
      descriptionController.clear();

      setState(() {
        selectedCategory = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'New event added successfully!',
          ),
        ),
      );
    }
  }

  // ================= DASHBOARD CARD =================

  Widget dashboardCard(
    String title,
    String value,
    IconData icon,
  ) {
    return SizedBox(
      width: 240,
      child: Card(
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: lightPurple,
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: purple,
                  size: 28,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      value,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= EVENT REGISTRATION CARD =================

  Widget eventRegistrationCard(
      Map<String, String> event) {
    int count =
        getRegistrationCount(event['name']!);

    return Card(
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: lightPurple,
          child: const Icon(
            Icons.event,
            color: purple,
          ),
        ),
        title: Text(
          event['name']!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        subtitle: Text(
          '${event['date']} • ${event['venue']}',
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: lightPurple,
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: Text(
            '$count ${count == 1 ? 'Registration' : 'Registrations'}',
            style: const TextStyle(
              color: purple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // ================= RECENT REGISTRATION =================

  Widget recentRegistrationCard(
      Map<String, String> registration) {
    return Card(
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: lightPurple,
          child: Icon(
            Icons.person,
            color: purple,
          ),
        ),
        title: Text(
          registration['name']!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        subtitle: Text(
          '${registration['event']} • '
          '${registration['department']}',
        ),
      ),
    );
  }

  // ================= VIEW ALL REGISTRATIONS =================

  void showAllRegistrations() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'All Registrations',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: 600,
            child: registrations.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'No registrations yet.',
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        registrations.length,
                    itemBuilder:
                        (context, index) {
                      final registration =
                          registrations[index];

                      return Card(
                        child: ListTile(
                          leading:
                              const CircleAvatar(
                            child: Icon(
                              Icons.person,
                            ),
                          ),
                          title: Text(
                            registration['name']!,
                          ),
                          subtitle: Text(
                            '${registration['event']}\n'
                            '${registration['email']} • '
                            '${registration['department']}',
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  // ================= ADMIN PAGE =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Container(
            constraints:
                const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                // HEADER
                const Text(
                  'Dashboard Overview',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Manage events and monitor student registrations',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 25),

                // SUMMARY CARDS
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    dashboardCard(
                      'Total Events',
                      '${events.length}',
                      Icons.event,
                    ),
                    dashboardCard(
                      'Total Registrations',
                      '$totalRegistrations',
                      Icons.people,
                    ),
                    dashboardCard(
                      'Average / Event',
                      averageRegistrations
                          .toStringAsFixed(1),
                      Icons.bar_chart,
                    ),
                    dashboardCard(
                      'Most Registered',
                      mostRegisteredEvent,
                      Icons.star,
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // EVENT REGISTRATION SECTION
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Event Registrations',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),
                    Text(
                      '${events.length} Events',
                      style: const TextStyle(
                        color: purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                if (events.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'No events available.',
                      ),
                    ),
                  )
                else
                  ...events.map(
                    (event) =>
                        eventRegistrationCard(event),
                  ),

                const SizedBox(height: 30),

                // RECENT REGISTRATIONS
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Registrations',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed:
                          showAllRegistrations,
                      icon: const Icon(
                        Icons.visibility,
                      ),
                      label: const Text(
                        'View All Registrations',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                if (registrations.isEmpty)
                  const Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: purple,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'No registrations yet.',
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...registrations.reversed
                      .take(5)
                      .map(
                        (registration) =>
                            recentRegistrationCard(
                                registration),
                      ),

                const SizedBox(height: 40),

                // ADD EVENT
                const Text(
                  'Add New Event',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),

                const SizedBox(height: 15),

                Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(25),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller:
                                nameController,
                            decoration:
                                const InputDecoration(
                              labelText: 'Event Name',
                              prefixIcon:
                                  Icon(Icons.event),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty) {
                                return 'Enter event name';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          TextFormField(
                            controller:
                                dateController,
                            decoration:
                                const InputDecoration(
                              labelText: 'Date',
                              hintText:
                                  'Example: 25 October 2026',
                              prefixIcon:
                                  Icon(Icons.calendar_today),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty) {
                                return 'Enter date';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          TextFormField(
                            controller:
                                venueController,
                            decoration:
                                const InputDecoration(
                              labelText: 'Venue',
                              prefixIcon:
                                  Icon(Icons.location_on),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty) {
                                return 'Enter venue';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          DropdownButtonFormField<String>(
                            decoration:
                                const InputDecoration(
                              labelText: 'Category',
                              prefixIcon:
                                  Icon(Icons.category),
                            ),
                            value:
                                selectedCategory,
                            items: categories.map(
                              (category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child:
                                      Text(category),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategory =
                                    value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Select category';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 15),

                          TextFormField(
                            controller:
                                descriptionController,
                            maxLines: 3,
                            decoration:
                                const InputDecoration(
                              labelText:
                                  'Description',
                              prefixIcon:
                                  Icon(Icons.description),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty) {
                                return 'Enter description';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          ElevatedButton.icon(
                            onPressed: addEvent,
                            icon: const Icon(
                              Icons.add,
                            ),
                            label: const Text(
                              'ADD EVENT',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // CURRENT EVENTS
                const Text(
                  'Manage Events',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),

                const SizedBox(height: 15),

                ...events.map(
                  (event) => Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: const Icon(
                        Icons.event,
                        color: purple,
                      ),
                      title: Text(
                        event['name']!,
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${event['date']} - '
                        '${event['venue']}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            events.remove(event);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(
        selectedIndex: 3,
      ),
    );
  }
}

// ================= ABOUT PAGE =================

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Center(
        child: Container(
          width: 650,
          padding: const EdgeInsets.all(30),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.school,
                    size: 80,
                    color: purple,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Campus Events',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Campus Events is a simple college '
                    'event management and registration '
                    'website. Students can view upcoming '
                    'events and register for them. '
                    'Administrators can add new events '
                    'and monitor student registrations.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(
        selectedIndex: 2,
      ),
    );
  }
}