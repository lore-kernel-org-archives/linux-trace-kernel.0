Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303337B41F;
	Tue, 11 Aug 2026 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428020; cv=none; b=TURNVYML01MtBzh8vIGS4RFSwe1VagFu/TUj7cHmOu61qUU1C0MTWg5rfORS7/orF3b747yjsEYz5lCf1UUw75sZ93xZT65Kk/X5qxsq+W8tPRwXynnfAMzbXEyOhDJgQyRCp0eb3DNP2YD5rs0EGxcTvU1lQz3hWJwSmKt6kGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428020; c=relaxed/simple;
	bh=WIMM879jcs6ktYtWd9rrpk7xFTIT2X291HczHctSjeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bF/D4YcGaj/kt24tApnn/6U9q3ugl9fRI60xFwePphz0qnewWhmLihP7roLFJOao/08FEmmp2CPutqdOHV+0yk/YpPSgfVzMpWx7qWXhhODqe+rX0/9yuA4+AfuhwryYB/Js6L6CcVCWwUU7qDfozH/ypXDQvZteTVljmED212g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07641056|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0153744-0.0352241-0.949402;FP=17796272291498788178|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.ij9Eqmo_1786428005;
Received: from 192.168.208.183(mailfrom:michael@allwinnertech.com fp:SMTPD_---.ij9Eqmo_1786428005 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 14:00:06 +0800
Message-ID: <3f27bacf-5f01-8cb5-a04c-824ca7b2c13f@allwinnertech.com>
Date: Tue, 11 Aug 2026 14:00:05 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5] tracing: Fix race between update_event_fields and,
 event_define_fields
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <2e5730d2-c631-da41-3a3a-ae35bb4895f3@allwinnertech.com>
 <20260810104525.6a3a2e6c@gandalf.local.home>
From: Michael Wu <michael@allwinnertech.com>
In-Reply-To: <20260810104525.6a3a2e6c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> What does the above mean? Are you loading two modules at the same time?
Two modules (A and B) are loaded simultaneously on different CPUs. On the arm64,
 when CPU0's trace_module_notify [pri=1] and CPU1's trace_module_notify [pri=0] 
simultaneously perform operations on call_A, because they are in different cache lines,
CPU1 may observe WRITE_ONCE(head->next, &f->link) in step (4) before f->link.next=next in step (2).
 At this time, CPU1 reads an uninitialized f->link.next and performs an operation that causes to crash.

> What does "pri=X notifier" mean? What function calls are these coming from?
`pri=X notifier` represents `trace_events.c:trace_module_notify [pri=1]` and `trace.c:trace_module_notify [pri=0]`, respectively.
 CPU0 (loads module A)                      CPU1 (loads module B)
  ===============================            ===============================
  load_module(A)                             load_module(B)
    blocking_notifier_call_chain_robust        blocking_notifier_call_chain_robust
         notifier_call_chain                     notifier_call_chain
          nb = trace_events.c:                     nb = trace.c:
          trace_module_notify [pri=1]              trace_module_notify [pri=0]
            mutex_lock(&event_mutex)                 trace_event_update_all() 
            trace_module_add_events(A)               down_write(&trace_event_sem) 
              __register_event(call_A)                
              __add_event_to_tracers(call_A)           
                event_define_fields(call_A)            
                  for each f:                          
                    f = kmem_cache_alloc()             
                    list_add(&f->link,               	
                             &class->fields)           
                      f->link.next=next; (2)       	   
                      WRITE_ONCE(head->next,        
                                &f->link); (4)       update_event_fields(call_A)   											           
            mutex_unlock(&event_mutex)	               list_for_each_entry(field, 
                                                         &class->fields, link) 
                                                         field = class->fields->next 
                                                               = &f->link 
                                                       	       = f (offset 0) 
                                                      up_write(&trace_event_sem)  
On 8/10/2026 10:45 PM, Steven Rostedt wrote:
> On Mon, 10 Aug 2026 14:32:30 +0800
> Michael Wu <michael@allwinnertech.com> wrote:
> 
>> The following sequence may leads race between event_define_fields()
>> and update_event_fields():
> 
>>   CPU0 (module A, pri=1 notifier)        CPU1 (module B, pri=0 notifier)
> 
> What does the above mean? Are you loading two modules at the same time?
> What does "pri=X notifier" mean? What function calls are these coming from?
> 
> -- Steve
> 
>>   ===============================        ===============================
>>   event_define_fields(call_A)            trace_event_update_all()
>>     for each f:                            list_for_each_entry(...,
>>       list_add(&f->link,                                &ftrace_events)
>>                &class->fields)               -> finds call_A
>>         f->link.next = next;        (2)
>>                                            update_event_fields(call_A)
>>         WRITE_ONCE(class->fields->next,
>>                    &f->link);       (4)
>>                                              list_for_each_entry(field,
>>                                                &class->fields, link)
>>                                              -> field = class->fields->next  
>>                                                   = &f->link
>>                                                   = f (offset 0)
>>                                              -> arm64 weak ordering:  
>>                                                 (4) visible before (2)
>>                                                 field->link.next == 0
>>                                              -> next iteration:  
>>                                                 field = (void *)0 = NULL
>>                                              -> crash at NULL->type (0x18)  
>>
>> This produces the following panic:
>>    Unable to handle kernel access ... at virtual address 0000000000000018
>>    pc : update_event_fields+0xf8/0x368
>>    Call trace:
>>     update_event_fields+0xf8/0x368
>>     trace_event_update_all+0x7c/0x2b4
>>     trace_module_notify+0x4c/0x1dc
>>     notifier_call_chain+0x84/0x168
>>     blocking_notifier_call_chain_robust+0x64/0xd4
>>     load_module+0x10c8/0x123c
>>     __arm64_sys_finit_module+0x230/0x31c
>>
>> Fix by taking event_mutex in trace_event_update_all() before
>> trace_event_sem.
>>
>> Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event types as well")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Michael Wu <michael@allwinnertech.com>


-- 
Regards,
Michael Wu
