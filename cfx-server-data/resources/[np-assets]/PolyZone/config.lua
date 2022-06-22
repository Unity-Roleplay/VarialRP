Config = Config or {}

Config.Zones = {
	garages = {
		-- Garage A --

		BoxZone:Create(vector3(466.49, -71.76, 77.49), 8.4, 13.8, {
			name="garagea",
			heading=337,
			--debugPoly=true
		}),

		BoxZone:Create(vector3(472.67, -61.76, 77.46), 8.4, 13.8, {
			name="garagea",
			heading=330,
			--debugPoly=true
		}),

		BoxZone:Create(vector3(487.94, -32.5, 77.72), 10.0, 24.4, {
			name="garagea",
			heading=60,
			--debugPoly=true
		}),
		
		BoxZone:Create(vector3(-356.31, -753.56, 33.97), 53.25, 10.4, {
			name="garageb",
			heading=1,
		}),

		-- Garage B --
  
  		BoxZone:Create(vector3(-341.99, -758.46, 33.97), 23.35, 8.6, {
			name="garageb",
			heading=0,
		}),
  
  		BoxZone:Create(vector3(-326.87, -751.89, 33.97), 31.2, 11.6, {
			name="garageb",
			heading=262,
		}),
  
		-- Garage C --

		BoxZone:Create(vector3(-321.95, -980.58, 31.08), 59.0, 9.0, {
			name="garagec",
			heading=70,
			--debugPoly=true
		}),
  
  		BoxZone:Create(vector3(-321.51, -941.79, 31.08), 37.6, 7.6, {
			name="garagec",
			heading=340,
		}),

  		BoxZone:Create(vector3(-307.8, -949.2, 31.08), 40.8, 7.8, {
			name="garagec",
			heading=340,
			--debugPoly=truew
		}),

		-- Garage D --

		BoxZone:Create(vector3(385.34, -1331.04, 33.22), 44.0, 7.6, {
			name="garaged",
			heading=50,
		}),
  
  		BoxZone:Create(vector3(427.39, -1366.02, 33.17), 44.0, 7.6, {
			name="garaged",
			heading=49,
		}),
  
		-- Garage E --

		BoxZone:Create(vector3(614.2, 112.74, 92.2), 46.85, 34.6, {
			name="garagee",
			heading=339,
		}),

		-- Garage F --

		BoxZone:Create(vector3(636.49, 176.47, 96.6), 60.2, 36.2, {
  			name="garagef",
  			heading=340,
		}),

		-- Garage G --

		BoxZone:Create(vector3(67.26, 6376.98, 31.24), 60.0, 64.8, {
  			name="garageg",
  			heading=41,
		}),

		-- Garage H --

		BoxZone:Create(vector3(-759.44, -2026.07, 8.93), 72.6, 50, {
  			name="garageh",
  			heading=335,
		}),

		-- Garage I --

		BoxZone:Create(vector3(-675.98, -2056.88, 8.87), 70.4, 33.8, {
  			name="garagei",
  			heading=85,
		}),

		-- Garage J --

		BoxZone:Create(vector3(-629.4, -2196.03, 5.99), 82.400000000001, 23.0, {
  			name="garagej",
  			heading=50,
		}),

		-- Garage K --

		BoxZone:Create(vector3(-125.32, -2133.55, 16.7), 61.2, 32.0, {
  			name="garagek",
  			heading=290,
		}),

		-- Garage L --

		BoxZone:Create(vector3(-51.6, -2101.08, 16.7), 27.8, 16.6, {
  			name="garagel",
  			heading=290,
		}),

		-- Garage M --

		BoxZone:Create(vector3(-83.62, -2006.09, 18.02), 51.0, 19.8, {
  			name="garagem",
  			heading=260,
		}),

		-- Garage O --

		BoxZone:Create(vector3(375.1, 281.46, 103.43), 41.0, 35.0, {
  			name="garageo",
  			heading=253,
		}),

		-- Garage P --

		BoxZone:Create(vector3(-339.36, 288.01, 85.83), 35.6, 30.2, {
  			name="garagep",
  			heading=0,
		}),

		-- Garage Q --

		PolyZone:Create({
			vector2(295.66567993164, -356.21514892578),
			vector2(305.9580078125, -327.55197143555),
			vector2(266.70874023438, -314.34658813477),
			vector2(258.60485839844, -339.76541137695)
		}, {
			name="garageq",
		}),

		-- Garage R --

		BoxZone:Create(vector3(59.43, 17.81, 69.78), 14.8, 7.0, {
  			name="garager",
  			heading=70,
		}),

		-- Garage S --

		BoxZone:Create(vector3(305.14, 71.33, 94.37), 30.4, 6.0, {
  			name="garages",
  			heading=70,
		}),

		-- Garage T --

		PolyZone:Create({
			vector2(239.68876647949, -820.34033203125),
			vector2(258.72216796875, -768.09613037109),
			vector2(218.64688110352, -754.83935546875),
			vector2(200.06071472168, -805.73034667969)
		}, {
			name="garaget",
		}),

		-- Garage U --

		BoxZone:Create(vector3(-772.92, 371.47, 87.87), 10.15, 84.400000000001, {
  			name="garageu",
  			heading=0,
		}),

		-- Garage PD --

		BoxZone:Create(vector3(443.13, -1026.24, 28.94), 5.8, 20.5, {
			name="garagepd",
			heading=6,
  		}),

		-- Garage Harm --

		BoxZone:Create(vector3(570.53, 2728.13, 42.06), 22.6, 34.8, {
			name="garageharm",
			heading=3,
  		}),

		-- Garage Pier --

		BoxZone:Create(vector3(-1587.95, -902.0, 9.21), 13.6, 18.0, {
			name="garagepier",
			heading=321,
  		}),

		-- Garage Richman --

		BoxZone:Create(vector3(-1308.41, 254.07, 64.49), 73.2, 62.8, {
			name="garagerich",
			heading=254,
  		}),

		-- Garage EMS --

		BoxZone:Create(vector3(325.88, -588.31, 28.8), 5.8, 19.0, {
			name="garageems",
			heading=340,
			minZ=27.8,
			maxZ=31.8
		}),
		  
		  BoxZone:Create(vector3(318.48, -572.01, 28.8), 20, 10, {
			name="garageems",
			minZ=27.8,
			maxZ=31.8
		}),
		  
		-- Garage Casino --

		PolyZone:Create({
			vector2(870.51776123047, 20.484987258911),
			vector2(876.04241943359, 17.465185165405),
			vector2(956.79577636719, -30.344190597534),
			vector2(947.38110351562, -63.22282409668),
			vector2(954.59088134766, -88.86612701416),
			vector2(926.10278320312, -116.17047119141),
			vector2(884.08178710938, -92.043014526367),
			vector2(827.90643310547, -56.764553070068),
			vector2(816.08416748047, -46.162780761719)
		}, {
			name="garagecasino",
		}),

		-- Garage Impound --

		BoxZone:Create(vector3(-153.13, -1168.22, 23.77), 7.4, 6.2, {
			name="nomalimpound",
			heading=0,
			--debugPoly=true
		}),
  

		--Job Storing
		BoxZone:Create(vector3(445.52, -991.54, 25.7), 13.2, 4.6, {
			name="garage_PD1_state",
			heading=0,
			--debugPoly=true,
			minZ=24.3,
			maxZ=28.7
		}),
		BoxZone:Create(vector3(437.36, -991.19, 25.7), 13.2, 4.6, {
			name="garage_PD2_state",
			heading=0,
			--debugPoly=true,
			minZ=24.3,
			maxZ=28.7
		}),
		BoxZone:Create(vector3(1866.73, 3698.52, 33.62), 9.4, 5.6, {
			name="garage_sandy_state",
			heading=31,
			--debugPoly=true,
			minZ=32.62,
			maxZ=36.62
		}),
		BoxZone:Create(vector3(-455.44, 6003.06, 31.34), 25.0, 5.4, {
			name="garage_paleto_state",
			heading=45,
			--debugPoly=true,
			minZ=30.34,
			maxZ=34.34
		}),
		BoxZone:Create(vector3(-475.33, 5988.43, 31.28), 12.8, 13.0, {
			name="garage_paletohelicopter_state",
			heading=315,
			--debugPoly=true,
			minZ=30.28,
			maxZ=35.28
		}),
		BoxZone:Create(vector3(1867.57, 3646.96, 35.82), 9.0, 7.4, {
			name="garage_sandyhelicopter_state",
			heading=300,
			--debugPoly=true,
			minZ=34.42,
			maxZ=38.42
		}),
		BoxZone:Create(vector3(449.33, -981.27, 43.69), 8.4, 6.4, {
		  name="garage_mrpdhelicopter_state",
		  heading=0,
		  --debugPoly=true,
		  minZ=42.69,
		  maxZ=46.89
		}),
		BoxZone:Create(vector3(351.88, -588.13, 74.16), 10, 10, {
			name="garage_pbmchelicopter_state",
			heading=70,
			--debugPoly=true,
			minZ=73.16,
			maxZ=77.16
		}),
		BoxZone:Create(vector3(1843.11, 3666.55, 33.68), 5.0, 8.6, {
		  name="garage_sandyemt_state",
		  heading=30,
		  --debugPoly=true,
		  minZ=32.68,
		  maxZ=36.88
		}),
		BoxZone:Create(vector3(-256.26, 6343.38, 32.43), 5, 10.6, {
			name="garage_paletoEMT_state",
			heading=45,
			--debugPoly=true,
			minZ=31.23,
			maxZ=35.23
		}),
		BoxZone:Create(vector3(326.18, -588.42, 28.8), 17.4, 5.2, {
			name="garage_pbmc_state",
			heading=70,
			--debugPoly=true,
			minZ=27.8,
			maxZ=31.8
		})
	}
}