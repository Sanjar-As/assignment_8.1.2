import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    @EnvironmentObject var network: Network
//    let url = URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    if let user = network.user {
                        if !user.avatar_url.isEmpty {
                            
                        let url = URL(string: user.avatar_url)!
                        AsyncImage(url: url, placeholder: { Text("Loading ...") })
                                .scaledToFill()
                                .frame(width: 220, height: 220)
                                .cornerRadius(110)
                                .overlay(RoundedRectangle(cornerRadius: 110).stroke(.gray.opacity(0.3), lineWidth: 5))
                            
//                      (2 📌)  WebImage(url: url)
//                                .resizable().scaledToFill()
//                                .frame(width: 220, height: 220)
//                                .cornerRadius(110)
//                                .overlay(RoundedRectangle(cornerRadius: 110).stroke(.gray.opacity(0.3), lineWidth: 5))
                        } else {
                            Image("ic_user")
                                .resizable().scaledToFill()
                                .frame(width: 220, height: 220)
                                .cornerRadius(110)
                                .overlay(RoundedRectangle(cornerRadius: 110).stroke(.gray.opacity(0.3), lineWidth: 5))
                        }
                        
                        Text("\(user.name)")
                            .font(.system(size: 28, weight: .semibold))
                        Text("\(user.bio)")
                            .padding(.top, 5)
                            .font(.system(size: 22))
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Edit profile")
                                .frame(height: 40).frame(maxWidth: 350)
                                .foregroundColor(.black)
                                .font(.system(size: 17, weight: .medium))
                                .background(.gray.opacity(0.15))
                                .cornerRadius(5)
                                .background(RoundedRectangle(cornerRadius: 5).stroke(.gray.opacity(0.4), lineWidth: 1))
                        }).frame(height: 60)
                        
                        HStack {
                            Image(systemName: "person.2")
                                .font(.system(size: 19))
                                .foregroundColor(.black.opacity(0.7))
                            Text("\(user.followers) followers · \(user.following) following")
                                .font(.system(size: 17))
                        }
                        
                        HStack {
                            Image(systemName: "building.2")
                                .font(.system(size: 19))
                                .foregroundColor(.black.opacity(0.7))
                            Text("\(user.company)")
                                .font(.system(size: 17))
                        }
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 19))
                                .foregroundColor(.black.opacity(0.7))
                            Text("\(user.location)")
                                .font(.system(size: 17))
                        }
                        HStack {
                            Image(systemName: "link")
                                .font(.system(size: 19))
                                .foregroundColor(.black.opacity(0.7))
                            Text("\(user.blog)")
                                .font(.system(size: 17))
                        }
                        HStack {
                            Image(systemName: "envelope")
                                .font(.system(size: 19))
                                .foregroundColor(.black.opacity(0.7))
                            Text("\(user.email ?? "not assigned")")
                                .font(.system(size: 17))
                        }
                    }
                    else {
                        ProgressView()
                    }
                }.frame(maxWidth: UIScreen.main.bounds.width).frame(height: 400)
            }
        }.onAppear {
            network.loadData()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//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

// Image🛑, type, name, company, blog, location, email

/*func loadData() {
    guard let url = URL(string: "https://api.github.com/users/sanjar-as") else { return }
    URLSession.shared.dataTask(with: url) {(data, _, _) in
        guard let data = data else { return }
        do {
            self.users = try JSONDecoder().decode(User.self, from: data)
        } catch {
            print("error: \(error)")
        }
    }.resume()
}*/
