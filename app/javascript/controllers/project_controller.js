import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "modal",
    "form",
    "filterable",
    "milestone",
    "milestoneTab",
    "milestoneWindow",
    "milestoneModal",
  ];

  initialize() {
    if (this.milestoneTargets.length) {
      this.milestoneTargets[0].classList.add("border-r-4", "border-r-sky-700");
    }
  }

  toggleOn() {
    this.modalTarget.classList.add("flex");
    this.modalTarget.classList.remove("hidden");
  }

  toggleOff() {
    this.modalTarget.classList.add("hidden");
    this.modalTarget.classList.remove("flex");
    this.formTarget.reset();
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

  // Reset the new project form
  reset() {
    this.toggleOff();
    this.formTargets.forEach((item) => {
      item.reset();
    });
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

  // Toggle the milestone options in the project
  handleMilestoneSelect(event) {
    this.milestoneTargets.forEach((item) => {
      item.classList.remove("border-r-4", "border-r-sky-700");
    });
    event.currentTarget.classList.add("border-r-4", "border-r-sky-700");
  }

  // Method to toggle the milestone windows based on the selected tab
  handleMilestoneTabSwitch(event) {
    const tabName = event.currentTarget.dataset.id;

    // Loop through milestoneTabs to background to the selected tab
    this.milestoneTabTargets.forEach((item) => {
      if (item.dataset.id === tabName) {
        item.classList.add("bg-gray-200");
      } else {
        item.classList.remove("bg-gray-200");
      }
    });

    this.milestoneWindowTargets.forEach((item) => {
      const isMatchingTab = item.dataset.name === tabName;
      item.classList.toggle("hidden", !isMatchingTab);
      item.classList.toggle("flex", isMatchingTab);
    });
  }

  // Handle milestone modal option selection for delete and update
  handleMilestoneOption(event) {
    event.stopPropagation();
    console.log(event.currentTarget.dataset.id);
  }

  // Handle new milestone modal toggle
  milestoneModalToggle() {
    this.milestoneModalTarget.classList.toggle("hidden");
    this.milestoneModalTarget.classList.toggle("flex");
    // this.reset();
  }
}
