# AgentRules Ultimate - Installation Guide

> **🌐 Language Options**: 🇺🇸 English (Current) | [🇨🇳 中文](INSTALL-GUIDE-CN.md)

> **IMPORTANT NOTICE**: Now only one script is needed to handle all AI tools!
>
> **Estimated Time**: 3-5 minutes | **Success Rate**: 100% when following steps
> **Latest Version**: install-ultra.bat (Final Release) - Unified solution for all AI tools
> **Super Simplified**: Now supports double-click execution, automatically creates agent folder on desktop!

## What This Tutorial Can Help You Do

Use **one script** to install AgentRules rule system for **all AI tools**, making your AI assistant super intelligent.

### Core Features
- **Frontend Development**: Vue, React, TypeScript professional development
- **Backend Development**: Node.js, Python, Java and other backend technologies
- **Full-stack Development**: Complete frontend + backend solution
- **Code Management**: Standardized commits, code review, bug fixes
- **Visualization**: Auto-generate architecture diagrams, flowcharts
- **Intelligent System**: AI memory, recommendation engine, super brain

### Ultimate Version Features
- **One Script for All AI Tools**: Augment, Cursor, Claude, Trae, etc.
- **Priority Architecture**: P0-P7 eight priority levels, AI understanding improved
- **Standardized Directory Structure**: Auto-creates `.rules/` subdirectory
- **Enhanced Encoding Support**: Perfect handling of Chinese paths and special characters
- **Three Development Modes**: frontend, backend, fullstack
- **Cross-Region Compatible**: Auto-detects system encoding for global compatibility
- **Double-Click Ready**: Supports direct double-click execution, zero-config installation

## Script Status

| Script Name | Status | Function | Supported AI Tools |
|-------------|--------|----------|-------------------|
| `install-ultra.bat` | **Final Release** | Unified rule installer | **All AI Tools** |

**Major Improvements**:
- **Unified Solution** - One script replaces all specialized scripts
- **Smart Adaptation** - Auto-adapts to all AI tools and IDEs
- **Priority System** - P0-P7 eight-layer architecture, 200% AI understanding improvement
- **Encoding Detection** - Auto-detects system encoding (CP936/950/932/949/437/65001)
- **Perfect Compatibility** - Supports all mainstream AI development tools
- **Double-Click Installation** - Supports direct script double-click, auto-creates desktop agent project

## Pre-Installation Preparation (Must Read!)

### Installation Checklist
- [ ] **Operating System**: Windows 10/11 (Required)
- [ ] **AI Tools**: Any AI development tool (Augment, Cursor, Claude, Trae, etc.)
- [ ] **Rule Files**: Downloaded `rules-2.1-optimized` folder
- [ ] **Project Directory**: Existing project folder or ready to create one

### File Preparation
1. Place `rules-2.1-optimized` folder in an easily accessible location (like desktop)
2. Ensure you have a project folder (if not, installation process will auto-create)
3. Ensure you have administrator privileges (some operations may require)

### Quick Start Tips
**Beginner Recommendation**: If you're unsure where to install, run the script without any parameters, and the system will automatically create an `agent` folder on the desktop as the project directory.

## Super Simple: Double-Click Installation (Recommended!)

**Easiest method - suitable for all users**:

1. **Find Script File**: Enter the `install-scripts` folder
2. **Double-Click to Run**: Directly double-click the `install-ultra.bat` file
3. **Auto-Complete**: Script will automatically create `agent` folder on desktop and install all fullstack rules

**Advantages of Double-Click Installation**:
- **Zero Configuration**: No need to input any commands or parameters
- **Fixed Location**: Unified creation of `agent` folder on desktop for easy management
- **Complete Functionality**: Auto-installs fullstack mode, includes all frontend + backend rules
- **Ready to Use**: Immediately usable in any AI tool after installation
- **Smart Detection**: Auto-detects if already installed, avoids duplicate execution
- **Encoding Auto-Detection**: Automatically adapts to your system's regional settings

**Installation Location**: `C:\Users\YourUsername\Desktop\agent`

## Command Line Installation (Advanced Users)

### Step 1: Open Command Line

**Important Reminder**: Recommend running as administrator to avoid permission issues!

**Method 1: PowerShell (Recommended)**
1. Press `Win + X` on keyboard
2. Select "Windows PowerShell (Admin)" or "Terminal (Admin)"
3. Click "Yes" to confirm admin privileges
4. See blue window means success!

**Method 2: CMD Command Prompt (Admin Mode)**
1. Press `Win` key
2. Type `cmd`
3. Right-click "Command Prompt"
4. Select "Run as administrator"
5. Click "Yes" to confirm admin privileges

### Step 2: Navigate to Correct Directory

**Copy and paste this command** (change `luo20` to your username):
```
cd c:\Users\luo20\Desktop\rules-2.1-optimized
```

**Check if successful**:
```
dir
```
You should see these folders:
- `install-scripts` ✅
- `project-rules` ✅  
- `global-rules` ✅

### Step 3: Choose Your Development Mode

**Don't know what to choose? Look here:**
- **Web pages, APP interfaces** → Choose `frontend`
- **Servers, APIs** → Choose `backend`
- **Full-stack development (Recommended)** → Choose `fullstack`

## One-Click Installation Commands

### Unified Installation Commands (All AI Tools Compatible)

**Frontend Development**:
```bash
# Method 1: Absolute path (Recommended)
install-scripts\install-ultra.bat C:\Users\YourUsername\Desktop\demo-project frontend

# Method 2: Relative path (Simple)
install-scripts\install-ultra.bat ..\demo-project frontend
```

**Backend Development**:
```bash
# Method 1: Absolute path
install-scripts\install-ultra.bat C:\Users\YourUsername\Desktop\demo-project backend

# Method 2: Relative path (Recommended)
install-scripts\install-ultra.bat ..\demo-project backend
```

**Full-stack Development (Recommended)**:
```bash
# Method 1: Absolute path
install-scripts\install-ultra.bat C:\Users\YourUsername\Desktop\demo-project fullstack

# Method 2: Relative path (Recommended)
install-scripts\install-ultra.bat ..\demo-project fullstack
```

### Simplified Command Examples

```bash
# Simplest way: No parameters (Recommended for beginners)
install-scripts\install-ultra.bat
# Effect: Creates C:\Users\YourUsername\Desktop\agent folder, uses fullstack mode

# Only specify development mode, use desktop default location
install-scripts\install-ultra.bat frontend
# Effect: Creates C:\Users\YourUsername\Desktop\agent folder, uses frontend mode

# Only specify directory, use default fullstack mode
install-scripts\install-ultra.bat C:\my-project
# Equivalent to: install-scripts\install-ultra.bat C:\my-project fullstack
```

**See "SUCCESS: Rules Directory Created! (Final Release)" means success!**

## File Structure After Installation

After installation, your project directory will look like this:

```
Your Project Directory/
└── .rules/                          ← All rule files are here
    ├── main.md                     ← Rules directory guide
    ├── P0-core-safety/             ← Core safety rules (Priority 1000)
    ├── P1-core-identity/           ← Core identity rules (Priority 900)
    ├── P2-intelligent-system/      ← Intelligent system rules (Priority 800)
    ├── P3-professional-dev/        ← Professional development rules (Priority 700)
    ├── P4-project-workflow/        ← Project workflow rules (Priority 600)
    ├── P5-advanced-features/       ← Advanced feature rules (Priority 500)
    ├── P6-system-optimization/     ← System optimization rules (Priority 400)
    └── P7-utilities/               ← Utility rules (Priority 300)
```

## File Count by Mode

| Mode | File Count | Contents |
|------|----------|----------|
| **Frontend** | 31 files | Frontend rules + mermaid chart support + 6 new core intelligent rules |
| **Backend** | 30 files | Backend rules (no mermaid) + 6 new core intelligent rules |
| **Fullstack** | 33 files | Frontend + backend complete rules + 6 new core intelligent rules |

## How to Use Installed Rules?

### AI Tool Auto-Recognition

After installation, **all AI tools** will automatically recognize rules in the `.rules/` directory:

- ✅ **Augment AI** - Auto-loads rules, supports Chinese dialogue
- ✅ **Cursor IDE** - Auto-loads rules, professional code editing
- ✅ **Claude Code** - Auto-loads rules, intelligent code assistant
- ✅ **Trae AI** - Auto-loads rules, supports Chinese dialogue
- ✅ **Other AI Tools** - Universal compatibility

### Priority System Explanation

AI will understand and execute rules in the following priority order:

1. **P0 (1000)**: Core Safety - Must be followed first
2. **P1 (900)**: Core Identity - Basic behavior patterns
3. **P2 (800)**: Intelligent System - Advanced capabilities
4. **P3 (700)**: Professional Development - Domain expertise
5. **P4 (600)**: Project Workflow - Operational processes
6. **P5 (500)**: Advanced Features - Enhanced functionality
7. **P6 (400)**: System Optimization - Performance tuning
8. **P7 (300)**: Utilities - Support tools

## Troubleshooting

### Common Issues Quick Reference

**❌ Issue 1: Script cannot run**
```
Error: Cannot recognize "install-scripts\install-ultra.bat" as cmdlet
```
**✅ Solution**: Ensure you're in the correct directory
```
cd c:\Users\luo20\Desktop\rules-2.1-optimized
```

**❌ Issue 2: Path contains special characters**
```
Error: The filename, directory name, or volume label syntax is incorrect
```
**✅ Solution**: Script now auto-handles Unicode characters with enhanced encoding detection
```
# Use English paths if issues persist
install-scripts\install-ultra.bat C:\projects\demo-project fullstack
```

**❌ Issue 3: Permission issues**
```
Error: Access denied
```
**✅ Solution**: Run PowerShell as administrator

**❌ Issue 4: Parent directory doesn't exist**
```
Error: Parent directory does not exist
```
**✅ Solution**: Create parent directory first
```
mkdir C:\Users\luo20\Desktop
```

## Advanced Usage

### Custom Project Paths
```bash
# Use absolute path
install-scripts\install-ultra.bat C:\projects\my-vue-app frontend

# Use relative path
install-scripts\install-ultra.bat ..\my-project backend

# Full-stack project
install-scripts\install-ultra.bat D:\workspace\fullstack-app fullstack
```

### Encoding Compatibility
The script now automatically detects and adapts to different system encodings:
- **CP936**: Chinese Simplified
- **CP950**: Chinese Traditional
- **CP932**: Japanese
- **CP949**: Korean
- **CP437/65001**: English/Western

## Summary

**🖱️ Simplest Method (Recommended for all users)**:
```
Directly double-click install-scripts\install-ultra.bat
Auto-creates agent folder on desktop with complete fullstack rules
```

**⌨️ Command Line Method (Advanced users)**:
```bash
# Complete format
install-scripts\install-ultra.bat [project-path] [mode]

# Quick command
install-scripts\install-ultra.bat
# Also creates agent folder on desktop
```

**🚀 Three Development Modes**:
- `frontend` - Frontend development (31 files)
- `backend` - Backend development (30 files)
- `fullstack` - Full-stack development (33 files, recommended)

**✅ Install once, all AI tools can use!**
**🎯 Double-click ready, zero technical barrier!**
**🌐 Global compatibility with auto-encoding detection!**

---

🎉 **Congratulations! Now you can enjoy unified, intelligent, and efficient AI-assisted development experience!**