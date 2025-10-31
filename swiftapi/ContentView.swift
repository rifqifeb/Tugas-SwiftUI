import SwiftUI

struct ContentView: View {
  @State var nama = ""
  @State var password = ""
  
  var body: some View {
    NavigationStack {
      Image(.IMG_4196)
        .resizable()
        .frame(width: 200, height: 200)
        .cornerRadius(1000)
        .padding()
        
      ScrollView {
        VStack {
          TextField("Masukkan nama kamu di sini", text: $nama)
            .padding()
            .background(.gray.opacity(0.3))
            .cornerRadius(20)
          
          SecureField("Masukkan password kamu", text: $password)
            .padding()
            .background(.gray.opacity(0.3))
            .cornerRadius(20)
            
          NavigationLink {
            RecipesView() // ⬅️ setelah login langsung ke halaman resep
          } label: {
            HStack {
              Text("Login")
              Image(systemName: "gamecontroller.fill")
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(.blue)
            .cornerRadius(100)
            .padding(.vertical, 20)
          }
        }
        .padding(.horizontal)
      }
      .navigationTitle("LOGIN ")
    }
  }
}

#Preview {
  ContentView()
}
