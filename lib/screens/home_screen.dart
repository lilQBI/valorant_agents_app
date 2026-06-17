import 'package:flutter/material.dart';
import '../agent_repository.dart';
import '../services/agent_local_database.dart';
import '../services/agent_sync_service.dart';
import 'detail_screen.dart';


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
        title: const Text("VALORANT AGENTS"),
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
              return Card(
                  elevation:2,
                  margin: const EdgeInsets.symmetric(vertical:6),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8),
                leading: agent.iconUrl.isNotEmpty ? Image.network(
                  agent.iconUrl,
                  width: 60,
                  height:60,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 60),
                )
                    :const Icon(Icons.person, size: 60),
                title: Text(agent.name.toUpperCase()),
                subtitle: Text(
                    "Role: ${agent.role}",
                    style: const TextStyle(color: Colors.red),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push (
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(agent: agent),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}