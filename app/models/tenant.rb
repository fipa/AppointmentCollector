class Tenant < Client
    #TODO este metodo no deberia existir, deberia ser un parametro de configuracion del usuario
    def self.calendar_id
	'3239macob37v5pp1224fom5a28@group.calendar.google.com'
    end
    
end
