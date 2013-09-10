module PleskKit

  class PleskRunSheet < ActiveRecord::Base

    # In Order!

    def create_account
=begin
      <packet version="1.6.3.0">
        <customer>
          <add>
             <gen_info>
                 <cname>LogicSoft Ltd.</cname>
                 <pname>Stephen Lowell</pname>
                 <login>stevelow</login>
                 <passwd>Jhtr66fBB</passwd>
                 <status>0</status>
                 <phone>416 907 9944</phone>
                 <fax>928 752 3905</fax>
                 <email>host@logicsoft.net</email>
                 <address>105 Brisbane Road, Unit 2</address>
                 <city>Toronto</city>
                 <state/>
                 <pcode/>
                 <country>CA</country>
             </gen_info>
          </add>
        </customer>
      </packet>

      RESPONSE

      <packet version="1.6.3.0">
        <customer>
          <add>
            <result>
              <status>ok</status>
              <id>6</id>
              <guid>d7914f79-d089-4db1-b506-4fac617ebd60</guid>
            </result>
          </add>
        </customer>
      </packet>

=end
    end

    def upgrade_customer_to_reseller
=begin
  <packet version ="1.6.3.0">
    <customer>
       <convert-to-reseller>
          <filter>
             <owner-login>JDoe</owner-login>
          </filter>
       </convert-to-reseller>
    </customer>
  </packet>


  RESPONSE

  <packet version="1.6.3.0">
    <customer>
       <convert-to-reseller>
           <result>
              <status>ok</status>
              <filter-id>JDoe</filter-id>
              <id>192</id>
           </result>
       </convert-to-reseller>
    </customer>
  </packet>


=end
    end

    def add_staff_member_to_account     # HOW THE FUCK DO I DO THAT? THANK YOU PLESK DOCS...

    end

    def create_subscription_from_service_plan
=begin
  <packet version="1.6.3.0">
    <webspace>
      <add>
         <gen_setup>
            <name>example.com</name>
            <htype>vrt_hst</htype>
            <ip_address>192.0.2.123</ip_address>
            <status>0</status>
         </gen_setup>
         <hosting>
            <vrt_hst>
              <property>
                <name>ssl</name>
                <value>false</value>
              </property>
              <ip_address>192.0.2.123</ip_address>
            </vrt_hst>
         </hosting>
         <plan-name>base_template</plan-name>
      </add>
    </webspace>
  </packet>


  RESPONSE


  <packet version="1.6.3.0">
    <webspace>
      <add>
        <result>
          <status>ok</status>
          <id>6</id>
          <guid>5c0e3881-22a2-4401-bcc0-881d691bfdef</guid>
        </result>
      </add>
    </webspace>
  </packet>


=end
    end

  end
end