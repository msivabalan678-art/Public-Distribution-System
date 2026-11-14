import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SmartPdsApp());
}

const bg = Color(0xFFF0FCF4);
const mint = Color(0xFFE4F5EA);
const green = Color(0xFF00613F);
const darkGreen = Color(0xFF005538);
const ink = Color(0xFF182B25);
const muted = Color(0xFF66756E);
const line = Color(0xFFDCEFE3);
const orange = Color(0xFFFFDDB5);

class SmartPdsApp extends StatelessWidget {
  const SmartPdsApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Smart PDS Tamil Nadu',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: bg,
          colorScheme: ColorScheme.fromSeed(seedColor: green),
          fontFamily: 'Roboto',
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: line)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: line)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: green, width: 1.5)),
          ),
        ),
        home: const SplashScreen(),
      );
}

void message(BuildContext context, String text) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));

class Panel extends StatelessWidget {
  const Panel(
      {super.key,
      required this.child,
      this.color = Colors.white,
      this.padding = const EdgeInsets.all(14)});

  final Widget child;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: line),
          boxShadow: const [
            BoxShadow(
                color: Color(0x08004D32),
                blurRadius: 8,
                offset: Offset(0, 2))
          ],
        ),
        child: child,
      );
}

class Brand extends StatelessWidget {
  const Brand({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: compact ? 38 : 44,
            height: compact ? 38 : 44,
            decoration: BoxDecoration(
                color: green, borderRadius: BorderRadius.circular(11)),
            child: const Icon(Icons.verified_user_outlined,
                color: Colors.white, size: 26),
          ),
          const SizedBox(width: 9),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TN-EPDS • தமிழ்நாடு',
                  style: TextStyle(
                      fontSize: compact ? 10 : 11,
                      color: darkGreen,
                      fontWeight: FontWeight.w800)),
              Text(compact ? 'Smart PDS' : 'Home Dashboard',
                  style: TextStyle(
                      fontSize: compact ? 14 : 17,
                      fontWeight: FontWeight.w900,
                      color: ink)),
            ],
          ),
        ],
      );
}

class Tag extends StatelessWidget {
  const Tag(this.text,
      {super.key, this.color = mint, this.textColor = darkGreen});

  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: Text(text,
            style: TextStyle(
                fontSize: 10,
                color: textColor,
                fontWeight: FontWeight.w800)),
      );
}

class Tile extends StatelessWidget {
  const Tile(this.icon,
      {super.key,
      this.size = 42,
      this.color = mint,
      this.iconColor = green});

  final IconData icon;
  final double size;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: iconColor, size: size * .52),
      );
}

Widget actionButton(String label, VoidCallback onTap,
        {IconData icon = Icons.arrow_forward}) =>
    SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: darkGreen,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text(label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 13))),
            const SizedBox(width: 8),
            Icon(icon, size: 17)
          ],
        ),
      ),
    );

Widget pageTitle(String title, {Widget? trailing}) => Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: ink))),
          if (trailing != null) trailing
        ],
      ),
    );

Widget pageFrame(Widget child, {double maxWidth = 680}) => SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
            child: child,
          ),
        ),
      ),
    );

// ============================================================
// SCREEN 1 — SPLASH SCREEN
// ============================================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const RegisterScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: bg,
        body: pageFrame(
          Column(
            children: [
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: const Text(
                  'DEPARTMENT OF FOOD & CONSUMER\nPROTECTION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: darkGreen,
                      fontWeight: FontWeight.w900,
                      fontSize: 11),
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'உணவு மற்றும் நுகர்வோர் பாதுகாப்புத் துறை',
                style: TextStyle(color: darkGreen, fontSize: 11),
              ),

              const SizedBox(height: 28),

              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: line, width: 5),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0x22004D32), blurRadius: 20)
                  ],
                ),
                child: const Icon(Icons.account_balance,
                    color: green, size: 86),
              ),

              const SizedBox(height: 18),

              const Text(
                'Smart PDS TN',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: ink),
              ),

              const Text(
                'Your Smart Ration Assistant',
                style: TextStyle(
                    fontSize: 14,
                    color: darkGreen,
                    fontWeight: FontWeight.w700),
              ),

              const Text(
                'உங்கள் ஸ்மார்ட் ரேஷன் உதவியாளர்',
                style: TextStyle(fontSize: 12, color: ink),
              ),

              const SizedBox(height: 18),

              const Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  Icon(Icons.fingerprint,
                      size: 16, color: green),
                  Text('Biometric e-PoS',
                      style: TextStyle(
                          fontSize: 11, color: darkGreen)),
                  Icon(Icons.qr_code_2,
                      size: 16, color: green),
                  Text('Smart Token',
                      style: TextStyle(
                          fontSize: 11, color: darkGreen)),
                ],
              ),

              const SizedBox(height: 28),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 5, backgroundColor: green),
                  SizedBox(width: 8),
                  CircleAvatar(
                      radius: 5, backgroundColor: Color(0xFF8BC6A1)),
                  SizedBox(width: 8),
                  CircleAvatar(
                      radius: 5, backgroundColor: Color(0xFFFFC66D)),
                ],
              ),

              const SizedBox(height: 9),

              const Text(
                'SYNCING LIVE STOCK & QUOTAS...',
                style: TextStyle(
                    fontSize: 10,
                    color: muted,
                    letterSpacing: .5),
              ),

              const SizedBox(height: 26),

              const Text(
                'Government of Tamil Nadu • தமிழ்நாடு அரசு',
                style: TextStyle(
                    fontSize: 11,
                    color: darkGreen,
                    fontWeight: FontWeight.w700),
              ),

              const Text(
                'National Informatics Centre (NIC) • e-Governance Initiative',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: muted),
              ),

              const SizedBox(height: 18),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterScreen()));
                },
                child: const Text('Continue',
                    style: TextStyle(color: darkGreen)),
              ),
            ],
          ),
        ),
      );
}

// ============================================================
// SCREEN 2 — RATION CARD REGISTRATION
// ============================================================

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String cardType = 'PHH';
  String district = 'Coimbatore';
  String taluk = 'Cbe South';
  bool accepted = true;
  bool isSaving = false;

  final nameController = TextEditingController(text: 'K. Muthukumar');
  final cardNumberController = TextEditingController(text: '03 / G / 0248591');
  final mobileController = TextEditingController(text: '+91 98421 84029');
  final shopController = TextEditingController(text: 'FPS102 - Gandhipuram Central');

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    mobileController.dispose();
    shopController.dispose();
    super.dispose();
  }

  Future<void> _saveRegistration() async {
    if (!accepted) {
      message(context, 'Please accept the verification declaration.');
      return;
    }

    final name = nameController.text.trim();
    final cardNumber = cardNumberController.text.trim();
    final mobile = mobileController.text.trim();
    final shop = shopController.text.trim();

    if (name.isEmpty || cardNumber.isEmpty || mobile.isEmpty) {
      message(context, 'Please complete your name, ration card number and mobile number.');
      return;
    }

    setState(() => isSaving = true);
    try {
      final db = FirebaseFirestore.instance;
      final userRef = await db.collection('users').add({
        'name': name,
        'mobile': mobile,
        'city': district,
        'district': district,
        'taluk': taluk,
        'userType': 'beneficiary',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await db.collection('ration_cards').add({
        'rationCardNumber': cardNumber,
        'cardType': cardType,
        'holderName': name,
        'district': district,
        'taluk': taluk,
        'shopCode': shop,
        'userId': userRef.id,
        'verificationStatus': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      message(context, 'Registration details saved. OTP verification is still a demo.');
      Navigator.push(context, MaterialPageRoute(builder: (_) => const OtpScreen()));
    } catch (e) {
      if (mounted) message(context, 'Could not save registration: $e');
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  Widget field(String label, TextEditingController controller, IconData icon) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 17, color: green),
              isDense: true,
            ),
          ),
        ],
      );

  Widget dropdown(String label, String value,
          List<String> options, ValueChanged<String?> onChanged) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            decoration: const InputDecoration(isDense: true),
            style: const TextStyle(fontSize: 11, color: ink),
            items: options
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, overflow: TextOverflow.ellipsis)))
                .toList(),
            onChanged: onChanged,
          ),
        ],
      );

  Widget typeOption(String code, String title) => Expanded(
        child: InkWell(
          onTap: () => setState(() => cardType = code),
          child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 9, horizontal: 3),
            decoration: BoxDecoration(
              color: cardType == code ? mint : Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                  color: cardType == code ? green : line),
            ),
            child: Column(
              children: [
                Text(code,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: darkGreen)),
                Text(title,
                    style: const TextStyle(fontSize: 9)),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: bg,
          title: const Text('Step 1 of 2',
              style: TextStyle(fontSize: 12, color: darkGreen)),
          centerTitle: true,
        ),
        body: pageFrame(
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LinearProgressIndicator(
                    value: 1 / 2,
                    color: green,
                    backgroundColor: line,
                    minHeight: 5),

                const SizedBox(height: 14),

                const Text(
                  'Register Your Ration Card',
                  style: TextStyle(
                      fontSize: 21, fontWeight: FontWeight.w900),
                ),

                const Text(
                  'ரேஷன் கார்டை பதிவு செய்யவும்',
                  style: TextStyle(
                      fontSize: 13,
                      color: darkGreen,
                      fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 11),

                const Panel(
                  child: Row(
                    children: [
                      Tile(Icons.account_balance),
                      SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'TN Civil Supplies & Consumer Protection\nEnter details exactly as printed on your Tamil Nadu Smart Family Card.',
                          style: TextStyle(fontSize: 10, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 11),

                field('Full Name • குடும்பத் தலைவர் பெயர்',
                    nameController, Icons.person_outline),

                const SizedBox(height: 10),

                field('Ration Card Number • குடும்ப அட்டை எண்',
                    cardNumberController, Icons.badge_outlined),

                const SizedBox(height: 10),

                field('Registered Mobile Number • பதிவு செய்யப்பட்ட எண்',
                    mobileController, Icons.phone_android),

                const SizedBox(height: 11),

                const Text(
                  'Ration Card Type • அட்டை வகை',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w800),
                ),

                const SizedBox(height: 5),

                Panel(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    children: [
                      typeOption('PHH', 'Priority'),
                      const SizedBox(width: 6),
                      typeOption('AAY', 'Antyodaya'),
                      const SizedBox(width: 6),
                      typeOption('NPHH', 'General'),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: dropdown(
                        'District • மாவட்டம்',
                        district,
                        [
                          'Coimbatore',
                          'Chennai',
                          'Madurai',
                          'Thanjavur'
                        ],
                        (v) => setState(
                            () => district = v ?? district),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: dropdown(
                        'Taluk / Area',
                        taluk,
                        [
                          'Cbe South',
                          'Cbe North',
                          'Pollachi',
                          'Mettupalayam'
                        ],
                        (v) =>
                            setState(() => taluk = v ?? taluk),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                field(
                    'Fair Price Shop Code • கடை குறியீடு',
                    shopController,
                    Icons.storefront_outlined),

                const SizedBox(height: 5),

                const Text(
                  'Assigned: Shop 03A0A12PN     Find Code? / கடை',
                  style: TextStyle(fontSize: 9, color: muted),
                ),

                const SizedBox(height: 11),

                Panel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.verified_user, color: green),
                          SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              'Official TN Government Verification',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'Data is securely synchronized with the TNPDS Master Registry. Online registration does not require biometric scanning or fingerprint details.',
                        style: TextStyle(
                            fontSize: 10,
                            color: muted,
                            height: 1.4),
                      ),

                      const SizedBox(height: 8),

                      InkWell(
                        onTap: () =>
                            setState(() => accepted = !accepted),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              accepted
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: green,
                              size: 18,
                            ),
                            const SizedBox(width: 7),
                            const Expanded(
                              child: Text(
                                'I confirm that I am the registered Smart Card holder or a designated family beneficiary. I agree that my details will be verified securely.',
                                style: TextStyle(
                                    fontSize: 10, height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 13),

                actionButton(
                  isSaving ? 'Saving...' : 'Save & Continue / தொடர்க',
                  isSaving ? () {} : _saveRegistration,
                ),

                const SizedBox(height: 10),

                const Center(
                  child: Text(
                    'Need help finding FPS Code? / உதவி தேவை?',
                    style: TextStyle(fontSize: 9, color: muted),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

// ============================================================
// SCREEN 3 — OTP VERIFICATION
// ============================================================

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controllers = List.generate(
      6,
      (i) => TextEditingController(
          text: i < 5 ? ['5', '8', '2', '1', '4'][i] : ''));

  final nodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final n in nodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: bg,
          title: const Tag('● Step 2 of 2: Mobile Security'),
          centerTitle: true,
        ),
        body: pageFrame(
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),

                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: mint,
                    border: Border.all(
                        color: const Color(0xFF9DDFB8), width: 4),
                  ),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: green,
                      child: Icon(Icons.lock, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'OTP Verification',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w900),
                ),

                const Text(
                  'ஒருமுறை கடவுச்சொல் சரிபார்ப்பு',
                  style: TextStyle(
                      fontSize: 14,
                      color: darkGreen,
                      fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Enter the 6-digit OTP sent to registered mobile number',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: muted),
                ),

                const SizedBox(height: 12),

                const Tag('▮ +91 98421 •••••     Edit / மாற்று'),

                const SizedBox(height: 13),

                Panel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Secured Digit Verification\n(பாதுகாப்பான சரிபார்ப்பு)',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Auto-Read\nReady',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 10,
                                color: green,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),

                      const SizedBox(height: 11),

                      Row(
                        children: List.generate(
                          6,
                          (i) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: i == 5 ? 0 : 5),
                              child: SizedBox(
                                height: 48,
                                child: TextField(
                                  controller: controllers[i],
                                  focusNode: nodes[i],
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w900),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: mint,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onChanged: (v) {
                                    if (v.isNotEmpty && i < 5) {
                                      nodes[i + 1].requestFocus();
                                    }
                                    if (v.isEmpty && i > 0) {
                                      nodes[i - 1].requestFocus();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 7),

                      const Center(
                        child: Text(
                          'Tamil Nadu e-PoS / m-PDS Secure Numeric Gate',
                          style: TextStyle(
                              fontSize: 9, color: darkGreen),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 11),

                Panel(
                  color: mint,
                  child: Column(
                    children: [
                      const Text('◷ Resend OTP in 00:28',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800)),
                      const Text(
                          'மீண்டும் அனுப்பும் நேரம் முடிந்தவுடன்',
                          style: TextStyle(
                              fontSize: 10, color: muted)),
                      TextButton.icon(
                        onPressed: () =>
                            message(context, 'Demo OTP resent.'),
                        icon: const Icon(Icons.refresh, size: 15),
                        label: const Text(
                            'Resend via SMS / குறுஞ்செய்தி மீண்டும் பெற'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                const Panel(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFC7F4D8),
                        child:
                            Icon(Icons.check_circle, color: green),
                      ),
                      SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Smart Card Matched',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w900)),
                            Text(
                                'Ration Card 03/G/0248591 Authenticated!',
                                style: TextStyle(fontSize: 10)),
                            Text(
                                'Linking FPS102 stock data & quota ledger...',
                                style: TextStyle(
                                    fontSize: 9, color: muted)),
                          ],
                        ),
                      ),
                      Tag('PHH-ACTIVE',
                          color: darkGreen,
                          textColor: Colors.white),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                actionButton(
                  'Verify & Enter App / சரிபார்த்து உள்ளேறவும்',
                  () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MainShell()),
                      (route) => false,
                    );
                  },
                ),

                const SizedBox(height: 9),

                const Panel(
                  color: mint,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified_user,
                          color: green, size: 15),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Secured by TNeGA & National Informatics Centre (NIC)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 9,
                              color: darkGreen,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

// ============================================================
// MAIN APP — BOTTOM NAVIGATION
// ============================================================

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selected = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: selected,
            children: [
              DashboardScreen(
                  onOpenStock: () => setState(() => selected = 1)),
              const StockScreen(),
              const InfoScreen(
                title: 'Purchase History',
                tamil: 'வாங்கிய வரலாறு',
                icon: Icons.history,
                description:
                    'Your monthly ration collection records and digital receipts will appear here.',
              ),
              const InfoScreen(
                title: 'Alerts & Reminders',
                tamil: 'அறிவிப்புகள்',
                icon: Icons.notifications_active_outlined,
                description:
                    'Monthly quota reminders, stock arrival updates and distribution deadlines.',
              ),
              const InfoScreen(
                title: 'My Profile',
                tamil: 'விவரங்கள்',
                icon: Icons.badge_outlined,
                description:
                    'Smart Card holder details, family members, language preferences and help.',
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          height: 68,
          selectedIndex: selected,
          onDestinationSelected: (i) =>
              setState(() => selected = i),
          backgroundColor: const Color(0xFFF7FEF9),
          indicatorColor: mint,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.shopping_bag_outlined),
                selectedIcon: Icon(Icons.shopping_bag),
                label: 'Ration'),
            NavigationDestination(
                icon: Icon(Icons.history), label: 'History'),
            NavigationDestination(
                icon: Icon(Icons.notifications_none),
                label: 'Alerts'),
            NavigationDestination(
                icon: Icon(Icons.badge_outlined), label: 'Profile'),
          ],
        ),
      );
}

// ============================================================
// SCREEN 4 — HOME DASHBOARD
// ============================================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.onOpenStock});

  final VoidCallback onOpenStock;

  Widget quotaCard(
    IconData icon,
    String name,
    String subtitle,
    String quota,
    String collected,
    String balance,
    double progress,
    String status, {
    bool pending = false,
  }) =>
      Panel(
        color: const Color(0xFFF4FCF6),
        child: Column(
          children: [
            Row(
              children: [
                Tile(icon),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900)),
                      Text(subtitle,
                          style: const TextStyle(
                              fontSize: 10, color: darkGreen)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Quota',
                        style: TextStyle(
                            fontSize: 9, color: muted)),
                    Text(quota,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  color: green,
                  backgroundColor: line),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Text('Collected: $collected',
                    style: const TextStyle(
                        fontSize: 9, fontWeight: FontWeight.w700)),
                const Spacer(),
                Tag(status,
                    color: pending ? orange : mint,
                    textColor: pending
                        ? const Color(0xFF9B5D00)
                        : darkGreen),
                const Spacer(),
                Text('Balance: $balance',
                    style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: muted)),
              ],
            ),
          ],
        ),
      );

  Widget service(
    IconData icon,
    String title,
    String tamil,
    String detail,
    VoidCallback onTap,
  ) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Panel(
          color: const Color(0xFFF4FCF6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tile(icon),
              const SizedBox(height: 9),
              Text(title,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w900)),
              Text(tamil,
                  style: const TextStyle(
                      fontSize: 10,
                      color: darkGreen,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 3),
              Text(detail,
                  style: const TextStyle(
                      fontSize: 9, color: muted)),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth > 650;

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(child: Brand()),
                      IconButton(
                          onPressed: () =>
                              message(context, 'Citizen help desk'),
                          icon: const Icon(Icons.support_agent,
                              color: green)),
                      CircleAvatar(
                        backgroundColor: green,
                        child: IconButton(
                          onPressed: () =>
                              message(context, 'Profile settings'),
                          icon: const Icon(Icons.person_outline,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 9),

                  const Text('வணக்கம்! • Good Morning',
                      style: TextStyle(
                          fontSize: 12,
                          color: muted,
                          fontWeight: FontWeight.w700)),

                  const Text('K. Muthukumar',
                      style: TextStyle(
                          fontSize: 23,
                          color: ink,
                          fontWeight: FontWeight.w900)),

                  const Row(
                    children: [
                      Icon(Icons.calendar_month,
                          size: 14, color: green),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                            'Coimbatore South • Shop FPS102',
                            style: TextStyle(
                                fontSize: 11, color: muted)),
                      ),
                      Tag('தமிழ்'),
                    ],
                  ),

                  const SizedBox(height: 13),

                  Panel(
                    padding: EdgeInsets.zero,
                    color: const Color(0xFFF3FCF6),
                    child: Column(
                      children: [
                        Container(
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF72C79C),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16)),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'FAMILY SMART CARD\nஎண்',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: muted),
                                    ),
                                  ),
                                  Tag('சரிபார்க்கப்பட்டது'),
                                ],
                              ),

                              const Text(
                                '03 / G / 0248591',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w900),
                              ),

                              const SizedBox(height: 10),

                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: mint,
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Card Category',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: muted)),
                                          Text('PHH • Rice Card',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.w800)),
                                          Text(
                                              'முன்னுரிமை குடும்ப அட்டை',
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: muted)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Assigned FPS Shop',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: muted)),
                                          Text('FPS102',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.w900)),
                                          Text('Gandhipuram, CBE',
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: muted)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 11),

                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      '♙ 4 Members / 4 பயனாளிகள்',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: muted),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text(
                                              'Family Smart Card'),
                                          content: const Text(
                                            'Card No. 03/G/0248591\n'
                                            'Holder: K. Muthukumar\n'
                                            'FPS102 · Gandhipuram Central\n'
                                            'Family members: 4',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('Close'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.qr_code_2,
                                        size: 17),
                                    label: const Text('View Card / அட்டை'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: darkGreen,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 13),

                  const Panel(
                    color: Color(0xFFE4F6EA),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Tile(Icons.shopping_bag_outlined,
                            color: orange,
                            iconColor: Color(0xFF9B5D00)),
                        SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'நவம்பர் ஒதுக்கீடு பகுதியளவு பெறப்பட்டது',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '10 KG collected • 6 KG balance remaining across 2 commodities before Nov 30.',
                                style: TextStyle(
                                    fontSize: 11, color: muted),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'View Breakdown / விவரங்கள் →',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: darkGreen,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  pageTitle('November 2026 Entitlement',
                      trailing: const Tag('Valid till 30 Nov')),

                  const Text(
                    'நவம்பர் 2026 மாதாந்திர உரிமை அளவு',
                    style: TextStyle(fontSize: 10, color: muted),
                  ),

                  const SizedBox(height: 9),

                  quotaCard(
                      Icons.grain,
                      'Rice / அரிசி',
                      'Free / இலவசம் (₹0)',
                      '20 KG',
                      '10 KG',
                      '10 KG',
                      .5,
                      '50% Collected'),

                  const SizedBox(height: 8),

                  quotaCard(
                      Icons.grass,
                      'Wheat / கோதுமை',
                      'Free / இலவசம் (₹0)',
                      '5 KG',
                      '0 KG',
                      '5 KG',
                      0,
                      'Not Yet Collected'),

                  const SizedBox(height: 8),

                  quotaCard(
                      Icons.shopping_basket_outlined,
                      'Sugar / சர்க்கரை',
                      '₹25.00 / KG',
                      '1 KG',
                      '0 KG',
                      '1 KG',
                      0,
                      'Pending',
                      pending: true),

                  const SizedBox(height: 15),

                  pageTitle(
                    'Quick Services / விரைவு சேவைகள்',
                    trailing: const Text(
                      'ePDS Portal',
                      style: TextStyle(
                          fontSize: 10,
                          color: darkGreen,
                          fontWeight: FontWeight.w800),
                    ),
                  ),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: wide ? 3 : 2,
                    childAspectRatio: wide ? 1.55 : 1.15,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: [
                      service(
                          Icons.inventory_2_outlined,
                          'Check Shop Stock',
                          'கடையில் உள்ள இருப்பு',
                          'Live queue & inventory',
                          onOpenStock),
                      service(
                          Icons.receipt_long_outlined,
                          'Purchase History',
                          'வாங்கிய வரலாறு',
                          'Previous months data',
                          () => message(
                              context, 'Purchase History selected')),
                      service(
                          Icons.receipt_long_outlined,
                          'Digital Receipt',
                          'டிஜிட்டல் ரசீது',
                          'Instant e-PoS bills',
                          () => message(
                              context, 'Digital receipts selected')),
                      service(
                          Icons.event_available_outlined,
                          'Monthly Alert',
                          'மாத நினைவூட்டல்',
                          'Deadlines & reminders',
                          () => message(
                              context, 'Monthly alerts selected')),
                      service(
                          Icons.query_stats,
                          'Stock Forecast',
                          'இருப்பு கணிப்பு',
                          'AI depletion window',
                          onOpenStock),
                      service(
                          Icons.map_outlined,
                          'Find Shop / வழி',
                          'ரேஷன் கடை வழி',
                          'Map & shop in-charge',
                          () => message(context,
                              'FPS102 · Gandhipuram Central, Coimbatore')),
                    ],
                  ),

                  const SizedBox(height: 16),

                  pageTitle(
                    'FPS Alert / புதிய அறிவிப்பு',
                    trailing: const Text(
                      'Today 8:45 AM',
                      style: TextStyle(fontSize: 9, color: muted),
                    ),
                  ),

                  const Panel(
                    color: Color(0xFFF4FCF6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Tile(Icons.campaign_outlined,
                            color: green, iconColor: Colors.white),
                        SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text('Fresh Stock Arrived at FPS102',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900)),
                              SizedBox(height: 4),
                              Text(
                                'Sugar (500 KG) and Fortified Wheat are available from today 9:00 AM onwards. Token generation open.',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: muted,
                                    height: 1.4),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'FPS102 - காந்திபுரம் மத்திய நியாயவிலைக் கடை',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: darkGreen,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 11),

                  const Panel(
                    color: Color(0xFFF4FCF6),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: mint,
                          child: Icon(Icons.support_agent,
                              color: green),
                        ),
                        SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shop In-Charge / விற்பனையாளர்',
                                style: TextStyle(
                                    fontSize: 9, color: muted),
                              ),
                              Text('S. Rajendran',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900)),
                              Text(
                                '● Duty Active: 8:30 AM - 5:30 PM',
                                style: TextStyle(
                                    fontSize: 10, color: green),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.call, color: green),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

// ============================================================
// SCREEN 5 — ENTITLEMENTS AND STOCK
// ============================================================

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final search = TextEditingController();

  String filter = 'All Items';

  bool alertEnabled = false;

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  bool isVisible(String name) {
    if (!name.toLowerCase().contains(search.text.toLowerCase())) {
      return false;
    }

    if (filter == 'Available') {
      return name == 'Rice' ||
          name == 'Wheat' ||
          name == 'Toor Dal';
    }

    if (filter == 'Limited') return name == 'Kerosene';

    if (filter == 'Out of Stock') return name == 'Sugar';

    return true;
  }

  Widget filterChip(String value, String tamil) =>
      Padding(
        padding: const EdgeInsets.only(right: 7),
        child: ChoiceChip(
          label: Text('$value • $tamil',
              style: const TextStyle(fontSize: 10)),
          selected: filter == value,
          onSelected: (_) => setState(() => filter = value),
          selectedColor: darkGreen,
          backgroundColor: mint,
          labelStyle: TextStyle(
              color: filter == value ? Colors.white : ink,
              fontWeight: FontWeight.w700),
          side: BorderSide.none,
        ),
      );

  Widget commodity({
    required String name,
    required String tamil,
    required IconData icon,
    required String status,
    required String quantity,
    required String unit,
    required double progress,
    required String left,
    required String right,
    Color statusColor = mint,
    Color quantityColor = darkGreen,
    bool sugar = false,
  }) {
    if (!isVisible(name)) return const SizedBox.shrink();

    return Panel(
      color: const Color(0xFFF4FCF6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tile(
                icon,
                color: sugar
                    ? const Color(0xFFFFDAD7)
                    : (statusColor == orange ? orange : mint),
                iconColor: sugar
                    ? Colors.red
                    : (statusColor == orange
                        ? const Color(0xFF9B5D00)
                        : green),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name == 'Rice'
                          ? 'Rice - Raw & Boiled'
                          : name == 'Wheat'
                              ? 'Fortified Wheat'
                              : name == 'Sugar'
                                  ? 'Premium Sugar'
                                  : name == 'Toor Dal'
                                      ? 'Toor Dal (முழுப்பு)'
                                      : name,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900),
                    ),

                    Text(tamil,
                        style: const TextStyle(
                            fontSize: 10, color: muted)),

                    const SizedBox(height: 4),

                    Tag(
                      status,
                      color: statusColor,
                      textColor: sugar
                          ? Colors.red
                          : (statusColor == orange
                              ? const Color(0xFF9B5D00)
                              : darkGreen),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(quantity,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: quantityColor)),
                  Text(unit,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 9, color: muted)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          if (sugar) ...[
            Text(right,
                style: const TextStyle(
                    fontSize: 10, color: muted)),
            const SizedBox(height: 7),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    setState(() => alertEnabled = !alertEnabled),
                icon: Icon(
                    alertEnabled
                        ? Icons.notifications_active
                        : Icons.notifications_none,
                    size: 15),
                label: Text(
                  alertEnabled
                      ? 'Stock Alert Enabled'
                      : 'Alert When In Stock • வந்ததும் தெரிவி',
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                    child: Text(left,
                        style: const TextStyle(fontSize: 10))),
                Text(right,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ],
            ),

            const SizedBox(height: 6),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  color: quantityColor,
                  backgroundColor: line),
            ),

            const SizedBox(height: 7),

            const Row(
              children: [
                Icon(Icons.verified_outlined,
                    color: green, size: 13),
                SizedBox(width: 4),
                Expanded(
                  child: Text('e-PoS Verified',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700)),
                ),
                Text('Updated 10:30 AM today',
                    style: TextStyle(
                        fontSize: 9, color: muted)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth > 700;

        final cards = [
          commodity(
            name: 'Rice',
            tamil: 'பச்சரிசி & புழுங்கல் அரிசி',
            icon: Icons.grain,
            status: 'In Stock',
            quantity: '500',
            unit: 'KG Avail.',
            progress: .75,
            left: 'Silo Capacity: 75% full',
            right: 'Quota: Free (₹0/kg)',
          ),

          commodity(
            name: 'Wheat',
            tamil: 'செறிவூட்டப்பட்ட கோதுமை',
            icon: Icons.inventory_2_outlined,
            status: 'In Stock',
            quantity: '100',
            unit: 'KG Avail.',
            progress: .4,
            left: 'Silo Capacity: 40% full',
            right: 'NFSA Subsidized',
          ),

          commodity(
            name: 'Sugar',
            tamil: 'சர்க்கரை',
            icon: Icons.inventory_2_outlined,
            status: 'Out of Stock • இல்லை',
            quantity: '0',
            unit: 'KG Avail.',
            progress: 0,
            left: 'Supply in Transit',
            right: 'Expected tomorrow, 14 Nov by 11:00 AM',
            statusColor: const Color(0xFFFFDAD7),
            quantityColor: Colors.red,
            sugar: true,
          ),

          commodity(
            name: 'Kerosene',
            tamil: 'மண்ணெண்ணெய்',
            icon: Icons.local_gas_station,
            status: 'Limited • குறைந்த இருப்பு',
            quantity: '50',
            unit: 'Litres Avail.',
            progress: .15,
            left: 'Remaining Capacity: 15%',
            right: '₹15.00 / Litre',
            statusColor: orange,
            quantityColor: const Color(0xFF9B5D00),
          ),

          commodity(
            name: 'Toor Dal',
            tamil: 'TN Special PDS Scheme',
            icon: Icons.spa_outlined,
            status: 'In Stock',
            quantity: '120',
            unit: 'KG Avail.',
            progress: .6,
            left: 'Silo Capacity: 60% full',
            right: '₹30.00 / KG',
          ),
        ];

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(child: Brand()),
                      IconButton(
                          onPressed: () =>
                              message(context, 'Citizen support'),
                          icon: const Icon(Icons.support_agent,
                              color: green)),
                      const CircleAvatar(
                          backgroundColor: green,
                          child: Icon(Icons.person_outline,
                              color: Colors.white)),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Panel(
                    color: const Color(0xFFF4FCF6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Tag('FPS102'),
                            SizedBox(width: 7),
                            Tag('● OPEN NOW • இயங்குகிறது'),
                            Spacer(),
                            Icon(Icons.storefront, color: green),
                          ],
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          'Gandhipuram Central Fair Price Shop',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900),
                        ),

                        const Text(
                          '⌖ Cross Cut Road, Coimbatore South',
                          style: TextStyle(
                              fontSize: 10, color: muted),
                        ),

                        const Divider(color: line, height: 16),

                        const Row(
                          children: [
                            Expanded(
                              child: Text(
                                '♙ In-Charge: S. Ramalingam',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text('☎ Call',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: green,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          '◷ Today: 8:30 AM - 12:30 PM • 4:00 PM - 7:30 PM',
                          style: TextStyle(
                              fontSize: 9, color: muted),
                        ),

                        const SizedBox(height: 7),

                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                '☁ e-PoS Sync: 13 Nov 2026, 10:30 AM',
                                style: TextStyle(
                                    fontSize: 9, color: muted),
                              ),
                            ),
                            TextButton(
                              onPressed: () => message(context,
                                  'Stock refreshed from e-PoS register.'),
                              child: const Text('Refresh • புதுப்பி',
                                  style: TextStyle(fontSize: 10)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: search,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText:
                          'Search rice, wheat, sugar, kerosene / தேடுக',
                      hintStyle: TextStyle(fontSize: 11),
                    ),
                  ),

                  const SizedBox(height: 7),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        filterChip('All Items', 'அனைத்தும் (5)'),
                        filterChip('Available', 'இருப்பில் (3)'),
                        filterChip('Limited', 'குறைவு'),
                        filterChip('Out of Stock', 'இல்லை'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 9),

                  if (wide)
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: cards
                          .map((c) => SizedBox(
                              width: (constraints.maxWidth - 40) / 2,
                              child: c))
                          .toList(),
                    )
                  else
                    ...[
                      for (final c in cards) ...[
                        c,
                        const SizedBox(height: 8),
                      ],
                    ],

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '✧ Stock Forecast / இருப்பு கணிப்பு',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),

                        const SizedBox(height: 7),

                        const Text(
                          'Rice & Wheat expected to last 6+ days at current consumption rate. No queue rush detected right now.',
                          style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFFD5F3E1),
                              height: 1.45),
                        ),

                        const SizedBox(height: 10),

                        OutlinedButton.icon(
                          onPressed: () => message(context,
                              'e-Token booking will open when the shop enables token generation.'),
                          icon: const Icon(
                              Icons.confirmation_number_outlined,
                              size: 15),
                          label: const Text(
                              'Book e-Token • டோக்கன் முன்பதிவு'),
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide.none),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Panel(
                    color: Color(0xFFF4FCF6),
                    child: Row(
                      children: [
                        Icon(Icons.wifi, color: green, size: 37),
                        SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text('♙ Civil Supplies Dept',
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: darkGreen,
                                      fontWeight: FontWeight.w800)),
                              Text('TN e-PoS 4G Network',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900)),
                              Text(
                                'Real-time ledger connected to Tamil Nadu Civil Supplies...',
                                style: TextStyle(
                                    fontSize: 10, color: muted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 11),

                  const Panel(
                    color: Color(0xFFE7F6EC),
                    child: Text(
                      'ⓘ Disclaimer: Stock information is synchronized in real-time with authorized TN e-PoS distribution registers. Actual physical availability may vary slightly during peak distribution hours.',
                      style: TextStyle(fontSize: 10, height: 1.45),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

// ============================================================
// HISTORY, ALERTS AND PROFILE TABS
// ============================================================

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    super.key,
    required this.title,
    required this.tamil,
    required this.icon,
    required this.description,
  });

  final String title;
  final String tamil;
  final IconData icon;
  final String description;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              const Brand(),

              const SizedBox(height: 22),

              Panel(
                color: mint,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tile(icon, size: 55),
                    const SizedBox(height: 15),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w900)),
                    Text(tamil,
                        style: const TextStyle(
                            fontSize: 14,
                            color: darkGreen,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Text(description,
                        style: const TextStyle(
                            fontSize: 12,
                            color: muted,
                            height: 1.5)),
                  ],
                ),
              ),

              const SizedBox(height: 13),

              const Panel(
                child: Text(
                  'TN-EPDS • Government of Tamil Nadu\n'
                  'Your smart ration information is connected to the authorized e-PoS distribution register.',
                  style: TextStyle(fontSize: 11, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      );
}