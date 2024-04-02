// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
console.log("hello");

document.addEventListener("data-turbo-track:reload", () => {
  // Call your functions here, e.g:
  // initSelect2();
  console.log("page chargée !!!");
});
