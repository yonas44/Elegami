import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["message", "projectCount"];

  connect() {
    if (this.hasMessageTarget) {
      if (
        this.messageTarget.textContent.includes("Project successfully created.")
      ) {
        setTimeout(() => {
          const event = new CustomEvent("flash:connect", {
            detail: { content: this.messageTarget.textContent },
          });

          document.dispatchEvent(event);
        }, 500);
      }

      setTimeout(() => {
        this.messageTarget.remove();
      }, 3000);
    }
  }
}
