Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A6263F4A;
	Tue, 11 Aug 2026 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453239; cv=none; b=paZ73xoPRKQVLDNse0SdvwDeuhTqfw20yI+Bx4sePcYvmxAMLdVs/torKdwxhiTsEbEhLsKa9QnQtmCypXu7Q/38Om14MvDZNoL6fMZret1V4ZhL1x6539ZufY3H5jMw3/D9TN99VCy6wtgjc/PkVmJCfeDMlVe7oenO9+o3BS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453239; c=relaxed/simple;
	bh=gP2JGultJci2XD7Odq9RRGu+Q9xtWOaCH8CusxAlkIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJf+HB5H85fSQQlrjoLHq/hY4JK3mkDmSL4jee3/3sMKhk+yf+vIclhhz5ALonpsQhZrQdCR+A6C+hC4r2ZEpJkPYq0S89/UDJcAHN68zuNnom3RHVOADgAZ9+0jJHw7QIDPhMp4QFB0rU2U0ff7L2L84u0Hw6kx0KraOf3SSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 4AB944042A;
	Tue, 11 Aug 2026 13:00:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 6DD782002B;
	Tue, 11 Aug 2026 13:00:34 +0000 (UTC)
Date: Tue, 11 Aug 2026 09:00:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tracing: Fix race between update_event_fields and,
 event_define_fields
Message-ID: <20260811090045.2a3cbed9@gandalf.local.home>
In-Reply-To: <3f27bacf-5f01-8cb5-a04c-824ca7b2c13f@allwinnertech.com>
References: <2e5730d2-c631-da41-3a3a-ae35bb4895f3@allwinnertech.com>
	<20260810104525.6a3a2e6c@gandalf.local.home>
	<3f27bacf-5f01-8cb5-a04c-824ca7b2c13f@allwinnertech.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6DD782002B
X-Stat-Signature: jo8mfyrjue6ceghpwrmjmkbp4jfpgwqq
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18K5Z4GeCFRxuLdTI5IJUE1vq1KXsncpco=
X-HE-Tag: 1786453234-103577
X-HE-Meta: U2FsdGVkX18i36anizP/VO/s9FTKydVsRdAe+ZBHo8JZ6mOQeRW/P8qYtI2FMupxxLVp9ueVcCK86x1pIL43k94tgekoj2dRn6/7HyJzyhkAM4cRP9Kf06ZvWrGxnB+YmQJzt5z+otBzL7BTEYexSEwWUkuyk4ieVeqYRGWr9+if+3rtANROx0CIM7ZTGVtqnL3IErn+T8UUc3ZvBFVFAVVt0FTTDTgz2F3fjl7rbCS8cQZTPXaZl1uaLcVNl7yQUmitAnVUXjT56PaJJrPvv/sTXAT1K/dIlOkIfSOycdXeOFJxrwkB2+dHZNoCN2NFuiTMt19pIRk9dZQ4CFIVbFM/6aYNbW99j0EXTzlAzymEjn2LxUtKino/51BYnLXaArkSGKoxeumN6PacNj2ggRvRKKide3yS

On Tue, 11 Aug 2026 14:00:05 +0800
Michael Wu <michael@allwinnertech.com> wrote:

> > What does the above mean? Are you loading two modules at the same time?  
> Two modules (A and B) are loaded simultaneously on different CPUs. On the arm64,
>  when CPU0's trace_module_notify [pri=1] and CPU1's trace_module_notify [pri=0] 
> simultaneously perform operations on call_A, because they are in different cache lines,
> CPU1 may observe WRITE_ONCE(head->next, &f->link) in step (4) before f->link.next=next in step (2).
>  At this time, CPU1 reads an uninitialized f->link.next and performs an operation that causes to crash.

This is still way too verbose. Is this AI written? If so, AI is *not* your friend.


> 
> > What does "pri=X notifier" mean? What function calls are these coming from?  
> `pri=X notifier` represents `trace_events.c:trace_module_notify [pri=1]` and `trace.c:trace_module_notify [pri=0]`, respectively.

Why are the priorities of the notifiers important here?

I honestly didn't know one was allowed to load two modules at the same time
and thought that it the module logic would prevent that. But if that's not
the case, then yeah, we need protection.


>  CPU0 (loads module A)                      CPU1 (loads module B)
>   ===============================            ===============================
>   load_module(A)                             load_module(B)
>     blocking_notifier_call_chain_robust        blocking_notifier_call_chain_robust
>          notifier_call_chain                     notifier_call_chain
>           nb = trace_events.c:                     nb = trace.c:
>           trace_module_notify [pri=1]              trace_module_notify [pri=0]
>             mutex_lock(&event_mutex)                 trace_event_update_all() 
>             trace_module_add_events(A)               down_write(&trace_event_sem) 
>               __register_event(call_A)                
>               __add_event_to_tracers(call_A)           
>                 event_define_fields(call_A)            
>                   for each f:                          
>                     f = kmem_cache_alloc()             
>                     list_add(&f->link,               	
>                              &class->fields)           
>                       f->link.next=next; (2)       	   
>                       WRITE_ONCE(head->next,        
>                                 &f->link); (4)       update_event_fields(call_A)   											           
>             mutex_unlock(&event_mutex)	               list_for_each_entry(field, 
>                                                          &class->fields, link) 
>                                                          field = class->fields->next 
>                                                                = &f->link 
>                                                        	       = f (offset 0) 
>                                                       up_write(&trace_event_sem)  

Basically this can be summed up to being:

 CPU0 (loads module A)                      CPU1 (loads module B)
 ===============================            ===============================
 load_module(A)                             load_module(B)
   notifier_call_chain                        notifier_call_chain
     trace_module_notify                        trace_module_notify
       mutex_lock(&event_mutex)                   trace_event_update_all() 
         trace_module_add_events(A)                 down_write(&trace_event_sem) 
            __register_event(call_A)                
              __add_event_to_tracers(call_A)           
                event_define_fields(call_A)            
                  for each f:                         list_for_each_entry(field, 
                    list_add(&f->link,                                    &class->fields, link) 
                             &class->fields)            field = class->fields->next;

Where you can see that one is being read while the other is being written
to. You do not need to go into details of the cache visibility here because
this is an obvious race condition. All that information just distracts from
the real issue that is being fixed.

Less is more when it comes to describing a bug.

I'll rewrite you change log and take the patch.

Thanks,

-- Steve
