## Introduction

This project is a native iOS app that allows users to browse recipes for Dessert category. There are no external dependencies. The recipes are fetched from the following API - https://themealdb.com/api.php.
There are 2 endpoints this app utilizes:
- https://themealdb.com/api/json/v1/1/filter.php?c=Dessert for fetching the list of meals in the Dessert category.
- https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID for fetching the meal details by its ID.

## Table of contents

- [Requirements](#requirements)
- [Architecture](#architecture)
- [Features](#features)
- [Usage and Testing](#usage-and-testing)
- [Experience](#experience)
- [Future Improvements](#future-improvements)
- [Screenshots](#screenshots)
- [Contact](#contact)

## Requirements

- Xcode version - 15.4 (latest stable version)
- iOS 16 and up
- Swift 5.10

## Architecture 

This project uses the Model-View-ViewModel (MVVM) architecture with a separate network layer. Here's a brief explanation of each component:

- **Model:** Represents the data of the application. It stores and formats data that can be used by the other components in the app.
- **View:** Represents the UI layer, responsible for displaying the data to the user. In this project, SwiftUI is used to create the views.
- **ViewModel:** Acts as a mediator between the Model and the View. It retrieves data from the Model and processes it, then provides the processed data to the View. I
- **Network Manager**: A separate component responsible for handling all network requests and interactions with APIs. It ensures that the network logic is decoupled from the rest of the application, providing a clean separation of concerns.

 #### How MVVM and Network Manager are Implemented in This Project

- **Model:** The `Model` classes handle data structures and encapsulate the business logic.
- **View:** The `View` layer is built using SwiftUI components, defining how the user interface looks and responds to user interactions.
- **ViewModel:** The `ViewModel` classes manage the data for the views. They fetch data from the `Model` or directly from the `Network Manager`, transform it if needed, and expose it to the `View` in a way that's easy to bind to UI elements.
- **Network Manager:** The `Network Manager` handles all network-related operations. It is responsible for making API calls, parsing responses, and handling any network errors. The `ViewModel` interacts with the `Network Manager` to fetch data from remote sources.

## Features

A list of features implemented in the project.
- List view that scrolls to display meals
- Detail view that displays the recipe
- Empty state, loading state and error view
- Dynamic fonts, supports accessibility, Light and dark mode.

## Usage and Testing

**Run the project.**

1. Select the target device/simulator.
2. Build and run the project by clicking on the "Run" button in Xcode or using the shortcut Cmd + R.

**Run tests**

1. Open the Test Navigator in Xcode.
2. Click the play button next to the test suite or use the shortcut Cmd + U.

## Experience

I have extensive experience with UIKit and have used it in several projects. This project represents my first formal attempt at using SwiftUI. Through this project, I aimed to explore SwiftUI's features and capabilities, leveraging my existing knowledge of iOS development.

## Future Improvements

A list of features I would add if I were to release this in production.
- Search meals
- A way for users to store and view favorite recipes
- More categories of meals
- Mechanism to get crashes (such as Firebase Crashlytics or Embace)
- Continuous integration (such as Xcode cloud or Bitrise)

## Screenshots

#### List of meals (initial screen)
| Launch screen | Meals List |
|:--:|:--:|
|<img src=https://github.com/bdsh-14/Recipes/assets/25411892/fda7e8c1-f72f-4599-8dd7-2dc7af02e19a width=250 />|<img src=https://github.com/bdsh-14/Recipes/assets/25411892/268908f7-1a5c-4ab0-864f-027dd73b79d7 width=250 />|

#### Details screen
| Collapsed | Expanded |
|:--:|:--:|
|<img src=https://github.com/bdsh-14/Recipes/assets/25411892/53548110-f003-46a4-b328-17d9d3320b7f width=250 />|<img src=https://github.com/bdsh-14/Recipes/assets/25411892/65ee218a-9ed6-42a4-a4e5-a6af9cad93a7 width=250 />|

## Contact

Provide your contact information or instructions on how to reach you for questions or feedback.

- Email: bdsh.14@gmail.com
- LinkedIn: [Bidisha Biswas](https://www.linkedin.com/in/yourprofile/](https://www.linkedin.com/in/biswasbidisha/))
