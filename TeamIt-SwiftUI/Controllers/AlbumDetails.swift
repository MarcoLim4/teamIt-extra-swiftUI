//
//  AlbumDetails.swift
//  TeamIt-SwiftUI
//
//  Created by Marco Lima on 2021-04-09.
//

import SwiftUI

struct AlbumDetails: View {
    
    @State private var showItunes = false
    let albumDetails: AlbumResults
    
    var body: some View {
        
        VStack {
            
            RemoteImage(url: albumDetails.artworkUrl100)
                .frame(width: 300, height: 300, alignment: .center)
                .cornerRadius(10)
                .padding(.top, 10)
                .padding(.bottom, 15)
            
            Text(albumDetails.collectionName)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.bottom, 2)
                .padding(.leading, 5)
                .padding(.trailing, 5)
                .lineLimit(3)
            
            Text(albumDetails.artistName)
                .font(.callout)
                .padding(.bottom, 5)
            
            Text(albumDetails.genres?.first?.name ?? "")
                .font(.callout)
                .padding(.bottom, 5)

            
            if let rDate = albumDetails.releaseDate {

                
                Text("Released on: \(DateHelper.transformDate(dateString: rDate))")
                    .padding(.bottom, 10)
                    .font(.callout)

            }

            Text(albumDetails.copyright)
                .font(.footnote)
                .padding(.bottom, 10)
                .foregroundColor(.secondary)

            Spacer()
            
            Button(action:  {
                // Action to come
                
                showItunes.toggle()
                
            }, label: {
                Text("iTunes")
            })
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 45,
                   maxHeight: 45,
                   alignment: .center)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10.0)
            .shadow(radius: 5)
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .sheet(isPresented: $showItunes) {
                WebView(itunesURL: albumDetails.url)
            }
            

            
            
        }
        
        
        
    }
}

struct AlbumDetails_Previews: PreviewProvider {
    static var previews: some View {
        let details = Top100Model.sampleDetails()
        AlbumDetails(albumDetails: details)
    }
}
