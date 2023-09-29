import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="member"
export default class extends Controller {
  static targets = ["updateMember"];
  connect() {}

  toggle() {
    this.updateMemberTarget.classList.toggle("hidden");
  }
}
