import ariadne_biograph


def test_package_exposes_version() -> None:
    assert isinstance(ariadne_biograph.__version__, str)
    assert ariadne_biograph.__version__
