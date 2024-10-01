Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62B6AA7;
	Tue,  1 Oct 2024 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789630; cv=none; b=dDFJoytdBEPyMir6knm74IgSDR1hoNzxMVc9njsCI7G2soxWxuQsi7eBojZbUc56sgtjKP33PiXcWhhsdqPPp0bux1f0HfqfbVgIkh7kn7MvNdZJ+XuDj7GAWWhL7ni7ag0fgr27ONyIQ3Edm7x10a+Auldbznik36qySNcrHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789630; c=relaxed/simple;
	bh=v7XMkyn79kqNuk2/TzU86VxiRU1tOkguAj6FOnzj7EE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lZp4p1S5gOGCwrsSwZMTuDBDSXrcoP/Xgn6WUWgVrb894kxSIu5/DlmOHk2Fz4EwtV1gdV2jQCoeMbNR0ptYNwNITK6n2cvOcSEC5P2B4r5nJToI/BBJ7qc02f2TuWpteGZZi1byYRLm0/A3f3u3KlE2zfNt67srP9I5Z1Rx5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8m/scyQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8m/scyQ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71b8d10e990so2546840b3a.3;
        Tue, 01 Oct 2024 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727789629; x=1728394429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MlVkqni3fdU8bFPKHwelwgv8JSNlz6H3MWx/qQmvUOk=;
        b=G8m/scyQ/YinKZS21VPYXFJ4BliXFZHsI1YIBSMp0B1n9X90UXX9WbQArCmnf3WGa0
         7hFa9KyQF2w/bGHetOR9R4+zhWbzxMUzok1hWynwhBbHRlFrqG+24AHc23/2wAUDOyZJ
         yN+hDwrcdYXgK1VQcI5gx62a8k3oRCZG6IEZnJQq/aKqYU9JGzTGHY3DSi5V+RmxGgxS
         C0hMqXvTPMDNOee/HW4nQ1yi59756Yp4b/HMrEV+qDT0QymxXqksBribA1sYOZmtc66j
         ZnxwO1twU/vlX1r+qpm0n4SECGHM0LVUoMMBQ9BfvNT2qP74Dcgn/c+XwOna10Er7xZ5
         KRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789629; x=1728394429;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlVkqni3fdU8bFPKHwelwgv8JSNlz6H3MWx/qQmvUOk=;
        b=o9h9AHty6CgM4d3UI4e16IsiauiWNMjI2+s3bLetOsLvVqcXblcOXX2ZuRYGp5bkMX
         E5xONwmUk4g7V5409VuSViY2QsGyptZJk5efr4/hcIj0XtDMXJO/QYLYuLIVF3nA44qH
         6gZ5xDbnu32e3vkKuU3T9CYIitRkZbiSt7sZHQUj0thg3uCmP4GYOc6OAfudWBQbxuvN
         hUUPqQ2mjJt3LHYWFV/1xV4qWDA9VPFC/7l47W42weZ+c6gRcJOFfb1REqJ2nQxesfE+
         oNzQGl+qPmCO5q7SmG2UQz5rrj/oowQ55qFAg81mP1KYmYAMl05dSBqzSVR863dY6qr0
         0JVA==
X-Forwarded-Encrypted: i=1; AJvYcCVZxi9R9I3tdwwpiOYAp0zr877+AGTXYhsQPgI0AMEljW37QO6qFU2deZ8AjazSi48Ye9gO/0knZ1mu2Es=@vger.kernel.org, AJvYcCWAm2cQ0KCkTto/1su74gS1loRA2tScsGJncoabVGS2ugJ7jryvFcN5TExcb3u9C7Xll28bfOpx6bN06XMAA7YLtc0g@vger.kernel.org
X-Gm-Message-State: AOJu0YyHB5UbLpnEfcrAx56xhz9VJgkZyyTS29HHYqwxehBgY1501EQM
	qL7a7M8WsViTjy/aiPOzFmq7yBd3g3KO74FmNfY+laFLzu8+n6/h
X-Google-Smtp-Source: AGHT+IGkruuCU2HRxJH/e2cdMeHLpt+GQc/Iwx+9F5mQrb8bhqdvpmOx2ynVFKz6GSre5zfQAMnkAg==
X-Received: by 2002:a05:6a21:1813:b0:1ce:f6b2:d5a2 with SMTP id adf61e73a8af0-1d4fa806edemr22054855637.41.1727789628612;
        Tue, 01 Oct 2024 06:33:48 -0700 (PDT)
Received: from ?IPV6:240d:1a:13a:f00:4b94:68e0:2d8b:3983? ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26538733sm7981191b3a.217.2024.10.01.06.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:33:48 -0700 (PDT)
Message-ID: <1994eeb2-838a-4bcf-aa6f-f21ab4eaf7e7@gmail.com>
Date: Tue, 1 Oct 2024 22:33:51 +0900
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ftrace: Hide a extra entry in stack trace
From: ts <tatsuya.s2862@gmail.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240926061311.25625-1-tatsuya.s2862@gmail.com>
 <20240930085139.5d34f28236a67ef1e9143655@kernel.org>
 <509829ab-98b5-4429-ba59-e1fc7b300682@gmail.com>
Content-Language: en-US
In-Reply-To: <509829ab-98b5-4429-ba59-e1fc7b300682@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/1/24 10:27 PM, ts wrote:
>
> On 9/30/24 8:51 AM, Masami Hiramatsu (Google) wrote:
>> On Thu, 26 Sep 2024 15:13:07 +0900
>> Tatsuya S<tatsuya.s2862@gmail.com> wrote:
>>
>>> A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).
>>>
>>>      [003] .....   110.171589: vfs_write <-__x64_sys_write
>>>      [003] .....   110.171600: <stack trace>
>>>   => XXXXXXXXX (Wrong function name)
>>>   => vfs_write
>>>   => __x64_sys_write
>>>   => do_syscall_64
>>>   => entry_SYSCALL_64_after_hwframe
>> OK, I confirmed it;
>>
>> ------
>> echo 1 > options/func_stack_trace
>> echo "vfs_write" >> set_ftrace_filter
>> echo "function" > current_tracer
>> echo > /dev/null
>> cat trace
>>                sh-136     [005] .....   266.884180: vfs_write 
>> <-ksys_write
>>                sh-136     [005] .....   266.884188: <stack trace>
>>   => 0xffffffffa0004099
>>   => vfs_write
>>   => ksys_write
>>   => do_syscall_64
>>   => entry_SYSCALL_64_after_hwframe
>> ------
>>
>>> To resolve this, increment skip in __ftrace_trace_stack().
>>> The reason why skip is incremented in __ftrace_trace_stack()
>>> is because __ftrace_trace_stack() in stack trace is the only function
>>> that wasn't skipped from anywhere.
>>>
>>> Signed-off-by: Tatsuya S<tatsuya.s2862@gmail.com>
>>> ---
>>>   kernel/trace/trace.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>>> index c3b2c7dfadef..0f2e255f563c 100644
>>> --- a/kernel/trace/trace.c
>>> +++ b/kernel/trace/trace.c
>>> @@ -2916,10 +2916,8 @@ static void __ftrace_trace_stack(struct 
>>> trace_buffer *buffer,
>>>        * Add one, for this function and the call to save_stack_trace()
>>>        * If regs is set, then these functions will not be in the way.
>>>        */
>> Hmm, with this change, the above comment should also be updated.
>>
>>
>>> -#ifndef CONFIG_UNWINDER_ORC
>>> -    if (!regs)
>>> +    if (IS_ENABLED(CONFIG_UNWINDER_ORC) || !regs)
>>>           skip++;
>>> -#endif
>> Also, this solves just one pattern (only enable function tracer) but if
>> there are fprobes (or kprobes) on the same function, it introduces 
>> another issue.
>> e.g. (with this fix)
>>
>> ------
>> echo 1 > options/func_stack_trace
>> echo 1 > options/stacktrace
>> echo "vfs_write" >> set_ftrace_filter
>> echo "function" > current_tracer
>> echo "f:myevent vfs_write" > dynamic_events
>> echo 1 > events/fprobes/myevent/enable
>> echo > /dev/null
>> cat trace
>> ...
>>                sh-140     [001] ...1.    18.352601: myevent: 
>> (vfs_write+0x4/0x560)
>>                sh-140     [001] ...1.    18.352602: <stack trace>
>>   => ksys_write
>>   => do_syscall_64
>>   => entry_SYSCALL_64_after_hwframe
>>                sh-140     [001] ...1.    18.352602: vfs_write 
>> <-ksys_write
>>                sh-140     [001] ...1.    18.352604: <stack trace>
>>   => ftrace_regs_call
>>   => vfs_write
>>   => ksys_write
>>   => do_syscall_64
>>   => entry_SYSCALL_64_after_hwframe
>> ------
>> As you can see, myevent skips "vfs_write".
>> (and function tracer still have ftrace_regs_call() )
>
> Thanks for the other tests. This issue may be function_trace_call() 
> specific problem.
>
Not function_trace_call(),  function_stack_trace_call().
> So I will change the place to increment skip number.
>
>> Thank you,
>>
>>>         preempt_disable_notrace();
>>>   --
>>> 2.46.1
>>>
> Thank you,
