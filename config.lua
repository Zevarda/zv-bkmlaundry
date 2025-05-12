Config = {}

Config.UsePed = true -- true = ped, false = prop

Config.LaunderLocation = {
    coords = vector4(126.78, -1299.3, 29.23, 90.0),
    model = Config.UsePed and 'g_m_y_famca_01' or 'prop_ld_suitcase_01'
}


Config.Inventory = 'ox' -- 'ox', 'qb', 'qs'

Config.BaseRate = 5000            -- 5sc / 10k
Config.MinAmount = 10000
Config.MaxAmount = 500000

Config.TargetDistance = 2.0

Config.Anim = {
    dict = 'amb@world_human_stand_mobile@male@text@enter',
    clip = 'enter'
}
