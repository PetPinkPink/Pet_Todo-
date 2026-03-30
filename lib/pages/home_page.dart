import 'package:flutter/material.dart';
import 'main_app_screen.dart';
import 'author_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  final VoidCallback onToggleTheme;
  const HomePage({super.key, required this.username, required this.onToggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentDrawerIndex = -1; 

  static const Color myPurple = Color.fromARGB(255, 195, 88, 234);

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) return "Chào buổi sáng ☀️";
    if (hour < 18) return "Chào buổi chiều 🌤️";
    return "Chào buổi tối 🌙";
  }

  void _showEmilyProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EmilyProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color uniformBg = Theme.of(context).scaffoldBackgroundColor;

    Widget welcomeScreen = Column(
      children: [
     
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Xin chào,", style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const Text(
                    "Emily", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _showEmilyProfile(context),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(color: myPurple, shape: BoxShape.circle),
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('images/logo.png'), 
                  ),
                ),
              ),
            ],
          ),
        ),
        
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.pets, size: 100, color: myPurple),
              const SizedBox(height: 25),
              Text(getGreeting(), style: const TextStyle(fontSize: 20, color: Colors.grey)),
              const SizedBox(height: 10),
              Text(
                widget.username, 
                style: const TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold, 
                  color: myPurple,
                  letterSpacing: 1.1
                ),
              ),
              const SizedBox(height: 60), 
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: uniformBg, 
      appBar: AppBar(
        title: InkWell(
          onTap: () => setState(() => _currentDrawerIndex = -1),
          child: const Text("Pet Todo", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
        backgroundColor: myPurple,
        foregroundColor: Colors.white,
        elevation: 0, 
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu), 
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: uniformBg,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: myPurple,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/logo.png'),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Pet Todo", 
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(
                  Icons.apps, 
                  color: _currentDrawerIndex == 0 ? myPurple : (isDark ? Colors.white70 : Colors.grey)
                ),
                title: Text(
                  "App", 
                  style: TextStyle(
                    color: _currentDrawerIndex == 0 
                        ? myPurple 
                        : (isDark ? Colors.white : Colors.black87),
                    fontWeight: _currentDrawerIndex == 0 ? FontWeight.bold : FontWeight.normal
                  )
                ),
                selected: _currentDrawerIndex == 0,
                onTap: () {
                  setState(() => _currentDrawerIndex = 0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person_outline, 
                  color: _currentDrawerIndex == 1 ? myPurple : (isDark ? Colors.white70 : Colors.grey)
                ),
                title: Text(
                  "Tác giả", 
                  style: TextStyle(
                    color: _currentDrawerIndex == 1 
                        ? myPurple 
                        : (isDark ? Colors.white : Colors.black87),
                    fontWeight: _currentDrawerIndex == 1 ? FontWeight.bold : FontWeight.normal
                  )
                ),
                selected: _currentDrawerIndex == 1,
                onTap: () {
                  setState(() => _currentDrawerIndex = 1);
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Đăng xuất", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      body: _currentDrawerIndex == -1 
          ? welcomeScreen 
          : IndexedStack(
              index: _currentDrawerIndex,
              children: [
                MainAppScreen(username: widget.username), 
                const AuthorPage(),
              ],
            ),
    );
  }
}

class EmilyProfilePage extends StatelessWidget {
  const EmilyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color emilyPurple = Color.fromARGB(255, 195, 88, 234);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emily\'s Profile'),
        backgroundColor: emilyPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 70,
              backgroundColor: emilyPurple,
              child: CircleAvatar(
                radius: 66,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('images/logo.png'), 
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Emily Smith',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: emilyPurple),
            ),
            
            
            const SizedBox(height: 30),
            
            _buildProfileInfo(Icons.email_outlined, 'Email', 'emily.smith@example.com'),
            _buildProfileInfo(Icons.phone_android_outlined, 'Số điện thoại', '0 123 456 789'),
            _buildProfileInfo(Icons.cake_outlined, 'Ngày sinh', '19 tháng 11'),
            _buildProfileInfo(Icons.pets_outlined, 'Mục tiêu', 'Sống kỷ luật hơn, cố gắng hơn ngày hôm qua'),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(IconData icon, String title, String value) {
    const Color emilyPurple = Color.fromARGB(255, 195, 88, 234);
    
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: emilyPurple),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(value, style: const TextStyle(fontSize: 16)),
        ),
        const Divider(height: 1, indent: 70, endIndent: 20),
      ],
    );
  }
}