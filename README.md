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

## 🚀 Module Structure
There are 3 main modules to help separate the code. They are Data, Domain, and Presentaion.

- **Data** contains Local Storage, APIs, Data objects (Request/Response object, DB objects), and the repository implementation.

- **Domain** contains UseCases, Domain Objects/Models, and Repository Interfaces

- **Presentaion** contains UI, ViewModel, ViewController etc. Can be split into separate modules itself if needed. For example, we could have a module called Device handling things like camera, location, etc.

## 🚀 Detail overview
### Domain
**Entities** are implemented as Swift struct
```swift
struct Hits: Decodable {
    var id: Int?
    var pageURL: String?
    var type: String?
    var tags: String?
    var previewURL: String?
    var previewWidth: Int?
    var previewHeight: Int?
    var webformatURL: String?
    var webformatWidth: Int?
    var webformatHeight: Int?
    var largeImageURL: String?
    var imageWidth: Int?
    var imageHeight: Int?
    var imageSize: Int?
    var views: Int?
    var downloads: Int?
    var collections: Int?
    var likes: Int
    var comments: Int
    var userId: Int?
    var user: String?
    var userImageURL: String?
}
```
**UseCases** are protocols
```
protocol PhotoUseCase {
    func getPhoto(pageSize: Int, completion: @escaping (Result<PhotoResult, Error>) -> Void)
}
```
Domain layer doesn't depend on UIKit or any 3rd party framework.

### Data
**DataSource** implement RestApi
```
enum PhotoDataSourceImpl: RestApi {
    case getPhotoDataSource(pageSize: Int)

    var path: String {
        switch self {
        case .getPhotoDataSource(let pageSize):
            return "?key=\(Config.current.apiKey)&page=\(pageSize)&per_page=200"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPhotoDataSource:
            return .get
        }
    }
}
```
**Repositories** implement PhotoUseCase
```
struct PhotoResult: Decodable {
    var hits: [Hits]?
    var total: Int?
    var totalHits: Int?
}

struct PhotoRepository: PhotoUseCase { 
    func getPhoto(pageSize: Int, completion: @escaping (Result<PhotoResult, Error>) -> Void) {
        return PhotoDataSourceImpl
            .getPhotoDataSource(pageSize: pageSize)
            .request(returnType: PhotoResult.self){ result in
                switch result {
                case .success(let photoResult):
                    completion(.success(photoResult));
                case .failure(let error):
                    completion(.failure(error));
                }
            }
    }
}
```

### Presentation
Presentation is implemented with the MVVM pattern

**ViewModel**
```
class PhotoViewModel {
    @Injected var photoUseCase: PhotoUseCase
    var photoResult: PhotoResult?
    
    func getPhotoVM(pageSize: Int, completion: @escaping (Result<PhotoResult, Error>) -> Void) {
        photoUseCase.getPhoto(pageSize: 1){ result in
            switch result {
            case .success(let photoResult):
                self.photoResult = photoResult
                completion(.success(photoResult))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        };
    }
}
```

**ViewController**
```
class PhotoListViewController: UIViewController {
    var apiResult = PhotoResult()
    @IBOutlet weak var tableViewPhoto: UITableView!
    var viewModel = PhotoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Photo", comment: "")
        viewModel.getPhotoVM(pageSize: 1) { result in
            switch result {
            case .success:
                self.tableViewPhoto.reloadData()
            case .failure(let error):
                print("Failed to fetch users: \(error)")
            }
        }
        configUI()
    }
    
    private func configUI() {
        tableViewPhoto.register(UINib(nibName: "PhotoCell",
                                      bundle: nil),
                                forCellReuseIdentifier: "PhotoCell")
        tableViewPhoto.dataSource = self
        tableViewPhoto.delegate = self
    }
}
```
## 🚀 UI example
![alt text](https://github.com/LamNguyen17/ios_swift_clean_architecture/blob/main/Images/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20-%202024-03-05%20at%2015.39.28.png)
