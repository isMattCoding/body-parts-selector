// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application";

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);

import BodyPartsModalController from "./body_parts_modal_controller.js";
application.register("body-parts-modal", BodyPartsModalController);

import HealthQuestionnaireController from "./health_questionnaire_controller.js";
application.register("health-questionnaire", HealthQuestionnaireController);

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
