alias prp='poetry run pytest -v'
alias prps='BUILD_NUMBER=1 prp'
alias prpb='prp --benchmark-only --benchmark-enable'
alias prpc='prp --cov=src --cov-report html'
