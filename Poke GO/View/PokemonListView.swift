//
//  PokemonListView.swift
//  Poke GO
//
//  Created by Sufiandy Elmy on 11/11/23.
//

import SwiftUI
import Kingfisher

struct PokemonListView: View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var viewModel = PokemonViewModel()
    @State var showFilterButtons = false
    @State var filterApplied = false
    
    @Environment(\.managedObjectContext) private var viewContext
    

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        let dataSource = filterApplied ? viewModel.filteredPokemon : viewModel.pokemon
                        ForEach(dataSource) { pokemon in
                            NavigationLink(
                                destination: NavigationLazyView(PokemonDetailView(pokemon: pokemon)),
                                label: {
                                    PokemonRowCell(pokemon: pokemon)
                                        .frame(width: 220, height: 150)
                                        .padding(.horizontal)
                                })
                        }
                    }
                    Spacer()
                }
                .navigationBarTitle("Pokemon")
                .onAppear {
                    viewModel.fetchPokemon()
                    print("Apakah fetch \(viewModel.pokemon.first?.imageUrl ?? "")")
                }

                VStack {
                    if showFilterButtons {
                        ActionButton(imageName: "fire", backgroundColor: .red, show: $showFilterButtons) {
                            filterApplied.toggle()
                            showFilterButtons.toggle()
                            viewModel.filterPokemon(by: "fire")
                        }
                        ActionButton(imageName: "leaf", backgroundColor: .green, show: $showFilterButtons) {
                            filterApplied.toggle()
                            showFilterButtons.toggle()
                            viewModel.filterPokemon(by: "poison")

                        }
                        ActionButton(imageName: "water", backgroundColor: .blue, show: $showFilterButtons) {
                            filterApplied.toggle()
                            showFilterButtons.toggle()
                            viewModel.filterPokemon(by: "water")

                        }
                        ActionButton(imageName: "lightning", backgroundColor: .yellow, show: $showFilterButtons) {
                            filterApplied.toggle()
                            showFilterButtons.toggle()
                            viewModel.filterPokemon(by: "electric")
                        }
                    }

                    let imageName = filterApplied ? "refresh" : "filter"
                    ActionButton(imageName: imageName, height: 36, width: 36, show: $showFilterButtons) {
                        filterApplied ? filterApplied.toggle() : showFilterButtons.toggle()
                    }.rotationEffect(.init(degrees: self.showFilterButtons ? 180 : 0))

                }
                .padding()
                .animation(.spring())
            }
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//MARK:- search key listener
extension PokemonListView: SearchChangeDelegate {
    func onKeyChange(text: String) {
//        let filteredList = productsObservable.productsList.filter{ $0.title.contains(text)}
//        productsObservable.productsList = filteredList.count>0 ? filteredList : LocalDataController.productsData
        print("text change listener called")
    }
}

