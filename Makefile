.PHONY: install lint format test check

install:  ## Create the environment and install the package + dev tools
	uv sync

lint:  ## Lint with ruff
	uv run ruff check .

format:  ## Auto-format and fix lint issues
	uv run ruff format .
	uv run ruff check --fix .

test:  ## Run the test suite
	uv run pytest

check: lint test  ## What CI runs (plus a format check)
	uv run ruff format --check .
