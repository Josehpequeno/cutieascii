# cutieascii 

A simple and cute command-line tool that displays random ASCII art emojis, perfect for terminal fun or as a lightweight neofetch alternative.

## Features

- 🎲 Random ASCII emoji display
- 🎨 Colored output
- 🚀 Lightweight and fast
- 📦 Easy installation

## About

This project uses the wonderful ASCII emoji collection from [nyaahilism/kaoscii](https://github.com/nyaahilism/kaoscii). All credit for the amazing emoji art goes to the original creator!

## Installation

### Method 1: Using Make (Recommended)

```bash
# Clone the repository
git clone https://github.com/Josehpequeno/cutieascii.git
cd cutieascii

# Build and install
make build
sudo make install
```

### Method 2: From Source

```bash
# Clone the repository
git clone https://github.com/Josehpequeno/cutieascii.git
cd cutieascii

# Build directly with Go
go build -o cutieascii cutieascii.go

# Install manually
sudo cp cutieascii /usr/local/bin/
sudo cp -r kaoscii /usr/local/share/cutieascii/
```

### Method 3: Using Pre-built Package

#### For Arch Linux
```bash
# Clone and build from AUR
git clone https://aur.archlinux.org/cutieascii.git
cd cutieascii
makepkg -si

# Or install directly (when available in AUR)
yay -S cutieascii
```

#### For Debian/Ubuntu
```bash
# Download the .deb package
wget https://github.com/Josehpequeno/cutieascii/releases/latest/download/cutieascii_0.1.0_amd64.deb

# Install the package
sudo dpkg -i cutieascii_0.1.0_amd64.deb

# Fix dependencies if needed
sudo apt install -f
```

#### For Other Distributions
Download the latest `.tar.gz` from [releases](https://github.com/Josehpequeno/cutieascii/releases) and extract:

```bash
tar -xzf cutieascii-*.tar.gz
cd cutieascii-*
sudo make install  # or follow manual instructions above
```

## Usage

```bash
# Display a random cute ASCII emoji
cutieascii

# Show version
cutieascii -v

```

## Examples

```
🚀 Running cutieascii might show:

ᔪ( ᐪoᐪ )ᔭᐤᑋ

🎨 In beautiful random colors!
```

## Building from Source

### Dependencies
- Go 1.16 or higher

### Steps
```bash
git clone https://github.com/Josehpequeno/cutieascii.git
cd cutieascii
go build -o cutieascii cutieascii.go
```

### Creating Packages

#### For Arch Linux
```bash
make arch-package
```

#### For Debian/Ubuntu
```bash
# Build .deb package
make deb-package
```

#### For General Linux (tarball)
```bash
make build-linux
./build-packages.sh
```

## Project Structure

```
cutieascii/
├── cutieascii.go          # Main program
├── kaoscii/               # Emoji collection from nyaahilism/kaoscii
│   └── allmojis          # ASCII emojis file
├── Makefile              # Build and installation
├── PKGBUILD             # Arch Linux package build
├── debian/              # Debian/Ubuntu packaging files
└── build-packages.sh    # Distribution script
```

## Package Management

### Removing
```bash
# Arch Linux
sudo pacman -R cutieascii

# Debian/Ubuntu  
sudo apt remove cutieascii

# From source installation
sudo make uninstall
```

## Credits

- **ASCII Emojis**: All ASCII art emojis are from [nyaahilism/kaoscii](https://github.com/nyaahilism/kaoscii)
- **Developer**: [Josehpequeno](https://github.com/Josehpequeno)

## License

MIT License - see LICENSE file for details.

---

**Note**: This project is a wrapper/redistributor of the kaoscii emoji collection. Please support the original project!