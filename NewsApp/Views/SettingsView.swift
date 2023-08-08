//
//  SettingsView.swift
//  NewsApp
//
//  Created by alex on 5/7/23.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @StateObject var purchaseViewModel = PurchaseViewModel()
    @AppStorage("purchased") var purchased = false
    
    var body: some View {
        NavigationView {
            if purchased == false {
                VStack {
                    Text("Subscribe to access settings.")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    Spacer()
                    
                    Image(systemName: "lock.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.bottom)
                    
                    Text("Unlock all features with a subscription.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    
                    HStack(spacing: 30) {
                        Button {
                            Task {
                                let viewModel = purchaseViewModel
                                await buy(product: viewModel.subscriptions[1])
                            }
                        } label: {
                            VStack {
                                Text("Monthly")
                                    .font(.headline)
                                Text("3.99/Month")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Button {
                            Task {
                                await buy(product: purchaseViewModel.subscriptions.first!)
                            }
                        } label: {
                            VStack {
                                Text("Yearly")
                                    .font(.headline)
                                Text("39.99/Year")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }

                    }
                    
                    Spacer()
                    
                    Text("By subscribing, you agree to the terms of use and privacy policy.")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.bottom)
                    
                }
                .padding()
                .preferredColorScheme(.dark)
            } else {
                Form {
                    Section("About") {
                        Text("This app keeps you up to date on the latest news. Premium content coming soon.")
                    }
                }
                .navigationTitle("Settings")
                .preferredColorScheme(.dark)
            }
        }
        .task {
            if purchaseViewModel.purchasedSubscriptions.isEmpty {
                purchased = false
            } else {
                purchased = true
            }
        }
    }
    
    func buy(product: Product) async {
        do {
            if try await purchaseViewModel.purchase(product) != nil {
                purchased = true
            }
        } catch {
            print("Purchase failed.")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
