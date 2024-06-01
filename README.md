# Body Parts Selector

Welcome to Body Parts Selector! This application demonstrates how one can create SVG images that can be used as form input in a Rails app using Hotwire and Turbo.

![Screenshot of an svg outlining the parts of the body, with some body parts selected](https://github.com/isMattCoding/body-parts-selector/blob/main/public/screenshot.png)

## Getting Started

To get started with Body Parts Selector, follow these steps:

1. Clone the repository to your local machine:

  ```bash
    git clone git@github.com:isMattCoding/body-parts-selector.git
  ```

2. Install the required gems:

  ```bash
    bundle install
  ```

3. Set up the database:

  ```bash
    rails db:create
    rails db:migrate
  ```

4. Initialise Tailwind:

  ```bash
    rails tailwindcss:install
    rails tailwindcss:build
  ```

## Running the Application
To run Body Parts Selector locally, use the following command:

  ```bash
    rails server
  ```

## Running Tests
To run the tests for Body Parts Selector, use the following command:

  ```bash
    rspec
  ```

## Completing a Questionnaire
To complete a questionnaire in Body Parts Selector, follow these steps:

1. Navigate to the homepage by clicking on the link provided or by visiting http://localhost:3000.
2. Click on the "New Body" link to start a new questionnaire.
3. Follow the on-screen instructions to complete the questionnaire.
4. Click on the "Continuer" button to proceed.

That's it! You have now completed a questionnaire in Body Parts Selector.


## How It Works
* __Overview__: Body Parts Selector enables users to interactively select body parts using SVG images within a Rails application enhanced by Hotwire and Turbo.

* __Navigating__:
  * Users visit the index page to view all existing body records.
  * SVG images (front and back of the body).

* __Selecting Body Parts__:
  * Clicking an SVG opens a larger modal version of the image.
  * Users can click body parts to select or deselect them. Selected parts are highlighted and added to a hidden text input.

* __Using Stimulus and Turbo__:
  * __Stimulus Controller__: Manages the selection of body parts. Adds or removes classes to highlight selected parts and updates the hidden input.
  * __Turbo Frames__: Used to load and display the modal. When a body part is selected, Turbo updates the hidden input with the selected parts.
  * __Turbo Streams__: When the form is submitted, Turbo Streams handle the response, updating the page without a full reload.

* __Saving and Viewing__:
  * After selecting body parts, users close the modal and submit the form.
  * The selected parts are saved as a parts attribute in the database.
  * Users can view all saved records on the index page.


## Contributing
If you'd like to contribute to Body Parts Selector, please fork the repository and submit a pull request. We welcome contributions of all kinds, including bug fixes, feature enhancements, and documentation improvements.

## License
Body Parts Selector is released under the [License Name] License. See LICENSE for details.

## Contact
If you have any questions or issues, please feel free to contact us using this online form: https://wmbt.services/contact
