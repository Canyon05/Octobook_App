import SwiftUI

struct StarRating: View {
    let rating: Int
    let maxRating: Int
    let size: CGFloat
    let onTap: (Int) -> Void
    
    init(
        rating: Int,
        maxRating: Int = 5,
        size: CGFloat = 20,
        onTap: @escaping (Int) -> Void
    ) {
        self.rating = rating
        self.maxRating = maxRating
        self.size = size
        self.onTap = onTap
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundStyle(star <= rating ? .yellow : .gray)
                    .font(.system(size: size))
                    .onTapGesture {
                        onTap(star)
                    }
            }
        }
    }
} 