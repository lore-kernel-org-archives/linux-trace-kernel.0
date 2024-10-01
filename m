Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E8C2E3;
	Tue,  1 Oct 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789221; cv=none; b=mKUiYWFq/fMuwBcwr9ymhI1uXiK2hgBZA/X2M88NPyIV+qIMt7DL3B8CiYVtqtL4eFDBK7MkOSQlasx/asFG4vhJf+et7e3A/6PcziME8Mae63tFXcXsvTGBaf23Fu4pFIM9Jko+6NAtJCYcZorazadbuVD26ODN2f5gBnLsDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789221; c=relaxed/simple;
	bh=1nyYkxfzo++NroL8S6yTzCJSX+2NT1qKVjcM69Zn1bU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uIjrd0bgjrwhColFzH5h+NLKI/Kvwk0g+Sd8waPvCNlt0tKgqYs8/6JieE6VU3uDcd/a4MzXerKKlFRk3jz5QNtLGmoLlwkOGSyGSAqSzjaWFsWZ9vQoe+CVGHALyozdgQ9azyGMdWcVBpZGJwpfhJWi0sOYZEkarEpJChRviPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbOfpWzr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbOfpWzr"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718816be6cbso4683406b3a.1;
        Tue, 01 Oct 2024 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727789220; x=1728394020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZdMUcxz4oj2z0u1JSSvYfdywXFuRlc1wU8q0+uI+ys=;
        b=ZbOfpWzreo9dqB+d7AzwuKZYhtcw3bPrUVc3POTs2r4nD4tc4VZS+c46/W9OGpQkXP
         U/JC1G14cDCh/uLrb1d0WmOWkNd5AcO8Bv70LAeQdWrl2CdSwXUytkAHqFhptPDg59sB
         5PYd41Teoxgh3eXNj/QilWidXrFVr4RGaV0H17uimxZL2haA7eugc1ONvq2UOvvvb69u
         wRiTXnjhZH86d1G442qh01RGEGSRemDYslsMEpmTCuUqqmRcbNCvbBT3pRGZvikNdz2K
         dp6reWCi3rPXBWTbnWxP3wLGoc6xfPiqn89CVpkSN1kGgMx4JehlILFvdimsT0jb5KqQ
         /U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789220; x=1728394020;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZdMUcxz4oj2z0u1JSSvYfdywXFuRlc1wU8q0+uI+ys=;
        b=beP2YXqdchupczHA9rzAhdcyIflI1NI1zl9bWxCk1TcUehtib1ApsECnzmybRM03IU
         Ft+8mdKhsoBd6eoH30tCiJrqB+ANpC3Qvtd/q+/OUqfl9tRH28UIHzOcP5lRbYq4MWMM
         424B6/AuZOPUtq8CatzfO7q9Q01uyKGf3OGaFZiySnkfUkhOsRulj/L2FJDgs4n7jan4
         rV4QAH1wwqKKp//uZdmJsuEILMPxCDl5bNlMNjZ4oj7EjOUXMwYE99HYaURNfwauHOc8
         5HtEGdlpf0vMAxQqUpk5BhW5+Fu18//eNyX8Uh0YjAH5j44rkVuYN+FQkgtUYv6cGLNe
         7fTw==
X-Forwarded-Encrypted: i=1; AJvYcCW+hooSEfRhErkvcRIxsmwF7/pgiycjppNjNlWnnqAu0twDNGLnft60kSVud4LFZdT++L2yz2MT8s/LiO2cPAOiOuxi@vger.kernel.org, AJvYcCW6qJr1Bm0JVPG/awvnBylSX2ZoXWphID1kYMLZaASBjGXRbWlBHWI7TWjWoyIDZR/dqXvZReajAVZ3gEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJF2T51Z/hvK7kuAbivA1MVMejQ2SPkDWFfO5DEDKdYjz+bygw
	SjBNZDD8PChHUF40NcCyPtnetPY7WcNEGqEy+eU5NIrb9UW0e5Zd0DwwAM3w
X-Google-Smtp-Source: AGHT+IH24fZeYDJ6tid2b5dW24cXNAJV9ayHG7xtYE56jRxuSNdt+NBTgWcBgB1JjsOs+tp+sk9j5g==
X-Received: by 2002:a05:6a00:23d2:b0:717:86ea:d010 with SMTP id d2e1a72fcca58-71b2605987dmr21416718b3a.21.1727789219768;
        Tue, 01 Oct 2024 06:26:59 -0700 (PDT)
Received: from ?IPV6:240d:1a:13a:f00:4b94:68e0:2d8b:3983? ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265371dbsm7974117b3a.207.2024.10.01.06.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:26:59 -0700 (PDT)
Message-ID: <509829ab-98b5-4429-ba59-e1fc7b300682@gmail.com>
Date: Tue, 1 Oct 2024 22:27:03 +0900
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: ts <tatsuya.s2862@gmail.com>
Subject: Re: [PATCH v2] ftrace: Hide a extra entry in stack trace
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240926061311.25625-1-tatsuya.s2862@gmail.com>
 <20240930085139.5d34f28236a67ef1e9143655@kernel.org>
Content-Language: en-US
In-Reply-To: <20240930085139.5d34f28236a67ef1e9143655@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/30/24 8:51 AM, Masami Hiramatsu (Google) wrote:
> On Thu, 26 Sep 2024 15:13:07 +0900
> Tatsuya S<tatsuya.s2862@gmail.com> wrote:
>
>> A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).
>>
>>      [003] .....   110.171589: vfs_write <-__x64_sys_write
>>      [003] .....   110.171600: <stack trace>
>>   => XXXXXXXXX (Wrong function name)
>>   => vfs_write
>>   => __x64_sys_write
>>   => do_syscall_64
>>   => entry_SYSCALL_64_after_hwframe
> OK, I confirmed it;
>
> ------
> echo 1 > options/func_stack_trace
> echo "vfs_write" >> set_ftrace_filter
> echo "function" > current_tracer
> echo > /dev/null
> cat trace
>                sh-136     [005] .....   266.884180: vfs_write <-ksys_write
>                sh-136     [005] .....   266.884188: <stack trace>
>   => 0xffffffffa0004099
>   => vfs_write
>   => ksys_write
>   => do_syscall_64
>   => entry_SYSCALL_64_after_hwframe
> ------
>
>> To resolve this, increment skip in __ftrace_trace_stack().
>> The reason why skip is incremented in __ftrace_trace_stack()
>> is because __ftrace_trace_stack() in stack trace is the only function
>> that wasn't skipped from anywhere.
>>
>> Signed-off-by: Tatsuya S<tatsuya.s2862@gmail.com>
>> ---
>>   kernel/trace/trace.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index c3b2c7dfadef..0f2e255f563c 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -2916,10 +2916,8 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>>   	 * Add one, for this function and the call to save_stack_trace()
>>   	 * If regs is set, then these functions will not be in the way.
>>   	 */
> Hmm, with this change, the above comment should also be updated.
>
>
>> -#ifndef CONFIG_UNWINDER_ORC
>> -	if (!regs)
>> +	if (IS_ENABLED(CONFIG_UNWINDER_ORC) || !regs)
>>   		skip++;
>> -#endif
> Also, this solves just one pattern (only enable function tracer) but if
> there are fprobes (or kprobes) on the same function, it introduces another issue.
> e.g. (with this fix)
>
> ------
> echo 1 > options/func_stack_trace
> echo 1 > options/stacktrace
> echo "vfs_write" >> set_ftrace_filter
> echo "function" > current_tracer
> echo "f:myevent vfs_write" > dynamic_events
> echo 1 > events/fprobes/myevent/enable
> echo > /dev/null
> cat trace
> ...
>                sh-140     [001] ...1.    18.352601: myevent: (vfs_write+0x4/0x560)
>                sh-140     [001] ...1.    18.352602: <stack trace>
>   => ksys_write
>   => do_syscall_64
>   => entry_SYSCALL_64_after_hwframe
>                sh-140     [001] ...1.    18.352602: vfs_write <-ksys_write
>                sh-140     [001] ...1.    18.352604: <stack trace>
>   => ftrace_regs_call
>   => vfs_write
>   => ksys_write
>   => do_syscall_64
>   => entry_SYSCALL_64_after_hwframe
> ------
> As you can see, myevent skips "vfs_write".
> (and function tracer still have ftrace_regs_call() )

Thanks for the other tests. This issue may be function_trace_call() 
specific problem.

So I will change the place to increment skip number.

> Thank you,
>
>>   
>>   	preempt_disable_notrace();
>>   
>> -- 
>> 2.46.1
>>
Thank you,
