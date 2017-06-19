class RenameTermsToInfoTerms < ActiveRecord::Migration
  def change
    rename_table :terms, :info_terms
  end
end
