//
//  ContentView.swift
//  TeamIt-SwiftUI
//
//  Created by Marco Lima on 2021-04-09.
//

import SwiftUI

struct ContentView: View {
    
    
    var top100: [AlbumResults]
    
    @State private var top1K = [AlbumResults]()
    
    var body: some View {

        NavigationView {
            
            List {
                
                ForEach(top1K, id: \.id) { dataItem in
                    AlbumRow(albumInfo: dataItem)
                }
                
            }
            .background(Color.black)
            .navigationTitle("Top 100 Albums")
            
        }
        .background(Color.black)
        .onAppear(perform: fetchCombine)

    }
    
    func fetchData() {
        
        Top100Model.fetchAlbums { result in

            switch result {
            case .success(let albumsInfo):
                print(albumsInfo)
                self.top1K = albumsInfo.feed.results ?? []
            case.failure(_ ):
                print("Error loading Data")
            }
            
        }
    }
    
    func fetchCombine() {
        
        Top100Model.fetchTop100Albums { result in
            
            switch result{
            case .success(let albumsInfo):
                self.top1K = albumsInfo.feed.results ?? []
            case .failure(_ ):
                print("Error loading Data")
                
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView(top100: Top100Model.sampleAlbums())
    }
}
