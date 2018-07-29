require_relative "pgproc/version"
require "pg"
require 'pp'

module Pg
	class Proc
	def initialize(schema:'public', **args)
		@pg = PG.connect(args)
		@pg.exec_params("select proc.proname::text from pg_proc proc join pg_namespace namesp on proc.pronamespace = namesp.oid where namesp.nspname = $1", [schema]).each do |result|
			name = result["proname"]
			define_singleton_method name do |*args|
				vars = []
				(1..args.length).each do |i| vars.push('$' + i.to_s) end
				query = "select * from " + name + "(" + vars.join(',') + ")"
				res = @pg.exec_params(query, args)
				if res.ntuples == 1 and res.nfields == 1
					return res.getvalue(0,0)
				else
					return res
				end
			end
		end
	end
	end
end
