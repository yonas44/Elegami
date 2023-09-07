import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "form", "detail"];

  initialize() {
    this.selectedProject = this.data.get("selectedProject");
    if (this.selectedProject) {
      this.newProject = JSON.parse(this.selectedProject);
      // Now this.newProject contains your @new_project data
      console.log(this.newProject);
    }
    console.log(this.element);

    document.addEventListener("flash:connect", ({ detail: { content } }) => {
      if (content.includes("Project successfully created.")) this.show();
    });
  }

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
