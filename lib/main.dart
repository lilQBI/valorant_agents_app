import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'agent_repository.dart';
import 'services/agent_local_database.dart';
import 'services/agent_sync_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("agents");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valorant Agents',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  late Future<List<Agent>> agentsFuture;

  @override
  void initState() {
    super.initState();
    agentsFuture = loadAgents();
  }

  Future<List<Agent>> loadAgents() async {
    await AgentSyncService.loadInitialDataIfNeeded();
    final agents = AgentLocalDatabase.getAgents();
    return agents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Valorant agents"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Agent>>(
        future: agentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Błąd: ${snapshot.error}",
                style: const TextStyle(color: Colors.red, fontSize: 16)));
          }
          final agents = snapshot.data ?? [];

          return ListView.builder(
            itemCount: agents.length,
            itemBuilder: (context, index) {
              final agent = agents[index];
              return ListTile(
                leading: const Icon(Icons.person, color: Colors.red),
                title: Text(agent.name.toUpperCase()),
                subtitle: Text(agent.role),
              );
            },
          );
        },
      ),
    );
  }
}