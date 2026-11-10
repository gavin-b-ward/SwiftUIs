//
//  ContentView.swift
//  TimeConversion
//
//  Created by gavin ward on 11/10/26.
//

import SwiftUI

enum TimeUnit: String, CaseIterable, Identifiable {
    case day, hour, minute, second
    var id: String { self.rawValue }
    
    var seconds: Double {
        switch self {
        case .day: return 86400
        case .hour: return 3600
        case .minute: return 60
        case .second: return 1
        }
    }
}

struct ContentView: View {
    @State private var timeUnit = TimeUnit.day
    @State private var timeValue = 1.0
    @FocusState private var amountIsFocused: Bool
    
    func convertTime(inputUnit: TimeUnit, outputUnit: TimeUnit) -> Double {
        return timeValue * inputUnit.seconds / outputUnit.seconds
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("Starting Unit") {
                    Picker("Selected Unit: ", selection: $timeUnit) {
                        ForEach(TimeUnit.allCases) { status in
                            Text(status.rawValue)
                                .tag(status)
                        }
                    }
                }
                
                Section ("Time Amount") {
                    TextField(
                        "Amount: ",
                        value: $timeValue,
                        format: .number
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                }
                
                if timeUnit != .day {
                    Section("Time in Days") {
                        Text("\(convertTime(inputUnit: timeUnit, outputUnit: .day), format: .number.precision(.fractionLength(0...2))) day(s)")
                    }
                }

                if timeUnit != .hour {
                    Section("Time in Hours") {
                        Text("\(convertTime(inputUnit: timeUnit, outputUnit: .hour), format: .number.precision(.fractionLength(0...2))) hour(s)")
                    }
                }

                if timeUnit != .minute {
                    Section("Time in Minutes") {
                        Text("\(convertTime(inputUnit: timeUnit, outputUnit: .minute), format: .number.precision(.fractionLength(0...2))) minute(s)")
                    }
                }

                if timeUnit != .second {
                    Section("Time in Seconds") {
                        Text("\(convertTime(inputUnit: timeUnit, outputUnit: .second), format: .number.precision(.fractionLength(0...2))) second(s)")
                    }
                }
            }
            .navigationTitle("TimeConverter")
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
