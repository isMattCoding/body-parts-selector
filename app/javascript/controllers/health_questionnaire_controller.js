import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="health-questionnaire"
export default class extends Controller {
  static targets = [
    "output",
    "clockSelect",
    "outputBodySymptoms",
    "bodySymptomsModal",
    "bodySymptomsModalValue",
    "bodySymptomsSvgDezoom",
  ];

  connect() {
    // Puts a listener on the entire document to listen for a turbo fetch request
    console.log("health-questionnaire connected");
    document.addEventListener("turbo:before-fetch-request", async (event) => {
      // If the turbo fetch requet is an "body_symptoms" action, it will execute
      if (/.*body_symptoms.*/.test(event.target.action)) {
        const bodySymptomsValueParam = new URLSearchParams(
          // The string will be passed into the params, which will be accessible in the turbo frame as "@link"
          `parts=${this.outputBodySymptomsTarget.value}`
        );
        event.detail.fetchOptions.body = bodySymptomsValueParam;
      }
    });
  }

  pushToArray(event) {
    console.log("hello");
    // On click, adds or removes class to/from body part path
    event.currentTarget.classList.toggle("active-body-part");
    // Define string, takes the current list of selected body parts
    let string = this.outputBodySymptomsTarget.value;
    // Add/remove clicked body part name to/from list of selected body parts
    if (string.split(", ").includes(event.params.bodypart)) {
      string = string.replace(event.params.bodypart, "");
    } else {
      if (string.length > 1) {
        string = string.concat(", ", event.params.bodypart);
      } else {
        string = event.params.bodypart;
      }
    }
    // Inject updated list as value back into the the input
    console.log(string);
    this.outputBodySymptomsTarget.setAttribute("value", string);
  }

  addActiveToPaths(string) {
    // Parse list into an array, so that we can iterate on each item of list
    const array = string.split(", ");
    // Iterate on list
    array.forEach((bodypart) => {
      // For each list item, we select all paths with the same class
      const parts = Array.from(document.getElementsByClassName(bodypart));
      // For each path with that class, we add the "active" class
      parts.forEach((part) => {
        part.classList.add("active-body-part");
      });
    });
  }

  // This function adds "active" to required body parts in the modal
  bodySymptomsSvgTargetConnected() {
    // Once the body symptoms modal (turbo frame) is rendered, below is executed
    // Define string, takes the current list of selected body parts
    // console.log(this.bodySymptomsModalTarget.dataset.list)
    const string = this.bodySymptomsModalTarget.dataset.list;
    if (string !== "") {
      this.addActiveToPaths(string);
    }
  }

  bodySymptomsSvgDezoomTargetConnected() {
    this.bodySymptomsSvgDezoomTargets.map((target) => {
      const string = target.dataset.list;
      console.log(string);
      if (string !== "") {
        const array = string.split(", ");
        array.forEach((bodypart) => {
          // For each list item, we select all paths with the same class
          const parts = Array.from(target.getElementsByClassName(bodypart));
          // For each path with that class, we add the "active" class
          parts.forEach((part) => {
            part.classList.add("active-body-part");
          });
        });
      }
    });
    const string = this.bodySymptomsSvgDezoomTarget.dataset.list;
    // if (string !== "") {
    //   this.addActiveToPaths(string);
    // }
  }

  // This function is called when the submit button on the modal is clicked
  close() {
    // Hide the modal
    this.bodySymptomsModalTarget.classList.toggle("hidden");
    // Define current list of selected body parts
    let string = this.outputBodySymptomsTarget.value;
    this.addActiveToPaths(string);
    // Parse into array all paths that were previously selected
    const activeParts = Array.from(
      document.getElementsByClassName("active-body-part")
    );
    activeParts.forEach((part) => {
      // For each path, find all of its classes (to determine which part it is)
      const partClasses = Array.from(part.classList);
      // If any of those classes are NOT included in the list of selected body parts, execute action
      if (!partClasses.some((r) => string.split(", ").includes(r))) {
        // Remove "active" from the svg on the initial page
        part.classList.remove("active-body-part");
      }
    });
  }
}
