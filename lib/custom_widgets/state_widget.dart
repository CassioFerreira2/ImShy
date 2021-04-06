import 'package:flutter/material.dart';

enum StateType {
  All, Friendship, Desactivated
}

class StateWidget extends Container {
  StateType actualState;
  
  StateWidget(this.actualState): super();
  
}



