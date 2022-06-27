# PokeChallenge

iOS application that allows you to browse the list of all available Pokémon and check its details.

## Project structure
The project structure is:
- |- Models: Contains the layers with the business logic of the application.
- |- Modules:
    - |- Views: Contains view components that can be reused.
    - |- ModuleName:
        - |- ViewModels: Knows and manipulates the logic on the view layer as well as the model layer.
        - |- Views: Contains the view components who is responsible for displaying data to the user and handling user interaction.
- |- Services: Contains the interfaces to reuse in this case, contains the clases and methods to request the information provided by the APIs and another important activity on the application. 
- |- Networking: Everything required to use graphQL with the Apollo client and PokeAPI with Rest API.
- |- Resources: Has the assets with Images, colors and Constants to reuse.
- Tests: contains all the unit Testings.

> The data was provided by GraphQL API to the list
> The data was provided by GraphQL and PokeAPI to the pokemon detail

## Installation

> PokeChallenge requires xcode 13.+ to run.
> The application runs on iOS 15.4

- Clone the repository.

```
git clone https://github.com/orellanaOC/Ravn-Challenge-V3-Concepcion-Orellana.git
```

![Project](./ImageReadme/PokemonList.gif)

## Technologies used

- Swift 5
- GraphQL API - Provided data with mutations.
- PokeAPI - Provided data with Rest API.
- URLSession - HTTP request in Swift.
- Apollo Client - It allows you to execute queries and mutations against a GraphQL server.
- Kingfisher - Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web.
