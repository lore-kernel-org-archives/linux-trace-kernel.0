Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79808A95E;
	Sat,  5 Oct 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728114371; cv=none; b=YiN+aiMYO3UkMWe000FfYverCABLJFf5DFQVRr121Hh3Bo3WOQ2PPTDxx1sd2CSkKT4gEnIUenqsprYLdGW690Myc1+q+BotSCzt1726FbIlOnW9m2PD9MqD+VCLqF5gvcnBFheiPLoxVQNtKaWgVnWJtFIfjaJ+wjk3OkWNv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728114371; c=relaxed/simple;
	bh=bg2V5J8+/z+gvMt/WLtagPG8j5eNX+gxuaoiueh2lz0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JA6Npx2J2OccBMOD2UfJNknI/5vL9V/jTojeA6VnD77SbldAt2vVZ9LfTnVX+B9wQBV5iEPu/XQkMtfNtG+qYwma2Vu6xupOOAENS51Gn4CNY1smtP7vZNZ24UBlTPf72R2LoqgVjrL5z27C7cDhkyUt/XCv3FZbSC9PdiHJLUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVm7EW2f; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVm7EW2f"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71def715ebdso694660b3a.2;
        Sat, 05 Oct 2024 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728114370; x=1728719170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ft6iFAWCz3rOicovV4x+NmklcxRaJf7zhluxXJdGAy8=;
        b=OVm7EW2fsIv+xMZh5CkLCwFez4KeB2gTThhm5Mc51KauqpfS5elCFXfBmsq36rxVk0
         BUd4WAhsu6M3wqsfgqL2gSEG/YSgRoMhaHk0ZFdAMefNNodLYT3UtdhTTIFtJHM9gVAH
         wjoNhTuCG0LYnK43uqeZlctzk+eReyjERjad9UVHCnu46MUA9WY34WNEI2vl52Dayi7s
         ftsVmWDurZrWVz4j4THBrsX+IvQfiR5xa7pW7lzmQNbUsX1nct2hgXLHcgfHSHjA5+qA
         cSTjjEzuXjgLy6geQLLDUb3Dwtxkd2/FHovBJ9Qjb8/L9qmC/tFVlf1UhKSS/q/uTxvf
         i+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728114370; x=1728719170;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ft6iFAWCz3rOicovV4x+NmklcxRaJf7zhluxXJdGAy8=;
        b=e5On5iLePN7hDxeOqp1UaiBr61kKS/h8kT9TqopujezmN+KvIiegKPOMaCSgNyYWRo
         qC8o6bmJ4SzvA4hGEzULhCAHsamvQ4oURVhVe/vYoZUbl0BowiswGS1+8P96Ptz4Esjm
         wlec12l4ysB7q/by/tGxYnaTXlvr8XeDP2UPG3/nw+heMYIevcHQlABTTSJWkR8KBT2n
         xwEeQH6xBqPj/nscabvef2/s+nxBWL32xfPUTzyl50x85TyHc02VNmbCVSX6PFD56IHN
         L5AqjXxh3Aepz/4TKcdr5/9UR82naexpTikF/bYg9ySyo3mqEosF+4xsbZVVVHcVtByu
         hY0w==
X-Forwarded-Encrypted: i=1; AJvYcCUXVwlZxn+F+EqJXWyUGxrQx1XQhRfHkfic0bQ1JS5EDRlWVZ+vmINgEQ2V/7nS9IoLJXlfePFJn//dHrv3v5faP1zK@vger.kernel.org, AJvYcCWGLtIyIIfwqpRmUC/ViTCAgK1WWhQP+vgl8mOO4EzKs16Be7UWMUxz8BnhK0U2uumm/QMGwBvf7r1AP2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5FpnAqn2gnn2ovcllslr4VaWUheK+9fIN1ZhBO503UNwld+1G
	GZ3lJMPZEM8u3TP84r/xeyyPqY+yuUDwAZ0TR1qmLS13FuW2o2Ng/JNV956s
X-Google-Smtp-Source: AGHT+IFw0j0tsU61YuECNYYiHfJ81goVCzMQnaP0EZ8Pnr10DhCU3izmkgQuz1mDOuX4zdjGXRbZYg==
X-Received: by 2002:a05:6a00:4fd3:b0:718:e51e:bd25 with SMTP id d2e1a72fcca58-71de245cd32mr8098495b3a.25.1728114369584;
        Sat, 05 Oct 2024 00:46:09 -0700 (PDT)
Received: from ?IPV6:240d:1a:13a:f00:4b94:68e0:2d8b:3983? ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbd8b8sm993500b3a.1.2024.10.05.00.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 00:46:09 -0700 (PDT)
Message-ID: <5e709161-505e-41f2-ac3a-f64667cdf1de@gmail.com>
Date: Sat, 5 Oct 2024 16:46:15 +0900
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tatsuya S <tatsuya.s2862@gmail.com>
Subject: Re: [PATCH v3] ftrace: Hide a extra entry in stack trace
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241002051347.4239-3-tatsuya.s2862@gmail.com>
 <20241004231732.247301975e1e8f1511b50c6a@kernel.org>
Content-Language: en-US
In-Reply-To: <20241004231732.247301975e1e8f1511b50c6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/24 11:17 PM, Masami Hiramatsu (Google) wrote:
> On Wed,  2 Oct 2024 14:13:48 +0900
> Tatsuya S <tatsuya.s2862@gmail.com> wrote:
> 
>> A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).
>>
>> [003] .....   110.171589: vfs_write <-__x64_sys_write
>> [003] .....   110.171600: <stack trace>
>> => XXXXXXXXX (Wrong function name)
>> => vfs_write
>> => ksys_write
>> => do_syscall_64
>> => entry_SYSCALL_64_after_hwframe
>>
>> To resolve this, increment skip for __ftrace_trace_stack() in
>> function_stack_trace_call().
>> The reason why skip is incremented for __ftrace_trace_stack()
>> is because __ftrace_trace_stack() in stack trace is the only function
>> that wasn't skipped from anywhere.
> 
> Hi Tatsuya,
> 
> Can you focus on making test cases which checks what combinations caused
> this wrong values and what does not? Also it should be checked with
> various kconfigs. That is more valuable than making add-hoc fixes.
> 
> Thank you,

OK, thank you for advise.

Curiously, now when test under the same conditions,
address(like 0xffffffffa1413099) within trampoline code appears
in XXXXXXXXX. Unrelated function name is not displayed now...

The following is the script used:

echo > trace
echo 'vfs_write' > set_ftrace_filter
echo function > current_tracer
echo 1 > options/func_stack_trace
echo 1 > tracing_on
read
echo 0 > tracing_on
cat trace
echo nop > current_tracer
---

Thanks

> 
>>
>> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
>> ---
>> V2 -> V3: Changed the place to increment skip number
>> V1 -> V2: Fixed redundant code
>>
>>   kernel/trace/trace_functions.c | 24 +++++++++++-------------
>>   1 file changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
>> index 3b0cea37e029..27089d8e65d4 100644
>> --- a/kernel/trace/trace_functions.c
>> +++ b/kernel/trace/trace_functions.c
>> @@ -203,23 +203,21 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>>   	ftrace_test_recursion_unlock(bit);
>>   }
>>   
>> -#ifdef CONFIG_UNWINDER_ORC
>> -/*
>> - * Skip 2:
>> - *
>> - *   function_stack_trace_call()
>> - *   ftrace_call()
>> - */
>> -#define STACK_SKIP 2
>> -#else
>>   /*
>>    * Skip 3:
>> - *   __trace_stack()
>> - *   function_stack_trace_call()
>> - *   ftrace_call()
>> + *   Skipped functions if CONFIG_UNWINDER_ORC is defined
>> + *
>> + *     __ftrace_trace_stack()
>> + *     function_stack_trace_call()
>> + *     ftrace_call()
>> + *
>> + *   Otherwise
>> + *
>> + *     __trace_stack()
>> + *     function_stack_trace_call()
>> + *     ftrace_call()
>>    */
>>   #define STACK_SKIP 3
>> -#endif
>>   
>>   static void
>>   function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
>> -- 
>> 2.46.2
>>
> 
> 

