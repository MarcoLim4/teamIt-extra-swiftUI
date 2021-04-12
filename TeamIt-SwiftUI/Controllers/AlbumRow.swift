//
//  AlbumRow.swift
//  TeamIt-SwiftUI
//
//  Created by Marco Lima on 2021-04-09.
//

import SwiftUI

struct AlbumRow: View {
    
    let albumInfo: AlbumResults
    
    var body: some View {

        NavigationLink(destination: AlbumDetails(albumDetails: albumInfo)) {

            HStack {

                VStack {

                    RemoteImage(url: albumInfo.artworkUrl100)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        .cornerRadius(5)
                    
                }
                
                VStack(alignment: .leading) {
                    
                    Text(albumInfo.artistName)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .clipped()
                        .lineLimit(1)
                    
                    Text(albumInfo.collectionName)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .clipped()

                }
                
            }
            .onAppear()
            .frame(height: 80)

        }
        
    }
        
}

struct AlbumRow_Previews: PreviewProvider {
    static var previews: some View {
        
        let sample = AlbumResults(artistName: "Taylor Swift",
                                  releaseDate: "2021",
                                  collectionName: "Fearless (Taylor's Version)",
                                  copyright: "",
                                  artworkUrl100: "",
                                  genres: nil,
                                  url: "")
        
        AlbumRow(albumInfo: sample)
    }
}
