set FLASK_APP=venv/Lib/site-packages/biweeklybudget/flaskapp/app.py
set DB_CONNSTRING=mysql+mysqlconnector://root@localhost:3306/biweekly
set PAY_PERIOD_START_DATE=2017-03-28
set RECONCILE_BEGIN_DATE=2017-02-15

flask rundev