import 'package:hive_ce/hive.dart';
import '../agent_repository.dart';

class AgentLocalDatabase {
  static Box get _box => Hive.box("agents");

  static List<Agent> getAgents() {
    return _box.values.map((item) {
      return Agent.fromMap(Map<String, dynamic>.from(item));
    }).toList();
  }

  static Future<void> saveAgents(List<Agent> agents) async {
    await _box.clear();
    for (final agent in agents) {
      await _box.put(agent.id, agent.toMap());
    }
  }

  static bool isEmpty() {
    return _box.isEmpty;
  }
}