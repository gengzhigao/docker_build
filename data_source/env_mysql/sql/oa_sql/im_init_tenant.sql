update tig_pairs set pval = concat('<vhost anon=\"true\" owner=\"admin@localhost\" register=\"true\" enabled=\"true\" tls-required=\"false\" max-users=\"0\" hostname=\"1846:eportal\" domain-filter=\"ALL\"><comps/><other/></vhost>',pval) where pkey = 'vhosts-lists';