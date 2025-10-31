import Foundation
import Alamofire

// MARK: - Network Manager
class NetworkManager {
    // Proper singleton instance
    static let shared = NetworkManager()

    private init() {}

    // Fetch recipes with a completion handler to surface success/failure
    func fetchRecipes(completion: @escaping (Result<RecipesResponseDTO, Error>) -> Void) {
        let url = "https://dummyjson.com/recipes"

        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(RecipesResponseDTO.self, from: data)
                        completion(.success(decoded))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

// MARK: - DTOs
struct RecipesResponseDTO: Decodable {
    let recipes: [RecipeDTO]
}

struct RecipeDTO: Decodable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let image: String
    let rating: Double
    let mealType: [String]

    // Convenience texts for UI display
    var ingredientsText: String {
        if ingredients.isEmpty { return "No ingredients available." }
        return ingredients.enumerated().map { index, item in
            "\(index + 1). \(item)"
        }.joined(separator: "\n")
    }

    var descriptionText: String {
        if instructions.isEmpty { return "No description available." }
        return instructions.enumerated().map { index, step in
            "Step \(index + 1): \(step)"
        }.joined(separator: "\n\n")
    }
}
