import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "form", "detail", "title"];

  initialize() {
    this.allProjects = JSON.parse(this.element.dataset.projects);
    const newProject = JSON.parse(this.element.dataset.newproject);

    if (newProject) {
      this.show(newProject);
    }
  }

  toggleOn() {
    this.modalTarget.classList.add("flex");
    this.modalTarget.classList.remove("hidden");
  }

  toggleOff() {
    this.modalTarget.classList.add("hidden");
    this.modalTarget.classList.remove("flex");
  }

  handleSelect(event) {
    const selectedProject = this.allProjects.find(
      (item) => item.id == event.currentTarget.dataset.id
    );
    this.show(selectedProject);
  }

  show(project) {
    this.titleTarget.textContent = project?.title;
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
