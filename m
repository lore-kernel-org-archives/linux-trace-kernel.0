Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393E1C232A;
	Sat, 19 Oct 2024 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729305902; cv=none; b=QfQ/O5VTHRJJvZa4Jot3dX2JhjzeMkrTMM1ZrDfVAvHr8exKhaz8SHpjmQqZWu2DkrSo6F05igWnbucyTp5WyitPSmux0Xj/AjdAjUBwaKijq+PrERYAPDAhsZIOnwO9YDLoyFd0SEI6FZI0W61JDZC9jCQLtGUiZ5sJ6Ik+JBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729305902; c=relaxed/simple;
	bh=ARrF3jX5p3ssMP3L92pFlpzp4705luKl11VJbp+bM3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFVJW7JQzcT7jBluC9ba+3u+QVSy+miweoPQsCPTAt4r123/oExvK065YycOeplPwXAa7hpdaLqOpLnjtGdlT2PnIYEUqvy28MxbKEUmUDagh922hnfmUW+hJNlEfwCTd5eX5K/gcsd+x3HFRCssXZX+YJI/H0Qwtz41DnBElKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpKDdMyc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpKDdMyc"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso2303962a91.1;
        Fri, 18 Oct 2024 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729305899; x=1729910699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqRxljumtD5Kyj1iLBGvC7QxtAEi2bp/81JCWPq5wvE=;
        b=DpKDdMychQie7kM2grrpTx49hz2xYwHp6v2cD1M5Iaz2yAMqpiZxyI+9sWsoJkqWo3
         Qb8VxJwG3tlyuNHnurG/dTuIo0zbNpXnxXV+uXExJu9kbDN5F7ifk+3kfrwqAjbtY38e
         Ewm7BqE77fu8mAD/kqaDqnUSWNxqIVx6dMaekmErM8LxbrdWPi22zJOWWxNDxopXTEVs
         cd8Ei53HDuj9tLOE0ANh92q1qry8dhLfz3Ga2wrdswOFKqsyloHo90zYPs7aTqumZ3hs
         AfTwhuzLG9/wOORrcPfH6jXmvQ1V2MmJ2/HNSovQNgppIjPknsGO7RfC+PQR6eTzqnQw
         Z+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729305899; x=1729910699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqRxljumtD5Kyj1iLBGvC7QxtAEi2bp/81JCWPq5wvE=;
        b=Sxltp7gOSC+3kYtsX1VxO+ZnEAFdLPmPV2G+QUwu4NukHWJ+nxu2Zh1T8gGfq7vWpV
         EJi8P+5RqqXs1BAAupDritLFCI+P8i1nebQAvJ6XkYZDDNkNDsXpPhHam/cO93wKBanY
         K8KsxFnnNVlyNzIZDoX77vNOdC+oszY39jvkrzDt/u+dkqc8mZM279fJQtDnKamjaBeW
         XuFG30M9m0AwQNARBHnwWoQwSEK7SB094+vNu+NQYacQf3A+dzCAVn2gopwjZ0zjSHx2
         qZjTMcWau4zsrHZ/OKPVvHCZQgEGkya3MHpMQKRVKD6W5dOiIC58uLBXukPe3W0w7cPm
         0YXg==
X-Forwarded-Encrypted: i=1; AJvYcCVsB4fyy5cPd0trHvgjvhIvGhaNw4LcCeud3fQUt/pEC3xskE1oS6/4E09Mm8aAH1ud3WBsXChA0G8iPJ8=@vger.kernel.org, AJvYcCWyh0QqoeZE2W3iaKlEIPbNGmqa6SUsHd+U0/5b/9D3uD2TQDpIPZH8E2YKoAtcp39r7sQ0rRRd4P7u/A65a5WL2+mx@vger.kernel.org
X-Gm-Message-State: AOJu0YwTVl+MbE1IHLgiNHIjPfwVG3Z/oQbASNjVvTgPZ9X8DaaCvlYO
	YbxTIGwRcSueC+da/LlO2NcHLzscmDw64xjqPfTm0cvVftMBqsGFgHB85g6g
X-Google-Smtp-Source: AGHT+IH8UCw+EdbMrQzGgpRvdXCXnlQQHoewJTHwNWvgH0VZga7XoqifRPP+puuGHIZ4xBiiAYcvkw==
X-Received: by 2002:a17:90b:3c47:b0:2e2:bd68:b8d8 with SMTP id 98e67ed59e1d1-2e5616dea4dmr4775849a91.8.1729305899219;
        Fri, 18 Oct 2024 19:44:59 -0700 (PDT)
Received: from ?IPV6:240d:1a:13a:f00:4c7c:ec82:af16:5780? ([240d:1a:13a:f00:4c7c:ec82:af16:5780])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55da43a30sm2978963a91.37.2024.10.18.19.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 19:44:58 -0700 (PDT)
Message-ID: <baa84463-113e-4362-ae3f-1ceb8adc9b64@gmail.com>
Date: Sat, 19 Oct 2024 11:44:55 +0900
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ftrace: Fix function name for trampoline
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241012124152.2078-1-tatsuya.s2862@gmail.com>
 <20241018112203.75307abe@gandalf.local.home>
Content-Language: en-US
From: t s <tatsuya.s2862@gmail.com>
In-Reply-To: <20241018112203.75307abe@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/10/19 0:22, Steven Rostedt wrote:
> On Sat, 12 Oct 2024 21:41:51 +0900
> Tatsuya S <tatsuya.s2862@gmail.com> wrote:
>
>> The issue that unrelated function name is shown on stack trace like
>> following even though it should be trampoline code address is caused by
>> the creation of trampoline code in the area where .init.text section
>> of module was freed after module is loaded.
>>
>> bash-1344    [002] .....    43.644608: <stack trace>
>>    => (MODULE INIT FUNCTION)
>>    => vfs_write
>>    => ksys_write
>>    => do_syscall_64
>>    => entry_SYSCALL_64_after_hwframe
>>
>> To resolve this, when function address of stack trace entry is in
>> trampoline, output without looking up symbol name.
>>
>> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
>> ---
>> V1 -> V2: Instead of checking trampoline when displaying "trace" results,
>> 	  it stores trampoline when generating the stacktrace entry.

Thank you for review.

> I'm sorry. I guess I wasn't clear. I meant to do the tests in the recording
> of the trampoline, and do not add them or replace them. I rather not add
> this meta data to the ring buffer.
>
>>   kernel/trace/trace.c         | 24 ++++++++++++++++--------
>>   kernel/trace/trace_entries.h |  2 ++
>>   kernel/trace/trace_output.c  |  7 +++++++
>>   3 files changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 1c69ca1f1088..92a8e76a0cd7 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -988,7 +988,8 @@ static inline void trace_access_lock_init(void)
>>   #endif
>>   
>>   #ifdef CONFIG_STACKTRACE
>> -static void __ftrace_trace_stack(struct trace_buffer *buffer,
>> +static void __ftrace_trace_stack(struct trace_array *tr,
>> +				 struct trace_buffer *buffer,
>>   				 unsigned int trace_ctx,
>>   				 int skip, struct pt_regs *regs);
>>   static inline void ftrace_trace_stack(struct trace_array *tr,
>> @@ -997,7 +998,8 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
>>   				      int skip, struct pt_regs *regs);
>>   
>>   #else
>> -static inline void __ftrace_trace_stack(struct trace_buffer *buffer,
>> +static inline void __ftrace_trace_stack(struct trace_array *tr,
>> +					struct trace_buffer *buffer,
>>   					unsigned int trace_ctx,
>>   					int skip, struct pt_regs *regs)
>>   {
>> @@ -2928,7 +2930,8 @@ struct ftrace_stacks {
>>   static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
>>   static DEFINE_PER_CPU(int, ftrace_stack_reserve);
>>   
>> -static void __ftrace_trace_stack(struct trace_buffer *buffer,
>> +static void __ftrace_trace_stack(struct trace_array *tr,
>> +				 struct trace_buffer *buffer,
>>   				 unsigned int trace_ctx,
>>   				 int skip, struct pt_regs *regs)
>>   {
>> @@ -2986,6 +2989,11 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>>   	memcpy(&entry->caller, fstack->calls,
>>   	       flex_array_size(entry, caller, nr_entries));
>>   
>> +#ifdef CONFIG_DYNAMIC_FTRACE
>> +	entry->trampoline = tr->ops ? tr->ops->trampoline : 0;
>> +	entry->trampoline_size = tr->ops ? tr->ops->trampoline_size : 0;
>> +#endif
>> +
>>   	if (!call_filter_check_discard(call, entry, buffer, event))
>>   		__buffer_unlock_commit(buffer, event);
>>   
> I meant here we can add something like:
>
> /* Make the marker not exactly -1, but max int to be something somewhat unique */
> #define FTRACE_TRAMPOLINE_MARKER	((unsigned long)MAX_INT)
>
>
> 	if (regs) {
> 		nr_entries = stack_trace_save_regs(regs, fstack->calls,
> 						   size, skip);
> 	} else {
> 		nr_entries = stack_trace_save(fstack->calls, size, skip);
> 	}
>
> +	if (tr->ops && tr->ops->trampoline) {
> +		unsigned long tramp_start = tr->ops->trampoline;
> +		unsigned long tramp_end = tramp_start + tr->ops->trampoline_size;
> +		unsigned long *calls = fstack->calls;
> +
> +		/* Mark any trampolines */
> +		for (int i = 0; i < nr_entries; i++) {
> +			if (calls[i] >= tramp_start && calls[i] < tramp_end) {
> +				calls[i] = FTRACE_TRAMPOLINE_MARKER;
> +		}
> +	}
> +
> 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
> 				    struct_size(entry, caller, nr_entries),
> 				    trace_ctx);
> 	if (!event)
> 		goto out;
> 	entry = ring_buffer_event_data(event);
>
> 	entry->size = nr_entries;
> 	memcpy(&entry->caller, fstack->calls,
> 	       flex_array_size(entry, caller, nr_entries));
>
>> @@ -3005,7 +3013,7 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
>>   	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
>>   		return;
>>   
>> -	__ftrace_trace_stack(buffer, trace_ctx, skip, regs);
>> +	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
>>   }
>>   
>>   void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
>> @@ -3014,7 +3022,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
>>   	struct trace_buffer *buffer = tr->array_buffer.buffer;
>>   
>>   	if (rcu_is_watching()) {
>> -		__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
>> +		__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
>>   		return;
>>   	}
>>   
>> @@ -3031,7 +3039,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
>>   		return;
>>   
>>   	ct_irq_enter_irqson();
>> -	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
>> +	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
>>   	ct_irq_exit_irqson();
>>   }
>>   
>> @@ -3048,8 +3056,8 @@ void trace_dump_stack(int skip)
>>   	/* Skip 1 to skip this function. */
>>   	skip++;
>>   #endif
>> -	__ftrace_trace_stack(printk_trace->array_buffer.buffer,
>> -			     tracing_gen_ctx(), skip, NULL);
>> +	__ftrace_trace_stack(printk_trace, printk_trace->array_buffer.buffer,
>> +				tracing_gen_ctx(), skip, NULL);
>>   }
>>   EXPORT_SYMBOL_GPL(trace_dump_stack);
>>   
>> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
>> index c47422b20908..81b84241e3b3 100644
>> --- a/kernel/trace/trace_entries.h
>> +++ b/kernel/trace/trace_entries.h
>> @@ -190,6 +190,8 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
>>   
>>   	F_STRUCT(
>>   		__field(	int,		size	)
>> +		__field(	unsigned long,	trampoline	)
>> +		__field(	unsigned long,	trampoline_size	)
>>   		__stack_array(	unsigned long,	caller,	FTRACE_STACK_ENTRIES, size)
>>   	),
>>   
>> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
>> index 868f2f912f28..fbd066e9c9fa 100644
>> --- a/kernel/trace/trace_output.c
>> +++ b/kernel/trace/trace_output.c
>> @@ -1246,6 +1246,13 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
>>   			break;
>>   
>>   		trace_seq_puts(s, " => ");
>> +		if (field->trampoline && field->trampoline_size &&
>> +			(*p) + delta >= field->trampoline &&
>> +			(*p) + delta < field->trampoline + field->trampoline_size) {
> Then the above can simply be:
>
> 		if ((*p) == FTRACE_TRAMPOLINE_MARKER) {
> 			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
> 			continue;
> 		}
>
> since the value is useless anyway.
>
> -- Steve

OK.


Thanks.

>
>
>> +			trace_seq_printf(s, "0x%08lx", (*p) + delta);
>> +			trace_seq_puts(s, " [FTRACE TRAMPOLINE]\n");
>> +			continue;
>> +		}
>>   		seq_print_ip_sym(s, (*p) + delta, flags);
>>   		trace_seq_putc(s, '\n');
>>   	}
