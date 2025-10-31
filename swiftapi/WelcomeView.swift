import SwiftUI

struct WelcomeView: View {
    var body: some View {
      NavigationStack {
            VStack(spacing: 30) {
              
              // Caption
              Text("Cari Resep Makananmu")
                  .font(.title2)
                  .fontWeight(.semibold)
                  .multilineTextAlignment(.center)
                  .padding(.horizontal, 20)
              
                
                // Gambar di atas
              Image(.IMG_4196)
                .resizable()
                .frame(width: 300, height: 200)
                .cornerRadius(1000)
                .padding()
                
                
                // Tombol Login
                NavigationLink (destination: ContentView()) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
                
                // Tombol Register (belum aktif)
                Button(action: {
                    // Nanti diisi kalau sudah ada halaman register
                }) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    WelcomeView()
}

