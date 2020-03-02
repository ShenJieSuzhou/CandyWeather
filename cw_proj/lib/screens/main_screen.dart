import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui show Image;
import 'package:flutter/services.dart';

import 'package:cw_proj/widgets/weather_card.dart';
import 'package:cw_proj/widgets/JCustomIndicator.dart';
import 'package:cw_proj/Model/SelLocations.dart';
import 'package:cw_proj/util/configFile.dart';
import 'package:cw_proj/screens/city_screen.dart';
import 'package:cw_proj/screens/setting_screen.dart';
import 'package:cw_proj/widgets/HeaderContentView.dart';
import 'package:spritewidget/spritewidget.dart';

ImageMap _images;
SpriteSheet _sprites;

enum WeatherType {
  sun,
  rain,
  snow
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _pageCount;
  int _initialPage;
  Future<SelLocations> citys;

  bool assetsLoaded = false;
  WeatherWorld weatherWorld;

  // 加载本项目所需的 assets.
  Future<Null> _loadAssets(AssetBundle bundle) async {
    // Load images using an ImageMap
    _images = new ImageMap(bundle);
    await _images.load(<String>[
      'assets/clouds-0.png',
      'assets/clouds-1.png',
      'assets/ray.png',
      'assets/sun.png',
      'assets/weathersprites.png',
      'assets/icon-sun.png',
      'assets/icon-rain.png',
      'assets/icon-snow.png'
    ]);
  
   // 加载sprite , 包含雪花与雨滴
    String json = await DefaultAssetBundle.of(context).loadString('assets/weathersprites.json');
    _sprites = new SpriteSheet(_images['assets/weathersprites.png'], json);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final headerHeight = 120.0;
    final bottomHeight = 50.0;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    
    AppBar appBar = AppBar(
        elevation: 0.0,   
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Navigation',
              onPressed: (){                
                // Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen()));
                Navigator.push(context, PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) {
                    return CityScreen();
                  },
                  
                  transitionsBuilder: (_, Animation<double> animation, Animation<double> animation1, Widget child){
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: const Offset(0.0, 0.0),
                      ).animate(animation),
                      child: child,
                    );
                  }
                ));
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
              Navigator.push(context, PageRouteBuilder(
                opaque: false,
                pageBuilder:(BuildContext context, _, __){
                  return SettingScreen();
                },

                transitionsBuilder: (BuildContext context, Animation<double> animation, __, Widget child){
                  return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0),
                      ).animate(animation),
                      child: child,
                    );
                }
              ));
            },
          )
        ],
      );

    double appBarHeight = appBar.preferredSize.height;

    return Scaffold(
        appBar: appBar,
        body: Material(
          child: Stack(
            children: <Widget>[
              // SpriteWidget(weatherWorld),
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      
                    ),
                    width: double.infinity,
                    height: headerHeight,
                    child: HeaderContentView()
                  ),
                  Container(
                    decoration: BoxDecoration(
                      
                    ),
                    height: screenHeight - headerHeight - appBarHeight - bottomHeight - statusBarHeight,
                    child: PageView.builder(
                      onPageChanged: onPageChanged,
                      controller: _pageController,
                      itemBuilder: (context, index){
                        return Container(
                          child: WeatherInfo(),
                        );
                      },
                      itemCount: _pageCount,
                    ),
                  ),
                  // Container(
                  //   height: bottomHeight,
                  //   child: JCustomIndicator(controller: _pageController,itemCount: 5,),
                  // ),
              ],
            ),
          ],
        ),
      ), 
      // drawer: SideMenuBar(),
      // bottomNavigationBar: Theme(
      //   data: Theme.of(context).copyWith(
      //     canvasColor: Theme.of(context).primaryColor,
      //     primaryColor: Theme.of(context).accentColor,
      //   ),
      //   child: Container(
      //     height: bottomHeight,
      //     child: JCustomIndicator(controller: _pageController,itemCount: 5,),
      //   )
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 获取 rootbundle
    AssetBundle bundle = rootBundle;
    // 加载天气图形
    _loadAssets(bundle).then((_){
      setState(() {
        assetsLoaded = true;
        weatherWorld = new WeatherWorld();
      });
    });

    // 加载配置文件
    citys = fetchCity();
    
    // 请求网络数据
    // ...
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }


  void onPageChanged(int index){
    setState(() {});

  }

  void setPageCount(int count){
    this._pageCount = count;
  }

  void setInitialPage(int initPage){
    this._initialPage = initPage;
  }
}

// For the different weathers we are displaying different gradient backgrounds,
// these are the colors for top and bottom.
const List<Color> _kBackgroundColorsTop = const <Color>[
  const Color(0xff5ebbd5),
  const Color(0xff0b2734),
  const Color(0xffcbced7)
];

const List<Color> _kBackgroundColorsBottom = const <Color>[
  const Color(0xff4aaafb),
  const Color(0xff4c5471),
  const Color(0xffe0e3ec)
];

// The WeatherWorld is our root node for our sprite tree. The size of the tree
// will be scaled to fit into our SpriteWidget container.
class WeatherWorld extends NodeWithSize {
  WeatherWorld() : super(const Size(2048.0, 2048.0)) {

    // Start by adding a background.
    _background = new GradientNode(
      this.size,
      _kBackgroundColorsTop[0],
      _kBackgroundColorsBottom[0],
    );
    addChild(_background);

    // Then three layers of clouds, that will be scrolled in parallax.
    _cloudsSharp = new CloudLayer(
      image: _images['assets/clouds-0.png'],
      rotated: false,
      dark: false,
      loopTime: 20.0
    );
    addChild(_cloudsSharp);

    _cloudsDark = new CloudLayer(
      image: _images['assets/clouds-1.png'],
      rotated: true,
      dark: true,
      loopTime: 40.0
    );
    addChild(_cloudsDark);

    _cloudsSoft = new CloudLayer(
      image: _images['assets/clouds-1.png'],
      rotated: false,
      dark: false,
      loopTime: 60.0
    );
    addChild(_cloudsSoft);

    // Add the sun, rain, and snow (which we are going to fade in/out depending
    // on which weather are selected.
    _sun = new Sun();
    _sun.position = const Offset(1024.0, 1024.0);
    _sun.scale = 1.5;
    addChild(_sun);

    _rain = new Rain();
    addChild(_rain);

    _snow = new Snow();
    addChild(_snow);
  }

  GradientNode _background;
  CloudLayer _cloudsSharp;
  CloudLayer _cloudsSoft;
  CloudLayer _cloudsDark;
  Sun _sun;
  Rain _rain;
  Snow _snow;

  WeatherType get weatherType => _weatherType;

  WeatherType _weatherType = WeatherType.rain;

  set weatherType(WeatherType weatherType) {
    if (weatherType == _weatherType)
      return;

    // Handle changes between weather types.
    _weatherType = weatherType;

    // Fade the background
    _background.motions.stopAll();

    // Fade the background from one gradient to another.
    _background.motions.run(new MotionTween<Color>(
      (a) => _background.colorTop = a,
      _background.colorTop,
      _kBackgroundColorsTop[weatherType.index],
      1.0
    ));

    _background.motions.run(new MotionTween<Color>(
      (a) => _background.colorBottom = a,
      _background.colorBottom,
      _kBackgroundColorsBottom[weatherType.index],
      1.0
    ));

    // Activate/deactivate sun, rain, snow, and dark clouds.
    _cloudsDark.active = weatherType != WeatherType.sun;
    _sun.active = weatherType == WeatherType.sun;
    _rain.active = weatherType == WeatherType.rain;
    _snow.active = weatherType == WeatherType.snow;
  }

  @override
  void spriteBoxPerformedLayout() {
    // If the device is rotated or if the size of the SpriteWidget changes we
    // are adjusting the position of the sun.
    _sun.position = spriteBox.visibleArea.topLeft + const Offset(350.0, 180.0);
  }
}

// The GradientNode performs custom drawing to draw a gradient background.
class GradientNode extends NodeWithSize {
  GradientNode(Size size, this.colorTop, this.colorBottom) : super(size);

  Color colorTop;
  Color colorBottom;

  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);

    Rect rect = Offset.zero & size;
    Paint gradientPaint = new Paint()..shader = new LinearGradient(
      begin: FractionalOffset.topLeft,
      end: FractionalOffset.bottomLeft,
      colors: <Color>[colorTop, colorBottom],
      stops: <double>[0.0, 1.0]
    ).createShader(rect);

    canvas.drawRect(rect, gradientPaint);
  }
}

// Draws and animates a cloud layer using two sprites.
class CloudLayer extends Node {
  CloudLayer({ ui.Image image, bool dark, bool rotated, double loopTime }) {
    // Creates and positions the two cloud sprites.
    _sprites.add(_createSprite(image, dark, rotated));
    _sprites[0].position = const Offset(1024.0, 1024.0);
    addChild(_sprites[0]);

    _sprites.add(_createSprite(image, dark, rotated));
    _sprites[1].position = const Offset(3072.0, 1024.0);
    addChild(_sprites[1]);

    // Animates the clouds across the screen.
    motions.run(new MotionRepeatForever(
      new MotionTween<Offset>(
        (a) => position = a,
        Offset.zero,
        const Offset(-2048.0, 0.0),
        loopTime)
    ));
  }

  List<Sprite> _sprites = <Sprite>[];

  Sprite _createSprite(ui.Image image, bool dark, bool rotated) {
    Sprite sprite = new Sprite.fromImage(image);

    if (rotated)
      sprite.scaleX = -1.0;

    if (dark) {
      sprite.colorOverlay = const Color(0xff000000);
      sprite.opacity = 0.0;
    }

    return sprite;
  }

  set active(bool active) {
    // Toggle visibility of the cloud layer
    double opacity;
    if (active) opacity = 1.0;
    else opacity = 0.0;

    for (Sprite sprite in _sprites) {
      sprite.motions.stopAll();
      sprite.motions.run(new MotionTween<double>(
        (a) => sprite.opacity = a,
        sprite.opacity,
        opacity,
        1.0
      ));
    }
  }
}

const double _kNumSunRays = 50.0;

// Create an animated sun with rays
class Sun extends Node {
  Sun() {
    // Create the sun
    _sun = new Sprite.fromImage(_images['assets/sun.png']);
    _sun.scale = 4.0;
    _sun.transferMode = BlendMode.plus;
    addChild(_sun);

    // Create rays
    _rays = <Ray>[];
    for (int i = 0; i < _kNumSunRays; i += 1) {
      Ray ray = new Ray();
      addChild(ray);
      _rays.add(ray);
    }
  }

  Sprite _sun;
  List<Ray> _rays;

  set active(bool active) {
    // Toggle visibility of the sun

    motions.stopAll();

    double targetOpacity;
    if (!active) targetOpacity = 0.0;
    else targetOpacity = 1.0;

    motions.run(
      new MotionTween<double>(
        (a) => _sun.opacity = a,
        _sun.opacity,
        targetOpacity,
        2.0
      )
    );

    if (active) {
      for (Ray ray in _rays) {
        motions.run(new MotionSequence(<Motion>[
          new MotionDelay(1.5),
          new MotionTween<double>(
            (a) => ray.opacity = a,
            ray.opacity,
            ray.maxOpacity,
            1.5
          )
        ]));
      }
    } else {
      for (Ray ray in _rays) {
        motions.run(new MotionTween<double>(
          (a) => ray.opacity = a,
          ray.opacity,
          0.0,
          0.2
        ));
      }
    }
  }
}

// An animated sun ray
class Ray extends Sprite {
  double _rotationSpeed;
  double maxOpacity;

  Ray() : super.fromImage(_images['assets/ray.png']) {
    pivot = const Offset(0.0, 0.5);
    transferMode = BlendMode.plus;
    rotation = randomDouble() * 360.0;
    maxOpacity = randomDouble() * 0.2;
    opacity = maxOpacity;
    scaleX = 2.5 + randomDouble();
    scaleY = 0.3;
    _rotationSpeed = randomSignedDouble() * 2.0;

    // Scale animation
    double scaleTime = randomSignedDouble() * 2.0 + 4.0;

    motions.run(new MotionRepeatForever(
      new MotionSequence(<Motion>[
        new MotionTween<double>((a) => scaleX = a, scaleX, scaleX * 0.5, scaleTime),
        new MotionTween<double>((a) => scaleX = a, scaleX * 0.5, scaleX, scaleTime)
      ])
    ));
  }

  @override
  void update(double dt) {
    rotation += dt * _rotationSpeed;
  }
}

// Rain layer. Uses three layers of particle systems, to create a parallax
// rain effect.
class Rain extends Node {
  Rain() {
    _addParticles(1.0);
    _addParticles(1.5);
    _addParticles(2.0);
  }

  List<ParticleSystem> _particles = <ParticleSystem>[];

  void _addParticles(double distance) {
    ParticleSystem particles = new ParticleSystem(
      _sprites['raindrop.png'],
      transferMode: BlendMode.srcATop,
      posVar: const Offset(1300.0, 0.0),
      direction: 90.0,
      directionVar: 0.0,
      speed: 1000.0 / distance,
      speedVar: 100.0 / distance,
      startSize: 1.2 / distance,
      startSizeVar: 0.2 / distance,
      endSize: 1.2 / distance,
      endSizeVar: 0.2 / distance,
      life: 1.5 * distance,
      lifeVar: 1.0 * distance
    );
    particles.position = const Offset(1024.0, -200.0);
    particles.rotation = 10.0;
    particles.opacity = 0.0;

    _particles.add(particles);
    addChild(particles);
  }

  set active(bool active) {
    motions.stopAll();
    for (ParticleSystem system in _particles) {
      if (active) {
        motions.run(
          new MotionTween<double>(
            (a) => system.opacity = a,
            system.opacity,
            1.0,
            2.0
        ));
      } else {
        motions.run(
          new MotionTween<double>(
            (a) => system.opacity = a,
            system.opacity,
            0.0,
            0.5
        ));
      }
    }
  }
}

// Snow. Uses 9 particle systems to create a parallax effect of snow at
// different distances.
class Snow extends Node {
  Snow() {
    _addParticles(_sprites['flake-0.png'], 1.0);
    _addParticles(_sprites['flake-1.png'], 1.0);
    _addParticles(_sprites['flake-2.png'], 1.0);

    _addParticles(_sprites['flake-3.png'], 1.5);
    _addParticles(_sprites['flake-4.png'], 1.5);
    _addParticles(_sprites['flake-5.png'], 1.5);

    _addParticles(_sprites['flake-6.png'], 2.0);
    _addParticles(_sprites['flake-7.png'], 2.0);
    _addParticles(_sprites['flake-8.png'], 2.0);
  }

  List<ParticleSystem> _particles = <ParticleSystem>[];

  void _addParticles(SpriteTexture texture, double distance) {
    ParticleSystem particles = new ParticleSystem(
      texture,
      transferMode: BlendMode.srcATop,
      posVar: const Offset(1300.0, 0.0),
      direction: 90.0,
      directionVar: 0.0,
      speed: 150.0 / distance,
      speedVar: 50.0 / distance,
      startSize: 1.0 / distance,
      startSizeVar: 0.3 / distance,
      endSize: 1.2 / distance,
      endSizeVar: 0.2 / distance,
      life: 20.0 * distance,
      lifeVar: 10.0 * distance,
      emissionRate: 2.0,
      startRotationVar: 360.0,
      endRotationVar: 360.0,
      radialAccelerationVar: 10.0 / distance,
      tangentialAccelerationVar: 10.0 / distance
    );
    particles.position = const Offset(1024.0, -50.0);
    particles.opacity = 0.0;

    _particles.add(particles);
    addChild(particles);
  }

  set active(bool active) {
    motions.stopAll();
    for (ParticleSystem system in _particles) {
      if (active) {
        motions.run(
          new MotionTween<double>((a) => system.opacity = a, system.opacity, 1.0, 2.0
        ));
      } else {
        motions.run(
          new MotionTween<double>((a) => system.opacity = a, system.opacity, 0.0, 0.5
        ));
      }
    }
  }
}
