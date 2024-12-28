init:
	pip install -r requirements.txt
	pip install -U pyinstaller
build_release:
	pyinstaller -F ./src/main.py
	@echo "Release build can be found in ./dist/"