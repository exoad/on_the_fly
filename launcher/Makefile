init:
	pip install -r requirements.txt
	pip install -U pyinstaller
build_release:
	pyinstaller --onefile -F ./src/launcher.py -n $(o_name) --icon=../windows/runner/resources/app_icon.ico
	@echo "Release build can be found in ./dist/"