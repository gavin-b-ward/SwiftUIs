import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    let currencyCode: String = Locale.current.currency?.identifier ?? "USD"
    
    var totalPerPerson: Double {
        let tipAmount = checkAmount * (Double(tipPercentage) / 100)
        let checkTotal = checkAmount + tipAmount
        return checkTotal / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("Enter the Bill Amount"){
                    TextField("Amount: ", value: $checkAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        
                }
                
                Section {
                    Picker("Number of People: ", selection: $numberOfPeople) {
                        ForEach(2..<11) {
                            Text($0, format: .number)
                                .tag($0)
                        }
                    }
                }
                
                Section ("How Much Do You Want To Tip?"){

                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text("Per Person Total is \(totalPerPerson, format: .currency(code: currencyCode))")
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
