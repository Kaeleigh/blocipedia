class WikiPolicy < ApplicationPolicy

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def destroy?
    user && (@user.admin? || @wiki.user_id == @user.id)
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user && user.role == 'admin'
        wikis = scope.all
      elsif user && user.role == 'premium'
        all_wikis = scope.all
        all_wikis.map { |wiki| wiki if !wiki.private || wiki.user_id == user.id || wiki.collaborators.include?(user_id: user.id) } end
            "Collaborator or Admin"
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private || wiki.collaborators.include?(user_id: user.id)
            if wiki.collaborators.include?(user_id: user.id)
             "\n\nNon Premium Collaborator Found\n\n"
            end
            wikis << wiki
          end
        end
      end
      wikis
    #closes resolve method  
    end
  #closes class scope
  end
#closes wiki policy
end
