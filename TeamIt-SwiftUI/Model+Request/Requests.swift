import Foundation
import Combine

enum ServiceError: Error {
    case noError
    case decodeFailed
    case downloadFailed
}

enum DownloadError: Error {
    case downloadFailed
    case decodeFailed
}

class Requests: ObservableObject {
    
    static var requests = Set<AnyCancellable>()
    static let defaultSession = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
    
    
    /*
     
        So, this is the same fetch I use on the No-Storyboard exercise.
        One thing I like it better than the Combine one, is that I can add breakpoints
        and debug it better to know with more details what the issue is.
        
     
     */

    
    static func fetch<T:Decodable>(url: String, dataModel: T, completion: @escaping (T?, ServiceError) -> Void) {
        
        dataTask?.cancel()

        guard let url = URL(string: url) else {
            return
        }

        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            
            defer {
                self.dataTask = nil
            }
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, .downloadFailed)
                }
                
            } else if let data = data {

                do {
                    
                    let jsonDecoder = JSONDecoder()
                    let decodedData = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedData, .noError)
                    }

                } catch {
                    debugPrint("Error decoding APOD Data : \(error)")
                    DispatchQueue.main.async {
                        completion(nil, .decodeFailed)
                    }
                }
            }
        }

        dataTask?.resume()
    }
    
    // Combine Call
    
    /*
     
        Much cleaner but, as my comment aboce, I sitll find it a little more "demanding" when we need to debug.
        This particular one at least it gives two possible errors, like decode or download, but with more complex
        calls, I'd still use the one above until I get a better grasp on Combine.
     
     */
    
    static func fetch2<T: Decodable>(url: URL, dataModel: T, completion: @escaping (Result<T, DownloadError>) -> Void) {
        
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .map(Result.success)
            .catch { error -> Just<Result<T, DownloadError>> in
                error is DecodingError
                    ? Just(.failure(.decodeFailed))
                    : Just(.failure(.downloadFailed))
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &requests)
       
    }
    
}
