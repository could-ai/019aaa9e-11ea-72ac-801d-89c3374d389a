import 'package:flutter/material.dart';
import 'package:dreams_reader/widgets/export_menu.dart';

class PlanDashboardScreen extends StatefulWidget {
  final String initialDream;

  const PlanDashboardScreen({super.key, required this.initialDream});

  @override
  State<PlanDashboardScreen> createState() => _PlanDashboardScreenState();
}

class _PlanDashboardScreenState extends State<PlanDashboardScreen> {
  final List<Map<String, String>> _chatHistory = [];
  final TextEditingController _chatController = TextEditingController();
  String _currentPlan = "";

  @override
  void initState() {
    super.initState();
    _generateInitialPlan();
    _chatHistory.add({
      "role": "ai",
      "message": "I have analyzed your dream: \"${widget.initialDream}\". Here is your strategic plan. I am here to guide you. We will not stop until you achieve this."
    });
  }

  void _generateInitialPlan() {
    // Mocking the AI plan generation based on the user's dream
    _currentPlan = """
# MASTER PLAN: ${widget.initialDream.toUpperCase()}

## PHASE 1: FOUNDATION
1. Research the core requirements for your goal.
2. Set up a daily routine dedicating 2 hours to this dream.
3. Remove distractions that do not serve this purpose.

## PHASE 2: EXECUTION
1. Begin the first practical project.
2. Connect with 5 mentors in this field.
3. Fail fast, learn faster. Do not fear mistakes.

## PHASE 3: MASTERY
1. Teach what you have learned to others.
2. Scale your efforts by automating routine tasks.
3. Never give up. Persistence is the key.

## MOTIVATION
"The only limit to our realization of tomorrow will be our doubts of today."
    """;
  }

  void _sendMessage() {
    if (_chatController.text.trim().isEmpty) return;

    final userMsg = _chatController.text;
    setState(() {
      _chatHistory.add({"role": "user", "message": userMsg});
      _chatController.clear();
    });

    // Simulate AI response and plan update
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _chatHistory.add({
          "role": "ai",
          "message": "I've updated the plan based on your request: \"$userMsg\". Let's adjust our strategy."
        });
        _currentPlan += "\n\n## ADJUSTMENT\n- New strategy added: $userMsg\n- Keep pushing forward!";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive layout: Split screen on wide devices, Tab/Column on mobile
    final isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Strategy"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => const ExportMenu(),
              );
            },
            tooltip: "Export Plan",
          ),
        ],
      ),
      body: isWide ? _buildWideLayout() : _buildMobileLayout(),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildPlanView(),
        ),
        const VerticalDivider(width: 1, color: Colors.white24),
        Expanded(
          flex: 2,
          child: _buildChatView(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: _buildPlanView(),
        ),
        const Divider(height: 1, color: Colors.white24),
        Expanded(
          flex: 2,
          child: _buildChatView(),
        ),
      ],
    );
  }

  Widget _buildPlanView() {
    return Container(
      color: const Color(0xFF1A1A2E),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "THE BLUEPRINT",
            style: TextStyle(
              color: Color(0xFFE94560),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                _currentPlan,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.6,
                  fontFamily: 'Courier', // Monospace for a "code/plan" feel
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatView() {
    return Container(
      color: const Color(0xFF16213E),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF0F3460),
            width: double.infinity,
            child: const Text(
              "AI COACH",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) {
                final msg = _chatHistory[index];
                final isAi = msg["role"] == "ai";
                return Align(
                  alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 260),
                    decoration: BoxDecoration(
                      color: isAi ? const Color(0xFF1A1A2E) : const Color(0xFFE94560),
                      borderRadius: BorderRadius.circular(12),
                      border: isAi ? Border.all(color: Colors.white24) : null,
                    ),
                    child: Text(
                      msg["message"] ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Modify the plan...",
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send, color: Color(0xFFE94560)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
