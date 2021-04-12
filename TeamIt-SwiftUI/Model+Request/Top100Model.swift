import Foundation

enum DataError: Error {
    case noData
}

struct Top100Model {
    
    static let albumsURL = "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-songs/all/100/explicit.json"
    
    static func fetchAlbums(completion: @escaping (Result<Feed, DataError>) -> Void) {
        
        // We could add this URL into a Plist file but for simplicity, here it is...
        
        
        Requests.fetch(url: albumsURL, dataModel: Feed()) { dataResult, error in
            
            if error == .noError {
                
                if let albumsResult = dataResult {
                    completion(.success(albumsResult))
                } else {
                    completion(.failure(.noData))
                }
            } else {
                print("Error getting Top 100 Albums : \(error)")
                completion(.failure(.noData))
            }
            
            
        }
    }
    
    
    static func fetchTop100Albums(completion: @escaping (Result<Feed, DownloadError>) -> Void) {
        
        guard let theURL = URL(string: albumsURL) else { return }
        
        Requests.fetch2(url: theURL, dataModel: Feed()) { result in
            
            switch result {
            case .success(let albumData):
                completion(.success(albumData))
            case .failure(let errorType):
                print(errorType)
                completion(.failure(errorType))
            }
            
        }
        
        
    }
    
    
    
    
    static func sampleAlbums() -> [AlbumResults] {
        
        let sample = [AlbumResults(artistName: "Taylor Swift",
                                  releaseDate: "2021",
                                  collectionName: "Album Name",
                                  copyright: "",
                                  artworkUrl100: "",
                                  genres: nil,
                                  url: "")]
        
        return sample
        
    }
    
    
    static func sampleDetails() -> AlbumResults {
        
        let sample = AlbumResults(artistName: "Masked Wolf",
                                  releaseDate: "2019-06-07",
                                  collectionName: "Astronaut In The Ocean - Single",
                                  copyright: "℗ 2021 Elektra Records LLC",
                                  artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/78/3a/b6/783ab65c-7210-6cbe-9316-22564b8177ad/075679793102.jpg/200x200bb.png",
                                  genres: [Genres(genreid: "18", name: "Hip-Hop/Rap", url: "https://itunes.apple.com/us/genre/id18")],
                                  url: "https://music.apple.com/us/album/astronaut-in-the-ocean/1547525310?i=1547525311&app=itunes")
        
        return sample

    }
    
}


/*
 
    The data model have a lot of data that we are not using on this exercise,
    so I have decided to keep only the data we are using!
 
    I've saved a copy of the JSON file here for reference only!
 
 */


struct Feed: Decodable {
    
    let feed: TopAlbums
    
    init() {
        self.feed = TopAlbums()
    }
}

struct TopAlbums: Decodable {
    
    let title: String
    let results: [AlbumResults]?

    init() {
        self.title = ""
        self.results = [AlbumResults]()
    }
    
}

struct AlbumResults: Decodable, Identifiable {
    
    let id = UUID()
    let artistName: String
    let releaseDate: String?
    let collectionName: String
    let copyright: String
    let artworkUrl100: String
    let genres: [Genres]?
    let url: String
    
}

struct Genres: Decodable {
    let genreid: String?
    let name: String?
    let url: String?
}
