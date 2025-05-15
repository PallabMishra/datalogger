import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() => runApp(const VoltageDashboardApp());

class VoltageDashboardApp extends StatelessWidget {
  const VoltageDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voltage Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Voltage Data Aggregation and Monitoring System',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        actions: [
          buildDropdownWidget('All States', ['All States', 'Karnataka']),
          buildDropdownWidget('All Districts', ['All Districts', 'Bangalore']),
          buildDropdownWidget('All Pincodes', ['All Pincodes', '560001']),
          buildDropdownWidget('2025', ['2025', '2024']),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                print("Submit clicked");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                elevation: 2,
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text('Guest User', style: TextStyle(color: Colors.white)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('US'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildInfoCard(
                  'Total Users',
                  '123,456',
                  Colors.blue.shade100,
                  Colors.blue.shade900,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const IndiaMapScreen()),
                    );
                  },
                ),
                buildInfoCard(
                  'Online Users',
                  '5,678',
                  Colors.green.shade100,
                  Colors.green.shade900,
                  () {
                    print("Online Users Clicked");
                  },
                ),
                buildInfoCard(
                  'Offline Users',
                  '1,234',
                  Colors.red.shade100,
                  Colors.red.shade900,
                  () {
                    print("Offline Users Clicked");
                  },
                ),
                buildInfoCard(
                  'New Users Added Today',
                  '123',
                  Colors.yellow.shade100,
                  Colors.orange.shade900,
                  () {
                    print("New Users Clicked");
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 👉 Right side: Heading
                const Text(
                  'Voltage Distribution Range',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // 👈 Left side: Dropdowns
                Row(
                  children: [
                    buildFilterDropdown('Day', [
                      'Day',
                      'Yesterday',
                      '2 Days Ago',
                    ]),
                    const SizedBox(width: 8),
                    buildFilterDropdown('Week', ['This Week', 'Last Week']),
                    const SizedBox(width: 8),
                    buildFilterDropdown('Month', [
                      'January',
                      'February',
                      'March',
                    ]),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 200,
                  minY: 180,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        reservedSize: 40,
                        getTitlesWidget:
                            (value, meta) => Text(
                              '${value.toInt()} V',
                              style: const TextStyle(fontSize: 12),
                            ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: true, horizontalInterval: 5),
                  borderData: FlBorderData(show: false),
                  barGroups:
                      voltageValues
                          .asMap()
                          .entries
                          .map(
                            (e) => BarChartGroupData(
                              x: e.key,
                              barRods: [
                                BarChartRodData(
                                  toY: e.value,
                                  color: Colors.lightBlueAccent,
                                  width: 10,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(thickness: 1, color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterDropdown(String value, List<String> options) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: options.contains(value) ? value : options.first,
          items:
              options
                  .map(
                    (option) =>
                        DropdownMenuItem(value: option, child: Text(option)),
                  )
                  .toList(),
          onChanged: (newValue) {
            // TODO: update filter state
          },
        ),
      ),
    );
  }

  final List<double> voltageValues = [
    193,
    196,
    194,
    197,
    196,
    197.5,
    196,
    197.5,
    196,
    196.5,
    195.5,
    195,
    195.5,
    195.2,
    196.8,
    194.5,
    197,
    195.6,
    198,
    194.7,
    197.8,
    196.5,
    198,
    197.6,
    198,
  ];

  Widget buildDropdownWidget(String currentValue, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.7)),
          ),
          child: DropdownButton<String>(
            value: currentValue,
            onChanged: (value) {
              print('$currentValue changed to $value');
            },
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            iconSize: 28,
            dropdownColor: Colors.blue.shade50,
            style: const TextStyle(color: Colors.white),
            items:
                options
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(
    String title,
    String value,
    Color backgroundColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: textColor.withOpacity(0.4)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontSize: 16, color: textColor)),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IndiaMapScreen extends StatelessWidget {
  const IndiaMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductData> dummyDataList = [
      ProductData(
        macId: 'AA:BB:CC:DD:EE:01',
        state: 'Karnataka',
        district: 'Bangalore',
        lastUsedTime: DateTime.now().subtract(const Duration(days: 1)),
        facturationCount: 120,
      ),
      ProductData(
        macId: 'AA:BB:CC:DD:EE:02',
        state: 'Tamil Nadu',
        district: 'Chennai',
        lastUsedTime: DateTime.now().subtract(const Duration(days: 3)),
        facturationCount: 95,
      ),
      ProductData(
        macId: 'AA:BB:CC:DD:EE:03',
        state: 'Maharashtra',
        district: 'Pune',
        lastUsedTime: DateTime.now().subtract(const Duration(days: 2)),
        facturationCount: 85,
      ),
      ProductData(
        macId: 'AA:BB:CC:DD:EE:04',
        state: 'Kerala',
        district: 'Kochi',
        lastUsedTime: DateTime.now().subtract(const Duration(days: 5)),
        facturationCount: 60,
      ),
    ];

    final stateWiseFacturation = [
      {'state': 'Karnataka', 'count': 120},
      {'state': 'Tamil Nadu', 'count': 95},
      {'state': 'Maharashtra', 'count': 85},
      {'state': 'Kerala', 'count': 60},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set background to white
        iconTheme: const IconThemeData(
          color: Colors.blue,
        ), // Changes the back arrow color if needed
        title: const Text(
          'India Map',
          style: TextStyle(
            color: Colors.blue, // Set title text color to blue
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 1,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            const Text(
              'Product Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...dummyDataList.map((data) {
              return Card(
                child: ListTile(
                  title: Text('MAC ID: ${data.macId}'),
                  subtitle: Text('${data.state}, ${data.district}'),
                  trailing: Text('Used: ${data.lastUsedTime.day} days ago'),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class ProductData {
  final String macId;
  final String state;
  final String district;
  final DateTime lastUsedTime;
  final int facturationCount;

  ProductData({
    required this.macId,
    required this.state,
    required this.district,
    required this.lastUsedTime,
    required this.facturationCount,
  });
}
