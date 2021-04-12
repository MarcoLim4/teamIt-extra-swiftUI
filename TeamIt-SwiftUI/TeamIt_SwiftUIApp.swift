//
//  TeamIt_SwiftUIApp.swift
//  TeamIt-SwiftUI
//
//  Created by Marco Lima on 2021-04-09.
//

import SwiftUI

@main
struct TeamIt_SwiftUIApp: App {
    var body: some Scene {
        
        let sample = [AlbumResults(artistName: "Taylor Swift",
                                  releaseDate: "2021",
                                  collectionName: "Album Name",
                                  copyright: "",
                                  artworkUrl100: "",
                                  genres: nil,
                                  url: "")]

        WindowGroup {
            
            ContentView(top100: sample)
            
        }
    }
}
