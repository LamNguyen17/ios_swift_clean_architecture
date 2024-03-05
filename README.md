## 🚀 Project using Clean Architecture recommend by Google Developer
This guide encompasses best practices and recommended architecture for building robust, high-quality apps
- [Guide to app architecture (Gooogle Developers)](https://developer.android.com/topic/architecture?continue=https%3A%2F%2Fdeveloper.android.com%2Fcourses%2Fpathways%2Fandroid-architecture%3Fhl%3Dvi%23article-https%3A%2F%2Fdeveloper.android.com%2Ftopic%2Farchitecture)
## 🚀 Introduction
### Technology use: Clean Architecture, UIKit, MVVM, Resolver, Alamofire, Kingfisher
This sample demonstrates how one can

- Setup base architecture of IOS Swift app using Clean Architecture
- Use dependency injection for layers separation
- Make api calls using Alamofire plugin.

```
├── Common
├── Data
|   ├── Config
|   ├── Datasources
|   ├── Gateway
|   └── Repositories
├── DI (dependency injection)
├── Domain 
|   ├── Entities
|   └── Usecases
└── Presentation
    ├── Scenes
    └── Routers
```

#### Dependencies
- [Alamofire](https://github.com/Alamofire/Alamofire) : Alamofire is an HTTP networking library written in Swift
- [Kingfisher](https://github.com/onevcat/Kingfisher) : Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web. It provides you a chance to use a pure-Swift way to work with remote images in your next app.
- [Resolver](https://github.com/onevcat/Kingfisher) : An ultralight Dependency Injection / Service Locator framework for Swift 5.x on iOS

# 🚀 Module Structure
There are 3 main modules to help separate the code. They are Data, Domain, and Presentaion.

- **Data** contains Local Storage, APIs, Data objects (Request/Response object, DB objects), and the repository implementation.

- **Domain** contains UseCases, Domain Objects/Models, and Repository Interfaces

- **Presentaion** contains UI, ViewModel, ViewController etc. Can be split into separate modules itself if needed. For example, we could have a module called Device handling things like camera, location, etc.
