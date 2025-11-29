# Variáveis
BINARY_NAME=cutieascii
VERSION=0.1.0
BUILD_DIR=build
PREFIX=/usr/local
PKGBUILD_SRC=PKGBUILD
PKGBUILD_TEMP=PKGBUILD.temp
NAME=cutieascii

# Targets especiais
#.PHONY: Indica que esses são "alvos falsos" (não são arquivos reais)
.PHONY: all build clean install uninstall

# Target padrão - executa quando você só digita 'make'
all: build

# Compila o programa
build:
	@echo "Building $(BINARY_NAME) v$(VERSION)..."
	go build -o $(BUILD_DIR)/$(BINARY_NAME) cutieascii.go
	@echo "Build complete!"

# Compila para Linux
build-linux:
	@echo "Building $(BINARY_NAME) v$(VERSION) for Linux..."
	GOOS=linux GOARCH=amd64 go build -o $(BUILD_DIR)/$(BINARY_NAME)-linux cutieascii.go
	@echo "Linux build complete!"

# Limpa os arquivos de build
clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)
	@echo "Clean complete!"

# Instala o programa no sistema
#    install: Comando do Linux para instalar arquivos

#    -D: Cria todos os diretórios necessários

#    -m755: Define permissões (755 = rwxr-xr-x - executável)

install:
	@echo "Installing $(BINARY_NAME)..."
	install -Dm755 $(BUILD_DIR)/$(BINARY_NAME) $(DESTDIR)$(PREFIX)/bin/$(BINARY_NAME)
	cp -r kaoscii $(DESTDIR)$(PREFIX)/share/$(BINARY_NAME)/
	@echo "Installation complete!"



# Desinstala o programa
uninstall:
	@echo "Uninstalling $(BINARY_NAME)..."
	rm -f $(DESTDIR)$(PREFIX)/bin/$(BINARY_NAME)
	rm -rf $(DESTDIR)$(PREFIX)/share/$(BINARY_NAME)
	@echo "Uninstallation complete!"

# Cria o tarball e atualiza o PKGBUILD automaticamente
pkgbuild:
	@echo "Creating source tarball for $(BINARY_NAME)..."
	tar -czf $(NAME)-$(VERSION).tar.gz cutieascii.go kaoscii/
	@echo "Tarball created: $(NAME)-$(VERSION).tar.gz"
	@echo "Run: makepkg -s"

# Limpa os arquivos de empacotamento
clean-pkg:
	@echo "Cleaning package files..."
	rm -f $(NAME)-*.tar.gz
	rm -f *.pkg.tar.*
	@echo "Package clean complete!"

# Alvo completo: limpa, cria tarball e constrói pacote
arch-package: clean clean-pkg pkgbuild
	@echo "Building Arch Linux package..."
	makepkg -s
	@echo "Package build complete!"

# Instala o pacote localmente (para teste)
install-arch: arch-package
	@echo "Installing Arch Linux package..."
	sudo pacman -U $(NAME)-*.pkg.tar.*
	@echo "Package installation complete!"

deb-package: build-linux
	mkdir -p $(BUILD_DIR)/deb/DEBIAN
	mkdir -p $(BUILD_DIR)/deb/usr/bin
	mkdir -p $(BUILD_DIR)/deb/usr/share/cutieascii
	cp $(BUILD_DIR)/cutieascii-linux $(BUILD_DIR)/deb/usr/bin/cutieascii
	cp -r kaoscii $(BUILD_DIR)/deb/usr/share/cutieascii/
	# Create control file
	@echo "Package: cutieascii" > $(BUILD_DIR)/deb/DEBIAN/control
	@echo "Version: $(VERSION)" >> $(BUILD_DIR)/deb/DEBIAN/control
	@echo "Section: utils" >> $(BUILD_DIR)/deb/DEBIAN/control
	@echo "Priority: optional" >> $(BUILD_DIR)/deb/DEBIAN/control
	@echo "Architecture: amd64" >> $(BUILD_DIR)/deb/DEBIAN/control
	@echo "Maintainer: Josehpequeno <hicarojbs21@gmail.com>" >> $(BUILD_DIR)/deb/DEBIAN/control
	@echo "Description: Display random cute ASCII art emojis" >> $(BUILD_DIR)/deb/DEBIAN/control
	dpkg-deb --build $(BUILD_DIR)/deb $(BUILD_DIR)/cutieascii_$(VERSION)_amd64.deb

# Comandos para AUR
prepare-aur:
	@echo "🚀 Preparando pacote para AUR..."
	@chmod +x prepare-aur.sh
	@./prepare-aur.sh

# Atualizar AUR (após mudanças)
update-aur: clean
	@echo "🔄 Atualizando AUR..."
	@mkdir -p cutieascii-$(VERSION)
	@cp cutieascii.go cutieascii-$(VERSION)/
	@cp -r kaoscii cutieascii-$(VERSION)/
	@tar -czf cutieascii-$(VERSION).tar.gz cutieascii-$(VERSION)/
	@rm -rf cutieascii-$(VERSION)
	@if [ -d "aur" ]; then \
		cp cutieascii-$(VERSION).tar.gz aur/; \
		cd aur && makepkg --printsrcinfo > .SRCINFO; \
		echo "✅ AUR atualizado localmente"; \
		echo "💡 Agora faça:"; \
		echo "   cd aur && git add . && git commit -m 'Update to v$(VERSION)' && git push"; \
	else \
		echo "❌ Diretório aur não encontrado. Execute 'make prepare-aur' primeiro"; \
	fi

# Limpar também arquivos AUR
clean-aur:
	rm -rf aur cutieascii-*.tar.gz

clean-all: clean clean-aur

# Comando para corrigir o AUR
fix-aur:
	@echo "🔧 Corrigindo problemas do AUR..."
	@if [ ! -f "go.mod" ]; then \
		echo "module github.com/Josehpequeno/cutieascii" > go.mod; \
		echo "go 1.21" >> go.mod; \
		echo "✅ go.mod criado"; \
	fi
	@echo "🎯 Agora execute:"
	@echo "   git add go.mod"
	@echo "   git commit -m 'Add go.mod'"
	@echo "   git tag v0.1.0"
	@echo "   git push origin main --tags"

# Comando para atualizar o AUR após correções
update-aur-fix: clean
	@echo "🔄 Atualizando AUR com correções..."
	@mkdir -p cutieascii-$(VERSION)
	@cp cutieascii.go cutieascii-$(VERSION)/
	@cp go.mod cutieascii-$(VERSION)/  # Inclui go.mod
	@cp -r kaoscii cutieascii-$(VERSION)/
	@tar -czf cutieascii-$(VERSION).tar.gz cutieascii-$(VERSION)/
	@rm -rf cutieascii-$(VERSION)
	@if [ -d "aur" ]; then \
		cp cutieascii-$(VERSION).tar.gz aur/; \
		cd aur && makepkg --printsrcinfo > .SRCINFO; \
		echo "✅ AUR atualizado com go.mod"; \
		echo "💡 Agora faça:"; \
		echo "   cd aur && git add . && git commit -m 'Fix build with go.mod' && git push"; \
	else \
		echo "❌ Diretório aur não encontrado. Execute 'make prepare-aur' primeiro"; \
	fi