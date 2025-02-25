//
//  BlogPostSection.swift
//  Octobook
//
//  Created by Elias Zeh on 25.02.25.
//

import SwiftUI

struct BlogPostSection: View {
    let filteredBlogs: [Blog]
    let journalData: JournalData
    let isEditing: Bool
    
    var body: some View {
        Group {
            if !filteredBlogs.isEmpty {
                ForEach(filteredBlogs) { blog in
                    BlogPostRow(
                        blog: blog,
                        journalData: journalData,
                        isEditing: isEditing
                    )
                }
            } else {
                EmptyStateView()
            }
        }
    }
}

#Preview {
    let journalData = JournalData()
    BlogPostSection(filteredBlogs: journalData.blogs,
                   journalData: journalData,
                   isEditing: false)
}

private struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "doc.text")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            
            Text("No Blog Posts available")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding(.horizontal, 25)
    }
}
