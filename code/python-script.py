def keep_repeat_users(df, visited=3):
	"""
	INPUT
	df: full dataframe of user activity
	visited = 3: minimum amount of times logged to be considered an adopted user

	OUTPUT
	new_df: dataframe containing all users who have logged on at least the 'visited' time, grouped by user_id
	"""
	import pandas as pd
	from pandas import DataFrame

	new_df = df.groupby('user_id').filter(lambda x: len(x) >= visited)
	return new_df

def active_users(period, days_logged, user):
	"""
	INPUT
	period: time period we want to look at, default 7
	days_logged: is the number of days of the period we want the user to have logged in, default 3
	user is the unique users

	OUPUT
	active_user: returns whether or not the user had 3 consecutive logins within a 7 day period
	"""
	import pandas as pd
	from pandas import DataFrame, Series

	visited = len(user.index) #get the number of times the user logged in
	i, count = 0, 1
	active_user = False

	while count < days_logged:
		if (i+2) < visited: #needs to be at least 3 entries left	
			if (user['time_stamp2'].iloc[i + 1] - user['time_stamp2'].iloc[i]) <= pd.Timedelta(days=period) and (user['time_stamp2'].iloc[i + 1] - user['time_stamp2'].iloc[i]) > pd.Timedelta(days=1) :
				count += 1 #logged in twice within a 7 day period
				new_timeframe = (user['time_stamp2'].iloc[i + 1] - user['time_stamp2'].iloc[i])
				if (user['time_stamp2'].iloc[i + 2] - user['time_stamp2'].iloc[i + 1]) <= new_timeframe and (user['time_stamp2'].iloc[i + 2] - user['time_stamp2'].iloc[i + 1]) > pd.Timedelta(days=1):
					active_user = True #they logged in three times within a 7 period window
					count += 1
				else: 
					i += 1
					count = 1
			else:
				i += 1
				count = 1
		else:
			count = days_logged
	return active_user

def keep_active_users(df):
	"""
	OUTPUT
	unique_active_peeps: a dataframe of unique adopted users
	"""
	import pandas as pd
	from pandas import DataFrame, Series

	active_peeps = df.filter(lambda x: active_users(period=7, days_logged=3, user=x) ==True)

	unique_active_peeps = DataFrame(Series.unique(active_peeps['user_id']))
	unique_active_peeps.columns = ['user_id']

	return unique_active_peeps
