# TextEdit 🧠

A modern, dark-themed text editor for macOS built with Swift and AppKit.

![Build Status](https://github.com/heyfinal/TextEdit-Swift/workflows/Build%20and%20Test%20TextEdit/badge.svg)
![Platform](https://img.shields.io/badge/platform-macOS%2013.0+-blue)
![Swift](https://img.shields.io/badge/swift-5.9+-orange)

## Features

🎨 **Modern Dark Interface**
- Native macOS dark mode integration
- Rounded window corners for elegant appearance
- Custom dark title bar with transparency
- Brain emoji app icon 🧠

✨ **Text Editing**
- Syntax-aware text editing
- Line numbers (⌘L to toggle)
- Word wrap (⌘⇧W to toggle)
- Monospaced font with optimal line spacing
- Custom selection and cursor colors

🔧 **Productivity Features**
- Zoom in/out (⌘+/⌘-)
- Full menu integration
- New, Open, Save, Save As
- Undo/Redo support
- Standard text operations (Cut, Copy, Paste, Select All)

🧠 **AI Integration Ready**
- Memory system integration for claude-code and codexcli
- Shared memory between AI assistants
- Synchronized preferences and conversation history
- Auto-approval wrappers for seamless operation

## Installation

### From Release (Recommended)
1. Download the latest `TextEdit.dmg` from [Releases](https://github.com/heyfinal/TextEdit-Swift/releases)
2. Mount the disk image
3. Drag TextEdit.app to your Applications folder

### Build from Source
```bash
git clone https://github.com/heyfinal/TextEdit-Swift.git
cd TextEdit-Swift
swift build -c release
```

### Memory System Integration 🧠
For AI assistant integration with shared memory between claude-code and codexcli:

1. Download the [macOS Memory System Installer](./MEMORY_SYSTEM.md)
2. Run the installer on your macOS system
3. Use `claudes` and `codexs` commands with synchronized memory

See [MEMORY_SYSTEM.md](./MEMORY_SYSTEM.md) for complete installation and usage instructions.

## Development

### Requirements
- macOS 13.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later

### Building
```bash
# Debug build
swift build

# Release build  
swift build -c release

# Run tests
swift test

# Run directly
swift run
```

### Project Structure
```
TextEdit-Swift/
├── Sources/TextEdit/           # Main application code
│   ├── main.swift             # Application entry point
│   ├── AppDelegate.swift      # App delegate and window setup
│   └── TextEditController.swift # Main text editor logic
├── Tests/TextEditTests/       # Unit tests
├── .github/workflows/         # GitHub Actions CI/CD
└── Package.swift             # Swift Package Manager config
```

## Architecture

- **AppDelegate**: Handles app lifecycle, window creation, and menu setup
- **TextEditController**: Main view controller managing the text editing interface
- **Document**: Simple document model for file handling
- **LineNumberRulerView**: Custom ruler view for line numbers

## GitHub Actions

The project includes comprehensive CI/CD with GitHub Actions:

- ✅ **Automated Testing**: Runs unit tests on every push/PR
- 🏗️ **Multi-configuration Builds**: Debug and release builds
- 📦 **App Bundle Creation**: Generates proper macOS app bundle
- 💿 **DMG Creation**: Creates distributable disk image
- 🚀 **Automated Releases**: Tagged releases automatically create GitHub releases

### Workflow Triggers
- Push to `main` or `develop` branches
- Pull requests to `main`
- Manual workflow dispatch
- Tagged releases

## Dark Mode Design

The app features a carefully crafted dark mode design:

- **Background**: `#1e1e1e` (Rich dark gray)
- **Text**: `#e6e6e6` (Light gray for readability)  
- **Title Bar**: `#2d2d2d` (Slightly lighter dark gray)
- **Selection**: `#334d7a` (Blue tint for selected text)
- **Cursor**: `#4db8ff` (Bright blue for visibility)

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with Swift and AppKit
- Inspired by modern text editors
- Brain emoji icon represents the smart, thoughtful approach to text editing 🧠

---

**Made with ❤️ and Swift**