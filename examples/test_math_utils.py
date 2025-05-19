import pytest

from simple_py import add, multiply


def test_add():
    assert add(2, 3) == 5


def test_multiply():
    assert multiply(2, 3) == 6


# Check the version process
import simple_py

print(simple_py.__version__)
