.PHONY: install
install:
	poetry install

.PHONY: dev
dev:
	poetry run flask --app page_analyzer:app run

PORT ?= 8000
start:
	poetry run gunicorn -w 5 -b 0.0.0.0:$(PORT) page_analyzer:app

start-no-poetry:
	gunicorn -w 5 -b 0.0.0.0:$(PORT) page_analyzer:app

.PHONY: flake8
flake8:
	poetry run flake8 page_analyzer

.PHONY: black-check
black-check:
	poetry run black --check page_analyzer  

.PHONY: black-diff
black-diff:
	poetry run black --diff page_analyzer

.PHONY: black
black:
	poetry run black page_analyzer

.PHONY: isort-check
isort-check:
	poetry run isort page_analyzer --check-only

.PHONY: isort-diff
isort-diff:
	poetry run isort page_analyzer --diff

.PHONY: isort
isort:
	poetry run isort page_analyzer

.PHONY: exportreq
exportreq:
	poetry export -f requirements.txt --output requirements.txt

.PHONY: test
test:
	poetry run pytest

.PHONY: test-coverage
test-coverage: # запись покрытия для CodeClimate
	poetry run pytest --cov=page_analyzer --cov-report xml