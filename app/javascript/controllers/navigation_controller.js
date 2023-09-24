import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["navOptions", "menuOpen", "menuClose"];

  toggle() {
    this.menuOpenTarget.classList.toggle("hidden");
    this.menuCloseTarget.classList.toggle("hidden");
    this.navOptionsTarget.classList.toggle("hidden");
    this.navOptionsTarget.classList.toggle("flex");
    this.navOptionsTarget.classList.toggle("scale-90");
    this.navOptionsTarget.classList.toggle("opacity-0");
    this.navOptionsTarget.classList.toggle("invisible");
  }
}
