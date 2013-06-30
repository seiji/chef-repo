case node['platform']
when "macosx"
  # TODO: install via homebrew
else
  znc_pkgs = value_for_platform(
                                [ "debian","ubuntu" ] => {
                                  "default" => %w{ znc znc-dev znc-extra }# znc-webadmin}
                                },
                                [ "centos","redhat" ] => {
                                  "default" => %w{ znc }
                                },
                                "default" => %w{ znc znc-dev znc-extra }
                                )

  znc_pkgs.each do |pkg|
    package pkg do
      action :install
    end
  end
end
