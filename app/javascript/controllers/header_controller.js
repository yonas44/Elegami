import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dropDown", "profileOptions"];

  connect() {}

  toggle() {
    this.dropDownTarget.classList.toggle("rotate-180");
    this.profileOptionsTarget.classList.toggle("scale-90");
    this.profileOptionsTarget.classList.toggle("opacity-0");
    this.profileOptionsTarget.classList.toggle("invisible");
  }
}
