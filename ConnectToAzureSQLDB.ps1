#This is the "ugly" way of doing it, and should only be used for a one time thing.

Connect-AzAccount -Subscription ''

$params = @{
'Database' = '' #DB name
'ServerInstance' =  '' #Full server name (YourServerName.database.windows.net)
'Username' = '' #SQL user with access to DB
'Password' = '' #Password the SQL user with acess to DB
'OutputSqlErrors' = $true

#Your SQL query aginst the DB
'Query' = 'select * from dbo.TABLENAME where SomeThing IS NOT NULL;'

  }

 $SQLquery = Invoke-Sqlcmd @params
