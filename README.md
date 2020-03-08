# StarWars Project
This project aims to consume data from [SWAPI](https://swapi.co/documentation) in order to present a Star Wars Characters list screen with search functionality.

## Requirements
* iOS 13.2

## Structure
StarWarsProject is composed by these main artifacts

Components  | Main Responsability
----------- | -------------------
[AppCoordinator](https://github.com/lmbcosta/StarWarsProject/blob/master/StarWarsProject/Coordinator/AppCoordinator.swift) | Instantiates dependencies and presents navigation
[StarWarsListViewController](https://github.com/lmbcosta/StarWarsProject/blob/master/StarWarsProject/Controllers/StarWarsListViewController.swift) | Builds and controls different UI components for list screen
[StarWarsListDataSource](https://github.com/lmbcosta/StarWarsProject/blob/master/StarWarsProject/Controllers/StarWarsListDataSource.swift) | Manages data and feeds content for table view cells
[StarWarsViewModel](https://github.com/lmbcosta/StarWarsProject/blob/master/StarWarsProject/ViewModels/StarWarsViewModel.swift) | Manages pagination and search logic for network requests
[StarWarsSearchBarDelegate](https://github.com/lmbcosta/StarWarsProject/blob/master/StarWarsProject/Controllers/StarWarsSearchBarDelegate.swift) | Handles search bar's text input
[StarWarsService](https://github.com/lmbcosta/StarWarsProject/blob/master/StarWarsProject/Services/StarWarsService.swift) | Manages network calls to Star Wars API

## External Dependencies ❌
StarWars Project has no external dependecies, although a framework like [RxSwift](https://github.com/ReactiveX/RxSwift) could be a good fit for a list search feature. Please, check a following example [here](https://github.com/ReactiveX/RxSwift#usage). *RxSwift* is a heavy framework, and for this reason, I decided to leave it outside of this simple project.

## Tests ✅
This project is covered with some Unit Tests from Model to ViewModel layers. Due to my lack of experience and time, I wasn't able to expand them to the UI layer. Probably is something I should study and improve for the next time.

## Thank You
Regardless of the outcome of this challenge I would like to thank you the opportunity. It's always a pleasure work in fun stuff😃

## Author
Luís Costa - lmbcosta@hotmail.com
