import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="confirmation"
export default class extends Controller {
  static targets = ["modal"];

  connect() {}

  toggle() {
    this.modalTarget.classList.toggle("hidden");
    this.modalTarget.classList.toggle("flex");
  }

  removeDetail() {
    const detailSection = document.querySelector("#milestone_detail_wrapper");
    detailSection.innerHTML = "";
  }
}
