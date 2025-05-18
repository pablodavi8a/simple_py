# Init to expose API

from .math_utils import add, multiply

__all__ = ["add", "multiply"]

# Dinamic version
try:
    from importlib.metadata import version
except ImportError:
    from importlib_metadata import version  # Para Python <3.8

__version__ = version("simple_py")
__author__ = "Pablo Ochoa"
