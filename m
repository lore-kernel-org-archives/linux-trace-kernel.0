Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737613C196B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850732; cv=none; b=reC4aulMxwLWtRcvf++l+UIRcS0Ojf6Ybw2yx65DhHJsqRSx29/PfYyHj50+pQARS/2Ai/PLKRCplhPg8UAU8mdWSSOeYW5p7sYvVsTmc/kS0Y4X3P1r+3QVioJPF+6tPVB9A3I/ILFtWf4M539RYJZEgJn63gSDMgnxwEYo4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850732; c=relaxed/simple;
	bh=qADmssOUqnrMjBgBqUywgXK8LLBb3PEeljOq4IAjtTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvvLmcVAiB3YFzXTfcGcUgZvKkN4nq+OtUXUw5wk6LZcjGAlpOgYC4/yfryIkxfWVXYX4qKU45IbvQs/H8ssYVidjxUFN6gjOOSLZd7gIIcTXJOzpxvFVH/vzRqymJ3zBdprNqcLoQVAXbDpyTQhRiGdoV3E/qPH3p98xeCEQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PrZVqwkn; arc=none smtp.client-ip=91.218.175.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PrZVqwkn"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qADmssOUqnrMjBgBqUywgXK8LLBb3PEeljOq4IAjtTY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790850726; v=1; x=1791455526;
 b=PrZVqwkn066mQaTaWb3/atsUNbsZY49GZVmGNJAc5neKuU7mPWgXMlE1AabOi9kyRbGA5ZZy
 E/rQPgiDiEvp6opufn1a9GXvdyhFDWV3/GwqwYnd60F86h+kDCBfoBl2j2kJ6sT0GGn2UDdWYhd
 1t++5jjl9GMPOTTGKykIsa9s=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cc3e7d3ec6f85194;
	Thu, 01 Oct 2026 10:32:05 +0000
X-Mizu-Trace-ID: cc3e7d3ec6f85194
X-Migadu-Flow: FLOW_OUT
Message-ID: <a10ad8db-c344-4c24-bab6-88e9f7055f10@linux.dev>
Date: Thu, 1 Oct 2026 03:32:05 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
To: bot+bpf-ci@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc: mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 peterz@infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260929005411.4105448-2-vineet.gupta@linux.dev>
 <2dc04cf6f1e0c474da152cb4afcd0e264930b4d1d9b969de1b7cfbdd50b1bd35@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <2dc04cf6f1e0c474da152cb4afcd0e264930b4d1d9b969de1b7cfbdd50b1bd35@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/29/26 4:46 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
>> index ed455b53513b..336f40dc6618 100644
>> --- a/kernel/trace/fgraph.c
>> +++ b/kernel/trace/fgraph.c
>> @@ -1036,10 +1036,9 @@ trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
>>   /* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE tasks. */
>>   static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>>   {
> Does this comment still match the function's behavior? Before the patch,
> alloc_retstack_tasklist() assigned at most FTRACE_RETSTACK_ALLOC_SIZE
> stacks per call and returned -EAGAIN to trigger another batch. After the
> patch, it walks every thread in one pass, allocating inline with
> GFP_NOWAIT. The FTRACE_RETSTACK_ALLOC_SIZE pre-allocated entries are now
> only a fallback when GFP_NOWAIT fails, and in the normal case they're all
> freed at the free: label.

Posted v3 [1] with comment fix.

Thx,
-Vineet

[1] 
https://lore.kernel.org/bpf/20261001102909.1152572-1-vineet.gupta@linux.dev/T/#t

>
>> -	int i;
>> -	int ret = 0;
>>   	int start = 0, end = FTRACE_RETSTACK_ALLOC_SIZE;
>>   	struct task_struct *g, *t;
>> +	int i, ret = 0;
>>
>>   	if (WARN_ON_ONCE(!fgraph_stack_cachep))
>>   		return -ENOMEM;
>> @@ -1054,26 +1053,37 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>>   		}
>>   	}
>>
>> -	rcu_read_lock();
>> -	for_each_process_thread(g, t) {
>> -		if (start == end) {
>> -			ret = -EAGAIN;
>> -			goto unlock;
>> -		}
>> +	scoped_guard (rcu) {
>> +		for_each_process_thread(g, t) {
>> +			unsigned long *rs;
>> +
>> +			if (t->ret_stack)
>> +				continue;
>> +
>> +			rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
>> +			if (!rs) {
>> +				/*
>> +				 * Returning from inside scoped_guard() drops
>> +				 * the RCU read lock, but skips the free loop
>> +				 * below. That is only safe because start ==
>> +				 * end here, which leaves that loop nothing to
>> +				 * free. Keep the two in step if this
>> +				 * exhaustion check ever changes.
>> +				 */
>> +				if (start == end)
>> +					return -EAGAIN;
>> +				rs = ret_stack_list[start++];
>> +			}
>>
>> -		if (t->ret_stack == NULL) {
>>   			atomic_set(&t->trace_overrun, 0);
>> -			ret_stack_init_task_vars(ret_stack_list[start]);
>> +			ret_stack_init_task_vars(rs);
>>   			t->curr_ret_stack = 0;
>>   			t->curr_ret_depth = -1;
>>   			/* Make sure the tasks see the 0 first: */
>> -			smp_wmb();
>> -			t->ret_stack = ret_stack_list[start++];
>> +			smp_store_release(&t->ret_stack, rs);
>>   		}
>>   	}
>>
>> -unlock:
>> -	rcu_read_unlock();
>>   free:
>>   	for (i = start; i < end; i++)
>>   		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36644771324

