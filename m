Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763081C6B4;
	Thu,  4 Sep 2025 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756948529; cv=none; b=XXXIoXdsfYMqJFpoTmWh47b9SLyMZ9nVzFeDzgxoiUaRKFelfMwATdUJdRUepytpzYndQI+nuETj1DQT2kNxqCSSRUm3tEpXwfAHNWINlzsPiHDF0GhqjHnKDgVUcWpXsbeEv23ThqEIEuDgBN+o8LQgjdvzIOOLz+SkcWIhplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756948529; c=relaxed/simple;
	bh=bzkTbmiv7TtqOsso3gdezYpqTKdFyOVSoSFv51y08EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdfhPdIDzlF04H1Qaofpc7VI7SGNUFyg6cBO+6pYqUBvzs43lRW2c+zedpKbQ3ohX9o6RWsJkXzINthxOpbgD7Wf1DxLDqdavLSJuUqMdhCSxuPg6knGqEddaVKIX0WbHpKpt+Wgvr+3vivc+DizypCpjm+e5WTfvKp3c+bVt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fk+8lxYp; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk+8lxYp"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e96ee32f86bso676433276.0;
        Wed, 03 Sep 2025 18:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756948526; x=1757553326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2bKdcT7iTL0M0foBoGAazsId5D8WGbE87p97GeaaRA=;
        b=Fk+8lxYpkOyz3hRFa83P30vxlqsnrNLtdJT1KCGtw1UKoGWyB8QZFqrbyXfFjtxriA
         yI/oNoNS3wpsyiEp1bCcn5g1/kaVw1pf1MNkLL6cCCoDwA1k96FMdxLspv4pqdZY10e4
         VYGS09yH8i7xYdDc3VZqzQWRLua5LtJ/F81boB8OyiCu50RuJbGUysAkeAxMJZ1hqPVZ
         NLtbkLci4ciRo8qIWPA94iPoDlK06ARb43JJHhvG6bQs2tU23O3q31z7EZ4j1XoiQp7Z
         ByThbTxbrcR/hGKzEXXd2/eF3mwTx+N/xgkypKa9UyrXJo2tzyExlMXKjOa//4gCtUnc
         tgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756948526; x=1757553326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2bKdcT7iTL0M0foBoGAazsId5D8WGbE87p97GeaaRA=;
        b=fAoN0N+g7FxlXR4xORyMpLcc7lUVWdgSRoUoGLp5F4Q5XjY9Ljy72K/JrbnzqcHgj5
         6W0qmzuhL7dzSqJBZUo+1Lcw47HXN9iJJGRULV7tkib0KcA+X9gNs8w3xNA+ul2AQ6qv
         AaekBcRutetTi3gokjJG0QuC+rY9cX1e5gy+6Hszx1NrnQz/3zPdVTZnZ1nb1lcBjbCE
         tT69a38+Mk5IQX+hdy0b7UrHg87ywbuWppqJDHxBpTG7HIlhDfgZdQ3Z2Koa8mRg5pNn
         PNJFAPjeCkALi3465Y9Qu6iGM/cbtgO0YQu2+WmpzLCUpsj0Cr8T5Hpw2JyfwlbnvISY
         ahUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6RolDPErqFyk8PLnXX3vMiQeFJMceSrxbPuGjVxhGW4TctZ1bj3oCcuRqziK4Ul7OKHCCLzJhc0QRK57YKUXIpXL@vger.kernel.org, AJvYcCXfytNakKcX4UzOYquEF8KJDEEVpiRWDsDNBph+jD1hL2HDn+/5gjbOXOZClk1ASrlEfGwq+mrL3NN0Kdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97oAFR3pb5a7oFolfo0RVJxNSRWSD/tPtd1K0k+skzKysVJ1e
	QVpf/yUKYoVB6fzzoh7Eyj9N6+yFQwtRr/aGvCT0H9X+hYpasCY/pXEa5Unfou8xXMUXCQ==
X-Gm-Gg: ASbGncu13XC3Cvy3DAEgekfZGrVBGp957TlLFVG3T6fXJ12XgF9Z0G1Qu8mTjuAHH/0
	yfvh03nOWjJX/9tV0YvoGutj3vOKRJVxZ716UBiAVgFIpP19SVKD2K3QetXuki93WngI/aREw6y
	lA1hKUYEnpkCKpj9MgTFmaPwhwRfLJUThXs8PrEWb43BYQGLN6nhqQzxhPUK+2s1RX2ZtY0yPIE
	OBHFxfFDdgWNvDpJxec2xGKBjkhVF9rV5s2dVBBP67aozOdI2Sab3CRetdFcOGPwOlS52+O96Sz
	Bot5f+6NkfNsz7cLUVA8OJ3kkOdyec2FmabwTcXbKBsdeSLL5MBZznUH/W9ggzSBzojXZpnOYed
	rCJUkcfPc8yRivyjPaiLKXr9I4RHv5kiZZtl6EuNZd+EGCjZ9PX0=
X-Google-Smtp-Source: AGHT+IEk/3J2EywD3d03w2jHZI+Qv8mu+ar25YB1ZQ39f5q83vbIDxKz9WBUw4aesQ9/JWtxW19TvA==
X-Received: by 2002:a05:690e:4107:b0:606:29d6:64ef with SMTP id 956f58d0204a3-60629d669ebmr1846046d50.15.1756948526207;
        Wed, 03 Sep 2025 18:15:26 -0700 (PDT)
Received: from [127.0.0.1] ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a83295b7sm17979517b3.24.2025.09.03.18.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 18:15:25 -0700 (PDT)
Message-ID: <6a874eff-f740-4a08-b669-eaa3be3be5af@gmail.com>
Date: Thu, 4 Sep 2025 09:15:20 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/13] x86/HWBP: Add arch_reinstall_hw_breakpoint()
 for atomic updates
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, naveen@kernel.org, davem@davemloft.net,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250901160602.e25f0107e7b0ef4af1078fb7@kernel.org>
 <284d5eef-447f-4e12-a121-3742d708c96f@gmail.com>
 <20250902231152.442041a74774d888cec39201@kernel.org>
 <5a6dde06-11ee-4ce7-9cb5-f0b8096e42ed@gmail.com>
 <20250904100231.e0bb08d069db31520a6e0435@kernel.org>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20250904100231.e0bb08d069db31520a6e0435@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/25 09:02, Masami Hiramatsu (Google) wrote:
> On Wed, 3 Sep 2025 15:58:44 +0800
> Jinchao Wang <wangjinchao600@gmail.com> wrote:
> 
>> On 9/2/25 22:11, Masami Hiramatsu (Google) wrote:
>>> On Mon, 1 Sep 2025 18:23:44 +0800
>>> Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>>
>>>> On 9/1/25 15:06, Masami Hiramatsu (Google) wrote:
>>>>> Hi Jinchao,
>>>>>
>>>> Hi Masami,
>>>>
>>>>> On Mon, 18 Aug 2025 20:26:07 +0800
>>>>> Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>>>>
>>>>>> Add arch_reinstall_hw_breakpoint() to enable atomic context modification
>>>>>> of hardware breakpoint parameters without deallocating and reallocating
>>>>>> the breakpoint slot.
>>>>>>
>>>>>> The existing arch_install_hw_breakpoint() allocates a new debug register
>>>>>> slot, while arch_uninstall_hw_breakpoint() deallocates it. However, some
>>>>>> use cases require modifying breakpoint parameters (address, length, type)
>>>>>> atomically without losing the allocated slot, particularly when operating
>>>>>> in atomic contexts where allocation might fail or be unavailable.
>>>>>>
>>>>>> This is particularly useful for debugging tools like kstackwatch that
>>>>>> need to dynamically update breakpoint targets in atomic contexts while
>>>>>> maintaining consistent hardware state.
>>>>>>
>>>>>
>>>>> I'm also trying to find this interface for my wprobe. So the idea is good.
>>>>> But this looks hacky and only for x86. I think the interface should be
>>>>> more generic and do not use this arch internal function directly.
>>>>>
>>>>
>>>> I agree with your point about the architectural dependency. I have been
>>>> considering this problem not only for the hardware breakpoint
>>>> reinstallation,
>>>> but also for other related parts of the series, such as canary finding and
>>>> stack address resolving. These parts also rely on arch-specific code.
>>>
>>> Yes, even though, the hw-breakpoint is an independent feature.
>>> Directly using arch_*() functions (which are expected to be used
>>> internally) introduces a hidden dependency between these two
>>> components and looses maintainability.
>>
>> Yes, I am trying to improve this in the v3 series.
>>
>>>
>>>>> It seems that the slot is allocated by "type", thus, if this reinstall
>>>>> hwbp without deallocate/allocate slot, it must NOT change the type.
>>>>> See __modify_bp_slot. Also, provide CONFIG_HAVE_... option for checking
>>>>> whether the architecture support that interface.
>>>>>
>>>> Regarding the slot allocation, I would like to clarify my point. I
>>>> believe the
>>>> event->attr.type should not be changed when reinstalling a hardware
>>>> breakpoint, as this defines the fundamental nature of the event. The type
>>>> must always be PERF_TYPE_BREAKPOINT.
>>>>
>>>> The event->attr.bp_type, however, can be changed. For example, from a
>>>> HW_BREAKPOINT_W to a HW_BREAKPOINT_RW without needing to deallocate and
>>>> reallocate the slot. This is useful for future applications, even though the
>>>> current use case for KStackWatch only requires HW_BREAKPOINT_W.
>>>
>>> I understand your point, so it also needs another wrapper which checks
>>> the type is compatible on the architecture.
>>>
>>
>> I think the wrapper should handle the type by type_slot, something like[1]:
>>
> 
> Ah, that's a good idea!
> 
>> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
>> index 1db2c5e24d0e..6fed9521baf2 100644
>> --- a/kernel/events/hw_breakpoint.c
>> +++ b/kernel/events/hw_breakpoint.c
>> @@ -752,6 +752,7 @@ modify_user_hw_breakpoint_check(struct perf_event
>> *bp, struct perf_event_attr *a
>>    {
>>    	struct arch_hw_breakpoint hw = { };
>>    	int err;
>> +	enum bp_type_idx old_type_idx, new_type_idx;
>>
>>    	err = hw_breakpoint_parse(bp, attr, &hw);
>>    	if (err)
>> @@ -766,7 +767,9 @@ modify_user_hw_breakpoint_check(struct perf_event
>> *bp, struct perf_event_attr *a
>>    			return -EINVAL;
>>    	}
>>
>> -	if (bp->attr.bp_type != attr->bp_type) {
>> +	old_type_idx = find_slot_idx(bp->attr.bp_type);
>> +	new_type_idx = find_slot_idx(attr->bp_type);
>> +	if (old_type_idx != new_type_idx) {
>>    		err = modify_bp_slot(bp, bp->attr.bp_type, attr->bp_type);
>>    		if (err)
>>    			return err;
>>
>> For kernel breakpoints, we might also consider introducing a
>> modify_kernel_hw_breakpoint() helper, similar to
>> modify_user_hw_breakpoint(), to encapsulate the kernel-specific case.
>>
>> [1]https://lore.kernel.org/all/20250903075144.3722848-3-wangjinchao600@gmail.com/
> 
> Hmm, it seems that there is *user_hw_breakpoint() and *wide_hw_breakpoint()
> (maybe it means system-wide) so it is better to call modify_wide_hw_breakpoint().
> (anyway it is only for kernel address space...)
> 
> Thank you!

The counterpart to user might be kernel, and wide likely means "for all 
CPUs".

We might have missed each other's emails due to the time zone 
difference. Thank you so much for your feedback.>
>>
>>>>
>>>> By the way, I have sent an updated series.
>>>> https://lore.kernel.org/all/20250828073311.1116593-1-wangjinchao600@gmail.com/
>>>
>>> Yeah, OK, let me review the series. Thanks for update!
>>>
>>>>
>>>> Thank you again for your valuable review.
>>>> -- 
>>>> Best regards,
>>>> Jinchao
>>>
>>>
>>
>>
>> -- 
>> Best regards,
>> Jinchao
> 
> 
-- 
Best regards,
Jinchao
