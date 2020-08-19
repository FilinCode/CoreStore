//
// Demo
// Copyright © 2020 John Rommel Estropia, Inc. All rights reserved.

import Combine
import CoreStore
import SwiftUI

// MARK: - Modern.PokedexDemo

extension Modern.PokedexDemo {

    // MARK: - Modern.PokedexDemo.MainView

    struct MainView: View {

        /**
         ⭐️ Sample 1: Setting a sectioned `ListPublisher` declared as an `@ObservedObject`
         */
        @ObservedObject
        private var pokedexEntries: ListPublisher<Modern.PokedexDemo.PokedexEntry>


        // MARK: Internal

        init() {

            self.pokedexEntries = Modern.PokedexDemo.pokedexEntries
        }


        // MARK: View

        var body: some View {
            ZStack {
                ScrollView {
                    ForEach(self.pokedexEntries.snapshot.prefix(self.visibleItems), id: \.self) { pokedexEntry in
                        LazyView {
                            Text(pokedexEntry.snapshot?.$name ?? "")
                        }
                        .frame(height: 100)
                        .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    Button(
                        action: {
                            self.visibleItems = min(
                                self.visibleItems + 50,
                                self.pokedexEntries.snapshot.count
                            )
                        },
                        label: { Text("Load more") }
                    )
                }
                if self.service.isLoading {
                    Color(.sRGB, white: 0, opacity: 0.3)
                        .overlay(
                            Text("Fetching Pokedex…")
                                .foregroundColor(.white),
                            alignment: .center
                        )
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
            .navigationBarTitle("Pokedex")
        }


        // MARK: Private

        @ObservedObject
        private var service: Modern.PokedexDemo.Service = .init()
        
        @State
        private var visibleItems: Int = 50
    }
}


#if DEBUG

@available(iOS 14.0, *)
struct _Demo_Modern_PokedexDemo_MainView_Preview: PreviewProvider {

    // MARK: PreviewProvider

    static var previews: some View {

        Modern.PokedexDemo.MainView()
    }
}

#endif