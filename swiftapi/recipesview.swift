//
//  UserView.swift
//  swiftapi
//
//  Created by iCodeWave Community on 31/10/25.
//

import SwiftUI
import Combine

final class RecipesViewModel: ObservableObject {
  @Published var recipes: [RecipeDTO] = []
  @Published var isLoading = false
  @Published var errorMessage: String?

  func fetchRecipes() {
    isLoading = true
    errorMessage = nil
    NetworkManager.shared.fetchRecipes { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading = false
        switch result {
        case .success(let response):
          self?.recipes = response.recipes
        case .failure(let error):
          self?.errorMessage = error.localizedDescription
        }
      }
    }
  }
}

struct RecipesView: View {
  @StateObject private var viewModel = RecipesViewModel()
  
  var body: some View {
    NavigationStack {
      Group {
        if viewModel.isLoading {
          ProgressView("Mengambil data resep...")
        } else if let error = viewModel.errorMessage {
          Text("Gagal memuat data: \(error)")
            .foregroundColor(.red)
        } else {
          List(viewModel.recipes, id: \.id) { recipe in
            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
              HStack {
                AsyncImage(url: URL(string: recipe.image)) { img in
                  img.resizable().scaledToFill()
                } placeholder: {
                  ProgressView()
                }
                .frame(width: 70, height: 70)
                .cornerRadius(8)
                
                VStack(alignment: .leading) {
                  Text(recipe.name).font(.headline)
                  Text("⭐️ \(String(format: "%.1f", recipe.rating)) • 🍴 \(recipe.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
              }
            }
          }
        }
      }
      .navigationTitle("Resep Makanan 🍳")
      .onAppear { viewModel.fetchRecipes() }
    }
  }
}

struct RecipeDetailView: View {
  let recipe: RecipeDTO
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        AsyncImage(url: URL(string: recipe.image)) { img in
          img.resizable().scaledToFit()
        } placeholder: {
          ProgressView()
        }
        .cornerRadius(12)
        
        Text(recipe.name)
          .font(.title)
          .fontWeight(.bold)
        
        Text("⭐️ \(String(format: "%.1f", recipe.rating)) | 🍴 \(recipe.cuisine)")
          .foregroundColor(.gray)
        
        Divider()
        Text("🍳 Bahan-bahan:")
          .font(.headline)
        Text(recipe.ingredients.joined(separator: ", "))
        
        Text("\n📖 Langkah-langkah:")
          .font(.headline)
        Text(recipe.instructions.joined(separator: "\n"))
      }
      .padding()
    }
    .navigationTitle("Detail Resep")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  RecipesView()
}
