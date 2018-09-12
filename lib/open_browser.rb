require "watir"
require "test/unit"
require "logger"
require "rubygems"
require "headless"
require "uri"
require 'colorize'
require "net/ping"
require "pry"

if $log.nil?
    $log = Logger.new STDERR
    $log.level = Logger::WARN
end

module OpenBrowser    
    def open_browser(url:, screenshots_dir: File.join(Dir.pwd, "screenshots"))
        browser = Watir::Browser.new :chrome#, headless: true
        browser.goto(url)
        p1 = Net::Ping::HTTP.new(url)
        if p1.ping? == true
            $log.debug "Able to ping the url? '#{p1.ping?}'".green
        elsif p1.ping? == false
            raise "Not able to ping URL".red
        end
        class << browser
            attr_accessor :screenshots_dir
        end
        browser.screenshots_dir = screenshots_dir
        return browser
    end
end

=begin
opens a browser and uses parametr(url:) to open url

template:
name_of_project = open_browser(
    url: "target_url_ending_with_port"
)

example:
meg_dg = open_browser(
    url: "http://172.22.16.19:9086/"
)
=end
