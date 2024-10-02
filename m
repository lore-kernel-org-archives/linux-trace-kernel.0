Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462941D0B8F;
	Wed,  2 Oct 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882905; cv=none; b=gVU0BQ1VeSfEKSrl0H+OvA3pSiA6LcdQpjYvXUIFCbGW0JJ1uC64F5dy5gt/f8YkUYaLkTemHKPN9sh8L/8GY1XHERQCLvMIIOvtt6067ctsigStPiVwVRjVxLGYc2vi8aHsLID3NAcv/JsnGRnc6mz8A0hsv4DzX5ihGJuf6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882905; c=relaxed/simple;
	bh=GIFJ+ub0dyf/6HINdN+6nnod9cYqbUkDdTMCF2Ad3ag=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hs31Q8CzNL7v/p8VseZOwQcdkMm9bqVYWvTBPXM1Oh7J69o1HDa3B9X/d0dg9IEQ/ZJQfXykXzDGTOLwWb+zlG3t4ZcpOuPf4WhrefKTF2rQXpIGtiATeTfoiMDLNxv/ZtsYPx4crljR8E1TUj6a163ZC7wmiFy+EDruDDRo4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aftqCKRS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aftqCKRS"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b84bfbdfcso7106135ad.0;
        Wed, 02 Oct 2024 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727882903; x=1728487703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YyjcuBAlSHDXXjE8TsusNbHHDeY3Wi2wIqHrUP4l/HM=;
        b=aftqCKRSiaXC2jxPjRRHUBjrLiHaep3723gSH8WruA3WGVhs6KNIlLGd9Sr9sK/mlk
         5bz9HJjHC7In7An2FH0DyitUpI2hSEGQL230Rp1NlTR/k0DG5FjapsVF7qFiw0AFf4x4
         4YkIbRS5hxRz13yd/NTQCuCNevvPSxaIhhs0rs6b1D7QDgNxAyuTg3G2WmBo8UuX8LV+
         lZjm1wx40cRb4f5IXhwnP+//TIZWbsSNzCrCj3KYhlzj4VIlJPXa3z8qafCESOTMwrUl
         bPCdQh5E1WITvOEsnpLe5c+lmvhq4QR9dSYO5vbtKji9+atzqW3QHVfgenXRkh4goTgA
         j84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882903; x=1728487703;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyjcuBAlSHDXXjE8TsusNbHHDeY3Wi2wIqHrUP4l/HM=;
        b=cP7Rxjla9N0gEHLjHDTXUJugd9ejJ93UL+aH1wogCuGee7+Rvq0SRWl5So+gHrDn0m
         oi+1f1oG/4Cn9C/IWQ7FiDzH3kqaaUD3ro8UMwp1W452mF7X2n3EUOc/y8ZVTKgJqVRA
         AwnLDmdyzKzoQEsKMxcpi8/K9UC6uIyS7m0G2tUYLpusqOQl7zoGghmzXqA4/z9be1bV
         Fr2P1iUsXzBpSjw52Uc/N1aANbN07eSzf7kV6B8auLP2yyxWCVelBQV5yuyDu6hZLbpi
         WFOwM+r8bpoF98K6uwQWMO+QAYwuQstZXV7EQYPo4vm+3V9tLlvYf9kXuJkVUQiNynW2
         Ao4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBxHxp65bcKWbKatJRMG06X72dt4QTvU7KB4WX2icWZR/j0ClRfXFEhvr1RJcyiTlOKEGvajL0y7OSPPYfREahXVjX@vger.kernel.org, AJvYcCXL8QGjBVw76JJ48+Kt2/z5SA900IypcNBdOzUAhm5aqFCRdyzv2ND6ZKtv7aC/twMCS416y67hppcC/KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBYY71wvG1qavbGkO9gvX6EbqpqB+xqCOoaY7m7ZMMt4PqAII
	jWEHvjNQDODgL0W76c0tCceMaS+raAPKHg0Gr7J5bme8CIbmK/xPHeKSUg3l
X-Google-Smtp-Source: AGHT+IF+Gf6cjizYVvRSNUcp9b2roP0RQpJsmKcgGNneaG3XjrInuh9rIxwkeoySbHtFlmVsuP0lmQ==
X-Received: by 2002:a17:90a:3482:b0:2d8:85fc:464c with SMTP id 98e67ed59e1d1-2e1b38c6e58mr10030a91.11.1727882903363;
        Wed, 02 Oct 2024 08:28:23 -0700 (PDT)
Received: from ?IPV6:240d:1a:13a:f00:4b94:68e0:2d8b:3983? ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa43767sm1692186a91.48.2024.10.02.08.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:28:22 -0700 (PDT)
Message-ID: <920d0c47-bc4a-418f-a9ea-ceeb931748f5@gmail.com>
Date: Thu, 3 Oct 2024 00:28:28 +0900
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tatsuya S <tatsuya.s2862@gmail.com>
Subject: Re: [PATCH v3] ftrace: Hide a extra entry in stack trace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241002051347.4239-3-tatsuya.s2862@gmail.com>
 <20241002095640.55e6cc37@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20241002095640.55e6cc37@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/2/24 10:56 PM, Steven Rostedt wrote:
> On Wed,  2 Oct 2024 14:13:48 +0900
> Tatsuya S <tatsuya.s2862@gmail.com> wrote:
> 
>> A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).
>>
>> [003] .....   110.171589: vfs_write <-__x64_sys_write
>> [003] .....   110.171600: <stack trace>
>> => XXXXXXXXX (Wrong function name)
> 
> BTW, instead of X'ing it out, can you show what that extra function was.
> Just saying "Wrong function name" doesn't give me any idea of what happened.
This is changed each shutdown.
For example, client_init_data, hidpp_driver_init, rfcomm_init.

The same function name was displayed each time if system was not shutdown.

And I added "nokaslr" to the kernel command line and boot, got same result.
> 
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
> Is that the function that was "wrong"?
Unrelated?
> 
> -- Steve
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
> 

thanks

