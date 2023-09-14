import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "modal",
    "form",
    "detail",
    "title",
    "description",
    "filterable",
  ];

  initialize() {
    this.allProjects = JSON.parse(this.element.dataset.projects);
    this.searchInput = "";
    const newProject = JSON.parse(this.element.dataset.newproject);
    this.selectedProjectId = null;

    this.BASE_URL = "http://localhost:3000";

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

  // handleSelect(event) {
  //   const selectedProject = this.allProjects.find(
  //     (item) => item.id == event.currentTarget.dataset.id
  //   );
  //   this.selectedProjectId = selectedProject?.id;
  //   console.log(this.selectedProjectId);
  //   this.show(selectedProject);
  // }

  // handleDelete() {
  //   const modal = document.querySelector("#deleteModal");

  //   // Show the modal when the delete button is clicked
  //   modal.classList.remove("hidden");
  //   modal.classList.add("flex");
  // }

  // handleConfirm(event) {
  //   const modal = document.querySelector("#deleteModal");
  //   const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
  //   const operation = event.currentTarget.textContent;

  //   if (this.selectedProjectId && operation === "Delete") {
  //     fetch(`${this.BASE_URL}/projects/${this.selectedProjectId}`, {
  //       method: "DELETE",
  //       headers: {
  //         "Content-Type": "application/json",
  //         "X-CSRF-Token": csrfToken,
  //       },
  //     });
  //   } else {
  //     this.selectedProjectId = null;
  //   }
  //   modal.classList.add("hidden"); // Hide the modal
  // }

  // Handle Delete button click
  // confirmButton.addEventListener("click", async () => {
  //   console.log(projectId);
  // });

  reset() {
    this.toggleOff();
    this.formTarget.reset();
  }

  handleSearch(event) {
    const searchInput = event.currentTarget.value.toLowerCase();
    const projectsList = document.querySelector("#projects_list");
    const noContentMsg = document.querySelector("#no-content-msg");

    // Filter the targets and store them in filteredProjects
    const filteredProjects = this.filterableTargets.filter((item) => {
      const itemExist = item.dataset.key.toLowerCase().includes(searchInput);
      return itemExist;
    });

    // Hide or show items based on the filter
    this.filterableTargets.forEach((item) => {
      const itemExist = item.dataset.key.toLowerCase().includes(searchInput);
      item.classList.toggle("hidden", !itemExist);
    });

    // Handle the "no-content" message
    if (noContentMsg) {
      noContentMsg.remove();
    }

    if (!filteredProjects.length) {
      const message = document.createElement("p");
      message.id = "no-content-msg";
      message.textContent = "There are no projects with that name";
      projectsList.appendChild(message);
    }
  }
}
