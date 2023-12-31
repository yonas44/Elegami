import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "modal",
    "form",
    "filterable",
    "projectTab",
    "projectWindow",
    "milestone",
    "milestoneTab",
    "milestoneWindow",
    "milestoneModal",
    "milestoneOption",
    "taskModal",
    "memberModal",
    "taskMemberModal",
    "categoryBtn",
    "category",
    "projectType",
    "taskDetailContainer",
  ];

  initialize() {}

  toggleOn() {
    this.modalTarget.classList.add("flex");
    this.modalTarget.classList.remove("hidden");
  }

  toggleOff() {
    this.modalTarget.classList.add("hidden");
    this.modalTarget.classList.remove("flex");
    this.formTarget.reset();
  }

  // Method to handle category switch from project to tasks and vise versa
  handleCategorySwitch(event) {
    const categoryName = event.currentTarget.dataset.name;

    this.categoryBtnTargets.forEach((item) => {
      item.classList.remove("font-semibold");
      item.classList.add(
        "bg-gray-700",
        "border-b",
        "border-gray-500",
        "text-gray-400"
      );
    });

    event.currentTarget.classList.add("font-semibold");
    event.currentTarget.classList.remove(
      "bg-gray-700",
      "border-b",
      "border-gray-500",
      "text-gray-400"
    );

    this.categoryTargets.forEach((item) => {
      if (item.dataset.name === categoryName) {
        item.classList.remove("hidden");
        item.classList.add("flex");
      } else {
        item.classList.add("hidden");
      }
    });
  }

  // Method to handle project type switch (All, inprogress and completed)
  handleProjectTypeSwitch(event) {
    this.projectTypeTargets.forEach((item) => {
      item.classList.remove("border-b", "border-white");
      item.classList.add("text-gray-500");
    });
    event.currentTarget.classList.add("border-b", "border-white");
    event.currentTarget.classList.remove("text-gray-500");
  }

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

  // Handle toggle of a milestone list in a project
  handleMilestoneSelect(event) {
    this.milestoneTargets.forEach((item) => {
      item.classList.remove("border-r-4", "border-r-sky-700");
    });
    event?.currentTarget.classList.add("border-r-4", "border-r-sky-700");
  }

  // Method to toggle the project windows based on the selected tab
  handleProjectTabSwitch(event) {
    const tabName = event.currentTarget.dataset.id;

    // Loop through milestoneTabs to background to the selected tab
    this.projectTabTargets.forEach((item) => {
      if (item.dataset.id === tabName) {
        item.classList.add("bg-gray-200");
      } else {
        item.classList.remove("bg-gray-200");
      }
    });

    this.projectWindowTargets.forEach((item) => {
      const isMatchingTab = item.dataset.name === tabName;
      item.classList.toggle("hidden", !isMatchingTab);
      item.classList.toggle("flex", isMatchingTab);
    });
  }

  // Method to toggle the milestone windows based on the selected tab
  handleMilestoneTabSwitch(event) {
    const tabName = event.currentTarget.dataset.id;

    // Loop through milestoneTabs to background to the selected tab
    this.milestoneTabTargets.forEach((item) => {
      if (item.dataset.id === tabName) {
        item.classList.add("border-b", "border-gray-500", "font-semibold");
      } else {
        item.classList.remove("border-b", "border-gray-500", "font-semibold");
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
    const clickedOptionId = event.currentTarget.dataset.id;

    this.milestoneOptionTargets.forEach((item) => {
      const optionId = item.dataset.optionid;

      if (optionId === clickedOptionId) {
        // Toggle visibility for the clicked item
        item.classList.toggle("hidden");
        item.classList.toggle("block");
      } else {
        // Hide all other items
        item.classList.add("hidden");
        item.classList.remove("block");
      }
    });
  }

  // Handle new milestone modal toggle
  milestoneModalToggle() {
    this.milestoneModalTarget.classList.toggle("hidden");
    this.milestoneModalTarget.classList.toggle("flex");
    this.formTargets.forEach((item) => {
      item.reset();
    });
  }

  // Handle new task modal toggle
  taskModalToggle() {
    this.taskModalTarget.classList.toggle("hidden");
    this.taskModalTarget.classList.toggle("flex");
    this.formTargets.forEach((item) => {
      item.reset();
    });
  }

  // Handle new project member modal toggle
  memberModalToggle() {
    this.memberModalTarget.classList.toggle("hidden");
    this.memberModalTarget.classList.toggle("flex");
    this.formTargets.forEach((item) => {
      item.reset();
    });
  }

  // Handle task member modal to add contributors for a task
  taskMemberModalToggle() {
    this.taskMemberModalTarget.classList.toggle("hidden");
    this.taskMemberModalTarget.classList.toggle("flex");
  }

  // Handle single task detail container remove when close button clicked
  handleTaskDetailClose() {
    this.taskDetailContainerTarget.innerHTML = "";
    this.taskDetailContainerTarget.classList = "";
  }
}
