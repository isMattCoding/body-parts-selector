import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="health-questionnaire"
export default class extends Controller {
  connect() {
    console.log("body parts");
    // let string = this.outputBodySymptomsTarget.value
    // const array = string.split(', ')
    // console.log(string)
    // array.forEach(bodypart => {
    //   document.getElementById(bodypart).classList.add('active-body-part')
    // })
  }
}
