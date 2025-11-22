import 'package:flutter/material.dart';

class ExportMenu extends StatelessWidget {
  const ExportMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF16213E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Generate & Export",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Select a format to generate your plan using the Python engine.",
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _ExportButton(
                icon: Icons.description,
                label: "DOCS",
                color: Colors.blue,
                onTap: () => _simulateGeneration(context, "DOCX"),
              ),
              _ExportButton(
                icon: Icons.slideshow,
                label: "PPTX",
                color: Colors.orange,
                onTap: () => _simulateGeneration(context, "PPTX"),
              ),
              _ExportButton(
                icon: Icons.picture_as_pdf,
                label: "PDF",
                color: Colors.red,
                onTap: () => _simulateGeneration(context, "PDF"),
              ),
              _ExportButton(
                icon: Icons.table_chart,
                label: "XLSX",
                color: Colors.green,
                onTap: () => _simulateGeneration(context, "Excel"),
              ),
              _ExportButton(
                icon: Icons.image,
                label: "JPEG",
                color: Colors.purple,
                onTap: () => _simulateGeneration(context, "JPEG"),
              ),
              _ExportButton(
                icon: Icons.image_outlined,
                label: "PNG",
                color: Colors.deepPurple,
                onTap: () => _simulateGeneration(context, "PNG"),
              ),
              _ExportButton(
                icon: Icons.audiotrack,
                label: "MP3",
                color: Colors.teal,
                onTap: () => _simulateGeneration(context, "MP3"),
              ),
              _ExportButton(
                icon: Icons.movie,
                label: "MP4",
                color: Colors.pink,
                onTap: () => _simulateGeneration(context, "MP4"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _simulateGeneration(BuildContext context, String format) {
    Navigator.pop(context); // Close sheet
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1A1A2E),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: Color(0xFFE94560)),
              const SizedBox(height: 24),
              Text(
                "Generating $format...",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                "Running Python script...",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );

    // Simulate backend delay
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$format generated successfully! (Simulated)"),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: "OPEN",
              textColor: Colors.white,
              onPressed: () {
                // In a real app, this would open the file
              },
            ),
          ),
        );
      }
    });
  }
}

class _ExportButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ExportButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F3460),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
