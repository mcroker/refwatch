import Foundation;

class AppSettings {
    
    public static let sanctionList: [(caption: String, title: String)] = [
        ("None Specified", "Unspecified"),
        ("Breakdown", "Breakdown"),
        ("Tackle", "Tackle"),
        ("Deliberate Knock-On", "Deliberate KO"),
        ("Dissent", "Dissent"),
        ("Foul Play", "Foul Play"),
        ("High Tackle", "High Tackle"),
        ("Line-out", "Line-out"),
        ("Maul", "Maul"),
        ("Obstruction", "Obstruction"),
        ("Offside", "Offside"),
        ("Scrum", "Scrum")
    ];
    
    public static let colorsList: [(caption: String, title: String, colour: Color)] = [
        ("Black", "Black", .black),
        ("Blue", "Blue", .blue),
        ("Brown", "Brown", .brown),
        ("Gray", "Gray", .gray),
        ("Green", "Green", .green),
        ("Gold", "Gold", .yellow),
        ("Magenta", "Magenta", .magenta),
        ("Orange", "Orange", .orange),
        ("Purple", "Purple", .purple),
        ("Red", "Red", .red),
        ("White", "White", .white)
    ];

}
