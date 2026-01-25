#!/bin/bash
set -e

VERSION="0.1.1"
NAME="cutieascii"
AUR_REPO="aur@aur.archlinux.org:${NAME}.git"

echo "🚀 Preparando pacote para AUR..."

# Criar tarball do código fonte
echo "📦 Criando tarball do código fonte..."
mkdir -p ${NAME}-${VERSION}
cp cutieascii.go ${NAME}-${VERSION}/
if [ -f go.mod ]; then
    cp go.mod ${NAME}-${VERSION}/
fi
if [ -f go.sum ]; then
    cp go.sum ${NAME}-${VERSION}/
fi
cp -r kaoscii ${NAME}-${VERSION}/
tar -czf ${NAME}-${VERSION}.tar.gz ${NAME}-${VERSION}
rm -rf ${NAME}-${VERSION}

# Criar diretório para o AUR
echo "📁 Preparando repositório AUR..."
if [ -d "aur" ]; then
    rm -rf aur
fi

mkdir aur
cd aur

# Clonar repositório AUR (vai falhar se for a primeira vez, mas é normal)
git clone $AUR_REPO . || true

# Se não clonou (primeira vez), inicializamos o git
if [ ! -d ".git" ]; then
    git init
    git remote add origin $AUR_REPO
fi

# Copiar arquivos para o repositório AUR
cp ../PKGBUILD ./
cp ../${NAME}-${VERSION}.tar.gz ./


# Gerar .SRCINFO
echo "📄 Gerando .SRCINFO..."
makepkg --printsrcinfo > .SRCINFO

# Mostrar status
echo ""
echo "✅ Preparação concluída!"
echo ""
echo "📋 Arquivos no diretório AUR:"
ls -la
echo ""
echo "🔑 Para enviar para o AUR (PRIMEIRA VEZ):"
echo "   cd aur"
echo "   git add ."
echo "   git commit -m 'Initial release'"
echo "   git push origin master"
echo ""
echo "🔄 Para atualizar depois:"
echo "   cd aur"
echo "   git add ."
echo "   git commit -m 'Update to vX.X.X'"
echo "   git push origin master"