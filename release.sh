#!/bin/bash

set -e  # exit if any command fails

#Paso 1: Confirmar número de versión
read -p "Ingresá la nueva versión (formato X.Y.Z): " VERSION

echo "🔍 Verificando tests con pytest..."
pytest

echo "Ejecutando pre-commit..."
pre-commit run --all-files

echo "Construyendo el paquete..."
rm -rf dist/ build/ *.egg-info
python -m build

echo "Borrando tag anterior si existe (local + remoto)..."
git tag -d v$VERSION || true
git push origin :refs/tags/v$VERSION || true

echo "Creando nuevo tag v$VERSION..."
git tag v$VERSION

echo "Subiendo cambios y el tag..."
git push origin main
git push origin v$VERSION

# OPCIONAL: subir a PyPI
read -p "¿Querés subir a PyPI? (s/n): " subir
if [ "$subir" == "s" ]; then
  echo "Subiendo a PyPI..."
  twine upload dist/*
else
  echo "⏭Salteando subida a PyPI."
fi

echo "Listo. Versión v$VERSION publicada correctamente."
