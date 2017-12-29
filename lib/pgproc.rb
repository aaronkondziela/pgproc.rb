require "pgproc/version"
require "pg"
require 'pp'

module Pg
	class Proc
	def initialize(database,schema,user,password)
		@pg = PG.connect( dbname: database,user: user, password: password)
		@pg.exec("select proc.proname::text from pg_proc proc join pg_namespace namesp on proc.pronamespace = namesp.oid where namesp.nspname = '" + schema + "'").each do |result|
			name = result["proname"]
			define_singleton_method name do |*args|
				query = "select " + name + "("
				vars = []	
				(1..args.length).each do |i| vars.push('$' + i.to_s) end
				query += vars.join(',') + ")"
				@pg.exec(query,args).getvalue(0,0)
			end
		end
	end
	end
end
