Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C88F5A;
	Fri, 29 Nov 2024 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848543; cv=none; b=YyiN+XrF2Y3PDiZl4m+xwnzM6KzeP2dHQM9t7+JtBfOChh9zfSQYH5jJwokQ6YsqOgArugGAWW24Pr3gn/4XEZczluO6ugRfnia0dsoHRjNsp9za2Fhgjkk3txcbXh2KAeZcaLg+vya/dx3U4EGNf8hBeNH4D0PGdPgPShItEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848543; c=relaxed/simple;
	bh=QLUjTtoDE9S97ZLbymgjtwtKTxN2cC3KIoEYtZwoy1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEkTSHa2onZH6U6Jdtc2UM8rVPpBuYjZ4SATTob/evTeLZSpFbg277JWAkak8gMPrm5bbgAwTkqD7foRZ9JrumQ2Ax+IHMZ9jrOptdd6j+kFJzrqHdstJzXgiY47VwTCCa+tOW1HYqP3MV8e+oxujjA/F7drE8byz/kndumNkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmdpjdfO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmdpjdfO"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee345c1bbdso737802a91.1;
        Thu, 28 Nov 2024 18:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732848541; x=1733453341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PICE+Q3/N0kMzg+O9wYNTMGH6EgupurTrcjA/6N0QTE=;
        b=PmdpjdfOh/rto/8Ds16tg9hXV577WEPaWheRIVcraWt20ULb0zxAF6v8xN7uR4A5pw
         WaIx88dJVCNSn4AXIXPVfIP0acJOUgZEXuoDG/S/61+cejZiEscNZTgUA/zoddhnHokX
         NJqch8DjSpNeyOyCk5wbiNDLW9esxBKm1Rh7JoXI4lOYiJwXaBrHyWaOKEEiS8yA+gzp
         3dcjIC3XNEse5gnWZzbAmFbi6z4lhB2wm650YqlxA2jwN2OjrfAcrvX60sPi1xi+4hwP
         VSPhfc+hT0V9iez6XalzdYf4d3ujd4Aw1jn7SUOUS3LywVCYr/b+z41j/7kRU06SKcpr
         6rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732848541; x=1733453341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PICE+Q3/N0kMzg+O9wYNTMGH6EgupurTrcjA/6N0QTE=;
        b=ZxXyGalyvQ/HiN6oVBeJp4dG9VZTW6wI5DsuP/dsX41ucTtdMmI46kdcHKjIg+fFcD
         1aPZB9OUqJFU5oK+fe11KntxKJMYAbxGPpLUL6mOSxClM62C5Q86lDB4b/m0vUTqh4pB
         a/HRGwZ+9PWkdc44MzjmoOW2kE3tt9CyGSkdLrCassQG9uzZivuQaspsh2UwLtgjzXZD
         oQfE2brV01SdaJeMFwzeZhww5HXg4YSDTCSapgUqUB6JCfracwLBJBsqgnImF/qIvjV7
         VGQjLSR8JHu337iE/DMTwYKlWfnWKw+l63Qz4sKUcV4QZk4F1H2bwaF3oon1a8yUyTSa
         ZF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6xTl80z50l96NDcTUhh8PcWCjuGfdUK6iE7fV/8FZ0CS/Xmp89dp9pQOvauDeOj9IcMckaULzUmSW9tY=@vger.kernel.org, AJvYcCX3W2kM90dXoV3BUXDiHTtIwtfqe/tF4jt04moFBe29Un/FVDsHRgUkx1ihHLajKYYmxY7FGd5O//t5dTtzs+vBAMbb@vger.kernel.org
X-Gm-Message-State: AOJu0YyapGjvb0eMkDKLbtzCrtzJf0aLPR3uRh5zs/0LZ5DsJAoieaDQ
	NXANVWKe1xzu2LZdKUT2y1a8EJuay9GGRxqLZRqbIEL2xX+tIF9W
X-Gm-Gg: ASbGnctUTlp8iYEvZhDL0JcM34skHfdHfAA4w7wp17xSmRrzu1suU0yP6qzbXYROF96
	O1xeRvcBwB33/7bsdApf0ixKdap/ASdnv1LU/yX158rYbYLT+Q/abfsy0nLFluUDYeaygxT/yeW
	RdefR/fyqr5Qy4C2AuElKRxljcsnqSeabECtGITQtQSk0VnQnJ3N14KnYoCESsGQVITdgxG4lP7
	eav9TJ1Rh0boZb4umtnS+/vArNJbWCHah1DpTeT/+ORIjDWM34wotTJ/FPXKv18defXVw==
X-Google-Smtp-Source: AGHT+IFQJh/q5177Fe9nAAwLwJNPGnI2B4eWUEGS3BPZiqzd0QFAP1AoF3G4Y+IoCWKDqCDmMC+x4Q==
X-Received: by 2002:a17:90b:1812:b0:2ea:8aac:6ab9 with SMTP id 98e67ed59e1d1-2ee08e9d54bmr12161768a91.8.1732848541028;
        Thu, 28 Nov 2024 18:49:01 -0800 (PST)
Received: from [172.23.161.188] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee4b1b2c1csm904931a91.9.2024.11.28.18.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 18:49:00 -0800 (PST)
Message-ID: <f27c1cf8-4c00-44dc-80f2-a499cf83ea81@gmail.com>
Date: Fri, 29 Nov 2024 10:48:55 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add WARN_ON_ONCE for syscall_nr check
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20241128115319.305523-1-chen.dylane@gmail.com>
 <20241128074623.063bf253@rorschach.local.home>
 <8d4796dc-ef5b-43d8-8ec0-3891b7994428@gmail.com>
 <62cb12cb-d3b6-4ad1-b9e6-c49b642eaeb4@efficios.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <62cb12cb-d3b6-4ad1-b9e6-c49b642eaeb4@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/11/28 22:27, Mathieu Desnoyers 写道:
> On 2024-11-28 08:15, Tao Chen wrote:
>> 在 2024/11/28 20:46, Steven Rostedt 写道:
>>> On Thu, 28 Nov 2024 19:53:19 +0800
>>> Tao Chen <chen.dylane@gmail.com> wrote:
>>>
>>>> Now, x86_64 kernel not support to trace syscall for ia32 syscall.
>>>> As a result, there is no any trace output when tracing a ia32 task.
>>>> Like unreg_event_syscall_enter, add a WARN_ON_ONCE judgment for
>>>> syscall_nr in perf_syscall_enter and ftrace_syscall_enter to give
>>>> some message.
>>>
>>> So on a system that has "panic_on_warn" set and they trace a 32 bit
>>> system call, it will cause their system to crash. Is that the intended
>>> behavior?
>>>
>>> WARN*() is for self testing the kernel to detect real bugs, not to
>>> inform users that something isn't supported.
>>>
>>> BIG NAK!
>>>
>>> -- Steve
>>
>> Hi, Steve, thank you for your reply, as you say, so what about 
>> pr_warn_once api just to print something ?
>>
> 
> I understand that explicitly enabling a system call and observing
> that ia32 system calls are just not traced by ftrace and perf can
> be surprising for end users. But printing a warning on the tracing
> path for an unimplemented tracing feature is just wrong.
> 

The initial problem was that I used eBPF 
SEC("tp/syscalls/sys_enter_sendto") to capture system calls and found no 
results for i32 programs. So here, i just wanted to remind users that on 
a 64-bit system, i32 system calls are not supported, to avoid confusion.

> Also, AFAIU the warning will trigger if an ia32 program issues any
> system call when any unrelated system call tracing is enabled,
> including non-compat syscalls.
> 
> If you want to check something and return an error, it would
> be in tracefs where the users interact with files that represent
> ia32 system calls to try to list/enable them. However, given the
> exposed files have nothing that mention whether they apply to
> non-compat or compat system calls, it's understandable that an
> end user would think all system calls are traced, including
> compat system calls. So I'm not sure how to solve that in ftrace/perf
> without actually implementing the missing feature the way the
> tracefs ABI is exposed.
> 
> If your end goal is to trace ia32 system call, you may want to try the
> lttng-modules kernel tracer [1], which has supported compat system call
> tracing for the past 12 years (at least since lttng-modules 2.0).

Thank you for your recommendation. I'll take a look at how lttng 
implements it. Actually, SEC("tp/raw_syscall/sys_enter") can also
capure it.

> 
> Thanks,
> 
> Mathieu
> 
> [1] https://lttng.org/
> 


-- 
Best Regards
Dylane Chen
