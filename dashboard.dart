import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({Key? key}) : super(key: key);

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  late User _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _verifyAuthState();
  }

  Future<void> _verifyAuthState() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, 'login');
      }
      return;
    }

    setState(() {
      _currentUser = user;
      _isLoading = false;
    });
  }

  Future<void> _signOut() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushReplacementNamed(context, 'login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout failed. Please try again')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              Text(
                _currentUser.email ?? 'Welcome back!',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFF4F8FF),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey[200],
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: _currentUser.photoURL != null
                                  ? Image.network(
                                _currentUser.photoURL!,
                                fit: BoxFit.cover,
                              )
                                  : Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Hello, ${_currentUser.displayName ?? _currentUser.email ?? 'User'}!',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Your existing dashboard content
                        _buildStatCard(
                          title: "Today's Inspections",
                          value: "16",
                          color: const Color.fromARGB(255, 248, 191, 4),
                        ),
                        _buildStatCard(
                          title: "Failed Panels",
                          value: "8",
                          color: const Color.fromARGB(255, 252, 14, 42),
                        ),
                        _buildStatCard(
                          title: "Passed Panels",
                          value: "12",
                          color: const Color.fromARGB(255, 156, 229, 30),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF514AD4),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, 'inspection');
                            },
                            child: const Text(
                              'Start New Inspection',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF4F9FF),
        boxShadow: [
          BoxShadow(
            color: const Color(0x40000000).withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 35),
      margin: const EdgeInsets.only(bottom: 20, left: 21, right: 21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 