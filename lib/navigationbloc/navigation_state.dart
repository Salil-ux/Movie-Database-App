abstract class NavigationState {
  final int selectedIndex;

  const NavigationState(this.selectedIndex);
}

class NavigationInitial extends NavigationState {
  NavigationInitial() : super(0); // Default to Home
}

class NavigationChanged extends NavigationState {
  const NavigationChanged(super.index);
}
