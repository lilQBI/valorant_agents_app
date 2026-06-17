import 'dart:convert';
import 'package:http/http.dart' as http;
import '../agent_repository.dart';

class AgentApiService {
  static const String apiUrl = "https://valorant-api.com/v1/agents?isPlayableCharacter=true";

  static Future<List<Agent>> fetchAgents() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final List agentsJson = data["data"];

      return agentsJson.map((agentMap) {
        return Agent(
          id: agentMap["uuid"] ?? "",
          name: agentMap["displayName"] ?? "",
          description: agentMap["description"] ?? "",
          iconUrl: agentMap["displayIcon"] ?? "",
          fullPortrait: agentMap["fullPortrait"] ?? "",
          role: agentMap["role"]?["displayName"] ?? "Brak roli",
        );
      }).toList();
    } else {
      throw Exception("Błąd pobierania danych z serwera REST API");
    }
  }
}