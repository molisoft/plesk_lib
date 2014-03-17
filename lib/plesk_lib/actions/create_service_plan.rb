class PleskLib::Actions::CreateServicePlan < PleskLib::Actions::Base
  attr_reader :service_plan, :guid, :plesk_id

  def initialize(service_plan)
    @service_plan = service_plan
  end

  def build_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
      xml.packet(:version => '1.6.3.0') {
        xml.tag!("service-plan")  {
          xml.add {
            xml.name("#{service_plan.name}")
            if service_plan.owner_id.present?
              xml.tag!('owner-id', service_plan.owner_id)
            end
            xml.mail{
              xml.webmail('horde')
            }
            xml.limits{
              xml.overuse('block')

              xml.limit{
                xml.name('max_site')
                xml.value("#{service_plan.domains.to_s}")
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
                xml.value("#{service_plan.storage.to_s}") #10gb
              }
              xml.limit{
                xml.name('disk_space_soft')
                xml.value('0')
              }
              xml.limit{
                xml.name('max_traffic')
                xml.value("#{service_plan.traffic.to_s}") # unlimited
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
                xml.value('-1')
              }
              xml.limit{
                xml.name('max_box')
                xml.value("#{service_plan.mailboxes.to_s}") # mailboxes
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
              # xml.limit{
              #   xml.name('upsell_site_builder')
              #   xml.value('0')
              # }

            }
            xml.tag!("log-rotation"){
            xml.on{
                xml.tag!("log-condition"){
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

            if service_plan.external_id.present?
              xml.tag!('external-id', service_plan.external_id)
            end
          }
        }
      }
      return xml.target!
  end

  def analyse(xml_document)
    add_node = xml_document.root.locate('*/result').first
    @plesk_id = add_node.id.text.to_i
    @guid = add_node.guid.text
  end
end
