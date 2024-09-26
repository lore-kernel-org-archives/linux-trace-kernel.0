Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90869BE6C;
	Thu, 26 Sep 2024 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727329438; cv=none; b=i1rgUhBQuXQMQVeuD4j5nBlT23HPcn4qx6X7Shy0HNMzhUGkrRYk0BOFWPedGIL6XyFm45vAjsCJPslbtRwgi/FJKrYhTei5cH8Ji5XoRQj1lPgbSDoKc4oy09PEU5er5citnlbTiNoS+PjiTCLOVrjPXyPVcL2sl9hq7R75peI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727329438; c=relaxed/simple;
	bh=2Cr2KzDGaxjlbO5pCjOqBbTHIf1+/wa+oaWdDL5bYR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bz8gaDvezrQ4JIva8A5PQtQMxl9EP6vwaUxO/biq2diRIDJMlid64WDgxceU1P5PZxjp7lT3Z5XdGrK0eVdwCZ3aUnx5haJGEVxRsQyrqO7rADOngA8zixEOCd+KW2C0c6n/HbVHjf2bbsdzVVu3XbxvTw0TGcG7/mhpAbLRNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbLSCC6+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbLSCC6+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2068a7c9286so5502845ad.1;
        Wed, 25 Sep 2024 22:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727329437; x=1727934237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSQOf0hpG7uYa1+knVWX4FcAmjCoDX0KudBYIIYGWgw=;
        b=KbLSCC6+4kmFuvAH9VMjz132FJJvY0VqUG/ct66rgDdCkj+SmZG75JsblhZUDCad94
         2W7xNkM5SWdkTAgaKry6bcsz1WKQAzYue72FZCW76fAKGl6nuPZMVODuWkkauhZ+bSoj
         9dpMY0yAppQmOW/TrLdTQdeG7QRoyp/RJ3mZGntiUBvbwa9VSBtuysW3mjEmjIOLwdtu
         91/31dtFmGUmFQM+guUZ15oiv3xm5VHMmFyKMnLpw/DNTpzsLJHSOdhJKwanWcOAYw+4
         qRH/qT220YB4ggZey6oz9yNa4qj3j3X66G4xW895lx2g1dx56W0K9zhDDFCwGBJAd8tv
         qHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727329437; x=1727934237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSQOf0hpG7uYa1+knVWX4FcAmjCoDX0KudBYIIYGWgw=;
        b=qXUjkij8aIfcm8FksaZBKlwjDy1vuogqVZAi2aBMrTO0NLZEZjkcPH1R/fzylAyKJW
         VJevlT8rgLvG23pWAmE4HvvZJHO6NXayaZkI809r+2IPt6YFoTUQ+cyRY8T7xoO4ultG
         hkOf/DxPmMwAsOAK1/7CyXg57Kx5Mt9CjB6PZugwcNwgaQAz/Lv31z7V32jtJVARUF1j
         xDAw4/UCx9uRiEGzxMdlMCHFUTUWnp1Qb2Pyzk4CPRMOgu84Yp6S7PQa+AhbDoFDUZfM
         hw3/YAYC1bOHzWr8RLHUgg7YuFCsdSdWkq3+e9YG5K/wv3sc4hKWUWrXT/SJFDtxPWMJ
         Dc0g==
X-Forwarded-Encrypted: i=1; AJvYcCVlgQXVY5CSqbRcxJk6OKV9A1VCM882OlReRLz9E7vZZzwwmAVszVe2pB14wNgnTmpN67X8rNisydfTJ1b3o2+H8gaR@vger.kernel.org, AJvYcCWg8dMV1OFC8DH01BbH0Wqlia0Pfr7BiSYf7tWGEkdlA79J+tWrsF5sIq3LjM4vKPPCZwJPrkducrzJWKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxztN3P1d1i1JxrZiLc4XXQfpBDt0ainorrlQZBB0YMrndOOnzY
	a1vKhZLxn09CgcVoGy/pcfFyYwa2iAQhbClljLCP5941P3pVEH2xvQVKZGJg
X-Google-Smtp-Source: AGHT+IGBodmZxULb1BNXRB/AoWDHT3kpIo/bP9IgJgEGNyBi862p8ZZ5gS2fMrcRbfU8igvHTcLL9A==
X-Received: by 2002:a17:903:191:b0:202:3bda:6f31 with SMTP id d9443c01a7336-20afc43806dmr80143765ad.14.1727329436681;
        Wed, 25 Sep 2024 22:43:56 -0700 (PDT)
Received: from ?IPV6:240d:1a:13a:f00:4b94:68e0:2d8b:3983? ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af185a8casm31465895ad.285.2024.09.25.22.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 22:43:56 -0700 (PDT)
Message-ID: <5298f02a-406b-4f1e-bc1d-f34217eb20bc@gmail.com>
Date: Thu, 26 Sep 2024 14:43:56 +0900
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: Hide a extra entry in stack trace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240923035916.6567-1-tatsuya.s2862@gmail.com>
 <20240926010536.5fe73463@rorschach.local.home>
Content-Language: en-US
From: ts <tatsuya.s2862@gmail.com>
In-Reply-To: <20240926010536.5fe73463@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/26/24 2:05 PM, Steven Rostedt wrote:

> On Mon, 23 Sep 2024 12:59:15 +0900
> Tatsuya S <tatsuya.s2862@gmail.com> wrote:
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
>>
>> To resolve this, increment skip in __ftrace_trace_stack().
>> The reason why skip is incremented in __ftrace_trace_stack()
>> is because __ftrace_trace_stack() in stack trace is the only function
>> that wasn't skipped from anywhere.
>>
>> Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
>> ---
>>   kernel/trace/trace.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index c3b2c7dfadef..e0d98621ff23 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -2919,6 +2919,8 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>>   #ifndef CONFIG_UNWINDER_ORC
>>   	if (!regs)
>>   		skip++;
>> +#else
>> +	skip++;
>>   #endif
> The above #ifdef block should be removed and replaced with;
>
>
> 	if (IS_ENABLED(CONFIG_UNWINDER_ORC) || !regs)
> 		skip++;
>
>>   
>>   	preempt_disable_notrace();
> -- Steve

  I will submit a new patch to fix it.

Thanks.

