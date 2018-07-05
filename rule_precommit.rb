include "rally-tools.rb"

# Get time of last commit
unix_commit_time = Integer(`git log --format=="%at" -n1`) * 1000

