import SwiftUI

struct OnboardingTitleView: View {
    @State private var showTitle = false
    
    var body: some View {
        let accent = Color(red: 0.46, green: 0.45, blue: 1)
        (
            Text("When it's ").foregroundColor(.white)
          + Text("bed time").foregroundColor(accent)
          + Text(",\nyou and your kid have\na warm quality time…").foregroundColor(.white)
        )
        .font(.title2.bold())
        .fontDesign(.rounded)
        .frame(width: 277, alignment: .leading)
        .padding(.leading, 32)
        .padding(.top, 195)
        .fixedSize(horizontal: false, vertical: true)
        .opacity(showTitle ? 1 : 0)
        .onAppear {
            withAnimation(.easeIn(duration: 1.0)) {
                showTitle = true
            }
        }
    }
}

#Preview {
    OnboardingTitleView()
        .background(Color.black)
}