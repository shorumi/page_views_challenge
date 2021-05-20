SimpleCov.start do
  STDOUT.print 'SimpleCov started successfully!'
  enable_coverage :branch

  add_group 'App', '/app'
  add_group 'Business Rules', 'app/business/rules'

  add_filter '/config/'
  add_filter '/spec/'
end

SimpleCov.minimum_coverage line: 100, branch: 90
SimpleCov.minimum_coverage_by_file 90