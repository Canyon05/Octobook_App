//
//  BlogRow.swift
//  Octobook
//
//  Created by Elias Zeh on 25.02.25.
//

import SwiftUI

struct BlogPostRow: View {
    let blog: Blog
    let journalData: JournalData
    let isEditing: Bool
    @State private var showingDeleteAlert = false
    @State private var showingFullPost = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(blog.date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("pages read: " + blog.pages)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Text(blog.blogtext)
                        .font(.body)
                        .lineLimit(3)
                        .foregroundColor(.primary)
                    Button {
                        showingFullPost = true
                    } label: {
                        HStack {
                            Text("Show More")
                                .font(.subheadline)
                            Image(systemName: "chevron.right")
                                .font(.caption)
                        }
                        .foregroundColor(.accentColor)
                    }
                    
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 2)
            }
            .padding(.horizontal)
            
            if isEditing {
                Button(role: .destructive) {
                    showingDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding(.trailing)
                }
            }
        }
        .sheet(isPresented: $showingFullPost) {
            NavigationStack {
                BlogPost(journalData: journalData, blog: blog)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") {
                                showingFullPost = false
                            }
                        }
                    }
            }
        }
        .alert("Delete Blog Post", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                journalData.removeBlog(blog)
            }
        } message: {
            Text("Are you sure you want to delete this blog post? This action cannot be undone.")
        }
    }
}

#Preview {
    let journalData = JournalData()
    BlogPostRow(blog: journalData.blogs[0],
                journalData: journalData,
                isEditing: false)
}
