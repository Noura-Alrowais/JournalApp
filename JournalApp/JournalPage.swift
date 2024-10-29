import SwiftUI
import SwiftData
struct JournalPage: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State  var JournalItem :JournalEntry
    //@State private var formattedDate: String = "" //to display
    var body: some View {
        let dateFormatter = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        
       
                    
        ZStack{
            Color(hex:"#1A1A1C").ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        dismiss()
                    }){Text("Cancel") .foregroundStyle(Color(hex: "D4C8FF"))}
                    Spacer()
                    Button(action: {
                        context.insert(JournalItem)
                        dismiss()
                    }){Text("Save") .foregroundStyle(Color(hex: "D4C8FF")).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)}
                    
                   
                }.padding()
                    .foregroundColor(.white)

             
             
                        VStack(alignment: .leading) {
                            TextField("Title", text: $JournalItem.title)
                                .font(.system(size: 34))
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(Color.white)
                        
                            Text(dateFormatter)                                .foregroundColor(Color(hex: "A39A9A"))
                                .padding(.horizontal)
                                .padding(.top, 4)
                         
                            // حقل النص "Type your Journal..."
                            TextEditor(text: $JournalItem.content)
                                   .padding()
                                   .foregroundColor(Color.white)
                                   .background(Color(hex: "#1A1A1C")) // Set background to match your design
                                   .cornerRadius(10) // Optional for rounded corners
                                   .scrollContentBackground(.hidden) // To hide the default background                                .padding()
                              
                                .foregroundColor(Color.white) // لون النص رمادي غامق
                                .scrollContentBackground(.hidden) // إزالة الخلفية الافتراضية
                        }
                        .padding()
                        .background(Color(hex:"1A1A1C"))
                    
                
                Spacer()
            }
        }
    }
    


            
      
      
        




    
}

#Preview {
    JournalPage(JournalItem: JournalEntry()).modelContainer(for: JournalEntry.self)
}
