puts ARGF.read.sub!(/\A(.)(\w*)/, '\lettrine{\1}{\2}')
