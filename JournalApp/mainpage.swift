import SwiftUI
import SwiftData

enum FilterOption {
    case all
    case bookmarked
    case byDate
}

struct mainpage: View {
    @State private var showingMenu = false
    @State private var selectedFilter: FilterOption = .all
    @State private var showingSheet = false
    @State private var searchText = ""
    @State private var editingItem: JournalEntry?
    @Query private var items: [JournalEntry]
    @Environment(\.modelContext) private var modelcontext
    
    // Computed property to filter items based on search text
    private var filteredItems: [JournalEntry] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText) ||
                item.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView{
        ZStack {
            Color(hex: "#050505").ignoresSafeArea()
            
            HStack {
                
                
                Button(action: {
                    showingMenu.toggle()
                }) {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color(hex: "#D4C8FF"), Color(hex: "#1F1F22"))
                }
                
      
                Button(action: {
                    editingItem = nil // Reset for new journal entry
                    showingSheet.toggle() // Show the sheet for new entry
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color(hex: "#D4C8FF"), Color(hex: "#1F1F22"))
                }
            }
            .padding(.trailing, 22.0)
            .padding(.leading, 299.0)
            .padding(.top, 60)
            .padding(.bottom, 742)
            
            VStack {
                Text("Journal")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .font(.system(size: 34))
                    .padding(.leading, 22.0)
                    .padding(.trailing, 255.0)
                
                if items.isEmpty {
                    emptyState
                } else {
                    CustomSearchField(placeholder: "Search", text: $searchText)
                        .frame(width: 357, height: 36)
                        .background(Color(hex: "#767680").opacity(0.24))
                        .cornerRadius(10)
                        .padding(.bottom, 14)
                    
                    List {
                        ForEach(filteredItems) { item in
                            VStack {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(hex: "#171719"))
                                        .shadow(color: Color(hex: "#8F8F8F").opacity(0.09), radius: 9)
                                        .cornerRadius(14)
                                        .frame(width: 350, height: 227)
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(item.title)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(Color(hex: "#D4C8FF"))
                                                .font(.system(size: 24))
                                            
                                            Spacer()
                                            // Bookmark Button
                                            Button(action: {
                                                toggleBookmark(for: item)
                                            }) {
                                                Image(systemName: item.isBookmarked ? "bookmark.fill" : "bookmark")
                                                    .foregroundColor(Color(hex: "#D4C8FF"))
                                                    .font(.system(size: 24))
                                            }
                                            .padding(.leading, 110)
                                        }
                                        .padding(.horizontal)
                                        
                                        let dateFormatter = DateFormatter.localizedString(from: item.date, dateStyle: .short, timeStyle: .none)
                                        Text(dateFormatter)
                                            .foregroundColor(Color(hex: "#9F9F9F"))
                                            .padding(.horizontal)
                                        
                                        Text(item.content)
                                            .lineLimit(5)
                                            .foregroundColor(Color.white)
                                            .frame(width: 295, height: 115)
                                            .font(.system(size: 18))
                                            .padding(.horizontal)
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    // Edit Button
                                    Button {
                                        editingItem = item // Set the item for editing
                                    } label: {
                                        Label("", systemImage: "pencil")
                                    }
                                    .tint(Color(hex: "#7F81FF"))}
                                .swipeActions(edge: .trailing){
                                    // Delete Button
                                    Button(role: .destructive) {
                                        modelcontext.delete(item)
                                    } label: {
                                        Label("", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .padding(.top, 88)
        }
        .sheet(item: $editingItem) { item in
            JournalPage(JournalItem: item) // Pass the existing item for editing
                .environment(\.modelContext, modelcontext)
                .onDisappear {
                    editingItem = nil // Reset editingItem when the sheet is dismissed
                }
        }
        .sheet(isPresented: $showingSheet) {
            JournalPage(JournalItem: JournalEntry()) // Create a new item when showing for new entry
                .environment(\.modelContext, modelcontext)
        }
    }.navigationBarBackButtonHidden(true)
    }
    private var filtere: [JournalEntry] {
        switch selectedFilter {
        case .all:
            return items
        case .bookmarked:
            return items.filter { $0.isBookmarked }
        case .byDate:
            return items.sorted { $0.date > $1.date } // Adjust sorting as needed
        }
    }

    private func toggleBookmark(for item: JournalEntry) {
        item.isBookmarked.toggle()
        do {
            try modelcontext.save()
        } catch {
            print("Error saving context after toggling bookmark: \(error)")
        }
    }
    

    private var emptyState: some View {
        Image("book")
            .resizable()
            .scaledToFit()
            .frame(width: 77.7, height: 101)
            .padding(.top, 161.77)
            .padding(.bottom, 439)
            .overlay(
                Text("Begin Your Journal")
                    .frame(width: 210, height: 29)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#D4C8FF"))
                    .font(.system(size: 24))
                    .padding(.bottom, 120)
            )
            .overlay(
                Text("Craft your personal diary, tap the plus icon to begin")
                    .multilineTextAlignment(.center)
                    .frame(width: 282, height: 53)
                    .font(.system(size: 18))
                    .foregroundColor(Color.white)
                    .padding(.bottom, 30)
            )
    }
}

#Preview {
    mainpage().modelContainer(for: JournalEntry.self)
}

// Custom search bar
struct CustomSearchField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color(hex: "#EBEBF5").opacity(0.60))
                .padding(.trailing, 4.5)

            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color(hex: "#EBEBF5").opacity(0.60))
                }
                TextField("", text: $text)
                    .foregroundColor(Color(hex: "#EBEBF5").opacity(0.60))
            }
        }
        .padding(.leading, 5)
        .padding(.bottom, 14.0)
        .padding(.top, 15.0)
    }
}

