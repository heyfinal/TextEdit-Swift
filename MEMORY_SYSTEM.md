# macOS Memory System Installer 🧠

This installer sets up a shared memory system for both **claude-code** and **codexcli** on macOS, enabling synchronized AI assistant experiences.

## What This Installer Does

✅ **Installs Memory System** - Python-based memory framework  
✅ **Creates AI Wrappers** - `claudes` and `codexs` commands with memory  
✅ **Synchronizes Memory** - Both AIs share preferences and conversation history  
✅ **Auto-Approval Setup** - Bypasses permission prompts for seamless operation  
✅ **Creates Management Tools** - `memory-sync` command for manual synchronization  

## Installation

1. **Copy to macOS** - Transfer this folder to your MacBook Pro
2. **Run Installer** - Execute `./install.sh` in Terminal
3. **Restart Terminal** - Or run `source ~/.zshrc`

```bash
cd /path/to/macos-memory-installer
chmod +x install.sh
./install.sh
```

## Configuration

- **User**: daniel
- **Sudo Password**: ;lk (configured in installer)
- **Memory Location**: `~/.local/share/assistant_memory/`

## Usage After Installation

```bash
# Claude Code with memory integration
claudes "help me write a function"

# CodexCLI with memory integration  
codexs "analyze this code"

# Manually sync memory between AIs
memory-sync
```

## Features

### Shared Memory
- Both AIs access the same preferences and conversation history
- Research and task completion status synchronized
- Session logging for continuity across sessions

### Auto-Approval
- `claudes` bypasses permission prompts (`--permission-mode bypassPermissions`)
- `codexs` uses expect script to auto-approve operations
- Seamless operation without interruptions

### Memory Persistence
- SQLite database for reliable storage
- Automatic session logging
- Conversation history maintained across sessions

## Files Installed

```
~/.local/share/assistant_memory/memory.db    # SQLite database
~/memory_system/                             # Python memory framework
~/.local/bin/claudes                         # Claude Code wrapper
~/.local/bin/codexs                          # CodexCLI wrapper  
~/.local/bin/memory-sync                     # Memory sync utility
~/CLAUDE.md                                  # System documentation
```

## Troubleshooting

**Commands not found after install:**
```bash
source ~/.zshrc
# or restart Terminal
```

**Permission issues:**
```bash
chmod +x ~/.local/bin/claudes
chmod +x ~/.local/bin/codexs
chmod +x ~/.local/bin/memory-sync
```

**expect not found:**
```bash
brew install expect
```

## Memory System Architecture

The memory system provides:
- **Local Storage**: SQLite database in `~/.local/share/assistant_memory/`
- **Namespaces**: preferences, directives, conversations, research, tasks
- **Bootstrap Pattern**: Auto-initialization in both AI tools
- **Session Logging**: Automatic conversation and task tracking

---

**Made with ❤️ for seamless AI assistant experiences**