module Neo4j
  module Embedded
    class EmbeddedTransaction
      attr_reader :root_tx
      include Neo4j::Transaction::Instance

      def initialize(root_tx)
        @root_tx = root_tx
        @pushed_nested = 0
      end

      def acquire_read_lock(entity)
        @root_tx.acquire_read_lock(entity)
      end

      def acquire_write_lock(entity)
        @root_tx.acquire_write_lock(entity)
      end


      def inspect
        "EmbeddedTransaction [nested: #{@pushed_nested} failed?: #{failure?} active: #{Neo4j::Transaction.current == self}]"
      end

      def delete
        @root_tx.failure
        @root_tx.close
      end

      def commit
        @root_tx.success
        @root_tx.close
      end
    end
  end
end
