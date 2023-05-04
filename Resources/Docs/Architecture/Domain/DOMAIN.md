# Domain Layer

The domain layer is the core of our app, encapsulating its business logic and the entities that represent its main objects. This layer is responsible for defining the rules and behavior of the app's features and provides a clean separation of concerns between the app's components.

## Entities

Entities are the data models or structures that represent the core business objects in our app. They are plain data structures without any business logic or dependencies on external components.

Entities should be simple and focused on representing the business objects, with clearly defined properties and relationships.

## Use Cases

Use cases are the components responsible for the app's business logic, encapsulated in separate classes or structs. They define and perform specific tasks, such as fetching data, updating entities, or performing calculations.

## Features

- [Localization](./Localization.md): Localization feature that fetches translations from Google Sheets and creates localization files.
