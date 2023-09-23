import { Application } from "@hotwired/stimulus";
import CheckboxSelectAll from "stimulus-checkbox-select-all";
import AnimatedNumber from "stimulus-animated-number";

const application = Application.start();
application.register("checkbox-select-all", CheckboxSelectAll);
application.register("animated-number", AnimatedNumber);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
