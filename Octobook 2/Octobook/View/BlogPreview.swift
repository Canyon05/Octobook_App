//
//  BlogPreview.swift
//  Octobook
//
//  Created by Elias Zeh on 25.02.25.
//

import SwiftUI

struct BlogPreview: View {
    let blog: Blog
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(blog.date)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(blog.blogtext)
                .lineLimit(2)
                .foregroundStyle(.primary)
            
            Text("Pages read: \(blog.pages)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    let journalData = JournalData()
    BlogPreview(blog: journalData.blogs[0])
}
