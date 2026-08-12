Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC6375ABE;
	Wed, 12 Aug 2026 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786500878; cv=none; b=Zy8wdS7lGqyvm/EcsPMAEttelXrbRSjMLjVWwWb+1CR0H1NrR8qY1+lEdmLWHZLFd/7xrvWVnNO9zV+t8/dthTN0yGvN58+FKJz6dxrU4d16idgyEdMCWF0luhBruKmMx4BHc0+HEySD7+7H1oTABydiifa9ODApCxDsGNfNtQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786500878; c=relaxed/simple;
	bh=WPUJQLKAO1IcWGRktCWFESp53OLi18zBfvn8kquoHY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiCJV5e6aZXM9iPJkTA9e8m9HV/oyMJF6MZMm6txxJIO+0yTQuXPtdK7eYnCF9QdpJ288BVCSR7JC9gKB/9XORQMzv/euJRMgBm4Xayuyf1uNok8liOYGQA86Bv5qo0cvtLTRlKgt7hp1CR9b3J1uNjqLS/SJLA3tCsmmbSdam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07447758|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.117566-0.130689-0.751745;FP=17796360389834409298|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.ijodgzg_1786500864;
Received: from 192.168.208.183(mailfrom:michael@allwinnertech.com fp:SMTPD_---.ijodgzg_1786500864 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 10:14:25 +0800
Message-ID: <f7b0e5a6-c38d-634e-4353-6d1bb5dcd12e@allwinnertech.com>
Date: Wed, 12 Aug 2026 10:14:24 +0800
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
 <3f27bacf-5f01-8cb5-a04c-824ca7b2c13f@allwinnertech.com>
 <20260811090045.2a3cbed9@gandalf.local.home>
From: Michael Wu <michael@allwinnertech.com>
In-Reply-To: <20260811090045.2a3cbed9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/2026 9:00 PM, Steven Rostedt wrote:
> This is still way too verbose. Is this AI written? If so, AI is *not* your friend.
This commit was written by me, not by AI. I apologize for wasting your time. Thank you for rewriting the change.
> Why are the priorities of the notifiers important here?
I probably wanted to describe the entire process, so I've gone on to say too much.
> Less is more when it comes to describing a bug.
Got it.

> On Tue, 11 Aug 2026 14:00:05 +0800
> Michael Wu <michael@allwinnertech.com> wrote:
> 
>>> What does the above mean? Are you loading two modules at the same time?  
>> Two modules (A and B) are loaded simultaneously on different CPUs. On the arm64,
>>  when CPU0's trace_module_notify [pri=1] and CPU1's trace_module_notify [pri=0] 
>> simultaneously perform operations on call_A, because they are in different cache lines,
>> CPU1 may observe WRITE_ONCE(head->next, &f->link) in step (4) before f->link.next=next in step (2).
>>  At this time, CPU1 reads an uninitialized f->link.next and performs an operation that causes to crash.
> 
> This is still way too verbose. Is this AI written? If so, AI is *not* your friend.
> 
> 
>>
>>> What does "pri=X notifier" mean? What function calls are these coming from?  
>> `pri=X notifier` represents `trace_events.c:trace_module_notify [pri=1]` and `trace.c:trace_module_notify [pri=0]`, respectively.
> 
> Why are the priorities of the notifiers important here?
> 
> I honestly didn't know one was allowed to load two modules at the same time
> and thought that it the module logic would prevent that. But if that's not
> the case, then yeah, we need protection.
> 
> 
>>  CPU0 (loads module A)                      CPU1 (loads module B)
>>   ===============================            ===============================
>>   load_module(A)                             load_module(B)
>>     blocking_notifier_call_chain_robust        blocking_notifier_call_chain_robust
>>          notifier_call_chain                     notifier_call_chain
>>           nb = trace_events.c:                     nb = trace.c:
>>           trace_module_notify [pri=1]              trace_module_notify [pri=0]
>>             mutex_lock(&event_mutex)                 trace_event_update_all() 
>>             trace_module_add_events(A)               down_write(&trace_event_sem) 
>>               __register_event(call_A)                
>>               __add_event_to_tracers(call_A)           
>>                 event_define_fields(call_A)            
>>                   for each f:                          
>>                     f = kmem_cache_alloc()             
>>                     list_add(&f->link,               	
>>                              &class->fields)           
>>                       f->link.next=next; (2)       	   
>>                       WRITE_ONCE(head->next,        
>>                                 &f->link); (4)       update_event_fields(call_A)   											           
>>             mutex_unlock(&event_mutex)	               list_for_each_entry(field, 
>>                                                          &class->fields, link) 
>>                                                          field = class->fields->next 
>>                                                                = &f->link 
>>                                                        	       = f (offset 0) 
>>                                                       up_write(&trace_event_sem)  
> 
> Basically this can be summed up to being:
> 
>  CPU0 (loads module A)                      CPU1 (loads module B)
>  ===============================            ===============================
>  load_module(A)                             load_module(B)
>    notifier_call_chain                        notifier_call_chain
>      trace_module_notify                        trace_module_notify
>        mutex_lock(&event_mutex)                   trace_event_update_all() 
>          trace_module_add_events(A)                 down_write(&trace_event_sem) 
>             __register_event(call_A)                
>               __add_event_to_tracers(call_A)           
>                 event_define_fields(call_A)            
>                   for each f:                         list_for_each_entry(field, 
>                     list_add(&f->link,                                    &class->fields, link) 
>                              &class->fields)            field = class->fields->next;
> 
> Where you can see that one is being read while the other is being written
> to. You do not need to go into details of the cache visibility here because
> this is an obvious race condition. All that information just distracts from
> the real issue that is being fixed.
> 
> Less is more when it comes to describing a bug.
> 
> I'll rewrite you change log and take the patch.
> 
> Thanks,
> 
> -- Steve


-- 
Regards,
Michael Wu
