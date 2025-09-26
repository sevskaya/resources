Config = {}

Config.DevMode = true

local glm = require "glm"

Config.Zones = {
    {
        name = "annesburg-apple-tree", -- name of the zone
        thickness = 20, -- height
        debug = true, -- debug drawing of the points and walls of the zone
        point = glm.polygon.new(
            {
                vec3(3001.654541015625, 1399.3458251953125, 43.19),
                vec3(2998.39990234375, 1393.282958984375, 43.19),
                vec3(2991.999267578125, 1395.465576171875, 43.19),
                vec3(2994.195556640625, 1401.05322265625, 43.19),
            }
        ),
        objects = {
            {
                model = `p_tree_apple_01`,
                coords = vec3(2996.754638, 1396.794067, 43.584380),
                rotation = vec3(0.000000,0.000000,0.000000),
            },
        },
    },
    {
        name = "portonovomexico",
        thickness = 50,
        debug = false,
        point = glm.polygon.new(
            {
                vec3(-7258.08251953125, -5304.06201171875, -29.23337173461914),
                vec3(-7071.80322265625, -5287.41748046875, -30.3470344543457),
                vec3(-7081.7578125, -5129.6103515625, -31.35990524291992),
                vec3(-7350.18798828125, -5160.4306640625, 1.57678341865539),
            }
        ),
        objects = {
            {
                model = `khfish1`,
                coords = vec3(-7171.261230,-5234.935547,-31.635132),
                rotation = vec3(0.000000,0.000000,-0.621630),
            },
            {
                model = `khfish2`,
                coords = vec3(-7164.865723,-5265.332031,-31.101318),
                rotation = vec3(0.000000,0.000000,0.261873),
            },
            {
                model = `khfish14`,
                coords = vec3(-7160.106934,-5165.152344,-28.939135),
                rotation = vec3(1.130359,0.416795,-45.626801),
            },
            {
                model = `khfish2`,
                coords = vec3(-7164.321289,-5205.866211,-31.114702),
                rotation = vec3(0.000000,0.000000,-179.737381),
            },
            {
                model = `khfish9`,
                coords = vec3(-7181.380371,-5202.361328,-31.725985),
                rotation = vec3(0.000000,0.000000,-0.048070),
            },
            {
                model = `khfish12`,
                coords = vec3(-7162.076172,-5195.036621,-35.500343),
                rotation = vec3(0.000000,0.000000,-90.894577),
            },
            {
                model = `khfish1`,
                coords = vec3(-7170.344238,-5177.300293,-31.618773),
                rotation = vec3(0.000000,0.000000,-0.621621),
            },
            {
                model = `khfish1`,
                coords = vec3(-7170.514648,-5193.075195,-31.647469),
                rotation = vec3(0.000000,0.000000,-0.621627),
            },
            {
                model = `khfish1`,
                coords = vec3(-7171.209961,-5227.047363,-31.642378),
                rotation = vec3(0.000000,0.000000,-0.621629),
            },
            {
                model = `khfish4`,
                coords = vec3(-7167.708496,-5244.107910,-27.497938),
                rotation = vec3(0.000000,0.000000,-90.576836),
            },
            {
                model = `khfish1`,
                coords = vec3(-7170.449707,-5185.193848,-31.634222),
                rotation = vec3(0.000000,0.000000,-0.621626),
            },
            {
                model = `khfish1`,
                coords = vec3(-7171.106934,-5219.180176,-31.644985),
                rotation = vec3(0.000000,0.000000,-0.621627),
            },
        },
    },
    {
        name = "Cidadeescalerav1", -- name of the zone
        thickness = 50, -- height
        debug = false, -- debug drawing of the points and walls of the zone
        point = glm.polygon.new(
            {
                vec3(-5986.520, -4307.163, 8.574),                    
                vec3(-5670.475, -4754.449, -9.935),                  
                vec3(-5430.327, -4380.197, -23.183),            
                vec3(-5745.250, -4129.499, -20.070),              
            }
        ),
        objects = {
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5759.266602,-4459.028809,12.088366),
                rotation = vec3(0.000000,0.000000,-60.999939),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5803.983887,-4462.979980,11.979523),
                rotation = vec3(0.000000,0.000000,-76.999878),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5765.972168,-4461.065918,12.204407),
                rotation = vec3(0.000000,0.000000,-28.999971),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5731.502930,-4412.511230,11.983364),
                rotation = vec3(-0.257198,3.977500,175.705536),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5743.099121,-4445.171875,12.049894),
                rotation = vec3(0.000000,0.000000,29.999968),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5774.427734,-4409.881836,11.681174),
                rotation = vec3(0.000000,0.000000,-80.999863),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5796.497559,-4462.402344,11.755207),
                rotation = vec3(0.000000,0.000000,-28.999958),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5812.303223,-4440.728516,12.195902),
                rotation = vec3(0.000000,0.000000,-115.999474),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5812.207031,-4433.048828,11.988005),
                rotation = vec3(0.000000,0.000000,7.999999),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5782.117676,-4409.631836,12.156764),
                rotation = vec3(0.000000,0.000000,144.999237),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5803.876465,-4409.376953,11.745497),
                rotation = vec3(0.000000,0.000000,-78.999527),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5736.830078,-4431.384766,12.059455),
                rotation = vec3(0.000000,0.000000,37.000134),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5752.190430,-4456.210449,11.919754),
                rotation = vec3(0.000000,0.000000,3.000002),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5732.633789,-4417.551758,12.354036),
                rotation = vec3(0.000000,0.000000,42.000118),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5743.974121,-4406.609863,11.670717),
                rotation = vec3(0.000000,0.000000,-66.999901),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5758.964355,-4409.128418,11.655991),
                rotation = vec3(0.000000,0.000000,-73.999794),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5810.945801,-4409.529297,11.975101),
                rotation = vec3(0.000000,0.000000,-118.999336),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5811.467773,-4417.376465,12.066935),
                rotation = vec3(0.000000,0.000000,5.999972),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5781.136230,-4461.785156,12.169984),
                rotation = vec3(0.000000,0.000000,-27.999973),
            },
            {
                model = `concretewallgate`,
                coords = vec3(-5811.816406,-4460.012207,11.609154),
                rotation = vec3(0.000000,0.000000,-120.999634),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5788.935059,-4462.263672,12.049700),
                rotation = vec3(0.000000,0.000000,-76.999878),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5734.498047,-4424.539062,11.830694),
                rotation = vec3(0.000000,0.000000,-6.000000),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5811.865234,-4425.016602,12.232644),
                rotation = vec3(0.000000,0.000000,-117.999557),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5789.525391,-4409.436523,11.703129),
                rotation = vec3(0.000000,0.000000,-80.999794),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5739.664062,-4438.400879,11.769726),
                rotation = vec3(0.000000,0.000000,-13.999990),
            },
            {
                model = `concretewallgate`,
                coords = vec3(-5732.916016,-4405.196289,11.744237),
                rotation = vec3(0.000000,0.000000,-36.999847),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5751.407715,-4408.396484,11.838772),
                rotation = vec3(0.000000,0.000000,167.000397),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5747.504395,-4450.619141,11.998426),
                rotation = vec3(0.000000,0.000000,150.000473),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5812.195801,-4448.380371,11.858131),
                rotation = vec3(0.000000,0.000000,-167.999237),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5766.595703,-4409.934082,12.021234),
                rotation = vec3(0.000000,0.000000,150.000488),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5797.183594,-4409.309570,11.668640),
                rotation = vec3(0.000000,0.000000,144.000412),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5773.488281,-4461.583984,12.080831),
                rotation = vec3(0.000000,0.000000,-76.999870),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5721.604980,-4579.152832,-11.854496),
                rotation = vec3(0.000000,0.000000,135.000320),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5727.542969,-4573.260254,-12.284394),
                rotation = vec3(0.000000,0.000000,136.000336),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5697.209961,-4549.380859,-12.343828),
                rotation = vec3(0.000000,0.000000,78.999825),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5682.605957,-4486.920410,-8.035023),
                rotation = vec3(0.000000,0.000000,55.999813),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5689.739746,-4530.779297,-12.364639),
                rotation = vec3(0.000000,0.000000,-102.999756),
            },
            {
                model = `gua_rock_06`,
                coords = vec3(-5693.499512,-4421.829102,-12.492485),
                rotation = vec3(47.876385,-10.495395,-174.388168),
            },
            {
                model = `gua_rock_06`,
                coords = vec3(-5689.100098,-4420.602539,-13.582840),
                rotation = vec3(0.498578,-17.288725,-177.388916),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5688.481445,-4495.981934,-7.947044),
                rotation = vec3(0.000000,0.000000,56.999947),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5781.987793,-4535.476074,-6.432623),
                rotation = vec3(-16.845232,4.229920,57.479401),
            },
            {
                model = `house7`,
                coords = vec3(-5696.203613,-4463.262207,-0.928105),
                rotation = vec3(0.000000,0.000000,48.999954),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5752.760742,-4493.533691,-3.942702),
                rotation = vec3(0.000000,0.000000,56.999947),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5721.401367,-4511.678711,-8.164798),
                rotation = vec3(0.000000,0.000000,25.999941),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5737.000977,-4509.726562,-8.494603),
                rotation = vec3(0.000000,0.000000,29.000265),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5703.767578,-4546.534180,-12.352366),
                rotation = vec3(0.000000,0.000000,-11.999992),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5687.629883,-4447.646973,-5.089558),
                rotation = vec3(0.000000,0.000000,96.999878),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5704.954590,-4551.728516,-12.363055),
                rotation = vec3(0.000000,0.000000,-11.000496),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5673.622070,-4467.950684,-8.036696),
                rotation = vec3(0.000000,0.000000,105.999725),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5702.974121,-4513.689941,-8.160994),
                rotation = vec3(0.000000,0.000000,6.999993),
            },
            {
                model = `p_val_aucgate1m01x_h`,
                coords = vec3(-5696.426270,-4565.351562,-11.926041),
                rotation = vec3(0.000000,0.000000,-119.999779),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5729.551758,-4571.327637,-12.365856),
                rotation = vec3(0.000000,0.000000,136.000336),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5673.390625,-4462.606934,-8.078998),
                rotation = vec3(0.000000,0.000000,60.000046),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5728.624023,-4515.889160,-8.469635),
                rotation = vec3(0.000000,0.000000,21.999943),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5742.799805,-4508.119141,-8.389269),
                rotation = vec3(0.000000,0.000000,-59.999924),
            },
            {
                model = `store5_1`,
                coords = vec3(-5674.910645,-4448.256836,-5.583919),
                rotation = vec3(0.000000,0.000000,-26.998295),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5707.508789,-4583.359863,-11.432666),
                rotation = vec3(0.000000,0.000000,-135.999496),
            },
            {
                model = `mx3`,
                coords = vec3(-5693.299316,-4504.775391,-9.598164),
                rotation = vec3(0.000000,0.000000,163.000595),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5697.734863,-4552.117676,-12.340184),
                rotation = vec3(0.000000,0.000000,78.999825),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5735.554688,-4563.551270,-12.639327),
                rotation = vec3(0.000000,-0.999984,43.999863),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5754.456543,-4484.212891,-2.397754),
                rotation = vec3(21.999983,0.000000,18.479986),
            },
            {
                model = `k_h_house_08`,
                coords = vec3(-5745.370117,-4494.587402,-3.104899),
                rotation = vec3(0.000000,0.000000,-148.806519),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5723.559082,-4577.173340,-12.034466),
                rotation = vec3(0.000000,0.000000,134.000443),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5717.666016,-4479.056152,-4.090262),
                rotation = vec3(0.000000,0.000000,-142.000427),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5707.718750,-4551.182617,-12.428185),
                rotation = vec3(0.000000,0.000000,-11.000496),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5717.652832,-4583.102051,-11.551374),
                rotation = vec3(0.000000,0.000000,135.000320),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5729.634277,-4557.599121,-12.509342),
                rotation = vec3(0.000000,0.000000,45.480549),
            },
            {
                model = `k_h_house_10`,
                coords = vec3(-5750.594238,-4479.584473,1.250860),
                rotation = vec3(0.000000,0.000000,25.999899),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5672.979004,-4473.317871,-7.943180),
                rotation = vec3(0.000000,0.000000,71.999878),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5763.011719,-4501.821777,-6.113413),
                rotation = vec3(-31.999756,-10.001162,37.480072),
            },
            {
                model = `p_val_aucgate1m01x_post`,
                coords = vec3(-5672.368652,-4455.757324,-9.235083),
                rotation = vec3(0.000000,0.000000,7.999995),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5700.644043,-4475.743164,-6.597610),
                rotation = vec3(0.569615,-27.640722,78.999664),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5674.299316,-4475.730957,-7.875115),
                rotation = vec3(0.000000,0.000000,51.999947),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5722.685547,-4483.702148,-4.054224),
                rotation = vec3(0.000000,0.000000,-57.999908),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5688.345215,-4455.969727,-4.966942),
                rotation = vec3(0.000000,0.000000,81.999832),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5742.278809,-4488.550293,-4.096033),
                rotation = vec3(0.000000,0.000000,-61.999992),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5687.976562,-4444.901855,-5.161540),
                rotation = vec3(0.000000,0.000000,99.000275),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5702.624023,-4547.944336,-12.351561),
                rotation = vec3(0.000000,0.000000,78.999825),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5756.168457,-4499.043945,-8.045373),
                rotation = vec3(-15.999971,0.000000,-18.872723),
            },
            {
                model = `fortm`,
                coords = vec3(-5780.427734,-4433.072266,7.884390),
                rotation = vec3(0.000000,0.000000,-89.137474),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5731.614258,-4559.617676,-12.499342),
                rotation = vec3(0.000000,0.000000,45.480549),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5713.317383,-4510.085938,-8.138849),
                rotation = vec3(0.000000,0.000000,-12.999916),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5706.482422,-4545.943848,-12.352366),
                rotation = vec3(0.000000,0.000000,-11.999992),
            },
            {
                model = `store1`,
                coords = vec3(-5687.480957,-4486.062500,-6.492456),
                rotation = vec3(0.000000,0.000000,162.000885),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5672.246094,-4457.218262,-8.017582),
                rotation = vec3(0.000000,0.000000,95.999687),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5692.830078,-4548.885742,-12.222507),
                rotation = vec3(0.000000,0.000000,-11.999537),
            },
            {
                model = `k_h_house_09`,
                coords = vec3(-5789.254883,-4491.311523,0.211222),
                rotation = vec3(0.000000,0.000000,23.999960),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5701.035156,-4547.124512,-12.345800),
                rotation = vec3(0.000000,0.000000,-11.999992),
            },
            {
                model = `alp_rock_01`,
                coords = vec3(-5786.034668,-4495.274902,-3.524745),
                rotation = vec3(32.578606,4.056072,-19.359310),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5734.572266,-4508.337402,-8.494603),
                rotation = vec3(0.000000,0.000000,31.000093),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5739.493652,-4511.124512,-8.494603),
                rotation = vec3(0.000000,0.000000,29.000265),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5687.170898,-4519.749512,-12.368452),
                rotation = vec3(0.000000,0.000000,-102.999756),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5672.900391,-4470.673828,-8.050508),
                rotation = vec3(0.000000,0.000000,104.999748),
            },
            {
                model = `stall14-1`,
                coords = vec3(-5722.561523,-4546.574707,-8.372959),
                rotation = vec3(0.000000,0.000000,-46.169727),
            },
            {
                model = `gua_rock_06`,
                coords = vec3(-5683.047363,-4428.072266,-12.613478),
                rotation = vec3(1.658633,-9.980223,-48.387581),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5712.896973,-4476.383789,-4.208106),
                rotation = vec3(0.000000,0.000000,-170.999207),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5715.410156,-4477.386719,-4.199386),
                rotation = vec3(0.000000,0.000000,-144.999451),
            },
            {
                model = `p_val_aucgate1m01x_h`,
                coords = vec3(-5698.666016,-4570.756836,-11.900822),
                rotation = vec3(0.000000,0.000000,65.999947),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5705.528320,-4581.374512,-11.430544),
                rotation = vec3(0.000000,0.000000,-132.999451),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5703.192383,-4550.715820,-12.353847),
                rotation = vec3(0.000000,0.000000,78.999825),
            },
            {
                model = `gua_rock_04`,
                coords = vec3(-5764.325684,-4513.350586,-5.673985),
                rotation = vec3(20.999937,-3.999984,2.450669),
            },
            {
                model = `p_val_aucgate1m01x_post`,
                coords = vec3(-5696.398438,-4565.288086,-12.189626),
                rotation = vec3(0.000000,0.000000,-26.999969),
            },
            {
                model = `house11`,
                coords = vec3(-5727.391602,-4502.301270,-5.318903),
                rotation = vec3(0.000000,0.000000,32.000004),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5705.687988,-4513.440430,-8.130291),
                rotation = vec3(0.000000,0.000000,-16.999960),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5746.764648,-4480.255371,-2.326919),
                rotation = vec3(24.999979,0.000000,25.480099),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5693.062500,-4556.028320,-11.537894),
                rotation = vec3(0.000000,0.000000,-99.999702),
            },
            {
                model = `alp_rock_01`,
                coords = vec3(-5688.592285,-4501.014648,-11.142503),
                rotation = vec3(12.466621,-43.412220,-113.669441),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5688.758789,-4458.719238,-4.890793),
                rotation = vec3(0.000000,0.000000,82.999809),
            },
            {
                model = `p_val_aucgate1m01x_post`,
                coords = vec3(-5696.401855,-4565.274414,-10.085402),
                rotation = vec3(0.000000,0.000000,-26.999969),
            },
            {
                model = `k_h_house_03`,
                coords = vec3(-5779.160645,-4476.820312,0.443202),
                rotation = vec3(0.000000,0.000000,15.999967),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5759.217773,-4498.565430,-3.804086),
                rotation = vec3(0.000000,0.000000,23.999947),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5761.227051,-4502.728516,-7.061909),
                rotation = vec3(0.000000,0.000000,-18.872805),
            },
            {
                model = `k_p_pier_06`,
                coords = vec3(-5746.663086,-4492.793945,-4.733916),
                rotation = vec3(0.000000,0.000000,30.999905),
            },
            {
                model = `gua_rock_04`,
                coords = vec3(-5761.905762,-4512.002441,-7.127213),
                rotation = vec3(-20.896229,-54.434490,-153.548157),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5731.562500,-4569.390625,-12.497886),
                rotation = vec3(0.000000,0.000000,136.000336),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5721.394043,-4485.816406,-4.054224),
                rotation = vec3(0.000000,0.000000,-56.998814),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5699.365723,-4572.181152,-11.403998),
                rotation = vec3(0.000000,0.000000,66.000443),
            },
            {
                model = `alp_rock_01`,
                coords = vec3(-5691.292969,-4509.631836,-11.073527),
                rotation = vec3(33.125450,2.687246,143.213943),
            },
            {
                model = `p_gen_glasstallbeer01x`,
                coords = vec3(-5695.449219,-4549.781250,-12.915799),
                rotation = vec3(-4.612734,0.341931,60.798004),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5691.720703,-4550.547852,-11.671468),
                rotation = vec3(0.000000,0.000000,-102.999756),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5692.439453,-4553.295898,-11.598171),
                rotation = vec3(0.000000,0.000000,-103.999718),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5695.625977,-4510.716797,-8.101025),
                rotation = vec3(0.000000,0.000000,59.999924),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5707.649902,-4475.035645,-4.593268),
                rotation = vec3(0.000000,-15.999986,-167.000473),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5708.261719,-4512.380859,-8.136457),
                rotation = vec3(0.000000,0.000000,-27.999960),
            },
            {
                model = `k_p_pier_01`,
                coords = vec3(-5723.556641,-4485.345215,-4.858683),
                rotation = vec3(0.000000,0.000000,-148.053024),
            },
            {
                model = `k_h_house_05`,
                coords = vec3(-5785.528809,-4534.463379,-3.500295),
                rotation = vec3(0.000000,0.000000,86.595985),
            },
            {
                model = `p_val_aucgate1m01x_post`,
                coords = vec3(-5749.640137,-4491.004395,-5.135108),
                rotation = vec3(0.000000,0.000000,-58.999882),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5720.162109,-4480.183105,-4.095337),
                rotation = vec3(0.000000,0.000000,-169.000748),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5674.037109,-4465.239746,-8.038307),
                rotation = vec3(0.000000,0.000000,93.999672),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5744.235840,-4487.860840,-3.991816),
                rotation = vec3(0.000000,0.000000,26.999954),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5713.692383,-4587.041504,-11.491545),
                rotation = vec3(0.000000,0.000000,135.000320),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5688.448242,-4525.225586,-12.368509),
                rotation = vec3(0.000000,0.000000,-102.999756),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5733.562988,-4567.447266,-12.599344),
                rotation = vec3(0.000000,0.000000,136.000336),
            },
            {
                model = `k_s_stairs_010`,
                coords = vec3(-5753.710449,-4500.966797,-7.288333),
                rotation = vec3(0.000000,0.000000,30.999960),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5731.217285,-4516.753418,-8.476044),
                rotation = vec3(0.000000,0.000000,14.999990),
            },
            {
                model = `gua_rock_06`,
                coords = vec3(-5687.552734,-4404.185059,-7.263239),
                rotation = vec3(16.016819,-9.937533,-144.387573),
            },
            {
                model = `k_h_house_06`,
                coords = vec3(-5797.369141,-4535.620117,1.871980),
                rotation = vec3(0.000000,0.000000,176.000305),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5700.067383,-4473.353516,-5.416862),
                rotation = vec3(0.381908,-17.594868,76.999680),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5678.033203,-4479.879395,-7.861639),
                rotation = vec3(0.000000,0.000000,55.999947),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5696.816895,-4469.244141,-4.995649),
                rotation = vec3(0.000000,0.000000,49.999939),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5688.082031,-4453.161133,-5.057734),
                rotation = vec3(0.000000,0.000000,88.999802),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5711.562012,-4587.109375,-11.479163),
                rotation = vec3(0.000000,0.000000,-138.999664),
            },
            {
                model = `mx4`,
                coords = vec3(-5734.283691,-4488.964355,-4.744874),
                rotation = vec3(0.000000,0.000000,-147.999649),
            },
            {
                model = `p_foundationwood03x`,
                coords = vec3(-5711.043457,-4435.690918,-5.199983),
                rotation = vec3(0.000000,0.000000,0.000000),
            },
            {
                model = `whitehouse`,
                coords = vec3(-5695.872559,-4432.617676,-5.092286),
                rotation = vec3(0.000000,0.000000,-0.999982),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5672.389648,-4459.999023,-8.063011),
                rotation = vec3(0.000000,0.000000,79.999870),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5793.520020,-4533.985840,-0.555920),
                rotation = vec3(-16.619877,1.020305,64.478523),
            },
            {
                model = `ntc_wall05`,
                coords = vec3(-5781.791992,-4514.630371,-4.903991),
                rotation = vec3(8.999998,0.000000,85.000351),
            },
            {
                model = `p_val_aucgate1m01x_post`,
                coords = vec3(-5698.713867,-4570.830566,-12.102110),
                rotation = vec3(0.000000,0.000000,-27.999956),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5694.715332,-4561.376465,-11.466202),
                rotation = vec3(0.000000,0.000000,-110.999649),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5784.433594,-4532.417480,-6.060089),
                rotation = vec3(-29.999914,-4.999990,23.479540),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5733.573730,-4561.584961,-12.499317),
                rotation = vec3(0.000000,0.000000,45.480549),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5715.644043,-4585.092773,-11.454080),
                rotation = vec3(0.000000,0.000000,135.000320),
            },
            {
                model = `p_val_aucgate1m01x_post`,
                coords = vec3(-5698.704102,-4570.822754,-9.987755),
                rotation = vec3(0.000000,0.000000,-26.999954),
            },
            {
                model = `ntc_wall06`,
                coords = vec3(-5775.505859,-4515.279297,-5.270018),
                rotation = vec3(0.000000,0.000000,-5.999992),
            },
            {
                model = `mx5`,
                coords = vec3(-5684.338867,-4508.549316,-12.744915),
                rotation = vec3(0.000000,0.000000,73.000092),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5725.539551,-4575.189453,-12.165295),
                rotation = vec3(0.000000,0.000000,136.000336),
            },
            {
                model = `ntc_wall05`,
                coords = vec3(-5800.997559,-4506.995605,-2.284061),
                rotation = vec3(-4.999993,7.999971,-4.999993),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5750.579590,-4481.265137,-4.072349),
                rotation = vec3(-76.000137,-160.999100,-139.519440),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5693.768066,-4558.724121,-11.490242),
                rotation = vec3(0.000000,0.000000,-107.999664),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5695.756836,-4563.975586,-11.460187),
                rotation = vec3(0.000000,0.000000,-112.999580),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5689.113770,-4528.057129,-12.368035),
                rotation = vec3(0.000000,0.000000,-102.999756),
            },
            {
                model = `p_dis_ropebridge4`,
                coords = vec3(-5686.574219,-4413.689453,-3.706108),
                rotation = vec3(0.000000,3.000000,-88.999542),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5754.739258,-4495.359375,-3.808065),
                rotation = vec3(0.000000,0.000000,28.999834),
            },
            {
                model = `k_p_pier_06`,
                coords = vec3(-5743.635742,-4497.685547,-4.740046),
                rotation = vec3(0.000000,0.000000,30.999962),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5695.573242,-4548.300293,-12.346070),
                rotation = vec3(0.000000,0.000000,-11.999992),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5733.717285,-4517.900391,-8.465422),
                rotation = vec3(0.000000,0.000000,33.999939),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5710.724121,-4511.069824,-8.129906),
                rotation = vec3(0.000000,0.000000,-27.999960),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5687.733887,-4450.324707,-5.042784),
                rotation = vec3(0.000000,0.000000,79.999863),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5726.156738,-4514.588379,-8.370265),
                rotation = vec3(0.000000,0.000000,33.999981),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5700.218750,-4513.349121,-8.178910),
                rotation = vec3(0.000000,0.000000,6.999997),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5718.771973,-4510.750977,-8.166785),
                rotation = vec3(0.000000,0.000000,12.999990),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5705.750000,-4475.752930,-5.801620),
                rotation = vec3(11.999999,-23.999910,133.000366),
            },
            {
                model = `gua_rock_06`,
                coords = vec3(-5690.105957,-4406.658203,-7.924235),
                rotation = vec3(35.714001,153.401703,11.612447),
            },
            {
                model = `p_val_aucgate1m01x_post`,
                coords = vec3(-5745.464355,-4488.466309,-5.142312),
                rotation = vec3(0.000000,0.000000,-58.999882),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5722.461914,-4481.483398,-4.102901),
                rotation = vec3(0.000000,0.000000,-131.000092),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5756.968262,-4497.014648,-3.813359),
                rotation = vec3(0.000000,0.000000,44.999889),
            },
            {
                model = `p_foundationwood03x`,
                coords = vec3(-5678.217773,-4454.352051,-9.473454),
                rotation = vec3(0.000000,0.000000,17.999826),
            },
            {
                model = `ntc_wall05`,
                coords = vec3(-5794.844727,-4513.583496,-2.750004),
                rotation = vec3(8.999993,0.000000,85.999954),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5689.861328,-4498.426270,-7.948566),
                rotation = vec3(0.000000,0.000000,64.999870),
            },
            {
                model = `k_s_stairs_011`,
                coords = vec3(-5753.903809,-4497.244629,-5.455406),
                rotation = vec3(0.000000,0.000000,30.999960),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5698.719238,-4471.249023,-4.976637),
                rotation = vec3(0.000000,0.000000,42.999924),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5697.583984,-4512.548828,-8.296776),
                rotation = vec3(0.000000,0.000000,26.999969),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5723.820312,-4513.057129,-8.149789),
                rotation = vec3(0.000000,0.000000,32.999866),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5703.679199,-4579.278320,-11.424696),
                rotation = vec3(0.000000,0.000000,-128.999405),
            },
            {
                model = `p_val_aucgate1m01x_post`,
                coords = vec3(-5688.167969,-4443.486816,-6.362947),
                rotation = vec3(0.000000,0.000000,10.999991),
            },
            {
                model = `k_p_pier_01`,
                coords = vec3(-5725.588379,-4486.618164,-4.852591),
                rotation = vec3(0.000000,0.000000,-148.053024),
            },
            {
                model = `gua_rock_06`,
                coords = vec3(-5761.802734,-4507.022461,-8.078630),
                rotation = vec3(15.742583,-15.525441,-79.387939),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5687.189453,-4517.059082,-12.387776),
                rotation = vec3(0.000000,0.000000,-76.999878),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5785.278320,-4537.153809,-6.007071),
                rotation = vec3(-32.558296,-5.527464,22.479610),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5709.500977,-4585.228027,-11.451163),
                rotation = vec3(0.000000,0.000000,-136.999466),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5735.571289,-4565.503906,-12.607965),
                rotation = vec3(0.000000,0.000000,136.000336),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5735.797363,-4519.777832,-8.369631),
                rotation = vec3(0.000000,0.000000,49.999977),
            },
            {
                model = `p_val_aucgate1m01x`,
                coords = vec3(-5696.492676,-4565.452637,-11.982856),
                rotation = vec3(0.000000,0.000000,-111.261993),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5719.617188,-4581.118652,-11.644471),
                rotation = vec3(0.000000,0.000000,135.000320),
            },
            {
                model = `mp004_s_gallowsstairs02x`,
                coords = vec3(-5795.092773,-4507.982910,-3.132180),
                rotation = vec3(0.000000,0.000000,84.999924),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5709.009766,-4546.421387,-12.351171),
                rotation = vec3(0.000000,0.000000,35.000744),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5702.007812,-4577.014648,-11.409323),
                rotation = vec3(0.000000,0.000000,-122.999298),
            },
            {
                model = `p_val_aucgate1m01x`,
                coords = vec3(-5698.620605,-4570.645996,-11.957963),
                rotation = vec3(0.000000,0.000000,65.996857),
            },
            {
                model = `gua_rock_06`,
                coords = vec3(-5687.944336,-4422.828125,-10.152608),
                rotation = vec3(-4.999771,157.999130,161.612137),
            },
            {
                model = `k_s_stairs_010`,
                coords = vec3(-5686.593750,-4402.433105,-4.122007),
                rotation = vec3(0.000000,0.000000,0.000000),
            },
            {
                model = `schoolhouse`,
                coords = vec3(-5765.978516,-4505.220215,-1.018912),
                rotation = vec3(0.000000,0.000000,125.000183),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5727.659668,-4555.592773,-12.509342),
                rotation = vec3(0.000000,0.000000,45.480549),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5710.187012,-4475.716797,-4.207806),
                rotation = vec3(0.000000,0.000000,-160.998993),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5698.315430,-4547.713867,-12.350313),
                rotation = vec3(0.000000,0.000000,-11.999992),
            },
            {
                model = `gua_rock_04`,
                coords = vec3(-5762.235352,-4507.577637,-5.691184),
                rotation = vec3(5.119670,-13.060797,-164.548462),
            },
            {
                model = `p_foundationwood03x`,
                coords = vec3(-5696.026855,-4435.660156,-5.230398),
                rotation = vec3(0.000000,0.000000,0.000000),
            },
            {
                model = `gua_rock_06`,
                coords = vec3(-5682.544922,-4422.729492,-13.390952),
                rotation = vec3(-9.664394,9.765554,11.612421),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5687.235352,-4493.495117,-7.934890),
                rotation = vec3(0.000000,0.000000,71.999878),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5679.563477,-4482.186035,-7.970142),
                rotation = vec3(0.000000,0.000000,57.999947),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5687.824219,-4522.494629,-12.368363),
                rotation = vec3(0.000000,0.000000,-102.999756),
            },
            {
                model = `gua_rock_07`,
                coords = vec3(-5753.485352,-4495.933594,-6.957769),
                rotation = vec3(0.999985,0.000000,-18.872387),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5676.181641,-4477.771484,-7.844403),
                rotation = vec3(0.000000,0.000000,42.999969),
            },
            {
                model = `stall13`,
                coords = vec3(-5695.343750,-4536.052734,-9.485356),
                rotation = vec3(0.000000,0.000000,76.999809),
            },
            {
                model = `k_s_stairs_010`,
                coords = vec3(-5686.590332,-4400.815430,-3.194865),
                rotation = vec3(0.000000,0.000000,0.000000),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5700.583984,-4574.608398,-11.394482),
                rotation = vec3(0.000000,0.000000,-117.999657),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5750.844727,-4491.703125,-4.044920),
                rotation = vec3(0.000000,0.000000,30.999897),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5716.057129,-4510.102539,-8.160916),
                rotation = vec3(0.000000,0.000000,14.000005),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5681.076172,-4484.577148,-8.031107),
                rotation = vec3(0.000000,0.000000,57.999908),
            },
            {
                model = `k_s_stairs_011`,
                coords = vec3(-5789.137207,-4536.839844,-0.149906),
                rotation = vec3(0.000000,0.000000,179.000763),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5689.828125,-4461.172852,-4.791102),
                rotation = vec3(0.000000,0.000000,52.999943),
            },
            {
                model = `val_fencepen01_ax`,
                coords = vec3(-5741.399414,-4510.550293,-8.419447),
                rotation = vec3(0.000000,0.000000,-59.999905),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5720.863281,-4486.528320,-4.228128),
                rotation = vec3(0.000000,0.000000,0.000000),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5705.785645,-4437.959961,-5.838122),
                rotation = vec3(0.000000,0.000000,-80.999779),
            },
            {
                model = `mp004_p_mp_gallows_rope01x`,
                coords = vec3(-317.424988,716.122559,115.984070),
                rotation = vec3(-9.986029,11.764963,-174.919174),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5667.515137,-4445.735840,-9.956121),
                rotation = vec3(0.000000,0.000000,27.999950),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5672.389648,-4455.229004,-9.904911),
                rotation = vec3(0.000000,0.000000,-61.999836),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5665.380371,-4452.779785,-10.229445),
                rotation = vec3(0.000000,0.000000,80.000053),
            },
            {
                model = `p_val_aucgate1m01x_post`,
                coords = vec3(-5672.368652,-4455.757324,-9.235083),
                rotation = vec3(0.000000,0.000000,7.999993),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5727.071289,-4490.929688,-5.419312),
                rotation = vec3(0.000000,0.000000,-46.999969),
            },
            {
                model = `k_p_pier_01`,
                coords = vec3(-5725.588379,-4486.618164,-4.852591),
                rotation = vec3(0.000000,0.000000,-148.053024),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5683.302246,-4430.794434,-6.056499),
                rotation = vec3(0.000000,0.000000,8.999983),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5705.599609,-4423.245117,-5.797454),
                rotation = vec3(0.000000,0.000000,-80.999847),
            },
            {
                model = `p_val_aucgate1m01x_post`,
                coords = vec3(-5688.167969,-4443.486816,-6.362947),
                rotation = vec3(0.000000,0.000000,10.999990),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5681.265625,-4423.776855,-10.158571),
                rotation = vec3(0.000000,0.000000,-85.999725),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5691.472168,-4438.261719,-5.881108),
                rotation = vec3(0.000000,0.000000,-80.999741),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5671.884766,-4431.522949,-10.180714),
                rotation = vec3(0.000000,0.000000,23.999920),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5683.397461,-4423.289062,-6.436184),
                rotation = vec3(0.000000,0.000000,59.000359),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5683.905273,-4438.279297,-6.216207),
                rotation = vec3(0.000000,0.000000,57.000153),
            },
            {
                model = `stall14-2`,
                coords = vec3(-5722.589355,-4546.573242,-8.423010),
                rotation = vec3(0.000000,0.000000,-46.231689),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5677.093750,-4441.021973,-10.115564),
                rotation = vec3(0.000000,0.000000,-60.999783),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5724.146973,-4480.336426,-5.667901),
                rotation = vec3(0.000000,0.000000,39.999802),
            },
            {
                model = `k_p_pier_01`,
                coords = vec3(-5723.556641,-4485.345215,-4.858683),
                rotation = vec3(0.000000,0.000000,-148.053024),
            },
            {
                model = `p_gen_glasstallbeer01x`,
                coords = vec3(-5695.449219,-4549.781250,-12.915799),
                rotation = vec3(-4.612733,0.341931,60.798004),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5673.852539,-4424.237793,-9.867405),
                rotation = vec3(0.000000,0.000000,62.000023),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5698.475586,-4423.196777,-5.789646),
                rotation = vec3(0.000000,0.000000,58.000065),
            },
            {
                model = `stall13`,
                coords = vec3(-5695.343750,-4536.052734,-9.485356),
                rotation = vec3(0.000000,0.000000,76.999809),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5750.251465,-4496.486816,-5.621944),
                rotation = vec3(0.000000,0.000000,-137.999435),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5690.961914,-4423.344727,-5.872717),
                rotation = vec3(0.000000,0.000000,-79.999840),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5670.308594,-4438.456055,-10.411059),
                rotation = vec3(0.000000,0.000000,76.000206),
            },
            {
                model = `ConcreteWallLong`,
                coords = vec3(-5739.812012,-4499.300781,-5.289293),
                rotation = vec3(0.000000,0.000000,-46.999962),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5745.789062,-4502.852051,-3.859713),
                rotation = vec3(0.000000,0.000000,-90.999496),
            },
            {
                model = `concretewallcolumn`,
                coords = vec3(-5733.312012,-4494.951172,-4.486614),
                rotation = vec3(0.000000,0.000000,-87.999741), 
            },
            {
                model = `mp004_p_mp_gallows_rope01x`,
                coords = vec3(-317.424988,716.122559,115.984070),
                rotation = vec3(-9.986030,11.764965,-174.919174),
            },
        },
    },
    
}


