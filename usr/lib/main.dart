import 'package:flutter/material.dart';

void main() {
  runApp(const EvaluationMethodsApp());
}

class EvaluationMethodsApp extends StatelessWidget {
  const EvaluationMethodsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perbandingan Evaluasi Program',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metode Evaluasi Kesejahteraan Sosial'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Perbandingan Metode Evaluasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Memahami perbedaan antara Cost-Effectiveness Analysis (CEA), Cost-Benefit Analysis (CBA), dan Social Return on Investment (SROI) dalam konteks program kesejahteraan sosial.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                // Responsive layout: 1 column for small screens, 3 columns for wide screens
                if (constraints.maxWidth > 800) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildMethodCard(context, MethodData.cea)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildMethodCard(context, MethodData.cba)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildMethodCard(context, MethodData.sroi)),
                    ],
                  );
                } else if (constraints.maxWidth > 500) {
                   return Column(
                    children: [
                      Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildMethodCard(context, MethodData.cea)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildMethodCard(context, MethodData.cba)),
                        ]
                      ),
                      const SizedBox(height: 16),
                      _buildMethodCard(context, MethodData.sroi),
                    ]
                   );
                } else {
                  return Column(
                    children: [
                      _buildMethodCard(context, MethodData.cea),
                      const SizedBox(height: 16),
                      _buildMethodCard(context, MethodData.cba),
                      const SizedBox(height: 16),
                      _buildMethodCard(context, MethodData.sroi),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 32),
            _buildContextSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodCard(BuildContext context, Method method) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: method.color.withOpacity(0.2),
                  child: Icon(method.icon, color: method.color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    method.acronym,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              method.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Divider(height: 24),
            _buildFeatureSection('Fokus Utama', method.focus),
            const SizedBox(height: 12),
            _buildFeatureSection('Satuan Pengukuran', method.measurement),
            const SizedBox(height: 12),
            _buildFeatureSection('Contoh Kasus', method.example),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildContextSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              const Text(
                'Konteks Program Kesejahteraan Sosial',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Dalam mengevaluasi program kesejahteraan sosial, pemilihan metode bergantung pada tujuan analisis:\n\n'
            '• Gunakan CEA jika Anda memiliki tujuan spesifik yang ingin dicapai (misal: menurunkan angka gizi buruk) dan ingin mencari cara paling murah untuk mencapainya.\n\n'
            '• Gunakan CBA jika Anda perlu membenarkan alokasi anggaran secara keseluruhan kepada penyandang dana dengan menunjukkan bahwa nilai moneter dari manfaat melebihi biaya.\n\n'
            '• Gunakan SROI jika program Anda sangat berfokus pada pemberdayaan, memiliki banyak stakeholder, dan Anda ingin menangkap nilai dari perubahan sosial atau lingkungan yang sulit diukur hanya dengan uang.',
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class Method {
  final String acronym;
  final String name;
  final String focus;
  final String measurement;
  final String example;
  final IconData icon;
  final Color color;

  const Method({
    required this.acronym,
    required this.name,
    required this.focus,
    required this.measurement,
    required this.example,
    required this.icon,
    required this.color,
  });
}

class MethodData {
  static const Method cea = Method(
    acronym: 'CEA',
    name: 'Cost-Effectiveness Analysis',
    focus: 'Membandingkan biaya dari intervensi yang berbeda untuk mencapai tujuan atau hasil spesifik yang sama.',
    measurement: 'Biaya per unit hasil (Contoh: Rp / anak yang divaksinasi, Rp / penurunan 1% tingkat kemiskinan).',
    example: 'Membandingkan biaya pemberian makanan tambahan vs. edukasi gizi untuk menurunkan angka stunting.',
    icon: Icons.trending_down,
    color: Colors.blue,
  );

  static const Method cba = Method(
    acronym: 'CBA',
    name: 'Cost-Benefit Analysis',
    focus: 'Menentukan apakah manfaat suatu program lebih besar daripada biayanya.',
    measurement: 'Rasio manfaat terhadap biaya (Semua diukur dalam satuan mata uang yang sama, misalnya Rupiah).',
    example: 'Menilai apakah program pelatihan kerja sepadan dengan biayanya dengan membandingkan biaya pelatihan dengan total peningkatan pendapatan peserta (diuangkan).',
    icon: Icons.account_balance_wallet,
    color: Colors.green,
  );

  static const Method sroi = Method(
    acronym: 'SROI',
    name: 'Social Return on Investment',
    focus: 'Mengukur nilai perubahan sosial, lingkungan, dan ekonomi yang diciptakan oleh suatu program, dengan penekanan kuat pada partisipasi stakeholder.',
    measurement: 'Rasio nilai (Contoh: Setiap Rp 1 yang diinvestasikan menghasilkan Rp 3 nilai sosial). Termasuk indikator proxy.',
    example: 'Mengevaluasi program pemberdayaan perempuan dengan mengukur tidak hanya peningkatan pendapatan, tetapi juga nilai dari peningkatan kepercayaan diri dan kohesi komunitas.',
    icon: Icons.people_alt,
    color: Colors.orange,
  );
}
