# Networking Layer

A simple, scalable, and testable networking layer

## Features

- 🏗 Modular architecture for easy customization and extension
- 💪 Type-safe API requests and decoding
- 📦 Built on top of URLSession for a lightweight footprint
- 🚀 Supports async/await for modern Swift concurrency
- 🔧 Comprehensive unit tests

## Components

### HTTPClient

The `HTTPClient` protocol is responsible for making raw HTTP requests and returning the data and response. It abstracts the underlying URLSession and can be easily mocked for testing.

### URLSessionHTTPClient

`URLSessionHTTPClient` is a concrete implementation of `HTTPClient` that uses URLSession to make the network requests. It can be easily configured with custom URLSession instances.

### RequestExecutor

`RequestExecutor` is a protocol for executing API requests and decoding the response into specified Swift model types.

### APIRequestExecutor

`APIRequestExecutor` is a concrete implementation of `RequestExecutor`. It uses the provided `HTTPClient` to fetch data and a JSON decoder to decode the data into the specified Swift model types.

## Usage

This networking layer provides a convenient way to make API requests using the APIRequestExecutor and RequestExecutor. Below, you will find examples of how to use these components to create and send API requests.

1. **Create a Request**
   First, define a custom request type that conforms to the Request protocol. This custom type should include all the necessary information for the API endpoint, such as the HTTP method, path, query parameters, and request body. Here's an example:
   
   ```swift
   struct GetUserByIdRequest: Request {
       typealias Response = User
   
       let id: String
   
       var method: HTTPMethod {
           return .get
       }
   
       var path: String {
           return "/users/\(id)"
       }
   }
   ```

2. **Initialize the APIRequestExecutor**
   Create an instance of the `APIRequestExecutor` with the base URL for your API. You can also provide custom instances of `HTTPClient`, `JSONDecoder`, `JSONEncoder`, and valid status codes if needed.
   
   ```swift
   let baseURLString = "https://api.example.com"
   let requestExecutor: RequestExecutor = APIRequestExecutor(baseURLString: baseURLString)
   ```

3. **Send the Request**
   Use the send(_:) function of the RequestExecutor to send your request. The function will return a decoded response of the expected type, or throw an error if the request fails.
   
   ```swift
   let getUserRequest = GetUserByIdRequest(id: "123")
   
   do {
       let user = try await requestExecutor.send(getUserRequest)
       print("User: \(user)")
   } catch {
       print("Error: \(error)")
   }
   ```

## Advanced Usage

You can also create more complex requests with custom query parameters and request bodies. Here's an example of a request that sends a Codable object as a JSON body and includes query parameters from a Codable struct:

```swift
struct UserPayload: Codable {
    let gender: String
}

struct PostUserByIdRequest: Request {
    typealias Response = User

    let id: String
    let user: User
    let payload: UserPayload

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/users/\(id)"
    }

    var queryItems: [URLQueryItem]? {
        return queryItems(from: payload)
    }

    var body: Data? {
        return try? JSONEncoder().encode(user)
    }

    var contentType: String? {
        return "application/json"
    }
}
```

## Customization

- To add custom logic for API-specific error handling or request building, create a new class conforming to `RequestExecutor` and implement the necessary logic.
- For specific HTTP clients or custom URLSession configurations, create a new class conforming to `HTTPClient` and implement the required methods.

## Testing

- This networking layer includes comprehensive unit tests for both `URLSessionHTTPClient` and `APIRequestExecutor`.
- Mock classes like `MockHTTPClient` and `MockURLProtocol` are provided for easy testing and isolation of components.
