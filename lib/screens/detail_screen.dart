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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}