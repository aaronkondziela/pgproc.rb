require "pgproc/version"
require "pg"

module Pgproc
	def initialize(schema)
		pg = PG.connect( dbname: 'customers' )
		pg.exec("select proc.proname::text from pg_proc proc join pg_namespace namesp on proc.pronamespace = namesp.oid where namesp.nspname = '" + schema + "'") do |name|
			define_method name do |*args|
				query = "select " + name + "("
				vars = []	
				(1..args.length).each do |i| vars.push('$' + i) end
				query += vars.join(',') + ")"
				pg.exec(query,args)
			end
		end
	end
end
