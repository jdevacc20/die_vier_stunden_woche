import 'package:flutter/material.dart';
import 'package:flutter_app/levels/level_memory/level_memory_card_widget.dart';
import 'package:flutter_app/levels/level_wrapper.dart';
import 'dart:async';

class LevelMemoryWidget extends StatefulWidget {
  const LevelMemoryWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LevelMemoryWidget();
}

class _LevelMemoryWidget extends State<LevelMemoryWidget> {
  bool done = false;
  int _curOpenIndex = -1; //index of the current open card
  List<LevelMemoryCardWidget> _cards = []; //all _cards
  List<int> _solved = []; //list of all _solved _cards
  Timer _timer = Timer(const Duration(seconds: 0),
      (() {})); //timer to close card after 2 seconds
  int _timeLeft = 0; //time left until the card is closed
  List<int> _indexCardToClose = []; //index of the card to close
  int timeLeftSecondCard = 0; //time left to select your second card

  @override
  void initState() {
    super.initState();
    _cards = generateMemoryCards();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(
          () {
            if (_timeLeft == 1) {
              for (int index in _indexCardToClose) {
                _changeCardState(index, false);
              }
              _indexCardToClose = [];
              _timeLeft = 0;
            } else if (_timeLeft > 1) {
              _timeLeft -= 1;
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return LevelWrapper(
      title: "Memory Test",
      description: "Find pairs of all Icons!",
      hint: "denk nach pisser",
      done: done,
      levelChild: GridView.count(
        crossAxisCount: 3,
        children: _cards,
      ),
    );
  }

  List<LevelMemoryCardWidget> generateMemoryCards() {
    List<int> items = [0, 0, 1, 1, 2, 2, 3, 3, 4, 5, 5, 6];
    items.shuffle();
    return List.generate(items.length, (index) {
      Icon icon;
      switch (items[index]) {
        case 0:
          {
            icon = const Icon(Icons.abc);
            break;
          }
        case 1:
          {
            icon = const Icon(Icons.tram_sharp);
            break;
          }
        case 2:
          {
            icon = const Icon(Icons.accessibility_new_rounded);
            break;
          }
        case 3:
          {
            icon = const Icon(Icons.open_in_browser);
            break;
          }
        case 4:
          {
            icon = const Icon(Icons.add);
            break;
          }
        case 5:
          {
            icon = const Icon(Icons.face);
            break;
          }
        default:
          {
            icon = const Icon(Icons.delete_forever);
            break;
          }
      }
      return LevelMemoryCardWidget(
          icon: icon,
          iconType: items[index],
          onTap: onCardIsPressed,
          index: index);
    });
  }

  ///callback, when a card is pressed
  void onCardIsPressed(int index) {
    if (_timeLeft > 0) {
      return; //no presses allowed, when card is animating back
    }
    if (_solved.contains(index)) {
      return; //already open and _solved
    }
    if (_curOpenIndex == -1) {
      //first card
      setState(() {
        _curOpenIndex = index;
        _changeCardState(index, true);
      });
    } else if (_curOpenIndex == index) {
      if (_cards[index].icon.icon == Icons.add && _solved.length == 10) {
        //other cards are solved
        if (_cards.length == 12) {
          // insert add-icon
          setState(() {
            List<LevelMemoryCardWidget> newCards = List.from(_cards);
            newCards.add(
              LevelMemoryCardWidget(
                  icon: const Icon(Icons.add),
                  iconType: 4,
                  onTap: onCardIsPressed,
                  index: 12),
            );
            _cards = newCards;
          });
        } else if (_cards.length == 13) {
          //insert delete-icon
          setState(() {
            List<LevelMemoryCardWidget> newCards = List.from(_cards);
            newCards.add(
              LevelMemoryCardWidget(
                  icon: const Icon(Icons.delete_forever),
                  iconType: 6,
                  onTap: onCardIsPressed,
                  index: 13),
            );
            _cards = newCards;
          });
        }
      }
    } else if (_cards[_curOpenIndex].iconType == _cards[index].iconType) {
      //found a pair
      setState(() {
        List<int> newSolved = List.from(_solved);
        newSolved.add(_curOpenIndex);
        newSolved.add(index);
        _solved = newSolved;
        _changeCardState(index, true); //open the other card
        _curOpenIndex = -1;
      });
      if (_cards.length == _solved.length) {
        setState(() {
          done = true;
        });
      }
    } else {
      //not the same card
      setState(() {
        _indexCardToClose = [_curOpenIndex, index];
        _timeLeft = 2;
        _curOpenIndex = -1;
        _changeCardState(index, true);
      });
    }
  }

  ///replace old card with new card with new state
  void _changeCardState(int index, bool open) {
    LevelMemoryCardWidget old = _cards[index];
    List<LevelMemoryCardWidget> newCards = List.from(_cards);
    newCards[index] = LevelMemoryCardWidget(
      icon: old.icon,
      iconType: old.iconType,
      onTap: onCardIsPressed,
      index: index,
      open: open,
    );
    _cards = newCards;
  }
}
