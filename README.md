# Agent Skills

A curated collection of production-ready, agentic skills designed for **Antigravity**, **Claude Code**, **Cursor**, **OpenAI Codex**, and **OpenCode**.

Each skill extends AI assistants with repeatable runbooks, tool orchestration, and specialized workflows conforming to the `SKILL.md` specification.

---

## Available Skills

| Skill | Description | Requirements | Quick Install |
| :--- | :--- | :--- | :--- |
| **[`video-generation`](skills/video-generation/SKILL.md)** | Turn any topic, idea, or script into a finished video using an 8-stage pipeline and local CLI assembly. | [MoneyPrinterTurbo](https://github.com/harry0703/MoneyPrinterTurbo), FFmpeg | `./install.sh video-generation` |

---

## Installation

### Method 1: Using the Multi-Skill Install Script (Recommended)

Clone the repository and install all skills or select a specific one:

```bash
git clone https://github.com/aakashdandekar/Agent-Skills.git
cd Agent-Skills

# Install all skills across Antigravity, Claude Code, Codex, and OpenCode:
./install.sh

# Or install a single specific skill:
./install.sh video-generation
```

This symlinks the skills into:
- **Antigravity**: `~/.gemini/config/skills/<skill-name>`
- **Claude Code**: `~/.claude/skills/<skill-name>`
- **OpenAI Codex**: `~/.codex/skills/<skill-name>`
- **OpenCode**: `~/.config/opencode/skills/<skill-name>`

### Method 2: Claude Code Marketplace / Plugin

Add this repository as a marketplace in Claude Code:

```bash
/plugin marketplace add aakashdandekar/Agent-Skills
```

Then install any individual skill:

```bash
/plugin install video-generation@agent-skills
```

### Method 3: Manual Installation

Copy any skill folder from `skills/<skill-name>` into your preferred agent's skills directory:

```bash
# Antigravity / Gemini CLI
cp -r skills/video-generation ~/.gemini/config/skills/

# Claude Code
cp -r skills/video-generation ~/.claude/skills/

# Codex
cp -r skills/video-generation ~/.codex/skills/

# OpenCode
cp -r skills/video-generation ~/.config/opencode/skills/
```

---

## Skill Prerequisites & Setup

### `video-generation`
The `video-generation` skill uses **[MoneyPrinterTurbo](https://github.com/harry0703/MoneyPrinterTurbo)** to assemble and render video files locally.

#### 1. System Dependencies (FFmpeg)
Ensure `ffmpeg` is installed:
```bash
# Ubuntu / Debian
sudo apt update && sudo apt install -y ffmpeg

# Arch Linux
sudo pacman -S ffmpeg

# macOS (Homebrew)
brew install ffmpeg

# Windows (winget)
winget install Gyan.FFmpeg
```

#### 2. Install MoneyPrinterTurbo
```bash
git clone https://github.com/harry0703/MoneyPrinterTurbo.git
cd MoneyPrinterTurbo

# Using uv (recommended)
uv sync

# Or using standard venv
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

#### 3. Expose the `video` Command
To allow your agent to execute `video` from any working directory, configure a wrapper or alias:

```bash
cat << 'EOF' > ~/.local/bin/video
#!/usr/bin/env bash
exec /path/to/MoneyPrinterTurbo/.venv/bin/python /path/to/MoneyPrinterTurbo/cli.py "$@"
EOF
chmod +x ~/.local/bin/video
```

#### 4. Configure `config.toml`
```bash
cp config.example.toml config.toml
```
- **Stock footage**: Add your free Pexels API key under `pexels_api_keys = ["YOUR_KEY"]`.
- **LLM Script generation (optional)**: Configure Ollama (`llm_provider = "ollama"`) or cloud LLM providers. Edge TTS voice synthesis requires no API key.

---

## Acknowledgements & Special Thanks

Special thanks to **[@harry0703](https://github.com/harry0703)**, the creator of **[MoneyPrinterTurbo](https://github.com/harry0703/MoneyPrinterTurbo)**, for building and open-sourcing such an exceptional automated video generation engine. The `video-generation` skill's local timeline compositing, Edge TTS synthesis, subtitle burning, and media orchestration are made possible by their fantastic work!

---

## License

Licensed under the [Apache License, Version 2.0](LICENSE).
