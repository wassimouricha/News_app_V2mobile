// ignore_for_file: camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:async';

class delayedAnimation extends StatefulWidget {
  final Widget child;
  final int
      delay; //ici ce sera ma variable de type nombre qui sera donc le delay
  const delayedAnimation(
      {required this.delay,
      required this.child}); //required indique au code que ces parametres a savoir delay et child sont obligatoire

  @override
  _delayedAnimationState createState() => _delayedAnimationState();
}

class _delayedAnimationState extends State<delayedAnimation>
    with TickerProviderStateMixin {
  //pour gerer plusieurs animations il faut ajouter a la class état "with TickerProviderStateMixin"
  late AnimationController
      _controller; // je declare le controleur que l'on va utiliser pour mon animation
  late Animation<Offset>
      _animOffset; //ces deux variables vont me permettre de controler et de preciser l'animation
  @override
  void initState() {
    // avec initstate je vais initialiser toute l'animation
    super.initState(); //syntaxe à écrire pour les initState

    _controller = AnimationController(
      vsync:
          this, // j'indique avec le vsync: this que je veux que mes différentes animations soit synchronisées les unes avec les autres
      duration: const Duration(milliseconds: 800),
    );

    final curve =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);

    _animOffset = Tween<Offset>(
      begin: const Offset(0.0, -0.35), //le offset est mon parametre de décalage
      end: Offset.zero,
    ).animate(curve);

    // je vais utiliser la bibliothèques async que l'on a importer au tout debut du code

    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    }); //avec timer je vais preciser un delai pour l'execution de mon code, le code sera executé une fois que le delay sera écoulé
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(position: _animOffset,
      child: widget.child), //on aura donc deux animation , un slide et un fade
      
      );
  }
}
