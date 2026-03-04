import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notification_dashboard/generated/locale_keys.g.dart';


/// Emotion/Emoji picker widget
/// Displays a grid of emotions and emojis that can be selected
class EmotionPicker extends StatelessWidget {
  final Function(String emotion) onEmotionSelected;

  const EmotionPicker({super.key, required this.onEmotionSelected});

  /// List of emotions/emojis to display
  static const List<String> emotions = [
    '😀', // grinning face
    '😃', // grinning face with big eyes
    '😄', // grinning face with smiling eyes
    '😁', // beaming face with smiling eyes
    '😆', // grinning squinting face
    '😅', // grinning face with sweat
    '🤣', // rolling on the floor laughing
    '😂', // face with tears of joy
    '🙂', // slightly smiling face
    '🙃', // upside down face
    '😉', // winking face
    '😊', // smiling face with smiling eyes
    '😇', // smiling face with halo
    '🥰', // smiling face with hearts
    '😍', // smiling face with heart eyes
    '🤩', // star struck
    '😘', // face blowing a kiss
    '😗', // kissing face
    '😚', // kissing face with closed eyes
    '😙', // kissing face with smiling eyes
    '🥲', // smiling face with tear
    '😋', // face savoring food
    '😛', // face with tongue
    '😜', // winking face with tongue
    '🤪', // zany face
    '😌', // relieved face
    '😔', // pensive face
    '😑', // expressionless face
    '😐', // neutral face
    '😶', // face with mouth covered
    '🤐', // zipper mouth face
    '🤨', // face with raised eyebrow
    '😏', // smirking face
    '😒', // unamused face
    '🙁', // slightly frowning face
    '☹️', // frowning face
    '😲', // astonished face
    '😞', // disappointed face
    '😖', // confounded face
    '😢', // crying face
    '😭', // loudly crying face
    '😤', // face with steam from nose
    '😠', // angry face
    '😡', // pouting face
    '🤬', // face with symbols on mouth
    '😈', // smiling face with horns
    '❤️', // red heart
    '💔', // broken heart
    '💕', // two hearts
    '💖', // sparkling heart
    '💗', // growing heart
    '💓', // beating heart
    '💞', // revolving hearts
    '👍', // thumbs up
    '👎', // thumbs down
    '🤝', // handshake
    '🎉', // party popper
    '🎊', // confetti ball
    '🎈', // balloon
    '🌟', // glowing star
    '⭐', // star
    '✨', // sparkles
    '💯', // hundred points
    '🔥', // fire
    '❄️', // snowflake
    '☀️', // sun
    '🌈', // rainbow
    '😎', // face with sunglasses
    '🤓', // nerd face
    '🥳', // partying face
    '😏', // smirking face
    '🤥', // lying face
    '😌', // relieved face
    '😔', // pensive face
    '😪', // sleepy face
    '🤤', // drooling face
    '😴', // sleeping face
    '😷', // face with medical mask
    '🤒', // face with thermometer
    '🤕', // face with head-bandage
    '🤮', // face vomiting
    '🤢', // nauseated face
    '🤮', // face vomiting
    '🤠', // cowboy hat face
    '🥺', // pleading face
    '🥵', // hot face
    '🥶', // cold face
    '🥴', // woozy face
    '😵', // dizzy face
    '🤯', // exploding head
    '💀', // skull
    '👻', // ghost
    '👹', // ogre
    '👺', // goblin
    '💩', // pile of poo
    '👺', // goblin
    '💏', // kiss
    '💑', // couple with heart
    '🧡', // orange heart
    '💛', // yellow heart
    '💚', // green heart
    '💙', // blue heart
    '💜', // purple heart
    '🖤', // black heart
    '🤍', // white heart
    '🤎', // brown heart
    '🤏', // pinching hand
    '👏', // clapping hands
    '🙌', // raising hands
    '👐', // open hands
    '🤲', // open hands with palms up
    '🤝', // handshake
    '🤜', // right fist
    '🤛', // left fist
    '✊', // fist
    '👊', // punch
    '🖐️', // hand with fingers splayed
    '✋', // raised hand
    '🖖', // vulcan salute
    '👌', // ok hand
    '🤌', // pinched fingers
    '🤏', // pinching hand
    '✌️', // victory hand
    '🤞', // crossed fingers
    '🫰', // hand with index and middle fingers crossed
    '🤟', // love you gesture
    '🤘', // sign of the horns
    '🤙', // call me hand
    '👈', // backhand index pointing left
    '👉', // backhand index pointing right
    '👆', // backhand index pointing up
    '👇', // backhand index pointing down
    '☝️', // index pointing up
    '🎈', // balloon
    '🎉', // party popper
    '🎊', // confetti ball
    '🎁', // wrapped gift
    '🎀', // ribbon
    '🎂', // birthday cake
    '🍕', // pizza
    '🍔', // hamburger
    '🍟', // french fries
    '🌭', // hot dog
    '🍿', // popcorn
    '🍎', // red apple
    '🍊', // orange
    '🍋', // lemon
    '🍌', // banana
    '🍉', // watermelon
    '🍇', // grapes
    '🍓', // strawberry
    '🍒', // cherries
    '🍑', // peach
    '☕', // hot beverage
    '🍵', // teacup without handle
    '🍺', // beer mug
    '🩵', // blue heart
    '🎮', // video game
    '🎲', // game die
    '🎯', // direct hit
    '🎪', // circus tent
    '🎭', // performing arts
    '🎨', // artist palette
    '🎬', // clapper board
    '🎤', // microphone
    '🎧', // headphone
    '🎼', // musical score
    '🎹', // musical keyboard
    '🎸', // guitar
    '🎺', // trumpet
    '🎻', // violin
    '🥁', // drum
    '✈️', // airplane
    '🚀', // rocket
    '🚁', // helicopter
    '🚂', // locomotive
    '🚃', // railway car
    '🚄', // high-speed train
    '🚅', // bullet train
    '🚆', // train
    '🚇', // metro
    '🚈', // light rail
    '🚉', // station
    '🚊', // tram
    '🚝', // mountain cableway
    '🚞', // mountain railway
    '🚋', // tram car
    '🚌', // bus
    '🚍', // oncoming bus
    '🚎', // trolleybus
    '🚐', // minibus
    '🚑', // ambulance
    '🚒', // fire engine
    '🚓', // police car
    '🚔', // oncoming police car
    '🚕', // taxi
    '🚖', // oncoming taxi
    '🚗', // automobile
    '🚘', // oncoming automobile
    '🚙', // sport utility vehicle
    '🚚', // delivery truck
    '🚛', // articulated lorry
    '🚜', // tractor
    '🏎️', // racing car
    '🏍️', // motorcycle
    '⛵', // sailboat
    '🚤', // speedboat
    '🛳️', // passenger ship
    '⛴️', // ferry
    '🛥️', // motor boat
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.emotion_select.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // Emotions grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: emotions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      onEmotionSelected(emotions[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          emotions[index],
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
