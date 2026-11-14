import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: green, width: 1.5),
        ),
      ),
    ),
    home: const SplashScreen(),
  );
}

void message(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

class Panel extends StatelessWidget {
  const Panel({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(14),
  });

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
          offset: Offset(0, 2),
        ),
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
          color: green,
          borderRadius: BorderRadius.circular(11),
        ),
        child: const Icon(
          Icons.verified_user_outlined,
          color: Colors.white,
          size: 26,
        ),
      ),
      const SizedBox(width: 9),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TN-EPDS • தமிழ்நாடு',
            style: TextStyle(
              fontSize: compact ? 10 : 11,
              color: darkGreen,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            compact ? 'Smart PDS' : 'Home Dashboard',
            style: TextStyle(
              fontSize: compact ? 14 : 17,
              fontWeight: FontWeight.w900,
              color: ink,
            ),
          ),
        ],
      ),
    ],
  );
}

class Tag extends StatelessWidget {
  const Tag(
    this.text, {
    super.key,
    this.color = mint,
    this.textColor = darkGreen,
  });

  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10,
        color: textColor,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class Tile extends StatelessWidget {
  const Tile(
    this.icon, {
    super.key,
    this.size = 42,
    this.color = mint,
    this.iconColor = green,
  });

  final IconData icon;
  final double size;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(icon, color: iconColor, size: size * .52),
  );
}

Widget actionButton(
  String label,
  VoidCallback onTap, {
  IconData icon = Icons.arrow_forward,
}) => SizedBox(
  height: 48,
  width: double.infinity,
  child: ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: darkGreen,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, size: 17),
      ],
    ),
  ),
);

Widget pageTitle(String title, {Widget? trailing}) => Padding(
  padding: const EdgeInsets.only(bottom: 9),
  child: Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: ink,
          ),
        ),
      ),
      if (trailing != null) trailing,
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
          MaterialPageRoute(builder: (_) => const RegisterScreen()),
        );
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
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text(
              'DEPARTMENT OF FOOD & CONSUMER\nPROTECTION',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: darkGreen,
                fontWeight: FontWeight.w900,
                fontSize: 11,
              ),
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
                BoxShadow(color: Color(0x22004D32), blurRadius: 20),
              ],
            ),
            child: const Icon(Icons.account_balance, color: green, size: 86),
          ),

          const SizedBox(height: 18),

          const Text(
            'Smart PDS TN',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: ink,
            ),
          ),

          const Text(
            'Your Smart Ration Assistant',
            style: TextStyle(
              fontSize: 14,
              color: darkGreen,
              fontWeight: FontWeight.w700,
            ),
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
              Icon(Icons.fingerprint, size: 16, color: green),
              Text(
                'Biometric e-PoS',
                style: TextStyle(fontSize: 11, color: darkGreen),
              ),
              Icon(Icons.qr_code_2, size: 16, color: green),
              Text(
                'Smart Token',
                style: TextStyle(fontSize: 11, color: darkGreen),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 5, backgroundColor: green),
              SizedBox(width: 8),
              CircleAvatar(radius: 5, backgroundColor: Color(0xFF8BC6A1)),
              SizedBox(width: 8),
              CircleAvatar(radius: 5, backgroundColor: Color(0xFFFFC66D)),
            ],
          ),

          const SizedBox(height: 9),

          const Text(
            'SYNCING LIVE STOCK & QUOTAS...',
            style: TextStyle(fontSize: 10, color: muted, letterSpacing: .5),
          ),

          const SizedBox(height: 26),

          const Text(
            'Government of Tamil Nadu • தமிழ்நாடு அரசு',
            style: TextStyle(
              fontSize: 11,
              color: darkGreen,
              fontWeight: FontWeight.w700,
            ),
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
                MaterialPageRoute(builder: (_) => const RegisterScreen()),
              );
            },
            child: const Text('Continue', style: TextStyle(color: darkGreen)),
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
  final _formKey = GlobalKey<FormState>();
  String? cardType;
  String? district;
  String? taluk;
  bool accepted = false;
  bool isSaving = false;
  bool _showSelectionErrors = false;

  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final mobileController = TextEditingController();
  final shopController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    mobileController.dispose();
    shopController.dispose();
    super.dispose();
  }

  Future<void> _saveRegistration() async {
    final name = nameController.text.trim();
    final cardNumber = cardNumberController.text.trim();
    final mobile = mobileController.text.trim();
    final shop = shopController.text.trim();

    setState(() => _showSelectionErrors = true);
    final isFormValid = _formKey.currentState!.validate();
    if (!isFormValid ||
        cardType == null ||
        district == null ||
        taluk == null ||
        !accepted) {
      return;
    }

    final registration = RegistrationDetails(
      name: name,
      rationCardNumber: cardNumber,
      mobile: mobile,
      cardType: cardType!,
      district: district!,
      taluk: taluk!,
      shopCode: shop,
    );

    setState(() => isSaving = true);
    try {
      final db = FirebaseFirestore.instance;
      final normalizedCardNumber = cardNumber.toUpperCase().replaceAll(
        RegExp(r'[^A-Z0-9]'),
        '',
      );
      final documentId =
          'card_${base64Url.encode(utf8.encode(normalizedCardNumber)).replaceAll('=', '')}';
      final userRef = db.collection('users').doc(documentId);
      final cardRef = db.collection('ration_cards').doc(documentId);

      await db.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userRef);
        final cardSnapshot = await transaction.get(cardRef);

        transaction.set(userRef, {
          'name': registration.name,
          'mobile': registration.mobile,
          'city': registration.district,
          'district': registration.district,
          'taluk': registration.taluk,
          'consentAccepted': accepted,
          'userType': 'beneficiary',
          'isActive': true,
          if (!userSnapshot.exists) 'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        transaction.set(cardRef, {
          'rationCardNumber': registration.rationCardNumber,
          'cardType': registration.cardType,
          'holderName': registration.name,
          'district': registration.district,
          'taluk': registration.taluk,
          'shopCode': registration.shopCode,
          'userId': userRef.id,
          'verificationStatus': 'pending',
          if (!cardSnapshot.exists) 'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      });

      if (!mounted) return;
      message(
        context,
        'Registration details saved. OTP verification is still a demo.',
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              OtpScreen(registration: registration, userId: userRef.id),
        ),
      );
    } catch (e) {
      if (mounted) message(context, 'Could not save registration: $e');
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  Widget field(
    String label,
    TextEditingController controller,
    IconData icon, {
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 5),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 17, color: green),
          isDense: true,
        ),
      ),
    ],
  );

  Widget dropdown(
    String label,
    String? value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 5),
      DropdownButtonFormField<String>(
        value: value,
        validator: (value) => value == null ? 'Please select $label.' : null,
        isExpanded: true,
        decoration: const InputDecoration(isDense: true),
        style: const TextStyle(fontSize: 11, color: ink),
        items: options
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e, overflow: TextOverflow.ellipsis),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    ],
  );

  Widget typeOption(String code, String title) => Expanded(
    child: InkWell(
      onTap: () => setState(() => cardType = code),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 3),
        decoration: BoxDecoration(
          color: cardType == code ? mint : Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: cardType == code ? green : line),
        ),
        child: Column(
          children: [
            Text(
              code,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            Text(title, style: const TextStyle(fontSize: 9)),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: bg,
      title: const Text(
        'Step 1 of 2',
        style: TextStyle(fontSize: 12, color: darkGreen),
      ),
      centerTitle: true,
    ),
    body: pageFrame(
      SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LinearProgressIndicator(
                value: 1 / 2,
                color: green,
                backgroundColor: line,
                minHeight: 5,
              ),

              const SizedBox(height: 14),

              const Text(
                'Register Your Ration Card',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
              ),

              const Text(
                'ரேஷன் கார்டை பதிவு செய்யவும்',
                style: TextStyle(
                  fontSize: 13,
                  color: darkGreen,
                  fontWeight: FontWeight.w700,
                ),
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

              field(
                'Full Name • குடும்பத் தலைவர் பெயர்',
                nameController,
                Icons.person_outline,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter your full name.'
                    : null,
              ),

              const SizedBox(height: 10),

              field(
                'Ration Card Number • குடும்ப அட்டை எண்',
                cardNumberController,
                Icons.badge_outlined,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter your ration card number.'
                    : null,
              ),

              const SizedBox(height: 10),

              field(
                'Registered Mobile Number • பதிவு செய்யப்பட்ட எண்',
                mobileController,
                Icons.phone_android,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  final mobile = (value ?? '').replaceAll(
                    RegExp(r'[\s()-]'),
                    '',
                  );
                  final localNumber = mobile.startsWith('+91')
                      ? mobile.substring(3)
                      : mobile.startsWith('91') && mobile.length == 12
                      ? mobile.substring(2)
                      : mobile;
                  if (localNumber.isEmpty) {
                    return 'Please enter your mobile number.';
                  }
                  if (!RegExp(r'^[6-9]\d{9}$').hasMatch(localNumber)) {
                    return 'Enter a valid 10-digit Indian mobile number.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 11),

              const Text(
                'Ration Card Type • அட்டை வகை',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
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
              if (_showSelectionErrors && cardType == null)
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Please select a ration card type.',
                    style: TextStyle(fontSize: 10, color: Colors.red),
                  ),
                ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: dropdown('District • மாவட்டம்', district, [
                      'Coimbatore',
                      'Chennai',
                      'Madurai',
                      'Thanjavur',
                    ], (v) => setState(() => district = v ?? district)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: dropdown('Taluk / Area', taluk, [
                      'Cbe South',
                      'Cbe North',
                      'Pollachi',
                      'Mettupalayam',
                    ], (v) => setState(() => taluk = v ?? taluk)),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              field(
                'Fair Price Shop Code • கடை குறியீடு',
                shopController,
                Icons.storefront_outlined,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Please enter your Fair Price Shop code.'
                    : null,
              ),

              const SizedBox(height: 5),

              const Text(
                'Enter the code assigned to your Fair Price Shop.',
                style: TextStyle(fontSize: 9, color: muted),
              ),

              const SizedBox(height: 11),

              Panel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified_user, color: green),
                        SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            'Official TN Government Verification',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Data is securely synchronized with the TNPDS Master Registry. Online registration does not require biometric scanning or fingerprint details.',
                      style: TextStyle(fontSize: 10, color: muted, height: 1.4),
                    ),

                    const SizedBox(height: 8),

                    InkWell(
                      onTap: () => setState(() => accepted = !accepted),
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
                              style: TextStyle(fontSize: 10, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_showSelectionErrors && !accepted)
                      const Padding(
                        padding: EdgeInsets.only(left: 25, top: 4),
                        child: Text(
                          'Please accept the verification declaration.',
                          style: TextStyle(fontSize: 10, color: Colors.red),
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
    ),
  );
}

class RegistrationDetails {
  const RegistrationDetails({
    required this.name,
    required this.rationCardNumber,
    required this.mobile,
    required this.cardType,
    required this.district,
    required this.taluk,
    required this.shopCode,
  });

  final String name;
  final String rationCardNumber;
  final String mobile;
  final String cardType;
  final String district;
  final String taluk;
  final String shopCode;
}

// ============================================================
// SCREEN 3 — OTP VERIFICATION
// ============================================================

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.registration,
    required this.userId,
  });

  final RegistrationDetails registration;
  final String userId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controllers = List.generate(6, (_) => TextEditingController());

  final nodes = List.generate(6, (_) => FocusNode());

  Widget registrationRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: muted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );

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
                border: Border.all(color: const Color(0xFF9DDFB8), width: 4),
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
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),

            const Text(
              'ஒருமுறை கடவுச்சொல் சரிபார்ப்பு',
              style: TextStyle(
                fontSize: 14,
                color: darkGreen,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Enter the 6-digit OTP sent to registered mobile number',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: muted),
            ),

            const SizedBox(height: 12),

            Tag('▮ ${widget.registration.mobile}'),

            const SizedBox(height: 13),

            Panel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Secured Digit Verification\n(பாதுகாப்பான சரிபார்ப்பு)',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Auto-Read\nReady',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 10,
                          color: green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 11),

                  Row(
                    children: List.generate(
                      6,
                      (i) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: i == 5 ? 0 : 5),
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
                                fontWeight: FontWeight.w900,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: mint,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
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
                      style: TextStyle(fontSize: 9, color: darkGreen),
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
                  const Text(
                    '◷ Resend OTP in 00:28',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                  ),
                  const Text(
                    'மீண்டும் அனுப்பும் நேரம் முடிந்தவுடன்',
                    style: TextStyle(fontSize: 10, color: muted),
                  ),
                  TextButton.icon(
                    onPressed: () => message(context, 'Demo OTP resent.'),
                    icon: const Icon(Icons.refresh, size: 15),
                    label: const Text(
                      'Resend via SMS / குறுஞ்செய்தி மீண்டும் பெற',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Panel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Registration Details',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 7),
                  registrationRow('Full Name', widget.registration.name),
                  registrationRow(
                    'Ration Card Number',
                    widget.registration.rationCardNumber,
                  ),
                  registrationRow('Mobile Number', widget.registration.mobile),
                  registrationRow(
                    'Ration Card Type',
                    widget.registration.cardType,
                  ),
                  registrationRow('District', widget.registration.district),
                  registrationRow('Taluk', widget.registration.taluk),
                  registrationRow(
                    'Fair Price Shop Code',
                    widget.registration.shopCode,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            actionButton('Verify & Enter App / சரிபார்த்து உள்ளேறவும்', () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => MainShell(userId: widget.userId),
                ),
                (route) => false,
              );
            }),

            const SizedBox(height: 9),

            const Panel(
              color: mint,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified_user, color: green, size: 15),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Secured by TNeGA & National Informatics Centre (NIC)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9,
                        color: darkGreen,
                        fontWeight: FontWeight.w700,
                      ),
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
  const MainShell({super.key, required this.userId});

  final String userId;

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
            userId: widget.userId,
            onOpenStock: () => setState(() => selected = 1),
            onOpenProfile: () => setState(() => selected = 4),
          ),
          const StockScreen(),
          const InfoScreen(
            title: 'Purchase History',
            tamil: 'வாங்கிய வரலாறு',
            icon: Icons.history,
            description: 'Your monthly ration collection records and digital receipts will appear here.',
          ),
          const InfoScreen(
            title: 'Alerts & Reminders',
            tamil: 'அறிவிப்புகள்',
            icon: Icons.notifications_active_outlined,
            description: 'Monthly quota reminders, stock arrival updates and distribution deadlines.',
          ),
          ProfileScreen(userId: widget.userId),
        ],
      ),
    ),
    bottomNavigationBar: NavigationBar(
      height: 68,
      selectedIndex: selected,
      onDestinationSelected: (i) => setState(() => selected = i),
      backgroundColor: const Color(0xFFF7FEF9),
      indicatorColor: mint,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_bag_outlined),
          selectedIcon: Icon(Icons.shopping_bag),
          label: 'Ration',
        ),
        NavigationDestination(icon: Icon(Icons.history), label: 'History'),
        NavigationDestination(
          icon: Icon(Icons.notifications_none),
          label: 'Alerts',
        ),
        NavigationDestination(
          icon: Icon(Icons.badge_outlined),
          label: 'Profile',
        ),
      ],
    ),
  );
}

// ============================================================
// SCREEN 4 — HOME DASHBOARD
// ============================================================

class RegistrationData {
  const RegistrationData({
    required this.name,
    required this.rationCardNumber,
    required this.mobile,
    required this.cardType,
    required this.district,
    required this.taluk,
    required this.shopCode,
    required this.verificationStatus,
    required this.consentStatus,
  });

  final String name;
  final String rationCardNumber;
  final String mobile;
  final String cardType;
  final String district;
  final String taluk;
  final String shopCode;
  final String verificationStatus;
  final String consentStatus;

  bool get isVerified => verificationStatus.toLowerCase() == 'verified';

  String get cardTypeTamil => switch (cardType.toUpperCase()) {
    'PHH' => 'முன்னுரிமை குடும்ப அட்டை',
    'AAY' => 'அந்த்யோதயா குடும்ப அட்டை',
    'NPHH' => 'பொது குடும்ப அட்டை',
    _ => 'குடும்ப அட்டை',
  };
}

Future<RegistrationData?> loadRegistrationData(String userId) async {
  final db = FirebaseFirestore.instance;
  final userSnapshot = await db.collection('users').doc(userId).get();
  if (!userSnapshot.exists) return null;

  final userData = userSnapshot.data();
  if (userData == null) return null;

  final cardSnapshot = await db
      .collection('ration_cards')
      .where('userId', isEqualTo: userId)
      .limit(1)
      .get();
  if (cardSnapshot.docs.isEmpty) return null;

  final cardData = cardSnapshot.docs.first.data();
  final consentRecorded = userData.containsKey('consentAccepted');

  return RegistrationData(
    name: _requiredRegistrationValue(userData, 'name'),
    mobile: _requiredRegistrationValue(userData, 'mobile'),
    rationCardNumber: _requiredRegistrationValue(cardData, 'rationCardNumber'),
    cardType: _requiredRegistrationValue(cardData, 'cardType'),
    district: _requiredRegistrationValue(cardData, 'district'),
    taluk: _requiredRegistrationValue(cardData, 'taluk'),
    shopCode: _requiredRegistrationValue(cardData, 'shopCode'),
    verificationStatus: cardData['verificationStatus']?.toString() ?? 'pending',
    consentStatus: !consentRecorded
        ? 'Not recorded / பதிவு செய்யப்படவில்லை'
        : userData['consentAccepted'] == true
        ? 'Accepted / ஏற்கப்பட்டது'
        : 'Not accepted / ஏற்கப்படவில்லை',
  );
}

String _requiredRegistrationValue(Map<String, dynamic> data, String key) {
  final value = data[key]?.toString().trim();
  if (value == null || value.isEmpty) {
    throw StateError('Registration data is missing "$key".');
  }
  return value;
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.userId,
    required this.onOpenStock,
    required this.onOpenProfile,
  });

  final String userId;
  final VoidCallback onOpenStock;
  final VoidCallback onOpenProfile;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<RegistrationData?> _registrationFuture;

  @override
  void initState() {
    super.initState();
    _registrationFuture = loadRegistrationData(widget.userId);
  }

  Widget _loadMessage(String text) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {
              setState(
                () => _registrationFuture = loadRegistrationData(widget.userId),
              );
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    ),
  );

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
  }) => Panel(
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
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 10, color: darkGreen),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Quota',
                  style: TextStyle(fontSize: 9, color: muted),
                ),
                Text(
                  quota,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
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
            backgroundColor: line,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Text(
              'Collected: $collected',
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Tag(
              status,
              color: pending ? orange : mint,
              textColor: pending ? const Color(0xFF9B5D00) : darkGreen,
            ),
            const Spacer(),
            Text(
              'Balance: $balance',
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: muted,
              ),
            ),
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
  ) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(15),
    child: Panel(
      color: const Color(0xFFF4FCF6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tile(icon),
          const SizedBox(height: 9),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
          ),
          Text(
            tamil,
            style: const TextStyle(
              fontSize: 10,
              color: darkGreen,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Text(detail, style: const TextStyle(fontSize: 9, color: muted)),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => FutureBuilder<RegistrationData?>(
    future: _registrationFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return _loadMessage(
          'Unable to load your registration details. Check your connection and try again.',
        );
      }
      final registration = snapshot.data;
      if (registration == null) {
        return _loadMessage(
          'No registration details were found for this account. Please register your ration card and try again.',
        );
      }
      return _buildDashboard(context, registration);
    },
  );

  Widget _buildDashboard(
    BuildContext context,
    RegistrationData registration,
  ) => LayoutBuilder(
    builder: (context, constraints) {
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
                      onPressed: () => message(context, 'Citizen help desk'),
                      icon: const Icon(Icons.support_agent, color: green),
                    ),
                    CircleAvatar(
                      backgroundColor: green,
                      child: IconButton(
                        onPressed: widget.onOpenProfile,
                        icon: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 9),

                const Text(
                  'வணக்கம்! • Good Morning',
                  style: TextStyle(
                    fontSize: 12,
                    color: muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Text(
                  registration.name,
                  style: TextStyle(
                    fontSize: 23,
                    color: ink,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                Row(
                  children: [
                    Icon(Icons.calendar_month, size: 14, color: green),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '${registration.taluk}, ${registration.district} • Shop ${registration.shopCode} • Mobile ${registration.mobile}',
                        style: TextStyle(fontSize: 11, color: muted),
                      ),
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
                            top: Radius.circular(16),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'FAMILY SMART CARD\nஎண்',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: muted,
                                    ),
                                  ),
                                ),
                                Tag(
                                  registration.isVerified
                                      ? 'சரிபார்க்கப்பட்டது'
                                      : 'சரிபார்ப்பு நிலுவையில்',
                                ),
                              ],
                            ),

                            Text(
                              registration.rationCardNumber,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: mint,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Card Category',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: muted,
                                          ),
                                        ),
                                        Text(
                                          registration.cardType,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          registration.cardTypeTamil,
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Assigned FPS Shop',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: muted,
                                          ),
                                        ),
                                        Text(
                                          registration.shopCode,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          '${registration.taluk}, ${registration.district}',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: muted,
                                          ),
                                        ),
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
                                    '♙ Family Smart Card / குடும்ப அட்டை',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: muted,
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text('Family Smart Card'),
                                        content: Text(
                                          'Card No. ${registration.rationCardNumber}\n'
                                          'Holder: ${registration.name}\n'
                                          'Mobile: ${registration.mobile}\n'
                                          '${registration.shopCode} · ${registration.taluk}, ${registration.district}',
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
                                  icon: const Icon(Icons.qr_code_2, size: 17),
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
                      Tile(
                        Icons.shopping_bag_outlined,
                        color: orange,
                        iconColor: Color(0xFF9B5D00),
                      ),
                      SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'நவம்பர் ஒதுக்கீடு பகுதியளவு பெறப்பட்டது',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '10 KG collected • 6 KG balance remaining across 2 commodities before Nov 30.',
                              style: TextStyle(fontSize: 11, color: muted),
                            ),
                            SizedBox(height: 7),
                            Text(
                              'View Breakdown / விவரங்கள் →',
                              style: TextStyle(
                                fontSize: 12,
                                color: darkGreen,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                pageTitle(
                  'November 2026 Entitlement',
                  trailing: const Tag('Valid till 30 Nov'),
                ),

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
                  '50% Collected',
                ),

                const SizedBox(height: 8),

                quotaCard(
                  Icons.grass,
                  'Wheat / கோதுமை',
                  'Free / இலவசம் (₹0)',
                  '5 KG',
                  '0 KG',
                  '5 KG',
                  0,
                  'Not Yet Collected',
                ),

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
                  pending: true,
                ),

                const SizedBox(height: 15),

                pageTitle(
                  'Quick Services / விரைவு சேவைகள்',
                  trailing: const Text(
                    'ePDS Portal',
                    style: TextStyle(
                      fontSize: 10,
                      color: darkGreen,
                      fontWeight: FontWeight.w800,
                    ),
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
                      widget.onOpenStock,
                    ),
                    service(
                      Icons.receipt_long_outlined,
                      'Purchase History',
                      'வாங்கிய வரலாறு',
                      'Previous months data',
                      () => message(context, 'Purchase History selected'),
                    ),
                    service(
                      Icons.receipt_long_outlined,
                      'Digital Receipt',
                      'டிஜிட்டல் ரசீது',
                      'Instant e-PoS bills',
                      () => message(context, 'Digital receipts selected'),
                    ),
                    service(
                      Icons.event_available_outlined,
                      'Monthly Alert',
                      'மாத நினைவூட்டல்',
                      'Deadlines & reminders',
                      () => message(context, 'Monthly alerts selected'),
                    ),
                    service(
                      Icons.query_stats,
                      'Stock Forecast',
                      'இருப்பு கணிப்பு',
                      'AI depletion window',
                      widget.onOpenStock,
                    ),
                    service(
                      Icons.map_outlined,
                      'Find Shop / வழி',
                      'ரேஷன் கடை வழி',
                      'Map & shop in-charge',
                      () => message(
                        context,
                        '${registration.shopCode} · ${registration.taluk}, ${registration.district}',
                      ),
                    ),
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

                Panel(
                  color: Color(0xFFF4FCF6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tile(
                        Icons.campaign_outlined,
                        color: green,
                        iconColor: Colors.white,
                      ),
                      SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fresh Stock Arrived at ${registration.shopCode}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Sugar (500 KG) and Fortified Wheat are available from today 9:00 AM onwards. Token generation open.',
                              style: TextStyle(
                                fontSize: 11,
                                color: muted,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '${registration.shopCode} - ${registration.taluk}, ${registration.district}',
                              style: TextStyle(
                                fontSize: 10,
                                color: darkGreen,
                                fontWeight: FontWeight.w800,
                              ),
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
                        child: Icon(Icons.support_agent, color: green),
                      ),
                      SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shop In-Charge / விற்பனையாளர்',
                              style: TextStyle(fontSize: 9, color: muted),
                            ),
                            Text(
                              'S. Rajendran',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '● Duty Active: 8:30 AM - 5:30 PM',
                              style: TextStyle(fontSize: 10, color: green),
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
    },
  );
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
      return name == 'Rice' || name == 'Wheat' || name == 'Toor Dal';
    }

    if (filter == 'Limited') return name == 'Kerosene';

    if (filter == 'Out of Stock') return name == 'Sugar';

    return true;
  }

  Widget filterChip(String value, String tamil) => Padding(
    padding: const EdgeInsets.only(right: 7),
    child: ChoiceChip(
      label: Text('$value • $tamil', style: const TextStyle(fontSize: 10)),
      selected: filter == value,
      onSelected: (_) => setState(() => filter = value),
      selectedColor: darkGreen,
      backgroundColor: mint,
      labelStyle: TextStyle(
        color: filter == value ? Colors.white : ink,
        fontWeight: FontWeight.w700,
      ),
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
                    : (statusColor == orange ? const Color(0xFF9B5D00) : green),
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
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    Text(
                      tamil,
                      style: const TextStyle(fontSize: 10, color: muted),
                    ),

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
                  Text(
                    quantity,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: quantityColor,
                    ),
                  ),
                  Text(
                    unit,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 9, color: muted),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          if (sugar) ...[
            Text(right, style: const TextStyle(fontSize: 10, color: muted)),
            const SizedBox(height: 7),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => setState(() => alertEnabled = !alertEnabled),
                icon: Icon(
                  alertEnabled
                      ? Icons.notifications_active
                      : Icons.notifications_none,
                  size: 15,
                ),
                label: Text(
                  alertEnabled
                      ? 'Stock Alert Enabled'
                      : 'Alert When In Stock • வந்ததும் தெரிவி',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: Text(left, style: const TextStyle(fontSize: 10)),
                ),
                Text(
                  right,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                color: quantityColor,
                backgroundColor: line,
              ),
            ),

            const SizedBox(height: 7),

            const Row(
              children: [
                Icon(Icons.verified_outlined, color: green, size: 13),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'e-PoS Verified',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  'Updated 10:30 AM today',
                  style: TextStyle(fontSize: 9, color: muted),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
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
                      onPressed: () => message(context, 'Citizen support'),
                      icon: const Icon(Icons.support_agent, color: green),
                    ),
                    const CircleAvatar(
                      backgroundColor: green,
                      child: Icon(Icons.person_outline, color: Colors.white),
                    ),
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
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const Text(
                        '⌖ Cross Cut Road, Coimbatore South',
                        style: TextStyle(fontSize: 10, color: muted),
                      ),

                      const Divider(color: line, height: 16),

                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              '♙ In-Charge: S. Ramalingam',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            '☎ Call',
                            style: TextStyle(
                              fontSize: 10,
                              color: green,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        '◷ Today: 8:30 AM - 12:30 PM • 4:00 PM - 7:30 PM',
                        style: TextStyle(fontSize: 9, color: muted),
                      ),

                      const SizedBox(height: 7),

                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              '☁ e-PoS Sync: 13 Nov 2026, 10:30 AM',
                              style: TextStyle(fontSize: 9, color: muted),
                            ),
                          ),
                          TextButton(
                            onPressed: () => message(
                              context,
                              'Stock refreshed from e-PoS register.',
                            ),
                            child: const Text(
                              'Refresh • புதுப்பி',
                              style: TextStyle(fontSize: 10),
                            ),
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
                    hintText: 'Search rice, wheat, sugar, kerosene / தேடுக',
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
                        .map(
                          (c) => SizedBox(
                            width: (constraints.maxWidth - 40) / 2,
                            child: c,
                          ),
                        )
                        .toList(),
                  )
                else ...[
                  for (final c in cards) ...[c, const SizedBox(height: 8)],
                ],

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '✧ Stock Forecast / இருப்பு கணிப்பு',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 7),

                      const Text(
                        'Rice & Wheat expected to last 6+ days at current consumption rate. No queue rush detected right now.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFFD5F3E1),
                          height: 1.45,
                        ),
                      ),

                      const SizedBox(height: 10),

                      OutlinedButton.icon(
                        onPressed: () => message(
                          context,
                          'e-Token booking will open when the shop enables token generation.',
                        ),
                        icon: const Icon(
                          Icons.confirmation_number_outlined,
                          size: 15,
                        ),
                        label: const Text('Book e-Token • டோக்கன் முன்பதிவு'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide.none,
                        ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '♙ Civil Supplies Dept',
                              style: TextStyle(
                                fontSize: 9,
                                color: darkGreen,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'TN e-PoS 4G Network',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Real-time ledger connected to Tamil Nadu Civil Supplies...',
                              style: TextStyle(fontSize: 10, color: muted),
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
    },
  );
}

// ============================================================
// HISTORY, ALERTS AND PROFILE TABS
// ============================================================

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<RegistrationData?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = loadRegistrationData(widget.userId);
  }

  Widget _profileField(IconData icon, String label, String value) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF4FCF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: line),
    ),
    child: Row(
      children: [
        Tile(icon, size: 36),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: muted)),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  color: ink,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _profileDetails(RegistrationData registration) => Panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Beneficiary Information / பயனாளர் விவரங்கள்',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 10.0;
            final columns = constraints.maxWidth >= 520 ? 2 : 1;
            final itemWidth =
                (constraints.maxWidth - spacing * (columns - 1)) / columns;
            final fields = [
              (Icons.person_outline, 'Full Name', registration.name),
              (
                Icons.badge_outlined,
                'Ration Card Number',
                registration.rationCardNumber,
              ),
              (
                Icons.phone_android,
                'Registered Mobile Number',
                registration.mobile,
              ),
              (
                Icons.category_outlined,
                'Ration Card Type',
                registration.cardType,
              ),
              (Icons.location_city_outlined, 'District', registration.district),
              (Icons.map_outlined, 'Taluk / Area', registration.taluk),
              (
                Icons.storefront_outlined,
                'Fair Price Shop Code',
                registration.shopCode,
              ),
              (
                Icons.verified_user_outlined,
                'Consent Status',
                registration.consentStatus,
              ),
            ];
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (final field in fields)
                  SizedBox(
                    width: itemWidth,
                    child: _profileField(field.$1, field.$2, field.$3),
                  ),
              ],
            );
          },
        ),
      ],
    ),
  );

  Widget _profileLoadError(String text) => Panel(
    child: Column(
      children: [
        Text(text, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () {
            setState(
              () => _profileFuture = loadRegistrationData(widget.userId),
            );
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    ),
  );

  Widget _profileContent() => FutureBuilder<RegistrationData?>(
    future: _profileFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const Panel(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
      if (snapshot.hasError) {
        return _profileLoadError(
          snapshot.error is StateError
              ? 'Some profile information is incomplete. Please contact support or complete registration.'
              : 'Unable to load your profile. Check your connection and try again.',
        );
      }
      final registration = snapshot.data;
      if (registration == null) {
        return _profileLoadError(
          'No profile information was found for this account. Please complete registration.',
        );
      }
      return _profileDetails(registration);
    },
  );

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
                const Tile(Icons.badge_outlined, size: 55),
                const SizedBox(height: 15),
                const Text(
                  'My Profile',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
                ),
                const Text(
                  'விவரங்கள்',
                  style: TextStyle(
                    fontSize: 14,
                    color: darkGreen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your registered Smart Card and beneficiary details.',
                  style: TextStyle(fontSize: 12, color: muted, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 13),
          _profileContent(),
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  tamil,
                  style: const TextStyle(
                    fontSize: 14,
                    color: darkGreen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: muted,
                    height: 1.5,
                  ),
                ),
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
