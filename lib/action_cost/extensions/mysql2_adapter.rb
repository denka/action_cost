module ActiveRecord
  module ConnectionAdapters # :nodoc:
    class Mysql2Adapter < AbstractMysqlAdapter

      def execute_with_action_cost(sql, name='')
        #Rails.logger.debug "execute_with_action_cost: #{sql}"
        parser = ActionCost::SqlParser.new(sql)
        ActionCost::Middleware.push_sql_parser(parser)
        execute_without_action_cost(sql, name)
      end
      alias_method_chain :execute, :action_cost
    end
  end
end
