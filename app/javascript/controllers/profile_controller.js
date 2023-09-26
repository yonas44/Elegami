import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = ["navBtn", "detail"];

  initialize() {
    this.selectedButton = this.navBtnTargets[0];
    this.selectedDetailPage = this.detailTargets[0];

    this.detailTargets.forEach((item, index) => {
      item.classList.add("hidden");
      item.classList.remove("flex");

      this.navBtnTargets[index].classList.remove("bg-gray-300");
    });

    this.selectedButton.classList.add("bg-gray-300");
    this.selectedDetailPage.classList.add("flex");
    this.selectedDetailPage.classList.remove("hidden");
  }

  // Handle the click event on the buttons
  handleProfileNav(event) {
    const clickedButton = event.currentTarget;

    if (
      clickedButton.textContent.toLowerCase() !==
      this.selectedButton.textContent.toLowerCase()
    ) {
      this.selectedButton.classList.remove("bg-gray-300");
      this.selectedDetailPage.classList.add("hidden");

      this.selectedButton = clickedButton;
      this.selectedButton.classList.add("bg-gray-300");
    }

    this.detailTargets.forEach((item) => {
      if (
        item.dataset.group === event.currentTarget.textContent.toLowerCase()
      ) {
        item.classList.remove("hidden");
      } else {
        item.classList.add("hidden");
      }
    });
  }
}
