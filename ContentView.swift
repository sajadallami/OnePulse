import SwiftUI

// هيكل لخصائص قطرة المي
struct WaterDrop: Identifiable {
    let id = UUID()
    var xOffset: CGFloat
    var size: CGFloat
    var speed: Double
    var opacity: Double
}

struct ContentView: View {
    @State private var isFalling = false
    
    // توليد 25 قطرة مي عشوائية
    let drops: [WaterDrop] = (1...25).map { _ in
        WaterDrop(
            xOffset: CGFloat.random(in: 0...400),
            size: CGFloat.random(in: 10...30),
            speed: Double.random(in: 2...6),
            opacity: Double.random(in: 0.2...0.6)
        )
    }
    
    var body: some View {
        ZStack {
            // 1. الخلفية المدمجة (دفء دبي وبرودة النرويج)
            LinearGradient(
                colors: [Color.blue.opacity(0.8), Color.orange.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // 2. حركة قطرات المي
            GeometryReader { geo in
                ZStack {
                    ForEach(drops) { drop in
                        Image(systemName: "drop.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: drop.size, height: drop.size)
                            .foregroundColor(.white.opacity(drop.opacity))
                            .position(x: drop.xOffset, y: isFalling ? geo.size.height + 100 : -100)
                            .animation(
                                Animation.linear(duration: drop.speed)
                                    .repeatForever(autoreverses: false)
                                    .delay(Double.random(in: 0...2)),
                                value: isFalling
                            )
                    }
                }
            }
            .ignoresSafeArea()
            
            // 3. تأثير الزجاج (Glassmorphism)
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            
            // 4. النصوص والواجهة التفاعلية
            VStack(spacing: 20) {
                Text("OnePulse")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                
                Text("من دبي إلى النرويج 💧")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.9))
                
                Spacer().frame(height: 50)
                
                // زر تفاعلي
                Button(action: {
                    // تفاعل إضافي مستقبلي
                }) {
                    Text("اكتشف المزيد")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .background(Color.white.opacity(0.9))
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
            }
        }
        .onAppear {
            // تشغيل الأنيميشن أول ما تفتح الواجهة
            isFalling = true
        }
    }
}

#Preview {
    ContentView()
}