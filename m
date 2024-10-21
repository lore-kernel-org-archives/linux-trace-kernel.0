Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A17462;
	Mon, 21 Oct 2024 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489961; cv=none; b=lwjAL/KCCG8R4CarR4yytUoKhHOZnsq4rHchYHF70UNJFuJAhKdSCXIgqixtO1nwBQy70hB55kJSTWSCFChUDL5FvCYKppJTCY1kr2S7zsnnon7yT7YXQlgHs+Eq2fZgyR0rrE8kGLgnNQVHdahJURisodj6jNLGX3NOKup5sMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489961; c=relaxed/simple;
	bh=o1CP8uCIVOwwxkR8NRZiRVx0jkXSOS9b7KrVWisouRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3IEKUyzCVlQLtkatibvthMWGj0XsPvCeOsQrglzypws0uOhqbAAVXR8yIVQWKXOpf82/NLIGOp64gBVBix59k9wK/apZ7W7cnFYsIRcs3ya6lfl3U9+j8wtws+7R7qHt3WnKJ3BLDiPR0GUPcX2YnTFIRVJiIbljqDnPIUVh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/AoEOoK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/AoEOoK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca7fc4484so28333465ad.3;
        Sun, 20 Oct 2024 22:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729489958; x=1730094758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mff+eb7R4P6Ox1qQGTAN6sEG1lMZC50oKAPPfCLduCA=;
        b=X/AoEOoKMOiLOUmPPkjdok3oQR7Oo2LcOKWSkmKRnb652QjzGUJzI+CZPijqbnqk4s
         ZcD5TcDQWfNvmkM6Lku46xfmboybb1kf82pXwvof1SNkGqQ7YaB+n+VWwJLjqcP9cmtH
         XQ+S3EmVsEHf4pTVipniDYALsf/fZHhJcblDL89HyWlJv04uqoMj3JSSbu0JXIKyudsp
         CAUO1xNz0q9fmV4PEtbAHARNUHZD4QXFxxPHpHmVeOQNuYLgeAhw+Sh3XyRP4nFDCRsM
         5EtdPBeGwt/5H/xPlqY6myRjJgNblzhv9m0h5VR9DXaiKK0+PPZOXeUveLSGPNnTlf1M
         zrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729489958; x=1730094758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mff+eb7R4P6Ox1qQGTAN6sEG1lMZC50oKAPPfCLduCA=;
        b=lCTFX/7k5n3iT8IpUfIO8L9drc2EVLX00ME/3OmqIGcj+IW/XZ68Nx4pu7WiVR6McB
         UI3nebjXdz7A5zY0pXm5kHAegCyInEU/1+mDGXSNdGE3zj05XONjja2nTuEflrCQwrUU
         Xc3/vkf4e4kN+aWLnLmGzaWf8D/07AnAVmdu/Ma6/gTSesFY+GsckoLHOXZ0gNbh1cuk
         agONV2eEHYz+fzRYRLGex/gXcTvcGJ3rrXSL1DsfCy4jzG6qG+Lr8x5HpZAfTcPcwMdX
         LTne41hGITsqtiNIppZEIlALJjmQEdMHVzMHFMKOq+Y3tQcqrGz6E/fsE23/EK1TBvhD
         0FVA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9GpiL+Btn2HkgIVFwmO+BzeinkwM0y8X+aFrpzkPMfnbHK/BATdltfBqxLxEmNVwEP8sBZbD5MJbGFBLNX2T70p5@vger.kernel.org, AJvYcCWlG9r6LD/JVuwHDrfy4asQCx0PLsW0EMlXD0tIdu2m1wye6gUzNEDIwOeW9xY7DM93Ckcp1MN/sMCS2JM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LD5aFaai1BYHBuNb2wJMkyw9S12t5xjLbdB/Ae7/BrpEjNHG
	7Gl8b2WhoaAM6mDORuF7wQwow2a+56xKn/3kw2zl9u+onEWJaYum1GV3ovKr
X-Google-Smtp-Source: AGHT+IF5nZxbk8sFwW/MbSZaI4WZAOE7xFo9Ym0w3zDl5ff03Ymql61yyNr/46aEUvG+3AAgvhH2RQ==
X-Received: by 2002:a17:902:e845:b0:206:ae39:9f4 with SMTP id d9443c01a7336-20e5a8b059dmr162896395ad.20.1729489958324;
        Sun, 20 Oct 2024 22:52:38 -0700 (PDT)
Received: from ?IPV6:240d:1a:13a:f00:56be:6d28:be7e:522d? ([240d:1a:13a:f00:56be:6d28:be7e:522d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bcc3csm18300295ad.158.2024.10.20.22.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 22:52:36 -0700 (PDT)
Message-ID: <69450d78-985f-4941-8e73-fb8f5f25f78a@gmail.com>
Date: Mon, 21 Oct 2024 05:52:33 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ftrace: Fix function name for trampoline
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241019115749.9499-2-tatsuya.s2862@gmail.com>
 <20241020051853.637e7fc0@rorschach.local.home>
Content-Language: en-US
From: ts <tatsuya.s2862@gmail.com>
In-Reply-To: <20241020051853.637e7fc0@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/20/24 09:18, Steven Rostedt wrote:
> On Sat, 19 Oct 2024 11:57:48 +0000
> Tatsuya S <tatsuya.s2862@gmail.com> wrote:
>
>
> Thanks, this is getting close. One small fix.
>
> Also note, the subject should be "tracing:" and not "ftrace:".
> "ftrace:" is used for the function hooking mechanism (basically the
> ftrace.c file). This is just the tracing infrastructure. I know it's
> confusing because the tracing infrastructure uses the name "ftrace_" as
> a prefix, but that's mostly due to legacy reasons when the tracing
> infrastructure basically only did function tracing.
>
>
>> The issue that unrelated function name is shown on stack trace like
>> following even though it should be trampoline code address is caused by
>> the creation of trampoline code in the area where .init.text section
>> of module was freed after module is loaded.
>>
>> bash-1344    [002] .....    43.644608: <stack trace>
>> => (MODULE INIT FUNCTION)
>> => vfs_write
>> => ksys_write
>> => do_syscall_64
>> => entry_SYSCALL_64_after_hwframe
>>
>> To resolve this, when function address of stack trace entry is in
>> trampoline, output without looking up symbol name.
>>
>> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
>> ---
>> V2 -> V3: Instead of saving the trampoline address, marker was introduced.
>> V1 -> V2: Instead of checking trampoline when displaying "trace" results,
>> 	  it stores trampoline when generating the stacktrace entry.
>>
>>   include/linux/ftrace.h      |  7 +++++++
>>   kernel/trace/trace.c        | 33 +++++++++++++++++++++++++--------
>>   kernel/trace/trace_output.c |  4 ++++
>>   3 files changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
>> index fd5e84d0ec47..39a32fd7b116 100644
>> --- a/include/linux/ftrace.h
>> +++ b/include/linux/ftrace.h
>> @@ -1188,4 +1188,11 @@ unsigned long arch_syscall_addr(int nr);
>>   
>>   #endif /* CONFIG_FTRACE_SYSCALLS */
>>   
>> +/*
>> + * This is used only to distinguish
>> + * function address from trampoline code.
>> + * So this value has no meaning.
>> + */
>> +#define FTRACE_TRAMPOLINE_MARKER  ((unsigned long) INT_MAX)
> This doesn't need to be in include/linux, please move this to
> kernel/trace/trace.h.
>
> Thanks,
>
> -- Steve

Thank you for your review.


OK, I will fix it.

>
>
>> +
>>   #endif /* _LINUX_FTRACE_H */
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 1c69ca1f1088..60d156c34e43 100644
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
>> @@ -2975,6 +2978,20 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>>   		nr_entries = stack_trace_save(fstack->calls, size, skip);
>>   	}
>>   
>> +#ifdef CONFIG_DYNAMIC_FTRACE
>> +	/* Mark entry of stack trace as trampoline code */
>> +	if (tr->ops && tr->ops->trampoline) {
>> +		unsigned long tramp_start = tr->ops->trampoline;
>> +		unsigned long tramp_end = tramp_start + tr->ops->trampoline_size;
>> +		unsigned long *calls = fstack->calls;
>> +
>> +		for (int i = 0; i < nr_entries; i++) {
>> +			if (calls[i] >= tramp_start && calls[i] < tramp_end)
>> +				calls[i] = FTRACE_TRAMPOLINE_MARKER;
>> +		}
>> +	}
>> +#endif
>> +
>>   	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
>>   				    struct_size(entry, caller, nr_entries),
>>   				    trace_ctx);
>> @@ -3005,7 +3022,7 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
>>   	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
>>   		return;
>>   
>> -	__ftrace_trace_stack(buffer, trace_ctx, skip, regs);
>> +	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
>>   }
>>   
>>   void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
>> @@ -3014,7 +3031,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
>>   	struct trace_buffer *buffer = tr->array_buffer.buffer;
>>   
>>   	if (rcu_is_watching()) {
>> -		__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
>> +		__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
>>   		return;
>>   	}
>>   
>> @@ -3031,7 +3048,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
>>   		return;
>>   
>>   	ct_irq_enter_irqson();
>> -	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
>> +	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
>>   	ct_irq_exit_irqson();
>>   }
>>   
>> @@ -3048,8 +3065,8 @@ void trace_dump_stack(int skip)
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
>> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
>> index 868f2f912f28..c14573e5a903 100644
>> --- a/kernel/trace/trace_output.c
>> +++ b/kernel/trace/trace_output.c
>> @@ -1246,6 +1246,10 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
>>   			break;
>>   
>>   		trace_seq_puts(s, " => ");
>> +		if ((*p) == FTRACE_TRAMPOLINE_MARKER) {
>> +			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
>> +			continue;
>> +		}
>>   		seq_print_ip_sym(s, (*p) + delta, flags);
>>   		trace_seq_putc(s, '\n');
>>   	}
