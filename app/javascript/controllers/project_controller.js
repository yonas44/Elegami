import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "form", "detail"];

  toggleOn() {
    this.modalTarget.classList.add("flex");
    this.modalTarget.classList.remove("hidden");
  }

  toggleOff() {
    this.modalTarget.classList.add("hidden");
    this.modalTarget.classList.remove("flex");
  }

  show() {
    this.detailTarget.classList.remove("translate-x-full");
    this.detailTarget.classList.add("translate-x-0");
  }

  hide() {
    this.detailTarget.classList.add("translate-x-full");
    this.detailTarget.classList.remove("translate-x-0");
  }

  reset() {
    this.toggleOff();
    this.formTarget.reset();
  }
}
