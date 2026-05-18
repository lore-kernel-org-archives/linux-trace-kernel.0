Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD822BE656
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118825; cv=none; b=JOo3Cf9NhK1nTHai4J2kjaEWmQlp0e14RcRz1sY8D8N17ZtlDTLIP/BGzsjsBd/7SGHys3VBp1KO+QO6NQXcHoHV3Y3Ab31ZDvcXbL7cTTw2TRv4MCv0y/1OVTtmGvHdSMe61BdlLxUBAn2sEC+OtRTnkPrmO2Ssh1QmesIpcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118825; c=relaxed/simple;
	bh=anlS8y0lTzHWASrLRnE/i2mu6SfTrJBkFjG/gG5XJvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdcAiVvHot8FIeGZnbYhEc/EPbUW0N/XpuBs4A1GNUnnGx8GLSe824Y1fPRqaHXcqQfGDeyQKh9+YBtEHR5iV4YStlwZcpvuphi2Mkt0Fq0BQK9OOJFQT+B9A6zbbyYwIuJrGPoemARsKlJqzp1o5qL3ZNuAsnPOKdKSu+YSvoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/mPQwbs; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/mPQwbs"
Message-ID: <974ce21a-eae4-44d1-9f22-3a8fe530f409@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779118811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEraYdKdMirCk4JjKOaCbZUPSVm9H9lV1vjABZm+P28=;
	b=O/mPQwbsiptCx5Z47ML082RFeYSXfuo8p9ktYTL0tVjm8p2AfFyeMFdYQPSZEweeCI29qm
	9EfRCA9ORDlIo1XhcfnMRPgveZU0qOO/3i62Yv8Nd7WqVYw65wdVdyzb1pLyWJdlt0RIoo
	IWgvXQbRFvsqQlNKeoBTI4TRkm28CTM=
Date: Mon, 18 May 2026 23:40:03 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 9/9] rv: Mandate deallocation for per-obj monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-10-gmonaco@redhat.com>
 <c4a3c4fc-7efb-4eb0-81d6-cc7a0d51f8fa@linux.dev>
 <27f7000d27f32ff74f50208779ef26d5566d06f5.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <27f7000d27f32ff74f50208779ef26d5566d06f5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/18/26 14:36, Gabriele Monaco wrote:
> On Sun, 2026-05-17 at 17:52 +0800, Wen Yang wrote:
>>
>> One gap: tools/verification/rvgen/rvgen/templates/dot2k/main.c uses
>> RV_MON_%%MONITOR_TYPE%% but generates no deallocation code, may fail
>> to build with a -Wunused-function warning.
>>
> 
> Thanks for the review!
> 
> That's technically the purpose of this patch, we don't know exactly how is the
> per-obj monitor going to deallocate, so we make sure build fails if they don't
> set up a way.
> 
> This combined with the fact per-obj monitors aren't really documented (yet),
> makes it quite confusing, doesn't it?
> 
> Would you prefer we always generate a dummy hook calling da_destroy_storage()
> and let the user decide what to do with it without forcing (obscure) compiler
> warnings?
> 

Hi Gabriele,

Thanks for the patch and the discussion.

I wonder if generating a dummy hook that calls da_destroy_storage by 
default is the best way to go.
Given that da_destroy_storage internally uses kfree_rcu(), it might 
introduce unnecessary memory allocation/free overhead and could even 
affect RCU grace periods -- especially for monitors that never actually 
need to release objects.

Perhaps a gentler approach for rvgen would be to generate a commented 
example in the template, showing how to use da_skip_deallocation to 
silence the warning.

--
Best wishes,
Wen


> 
>>
>> --
>> Best wishes,
>> Wen
>>
>> On 5/12/26 22:02, Gabriele Monaco wrote:
>>> The per-object monitors use a hash tables and dynamic allocation of the
>>> monitor storage, functions to clean a monitor that is no longer needed
>>> are provided but nothing ensures the monitor actually uses them.
>>>
>>> Remove the inline specifier on the deallocation function to let the
>>> compiler warn in case it isn't referenced. If the monitor really doesn't
>>> need one (for instance because instances will never cease to exist
>>> before disabling the monitor), the da_skip_deallocation() helper macro
>>> can be used to silence the warning.
>>>
>>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>> ---
>>>    include/rv/da_monitor.h                      | 14 +++++++++++++-
>>>    kernel/trace/rv/monitors/deadline/deadline.h |  5 ++++-
>>>    2 files changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
>>> index 402d3b935c08..378d23ab7dfb 100644
>>> --- a/include/rv/da_monitor.h
>>> +++ b/include/rv/da_monitor.h
>>> @@ -489,8 +489,11 @@ static inline monitor_target
>>> da_get_target_by_id(da_id_type id)
>>>     * locks.
>>>     * This function includes an RCU read-side critical section to synchronise
>>>     * against da_monitor_destroy().
>>> + * NOTE: inline is omitted on purpose to let the compiler warn if this
>>> function
>>> + * is never referenced. For monitors that don't require a deallocation
>>> hook,
>>> + * da_skip_deallocation() can be used.
>>>     */
>>> -static inline void da_destroy_storage(da_id_type id)
>>> +static void da_destroy_storage(da_id_type id)
>>>    {
>>>    	struct da_monitor_storage *mon_storage;
>>>    
>>> @@ -504,6 +507,15 @@ static inline void da_destroy_storage(da_id_type id)
>>>    	kfree_rcu(mon_storage, rcu);
>>>    }
>>>    
>>> +/*
>>> + * da_skip_deallocation - explicitly mark a deallocation function as not
>>> required
>>> + *
>>> + * Only use when you are absolutely sure the monitor doesn't require a
>>> + * deallocation hook (i.e. it's not possible for an object to finish
>>> existing
>>> + * when the monitor is still running).
>>> + */
>>> +#define da_skip_deallocation(hook) ((void)hook)
>>> +
>>>    static void da_monitor_reset_all(void)
>>>    {
>>>    	struct da_monitor_storage *mon_storage;
>>> diff --git a/kernel/trace/rv/monitors/deadline/deadline.h
>>> b/kernel/trace/rv/monitors/deadline/deadline.h
>>> index 78fca873d61e..c39fd79148c2 100644
>>> --- a/kernel/trace/rv/monitors/deadline/deadline.h
>>> +++ b/kernel/trace/rv/monitors/deadline/deadline.h
>>> @@ -194,7 +194,10 @@ static void __maybe_unused handle_newtask(void *data,
>>> struct task_struct *task,
>>>    		da_create_storage(EXPAND_ID_TASK(task), NULL);
>>>    }
>>>    
>>> -static void __maybe_unused handle_exit(void *data, struct task_struct *p,
>>> bool group_dead)
>>> +/*
>>> + * Deallocation hook, use da_skip_deallocation() when not necessary
>>> + */
>>> +static void handle_exit(void *data, struct task_struct *p, bool group_dead)
>>>    {
>>>    	if (p->policy == SCHED_DEADLINE)
>>>    		da_destroy_storage(get_entity_id(&p->dl, DL_TASK,
>>> DL_TASK));
> 
