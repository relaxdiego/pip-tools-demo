.PHONY: clean dev-install
.DEFAULT_GOAL := dev-install

# Use as follows `make clean all=t`
ifndef all
	requirements=""
	uninstall_pip_tools="pip uninstall -y pip-tools 2>/dev/null"
else
	requirements=*requirements.txt
	uninstall_pip_tools="true"
endif

# PHONY GOALS

clean:
	@pip uninstall -y -r requirements.txt -r dev-requirements.txt 2>/dev/null || echo -n
	@${uninstall_pip_tools} || true
	@rm -fv .last* ${requirements}
	@rm -rfv build/ *.egg-info **/__pycache__ .pytest_cache


dev-install: .last-dev-pip-sync .last-pip-tools-install


# REAL GOALS

.last-dev-pip-sync: dev-requirements.txt requirements.txt
	@(pip-sync dev-requirements.txt requirements.txt || echo "pip-sync error") | tee .last-dev-pip-sync
	@(grep "pip-sync error" .last-dev-pip-sync 1>/dev/null 2>&1 && rm -f .last-dev-pip-sync && exit 1) || true

dev-requirements.txt: dev-requirements.in requirements.txt .last-pip-tools-install
	@CUSTOM_COMPILE_COMMAND="make dependencies" pip-compile dev-requirements.in

.last-pip-tools-install:
	@(pip-compile --version 1>/dev/null 2>&1 || pip --disable-pip-version-check install "pip-tools>=5.2.1,<5.3" || echo "pip-tools install error") | tee .last-pip-tools-install
	@(grep "pip-tools install error" .last-pip-tools-install 1>/dev/null 2>&1 && rm -f .last-pip-tools-install && exit 1) || true

requirements.txt: setup.py .last-pip-tools-install
	@CUSTOM_COMPILE_COMMAND="make dependencies" pip-compile

