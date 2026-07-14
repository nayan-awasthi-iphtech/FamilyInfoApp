//
//  RelationshipChartView.swift
//  FamilyInformation
//
//  Created by iPHTech 30 on 14/07/26.
//

import SwiftUI
import CoreData
import Charts

struct RelationshipChartView: View {
    @FetchRequest(
        entity: Member.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Member.relationship, ascending: true)]
    )
    var members: FetchedResults<Member>
    
    @EnvironmentObject var appstate: AppState
    
    // MARK: - Computed Pipeline Map
    private var relationshipCount: [(relationship: String, count: Int)] {
        let grouped = Dictionary(grouping: members, by: { $0.relationship ?? "Other" })
        let mapped = grouped.map { (key: String, value: [Member]) in
            (relationship: key, count: value.count)
        }
        return mapped.sorted { $0.relationship < $1.relationship }
    }
    
    private var totalMembersCount: Int {
        members.count
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                if members.isEmpty {
                    ContentUnavailableView(
                        "No Family Members",
                        systemImage: "person.crop.circle.badge.questionmark",
                        description: Text("Add family members to see the chart metrics.")
                    )
                } else {
                    // MARK: - Fixed Premium Donut Chart Container Layout
                    ZStack {
                        Chart {
                            ForEach(relationshipCount, id: \.relationship) { data in
                                SectorMark(
                                    angle: .value("Count", data.count),
                                    innerRadius: .ratio(0.68) // iOS 16 Compatible hollow center ring look
                                )
                                .foregroundStyle(by: .value("Relationship", data.relationship))
                            }
                        }
                        .frame(height: 220)
                        .chartLegend(position: .bottom, alignment: .center, spacing: 18)
                        
                        // Center Metrics Badge (Signature look remains intact!)
                        VStack(spacing: 2) {
                            Text("\(totalMembersCount)")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(appstate.isDarkMode ? .white : .primary)
                            Text(totalMembersCount == 1 ? "MEMBER" : "MEMBERS")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.gray)
                                .tracking(1.5)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // MARK: - Breakdown Metrics List Detail Card Panels
                    List {
                        Section {
                            ForEach(relationshipCount, id: \.relationship) { data in
                                HStack(spacing: 12) {
                                    Circle()
                                        .frame(width: 8, height: 8)
                                        .foregroundColor(.blue)
                                    
                                    Text(data.relationship.capitalized)
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Spacer()
                                    
                                    Text("\(data.count)")
                                        .font(.system(size: 15, weight: .bold, design: .rounded))
                                        .foregroundColor(appstate.isDarkMode ? .cyan : .blue)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(
                                            Capsule()
                                                .fill(appstate.isDarkMode ? Color.cyan.opacity(0.15) : Color.blue.opacity(0.08))
                                        )
                                }
                                .padding(.vertical, 2)
                            }
                        } header: {
                            Text("Detailed Distribution")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.gray)
                                .tracking(0.5)
                        }
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                }
            }
            .background(
                Color(appstate.isDarkMode ? UIColor.systemBackground : UIColor.secondarySystemBackground)
                    .ignoresSafeArea()
            )
            .navigationTitle("Family Analytics")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
