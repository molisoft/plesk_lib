module PleskKit
  class ServicePlan < ActiveRecord::Base
    attr_accessible :mailboxes, :domains, :name, :traffic, :storage
    validates_presence_of :mailboxes, :domains, :name, :traffic, :storage
    has_many :subscriptions

    def find_or_push server
      PleskKit::Communicator.get_service_plan self, server
    end

    def analyse response_string, server
      xml = REXML::Document.new(response_string)
      status = xml.root.elements['//status'].text if xml.root.elements['//status'].present?
      puts response_string
      if xml.root.elements['//get'].present?
        if status == 'error'
          if server.platform == 'linux'
            PleskKit::Communicator.push_service_plan self, server
          elsif server.platform == 'windows'
            PleskKit::Communicator.push_windows_service_plan self, server
          end
        elsif status == 'ok'
          return true
        end

      elsif xml.root.elements['//add'].present?
        if status == "error"
          code = xml.root.elements['//errcode'].text
          message = xml.root.elements['//errtext'].text
          raise "#{code}: #{message}"
        elsif status == 'ok'
          return true
       end
      end
    end

    def build_xml_for_get shell
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.0') {
        xml.tag!("service-plan") {
          xml.get{
            xml.filter{
              xml.name("#{self.name}")
            }
          }
        }
      }
      puts xml.target!
      return xml.target!
    end

    def build_xml_for_add shell
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.0') {
        xml.send(:"service-plan") {
          xml.add{
            xml.name("#{self.name.to_s}")
            xml.mail{
              xml.webmail('horde')
            }
            xml.limits{
              xml.overuse('block')

              xml.limit{
                xml.name('max_site')
                xml.value("#{self.domains.to_s}")
              }
              xml.limit{
                xml.name('max_subdom')
                xml.value('-1')
              }
              xml.limit{
                xml.name('max_dom_aliases')
                xml.value('-1')
              }
              xml.limit{
                xml.name('disk_space')
                xml.value("#{self.storage}") #10gb
              }
              xml.limit{
                xml.name('disk_space_soft')
                xml.value('0')
              }
              xml.limit{
                xml.name('max_traffic')
                xml.value("#{self.traffic.to_s}") # unlimited
              }
              xml.limit{
                xml.name('max_traffic_soft')
                xml.value('0')
              }
              xml.limit{
                xml.name('max_wu')
                xml.value('-1')
              }
              xml.limit{
                xml.name('max_subftp_users')
                xml.value('-1')
              }
              xml.limit{
                xml.name('max_db')
                xml.value('10')
              }
              xml.limit{
                xml.name('max_box')
                xml.value("#{self.mailboxes.to_s}") # mailboxes
              }
              xml.limit{
                xml.name('mbox_quota')
                xml.value('1073741824')
              }
              xml.limit{
                xml.name('max_maillists')
                xml.value('100')
              }
              xml.limit{
                xml.name('max_webapps')
                xml.value('0')
              }
              xml.limit{
                xml.name('max_site_builder')
                xml.value('1')
              }
              xml.limit{
                xml.name('max_unity_mobile_sites')
                xml.value('0')
              }
              xml.limit{
                xml.name('expiration')
                xml.value('-1')
              }
              xml.limit{
                xml.name('upsell_site_builder')
                xml.value('0')
              }

            }
            xml.send(:"log-rotation"){
              xml.on{
                xml.send(:"log-condition"){
                  xml.tag!("log-bysize", "10485760")
                }
                xml.tag!("log-max-num-files", "10")
                xml.tag!("log-compress", "true")
              }
            }
            xml.preferences{
              xml.stat('3')
              xml.maillists('false')
              xml.dns_zone_type('master')
            }
            xml.hosting{
              xml.property{
                xml.name('ssl')
                xml.value('false')
              }
              xml.property{
                xml.name('fp')
                xml.value('false')
              }
              xml.property{
                xml.name('fp_ssl')
                xml.value('false')
              }
              xml.property{
                xml.name('fp_auth')
                xml.value('false')
              }
              xml.property{
                xml.name('webstat')
                xml.value('awstats')
              }
              xml.property{
                xml.name('webstat_protected')
                xml.value('true')
              }
              xml.property{
                xml.name('wu_script')
                xml.value('true')
              }
              xml.property{
                xml.name('shell')
                xml.value('/bin/false')
              }
              xml.property{
                xml.name('ftp_quota')
                xml.value('-1')
              }
              xml.property{
                xml.name('php_handler_type')
                xml.value('fastcgi')
              }
              xml.property{
                xml.name('asp')
                xml.value('false')
              }
              xml.property{
                xml.name('ssi')
                xml.value('false')
              }
              xml.property{
                xml.name('php')
                xml.value('true')
              }
              xml.property{
                xml.name('cgi')
                xml.value('true')
              }
              xml.property{
                xml.name('perl')
                xml.value('true')
              }
              xml.property{
                xml.name('python')
                xml.value('true')
              }
              xml.property{
                xml.name('fastcgi')
                xml.value('true')
              }
              xml.property{
                xml.name('miva')
                xml.value('false')
              }
              xml.property{
                xml.name('coldfusion')
                xml.value('false')
              }
            }
            xml.performance{
              xml.bandwidth('-1')
              xml.max_connections('-1')
            }
            xml.permissions{
              xml.permission{
                xml.name('create_domains')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_phosting')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_php_settings')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_sh_access')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_not_chroot_shell')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_quota')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_subdomains')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_domain_aliases')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_log')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_anonftp')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_subftp')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_crontab')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_dns')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_webapps')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_webstat')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_mail_settings')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_maillists')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_spamfilter')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_virusfilter')
                xml.value('true')
              }
              xml.permission{
                xml.name('allow_local_backups')
                xml.value('true')
              }
              xml.permission{
                xml.name('allow_ftp_backups')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_performance')
                xml.value('false')
              }
              xml.permission{
                xml.name('select_db_server')
                xml.value('false')
              }
              xml.permission{
                xml.name('access_appcatalog')
                xml.value('true')
              }
              xml.permission{
                xml.name('allow_insecure_sites')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_website_maintenance')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_protected_dirs')
                xml.value('true')
              }
              xml.permission{
                xml.name('access_service_users')
                xml.value('true')
              }
              xml.permission{
                xml.name('allow_license_stubs')
                xml.value('false')
              }
            }
          }
        }
      }
      puts xml.target!
      return xml.target!
    end




    def build_windows_xml_for_add shell
      xml = shell
      xml.instruct!
      xml.packet(:version => '1.6.3.0') {
        xml.send(:"service-plan") {
          xml.add{
            xml.name("#{self.name.to_s}")
            xml.mail{
              xml.webmail('horde')
            }
            xml.limits{
              xml.overuse('block')

              xml.limit{
                xml.name('max_site')
                xml.value("#{self.domains.to_s}")
              }
              xml.limit{
                xml.name('max_subdom')
                xml.value('-1')
              }
              xml.limit{
                xml.name('max_dom_aliases')
                xml.value('-1')
              }
              xml.limit{
                xml.name('disk_space')
                xml.value("#{self.storage}") #10gb
              }
              xml.limit{
                xml.name('disk_space_soft')
                xml.value('0')
              }
              xml.limit{
                xml.name('max_traffic')
                xml.value("#{self.traffic.to_s}") # unlimited
              }
              xml.limit{
                xml.name('max_traffic_soft')
                xml.value('0')
              }
              xml.limit{
                xml.name('max_wu')
                xml.value('-1')
              }
              xml.limit{
                xml.name('max_subftp_users')
                xml.value('-1')
              }
              xml.limit{
                xml.name('max_db')
                xml.value('10')
              }
              xml.limit{
                xml.name('max_box')
                xml.value("#{self.mailboxes.to_s}") # mailboxes
              }
              xml.limit{
                xml.name('mbox_quota')
                xml.value('1073741824')
              }
              xml.limit{
                xml.name('max_maillists')
                xml.value('100')
              }
              xml.limit{
                xml.name('max_webapps')
                xml.value('0')
              }
              xml.limit{
                xml.name('max_site_builder')
                xml.value('1')
              }
              xml.limit{
                xml.name('max_unity_mobile_sites')
                xml.value('0')
              }
              xml.limit{
                xml.name('expiration')
                xml.value('-1')
              }
              xml.limit{
                xml.name('upsell_site_builder')
                xml.value('0')
              }

            }
            xml.send(:"log-rotation"){
              xml.on{
                xml.send(:"log-condition"){
                  xml.tag!("log-bysize", "10485760")
                }
                xml.tag!("log-max-num-files", "10")
                xml.tag!("log-compress", "true")
              }
            }
            xml.preferences{
              xml.stat('3')
              xml.maillists('false')
              xml.dns_zone_type('master')
            }
            xml.hosting{
              xml.property{
                xml.name('ssl')
                xml.value('false')
              }
              xml.property{
                xml.name('fp')
                xml.value('false')
              }
              xml.property{
                xml.name('fp_ssl')
                xml.value('false')
              }
              xml.property{
                xml.name('fp_auth')
                xml.value('false')
              }
              xml.property{
                xml.name('webstat')
                xml.value('awstats')
              }
              xml.property{
                xml.name('webstat_protected')
                xml.value('true')
              }
              xml.property{
                xml.name('wu_script')
                xml.value('true')
              }
              #xml.property{
              #  xml.name('shell')
              #  xml.value('/bin/false')
              #}
              xml.property{
                xml.name('ftp_quota')
                xml.value('-1')
              }
              xml.property{
                xml.name('php_handler_type')
                xml.value('fastcgi')
              }
              xml.property{
                xml.name('asp')
                xml.value('false')
              }
              xml.property{
                xml.name('ssi')
                xml.value('false')
              }
              xml.property{
                xml.name('php')
                xml.value('true')
              }
              xml.property{
                xml.name('cgi')
                xml.value('true')
              }
              xml.property{
                xml.name('perl')
                xml.value('true')
              }
              xml.property{
                xml.name('python')
                xml.value('true')
              }
              #xml.property{
              #  xml.name('fastcgi')
              #  xml.value('true')
              #}
              xml.property{
                xml.name('miva')
                xml.value('false')
              }
              xml.property{
                xml.name('coldfusion')
                xml.value('false')
              }
            }
            xml.performance{
              xml.bandwidth('-1')
              xml.max_connections('-1')
            }
            xml.permissions{
              xml.permission{
                xml.name('create_domains')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_phosting')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_php_settings')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_sh_access')
                xml.value('false')
              }
              #xml.permission{
              #  xml.name('manage_not_chroot_shell')
              #  xml.value('false')
              #}
              xml.permission{
                xml.name('manage_quota')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_subdomains')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_domain_aliases')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_log')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_anonftp')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_subftp')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_crontab')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_dns')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_webapps')
                xml.value('false')
              }
              xml.permission{
                xml.name('manage_webstat')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_mail_settings')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_maillists')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_spamfilter')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_virusfilter')
                xml.value('true')
              }
              xml.permission{
                xml.name('allow_local_backups')
                xml.value('true')
              }
              xml.permission{
                xml.name('allow_ftp_backups')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_performance')
                xml.value('false')
              }
              xml.permission{
                xml.name('select_db_server')
                xml.value('false')
              }
              xml.permission{
                xml.name('access_appcatalog')
                xml.value('true')
              }
              xml.permission{
                xml.name('allow_insecure_sites')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_website_maintenance')
                xml.value('true')
              }
              xml.permission{
                xml.name('manage_protected_dirs')
                xml.value('true')
              }
              xml.permission{
                xml.name('access_service_users')
                xml.value('true')
              }
              xml.permission{
                xml.name('allow_license_stubs')
                xml.value('false')
              }
            }
          }
        }
      }
      puts xml.target!
      return xml.target!
    end


  end
end