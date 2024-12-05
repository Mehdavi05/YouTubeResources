import UIKit
import Combine

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

let postURL = URL(string: "https://jsonplaceholder.typicode.com/posts")

func getPosts() -> AnyPublisher<[Post], Error> {
    let postsPublisher = URLSession
        .shared
        .dataTaskPublisher(for: postURL!)
        .map { $0.data }
        .decode(type: [Post].self, decoder: JSONDecoder())
        .catch { _ in return Just([]).setFailureType(to: Error.self) }
        .eraseToAnyPublisher()
   
    return postsPublisher
}

var subscriptions: Set<AnyCancellable> = []

getPosts()
    .replaceError(with: []) // Provide a default value in case of an error
    .sink { posts in
        print(posts)
    }
    .store(in: &subscriptions)
