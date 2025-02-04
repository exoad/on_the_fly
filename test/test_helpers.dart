dynamic Function() atLeastReturnSomething(void Function() r) => () {
      r();
      return 1;
    };
