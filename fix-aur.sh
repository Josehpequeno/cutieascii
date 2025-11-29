#!/bin/bash
set -e

echo "🔧 Corrigindo problemas do AUR..."

# Criar go.mod se não existir
if [ ! -f "go.mod" ]; then
    echo "📝 Criando go.mod..."
    cat > go.mod << EOF
module github.com/Josehpequeno/cutieascii

go 1.21
EOF
    echo "✅ go.mod criado"
fi

# Atualizar PKGBUILD com pkgrel incrementado
if [ -f "PKGBUILD" ]; then
    echo "📦 Atualizando PKGBUILD..."
    # Incrementa pkgrel
    current_rel=$(grep "pkgrel=" PKGBUILD | cut -d= -f2)
    new_rel=$((current_rel + 1))
    sed -i "s/pkgrel=$current_rel/pkgrel=$new_rel/" PKGBUILD
    echo "✅ PKGBUILD atualizado: pkgrel=$new_rel"
fi

# Se estiver no diretório aur, atualizar .SRCINFO
if [ -f ".SRCINFO" ]; then
    echo "📄 Atualizando .SRCINFO..."
    makepkg --printsrcinfo > .SRCINFO
    echo "✅ .SRCINFO atualizado"
fi

echo ""
echo "🎯 Próximos passos:"
echo "1. git add go.mod"
echo "2. git commit -m 'Add go.mod and fix build'"
echo "3. git tag v0.1.0"
echo "4. git push origin main --tags"
echo "5. No diretório aur: git add . && git commit -m 'Update to pkgrel $new_rel' && git push"