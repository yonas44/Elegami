import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="navigation"
export default class extends Controller {
  static targets = ["navOptions", "menuOpen"];

  show() {
    this.menuOpenTarget.classList.toggle("hidden");
    this.navOptionsTarget.classList.remove("-translate-x-full");
    this.navOptionsTarget.classList.add("translate-x-0");
  }

  hide() {
    this.menuOpenTarget.classList.toggle("hidden");
    this.navOptionsTarget.classList.add("-translate-x-full");
    this.navOptionsTarget.classList.remove("translate-x-0");
  }
}
