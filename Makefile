setup:
	python3 -m venv ~/.myrepo &&\
    source ~/.myrepo/bin/activate
	
install:
	python3 -m pip install --upgrade pip &&\
    python3 -m pip install -r requirements.txt

lint:
	pylint --disable=R,C,W1203,bare-except --fail-under=6 app.py

test:
	# python -m pytest -vv --cov=myrepolib tests/*.py
	# python -m pytest --nbval notebook.ipynb

all: install lint test