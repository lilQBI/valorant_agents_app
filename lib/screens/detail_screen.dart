import 'package:flutter/material.dart';
import '../agent_repository.dart';

class DetailScreen extends StatelessWidget {
  final Agent agent;

  const DetailScreen({super.key, required this.agent});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(agent.name.toUpperCase())
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
                agent.fullPortrait,
                height: 300,
                fit: BoxFit.contain
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ROLE: ${agent.role.toUpperCase()}",
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "AGENT BIOGRAPHY",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Divider(color: Colors.redAccent, thickness: 2),
                  const SizedBox(height: 12),
                  Text(
                    agent.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    "SKILLS",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Divider(color: Colors.redAccent, thickness: 2),
                  const SizedBox(height: 12),

                  for (var ability in agent.abilities)
                    if ((ability["displayName"] ?? "").toString().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (ability["displayIcon"] != null)
                                Image.network(
                                  ability["displayIcon"],
                                  width: 60,
                                  height: 60,
                                  color: Colors.white,
                                )
                              else
                                const Icon(Icons.bolt, size: 60, color: Colors.white),

                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (ability["displayName"] ?? "").toString().toUpperCase(),
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      (ability["description"] ?? "Brak opisu").toString(),
                                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}