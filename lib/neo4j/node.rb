# external neo4j dependencies

module Neo4j
  # A node in the graph with properties and relationships to other entities.
  # Along with relationships, nodes are the core building blocks of the Neo4j data representation model.
  # Node has three major groups of operations: operations that deal with relationships, operations that deal with properties and operations that traverse the node space.
  # The property operations give access to the key-value property pairs.
  # Property keys are always strings. Valid property value types are the primitives(<tt>String</tt>, <tt>Fixnum</tt>, <tt>Float</tt>, <tt>Boolean</tt>), and arrays of those primitives.
  #
  # === Instance Methods from Included Mixins
  # * Neo4j::Property - methods that deal with properties
  # * Neo4j::Rels methods for accessing incoming and outgoing relationship and nodes of depth one.
  # * Neo4j::Equal equality operators: <tt>eql?</tt>, <tt>equal</tt>, <tt>==</tt>
  # * Neo4j::Index lucene index methods, like indexing a node
  # * Neo4j::Traversal - provides an API for accessing outgoing and incoming nodes by traversing from this node of any depth.
  #
  # === Class Methods from Included Mixins
  # * Neo4j::Index::ClassMethods lucene index class methods, like find
  # * Neo4j::Load - methods for loading a node
  #
  # === Neo4j::Node#new and Wrappers 
  #
  # The Neo4j::Node#new method does not return a new Ruby instance (!). Instead it will call the Neo4j Java API which will return a 
  # *org.neo4j.kernel.impl.core.NodeProxy* object. This java object includes those mixins, see above. The #class method on the java object
  # returns Neo4j::Node in order to make it feel like an ordinary Ruby object.
  #
  # If you want to map your own class to a neo4j node you can use the  Neo4j::NodeMixin or the Neo4j::Rails::Model.
  # The Neo4j::NodeMixin and Neo4j::Rails::Model wraps the Neo4j::Node object. The raw java node/Neo4j::Node object can be access with the Neo4j::NodeMixin#java_node method.
  #
  class Node
    extend Neo4j::Core::Node::ClassMethods
    extend Neo4j::Core::Index::ClassMethods
    extend Neo4j::Core::Loader::ClassMethods

    self.node_indexer self


    ##
    # :method: wrapped_entity
    # same as _java_node
    # Used so that we have same method for both relationship and nodes
    # This method is  defined in the  org.neo4j.kernel.impl.core.NodeProxy which is return by Neo4j::Node.new

    ##
    # :method: wrapper
    # Loads the Ruby wrapper for this node (unless it is already the wrapper).
    # If there is no _classname property for this node then it will simply return itself.
    # Same as Neo4j::Node.wrapper(node)
    # This method is  defined in the  org.neo4j.kernel.impl.core.NodeProxy which is return by Neo4j::Node.new


    ##
    # :method: _java_node
    # Returns the java node/relationship object representing this object unless it is already the java object.
    # This method is  defined in the  org.neo4j.kernel.impl.core.NodeProxy which is return by Neo4j::Node.new


    ##
    # :method: expand
    # See Neo4j::Traversal#expand

    ##
    # :method: outgoing
    # See Neo4j::Traversal#outgoing


    ##
    # :method: incoming
    # See Neo4j::Traversal#incoming

    ##
    # :method: both
    # See Neo4j::Traversal#both

    ##
    # :method: eval_paths
    # See Neo4j::Traversal#eval_paths

    ##
    # :method: unique
    # See Neo4j::Traversal#unique

    ##
    # :method: node
    # See Neo4j::Rels#node or Neo4j::Rels

    ##
    # :method: _node
    # See Neo4j::Rels#_node or Neo4j::Rels

    ##
    # :method: rels
    # See Neo4j::Rels#rels or Neo4j::Rels

    ##
    # :method: _rels
    # See Neo4j::Rels#_rels or Neo4j::Rels

    ##
    # :method: rel
    # See Neo4j::Rels#rel

    ##
    # :method: _rel
    # See Neo4j::Rels#_rel

    ##
    # :method: rel?
    # See Neo4j::Rels#rel?

    ##
    # :method: props
    # See Neo4j::Property#props

    ##
    # :method: neo_id
    # See Neo4j::Property#neo_id

    ##
    # :method: attributes
    # See Neo4j::Property#attributes

    ##
    # :method: property?
    # See Neo4j::Property#property?

    ##
    # :method: update
    # See Neo4j::Property#update

    ##
    # :method: []
    # See Neo4j::Property#[]

    ##
    # :method: []=
    # See Neo4j::Property#[]=

    ##
    # :method: []=
    # See Neo4j::Property#[]=

    class << self


      def extend_java_class(java_clazz) #:nodoc:
        java_clazz.class_eval do
          extend Neo4j::Core::Node
          include Neo4j::Core::Property
          include Neo4j::Core::Rels
          # include Neo4j::Core::Traversal TODO
          include Neo4j::Core::Equal
          include Neo4j::Core::Index
          include Neo4j::Core::Node
          include Neo4j::Core::Loader
        end
      end
    end
  end

  Neo4j::Node.extend_java_class(Java::OrgNeo4jKernelImplCore::NodeProxy)

end
