import 'package:flutter/material.dart';
import '../Datas/weatherData.dart';
import '../profileScreen/settingPage.dart';
import 'notificationsPage.dart';


class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {


  var takeWeather;
  Widget statusWeather = Icon(Icons.cloud);
  TextEditingController cityController = TextEditingController();
  // Sahte hava durumu verisi
  final Map<String, String?> weatherData = {
    'description': '',
    'city': '',
    'temperature': '',
  };

  final List<String> cities = [
    'Adana',
    'Adiyaman',
    'Afyonkarahisar',
    'Agri',
    'Aksaray',
    'Amasya',
    'Ankara',
    'Antalya',
    'Ardahan',
    'Artvin',
    'Aydin',
    'Balikesir',
    'Bartin',
    'Batman',
    'Bayburt',
    'Bilecik',
    'Bingol',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Canakkale',
    'Cankiri',
    'Corum',
    'Denizli',
    'Diyarbakir',
    'Duzce',
    'Edirne',
    'Elazig',
    'Erzincan',
    'Erzurum',
    'Eskisehir',
    'Gaziantep',
    'Giresun',
    'Gumushane',
    'Hakkari',
    'Hatay',
    'Igdir',
    'Isparta',
    'Istanbul',
    'Izmir',
    'Kahramanmaras',
    'Karabuk',
    'Karaman',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kilis',
    'Kirikkale',
    'Kirklareli',
    'Kirsehir',
    'Kocaeli',
    'Konya',
    'Kutahya',
    'Malatya',
    'Manisa',
    'Mardin',
    'Mersin',
    'Mugla',
    'Mus',
    'Nevsehir',
    'Nigde',
    'Ordu',
    'Osmaniye',
    'Rize',
    'Sakarya',
    'Samsun',
    'Sanliurfa',
    'Siirt',
    'Sinop',
    'Sirnak',
    'Sivas',
    'Tekirdag',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Usak',
    'Van',
    'Yalova',
    'Yozgat',
    'Zonguldak',
  ];

  String? selectedCity;

  @override
  initState() {
    super.initState();
    updateInfo();
  }



  Future<void> updateInfo() async {
    setState(
      () async {
        if (selectedCity != null) {
          takeWeather = await getWeather(selectedCity!);
          setState(
            () {
              weatherData['temperature'] = takeWeather[1];
              weatherData['description'] = takeWeather[0];
            },
          );
        }else{
          selectedCity = 'Istanbul';
          updateInfo();
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: weatherData['description'] == ''
                            ? Text('Lütfen, şehir seçin.')
                            : statusWeather),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      weatherData['description'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedCity ?? 'NULL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          weatherData['temperature'] ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.location_city_outlined),
            title: Text("Şehri değiştir"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Şehir Değiştir"),
                    content: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return cities.where((String option) {
                          return option
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String? value) {
                        setState(() {
                          selectedCity = value;
                        });
                        updateInfo();
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Değiştir"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.refresh),
            title: Text("Hava Durumu Yenile"),
            onTap: updateInfo,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notification_add),
            title: Text('Bildirimler'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationsPage()
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ayarlar'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
