import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = ["navBtn"];

  initialize() {
    this.selectedButton = this.navBtnTargets[0];
    this.selectedButton.classList.add("active");
  }

  // Handle the click event on the buttons
  handleProfileNav(event) {
    const clickedButton = event.currentTarget;

    if (this.selectedButton) {
      this.selectedButton.classList.remove("active");
    }

    clickedButton.classList.add("active");

    this.selectedButton = clickedButton;
  }
}
