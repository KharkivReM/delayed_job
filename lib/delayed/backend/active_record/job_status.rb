require 'active_record'
module Delayed
  module Backend
    module ActiveRecord

      class JobStatus < ::ActiveRecord::Base
        set_table_name :delayed_job_statuses
    
        INITIAL_STATUS = 'created'
        PENDING_STATUS = 'done'
        TOKENIZER_PENDING_STATUS = 'tokenizer:pending'
        FINAL_TOKENIZER_STATUS = 'tokenizer:done'
        ERROR_TOKENIZER_STATUS = 'tokenizer:error'
        FINAL_STATUS = 'done'
        ERROR_STATUS = 'error'
    
        #successful means - we can go forward even with 'not done' status, for instance archiving fails
        SUCCESSFUL_AND_ERROR_STATUSES = ['toneloc:sent', 'tokenizer:error', 'done', 'error']
    
        def self.find_by_status_name(name)
          JobStatus.find_by_job_status(name)
        end
    
        def self.initial_status
          find_by_status_name(INITIAL_STATUS)
        end
        
        def self.pending_status
          find_by_status_name(PENDING_STATUS)
        end
        
        def self.tokenizer_pending_status
          find_by_status_name(TOKENIZER_PENDING_STATUS)
        end
        
        def self.final_status
          find_by_status_name(FINAL_STATUS)
        end
        
        def self.error_status
          find_by_status_name(ERROR_STATUS)
        end
        
        def self.tokenizer_error_status
          find_by_status_name(ERROR_TOKENIZER_STATUS)
        end    
        
        def self.successful_and_error_statuses
          SUCCESSFUL_AND_ERROR_STATUSES.inject([]) do |statuses, status|
            statuses << find_by_status_name(status)
            statuses
          end      
        end    
        
        def is_final_tokenizer_status?
          job_status == FINAL_TOKENIZER_STATUS
        end

        def is_final_status?
          job_status == FINAL_STATUS
        end
      end # class JobStatus
    end # module ActiveRecord
  end # module Backend
end # module Delayed
