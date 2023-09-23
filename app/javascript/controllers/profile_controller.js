import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = ["navBtn", "detail"];

  initialize() {
    this.selectedButton = this.navBtnTargets[0];
    this.selectedDetailPage = this.detailTargets[0];
    this.selectedDetailPage.classList.remove("hidden");
    this.selectedDetailPage.classList.add("flex");
    this.selectedButton.classList.add("active");
  }

  // Handle the click event on the buttons
  handleProfileNav(event) {
    const clickedButton = event.currentTarget;

    if (this.selectedButton) {
      this.selectedButton.classList.remove("active");
      this.selectedDetailPage.classList.remove("active");
    }

    clickedButton.classList.add("active");
    this.detailTargets.forEach((item) => {
      if (
        item.dataset.group === event.currentTarget.textContent.toLowerCase()
      ) {
        item.classList.remove("hidden");
        item.classList.add("flex");
      } else {
        item.classList.add("hidden");
        item.classList.remove("flex");
      }
    });

    this.selectedButton = clickedButton;
  }
}
