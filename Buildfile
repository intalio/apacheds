require "buildr"
require "install.rb"
require "build/common.rb"

repositories.release_to[:username] ||= "release"
repositories.release_to[:url] ||= "sftp://www.intalio.org/var/www-org/public/maven2"
repositories.release_to[:permissions] ||= 0664

# Keep this structure to allow the build system to update version numbers.
VERSION_NUMBER = "6.0.0.41-SNAPSHOT"

desc "Embedded Apache Directory Service"
define "apacheds-webapp" do
  project.version = VERSION_NUMBER
  project.group = "org.intalio.tempo"
  compile.options.target = "1.5"
  
  libs = [APACHE_DS_DEPS, APACHE_COMMONS[:lang], APACHE_COMMONS[:collections], JSON_NAGGIT, SLF4J.values]
  compile.with(libs, SERVLET_API)
  test.with(libs, LOG4J)
  package(:war).with :libs => libs
end

#delete temporary build folder
rm_rf "build"
