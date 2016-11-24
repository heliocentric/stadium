# Copyright (c) 2016, Dylan Cochran <heliocentric@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

module Stadium
	class QueuePair
		def initialize
			@request_queue = Queue.new();
			@response_queues = Hash.new();
			@mutex = Mutex.new();
		end
		def push(tid, message)
			return @request_queue.push([tid, message]);
		end
		def pop(tid)
			unless (@response_queues.key?(tid)) 
				@mutex.synchronize do
					@response_queues[tid] = Queue.new();
				end
			end
			return @response_queues[tid].pop();
		end
		
		def master_push(tid, message)
			unless (@response_queues.key?(tid)) 
				@mutex.synchronize do
					@response_queues[tid] = Queue.new();
				end
			end
			return @response_queues[tid].push(message)
			
		end
		def master_pop
			pop = @request_queue.pop();
			return pop[0], pop[1]
		end
	end
end
