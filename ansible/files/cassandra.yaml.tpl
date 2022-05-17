cluster_name: 'sys8'
num_tokens: 32
seed_provider:
  - class_name: org.apache.cassandra.locator.SimpleSeedProvider
    parameters:
         - seeds: "10.0.2.149,10.0.2.142,10.0.2.50"

rpc_address: {{ ansible_default_ipv4.address }}
endpoint_snitch: GossipingPropertyFileSnitch
commitlog_sync: periodic
commitlog_sync_period_in_ms: 10000

data_file_directories:
    - /var/lib/cassandra/data
commitlog_directory: /var/lib/cassandra/commitlog
saved_caches_directory: /var/lib/cassandra/saved_caches


# initial_token: -9219205951966861128, -8938945219381722546, -8914653441857733794, -8889559815985744060, -8835268928907713044, -8630802937815712099, -8627926848793389929, -8585985739102463287, -8519830241832404894, -8480117434543643258, -8397422824165934033, -8286579172925944190, -8196496924138271363, -8083594394529266683, -7988699927311699847, -7950263824907681918, -7919381843348142089, -7831326306498565098, -7558985962950938263, -7557510474014371825, -7520531743387603561, -7345675124287782481, -7199123384477070556, -7177663599719266975, -7159043414402803568, -7032287125104846054, -6789218050867041175, -6738744243744181054, -6707907348935200325, -6698415934066941674, -6629214179077054343, -6628149364963162775, -6613576480171332482, -6591094971314115446, -6566459184155346355, -6477535579409250845, -6449384342189745914, -6435454020271146950, -6396882495548196704, -6255584988537963091, -6066965667086361776, -6041603066496337448, -5979839898670510542, -5865151030132196240, -5790753218179272089, -5749214971780919106, -5694919289376994726, -5682099238439574802, -5485908965466948090, -5438235527564361048, -5308634964581982696, -5295238886138636559, -5241918299936831440, -5187953056101458867, -5016587246164618885, -5008066042221336265, -4939589269078441577, -4850787825178468740, -4794951102832198402, -4534392006008823106, -4531065859385798947, -4349335784217011425, -4304378937350973785, -4209958467887099124, -4187788189925199472, -4161738725045999986, -4098460377507486714, -4000219976582503394, -3966220918142086502, -3965291191040363120, -3950389228337608175, -3935879221674263885, -3901631124581750800, -3883284389667471015, -3767524785046095537, -3734688209005570490, -3668236282156683128, -3645579838750984778, -3479605753239695869, -3469971114931744095, -3349408699968211392, -3347687397062480536, -3266875749060005881, -3187119079598436301, -3094929101172692862, -2963642052262603760, -2946310300267296771, -2919630859468755969, -2868131557723329444, -2866758417452581343, -2721760145633652755, -2699680617584710037, -2655253851827633157, -2582070900510378062, -2519716867511921070, -2510345636162218674, -2394799440970120195, -2368042447433139375, -2253717855977397458, -2157230314311782254, -2115974130692004718, -2091326026207294999, -2034135134758057802, -1962811435902092240, -1880060691817567177, -1785785254764776810, -1755366527336274349, -1748727364474869099, -1531437065631505446, -1413155670318003017, -1358271950056765650, -1168911589937004814, -1085073245552486320, -969350691659986536, -956145231442657313, -893122090726197954, -836160208230353948, -812137367013206179, -741888889068746165, -676941554348550441, -638276392173884350, -629459861247015159, -615758270470367205, -590065974226409035, -558259688271861269, -547473295556689030, -526746409253276917, -452177060188233494, -424102781382672937, -401730617054423019, -317181687819446720, -297745506780300684, -251462247408491774, -249633955665367070, -205900151673878548, -175867825843485017, -174521457559651196, -171678413383787504, -109378161187741628, -19286303958603329, 1255530378120962, 47673871696434036, 501253315561004001, 527282985349979369, 540159234062098629, 624495063599017647, 757576088659615908, 794432647928098674, 838284133506992978, 849433472406620196, 861867335073260607, 908895631420114467, 1138350930862357486, 1191914731174251776, 1229584607386120939, 1269728886336711679, 1336055449321132528, 1422161981425550081, 1468866472203465253, 1475568074313188079, 1503214863013627135, 1510602388699892865, 1634377229962296189, 1665107885994695332, 1698074334779161607, 1716902906070504693, 1741350295891077230, 1781461334057321434, 1804483601079416677, 1826210979595736584, 1981625294210180104, 2017092701362064001, 2085666612830432406, 2091888877272812190, 2212699098296495241, 2319803912079346960, 2541709130489718400, 2602533274547879954, 2816311102154442722, 2938015979199119956, 3025876403029141594, 3080259427565923367, 3175494266765288543, 3261511974909558193, 3283699138989915855, 3444855838500094994, 3612260408231098378, 3809874545042456944, 3812084967452292044, 3848594064680829503, 4060016180831853279, 4069093093177190436, 4077452297148402263, 4117900491381807852, 4169762580731761409, 4210603140319763766, 4218957494461393512, 4220129823960746794, 4370314981278684097, 4400082962124820690, 4457830650278576739, 4527063113078777516, 4660180847567881282, 4821574501108856942, 4856327969696556630, 4893309070111049304, 5179700651257627912, 5209059497027548480, 5245927797664659135, 5411381147573437246, 5660589606725003210, 5689913344941473282, 5690646956758513468, 5745031614259011492, 5758930761830005737, 5762417510371601486, 5791798743361183229, 5882420303446978399, 5917147113428390578, 6198103198288002105, 6295215946383008297, 6420676383493643599, 6424869729797577092, 6458808585897695270, 6562298510967475041, 6588477626089428762, 6609521044689815994, 6632916635250923763, 6698245209722558603, 6748073595744835489, 6766268184010445284, 6853038880042968307, 7114576795756168772, 7160748182497625484, 7338203722104901830, 7373231412173699714, 7665688152817659631, 7904491089810592213, 8047341469152931940, 8049552707293279886, 8076270337058876327, 8097842027691752224, 8162371191832692999, 8188721319877506885, 8251143995328326408, 8279466003564151498, 8289899989467329810, 8334967353692095452, 8602769997989401391, 8612849832372050831, 8649500919682328790, 8698826021187273181, 8900907827857398332, 8978366030553002817, 9161275921273437223, 9205705306887508350
hints_directory: /var/lib/cassandra/hints
authenticator: AllowAllAuthenticator
authorizer: AllowAllAuthorizer
role_manager: CassandraRoleManager
partitioner: org.apache.cassandra.dht.Murmur3Partitioner
prepared_statements_cache_size_mb:
thrift_prepared_statements_cache_size_mb:
key_cache_size_in_mb:
counter_cache_size_in_mb:

index_summary_capacity_in_mb:
listen_address: {{ ansible_default_ipv4.address }}
request_scheduler: org.apache.cassandra.scheduler.NoScheduler
back_pressure_strategy:


