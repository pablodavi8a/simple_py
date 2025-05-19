# 📦 Cómo crear una librería Python profesional desde cero

Esta guía te enseña paso a paso cómo crear, organizar, probar, versionar y publicar una librería de Python moderna, utilizando herramientas estándar y buenas prácticas. Cualquier desarrollador podrá seguirla sin errores.

---

## 🧰 Requisitos previos

Antes de comenzar, asegúrate de tener instalado:

- Python 3.8 o superior
- Git
- pip
- Una cuenta en GitHub
- Una cuenta en PyPI (opcional, para publicar la librería)

---

## 📂 Estructura recomendada del proyecto

```
simple_py/
├── src/
│   └── simple_py/
│       ├── __init__.py
│       └── math_utils.py
├── tests/
│   └── test_math_utils.py
├── .pre-commit-config.yaml
├── pyproject.toml
├── release.sh
└── README.md
```

---

## 🔧 Paso 1: Crear un entorno virtual

```bash
# MacOs
python3 -m venv .venv
source .venv/bin/activate

# Windwos
python -m venv .venv
.venv\Scripts\activate

# Upgrade pip setuptools and wheel
pip install --upgrade pip setuptools wheel
```
---

## 🔧 Paso 2: Instalar las herramientas de desarrollo

📦 `build` es la herramienta oficial para empaquetar tu librería de Python.
Permite generar los archivos estándar (`.whl` y `.tar.gz`) que se requieren para subir a PyPI.
Reemplaza los comandos antiguos como `python setup.py sdist bdist_wheel`.

🚀 `twine` es la herramienta recomendada para subir paquetes a PyPI.
Se encarga de la autenticación y del envío seguro de los archivos generados por `build`.

```bash
pip install build twine
```

---

## 🛠️ Paso 3: Crear el archivo `pyproject.toml`

```toml
[project]
name = "simple_py"
description = "A simple math utility library"
authors = [{ name = "Pablo Ochoa", email = "pablodavi8a@gmail.com" }]
readme = "README.md"
requires-python = ">=3.8"
dependencies = []
dynamic = ["version"]

[build-system]
requires = ["setuptools>=61.0", "setuptools-scm"]
build-backend = "setuptools.build_meta"

[tool.setuptools]
package-dir = {"" = "src"}

[tool.setuptools.packages.find]
where = ["src"]

[tool.setuptools_scm]
version_scheme = "post-release"
local_scheme = "node-and-date"
```

---

## 📁 Paso 4: Código fuente y versión automática

```python
# src/simple_py/__init__.py
try:
    from importlib.metadata import version
except ImportError:
    from importlib_metadata import version

__version__ = version("simple_py")
__author__ = "Pablo Ochoa"
```
```bash
# Necesario instalar importlib_metadata (versiones anteriores de Python)
pip install importlib_metadata
```

```python
# src/simple_py/math_utils.py
def add(a, b):
    return a + b
```

---

## ✅ Paso 5: Instalar en modo editable

```bash
pip install -e .
```

Esto instala la librería localmente, permitiéndote probar los cambios sin reinstalar cada vez. Si existe un error es por que debe estas buscando el versionado dinamico con setuptools_scm.

```bash
Comentas las siguienes lineas y agregar las siguientes:

#dynamic = ["version"]
version = "0.1.0"

#requires = ["setuptools>=61.0", "setuptools-scm"]
requires = ["setuptools>=61.0"]

#[tool.setuptools_scm]
#version_scheme = "post-release"
#local_scheme = "node-and-date"

```
---

## 🧪 Paso 6: Crear y correr pruebas con pytest

Instala pytest:

```bash
pip install pytest
```

Crea el archivo:

```python
# tests/test_math_utils.py
from simple_py.math_utils import add

def test_add():
    assert add(2, 3) == 5
```

Corre los tests:

```bash
pytest
```

---

## 🎨 Paso 7: Formato automático con black y pre-commit

Instala las herramientas:

```bash
pip install pre-commit black
```

Archivo `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/psf/black
    rev: 23.9.1
    hooks:
      - id: black

  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
```

Configura pre-commit:

```bash
pre-commit install
pre-commit run --all-files
```

---

## 🏷️ Paso 8: Versionado automático con Git

1. Inicializa Git:

```bash
git init
git add .
git commit -m "Initial commit"
```

2. Crea y sube un tag:

```bash
git tag v0.1.0
git push origin main
git push origin v0.1.0
```

3. Verifica la versión desde el código:

```python
import simple_py
print(simple_py.__version__)  # Salida: 0.1.0 o 0.1.0.post0+<hash>
```

---

## 🚀 Paso 9: Script para lanzar una versión

```bash
# release.sh
#!/bin/bash
set -e

read -p "📦 Ingresa la nueva versión (formato X.Y.Z): " VERSION

pytest
pre-commit run --all-files

rm -rf dist/ build/ *.egg-info
python -m build

git tag -d v$VERSION || true
git push origin :refs/tags/v$VERSION || true
git tag v$VERSION
git push origin main
git push origin v$VERSION

read -p "¿Quieres subir a PyPI? (s/n): " subir
if [ "$subir" == "s" ]; then
  twine upload dist/*
else
  echo "⏭️ Subida a PyPI cancelada."
fi
```

```bash
# Dar permisos
chmod +x release.sh
# Run
./release.sh
```
---

## 🚀 Paso 10: Generar archivo requerimientos.txt con PIP-CHILL

```bash
pip install pip-chill

pip-chill > requirements.txt
```
---

## 💡 Buenas prácticas

- Usa `setuptools_scm` para versiones automáticas desde Git.
- Usa `pre-commit` para mantener el código limpio.
- Usa `pytest` para pruebas rápidas y confiables.
- Documenta y sube tu código a GitHub para compartirlo o colaborar.

---

## 👨‍💻 Autor

**Pablo Ochoa**
📧 pablodavi8a@gmail.com
🔗 https://github.com/pablodavi8a
