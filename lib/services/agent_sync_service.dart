import 'agent_api_service.dart';
import 'agent_local_database.dart';
import '../agent_repository.dart';

class AgentSyncService {
  static Future<void> loadInitialDataIfNeeded() async {
    if (!AgentLocalDatabase.isEmpty()) {
      return;
    }

    try {
      final agents = await AgentApiService.fetchAgents();
      await AgentLocalDatabase.saveAgents(agents);
    } catch (e) {
      rethrow;
    }
  }
}