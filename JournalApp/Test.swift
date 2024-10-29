import SwiftUI

struct Test: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var content: String = ""
    var body: some View {
        Color(hex:"#050505").ignoresSafeArea()
        
       
            VStack{
                HStack{
                    Button("Save") {
                        // addEntry()
                        dismiss()
                    }.buttonStyle(PlainButtonStyle()) // No border
                        .foregroundColor(Color(hex: "#A499FF")) // Change text color
                    Spacer()
                    Button("Cancel"){
                        dismiss()
                    }.buttonStyle(PlainButtonStyle()) // No border
                        .foregroundColor(Color(hex:"#A499FF")) // Change text color
                }
                TextField("Title", text: $title).font(.system(size: 34))
                Text(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none))
                TextField("Type your Journal…", text: $content).font(.system(size: 20))
            }.padding(.bottom, 669.0).padding(.leading, 22.82)
            
            //            Form {
            //                Section(header: Text("New Journal Entry")) {
            //                    TextField("Title", text: $title).font(.system(size: 34))
            //                    TextField("Type your Journal…", text: $content).font(.system(size: 20))
            //                        .frame(height: 434) // More space for content
            //                }
            //                Button("Save") {
            //                    addEntry()
            //                    dismiss()
            //                }
            //                Button("Cancel"){
            //                    dismiss()
            //                }
            //
            //            }
            // .navigationTitle("New Entry")
        
    }}
#Preview {
    Test()
}
