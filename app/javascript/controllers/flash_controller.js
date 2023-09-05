import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["message", "projectCount"];

  connect() {
    if (this.hasMessageTarget) {
      setTimeout(() => {
        this.messageTarget.remove();
      }, 3000);
    }
  }
}
