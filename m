Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808BA10E0;
	Thu,  4 Sep 2025 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947235; cv=none; b=m04ht6LvyjCbsTDFrpfX9386bZsFuqE0pAa+AlmKXp5ejO9kdqVwKyhQpjGLSWxBXmceUtMLPDAyDPudncu7QOsPeyTvao2uaJH0+F/pAlp0g8r+MY7CK2bnrbRtNxzd5mFBrAnpbbYd5wZZ06Nbjbd06IzY0AUFiePAXOwL/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947235; c=relaxed/simple;
	bh=gnt3M4lwFGjrobAWEub6gb7JgQ52Qk90u4VjNy13tIk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WJ6Oy1gbmCevksm/8yA6ctWXyaK56Vf7uHgfsYZ7l9TrP7wxT2a6uYDBlWFYiMxdVSHswTo2VWOA/vVT1CMfr/b8ssbbgnY1K8WKvNIRfkKxnQRavfCpC1VcxCTmu73Xx8RDc2BrWXEPqI5TpmStqWlhQRwWTF6icLgnY/0cm9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjPXwJ9X; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjPXwJ9X"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so506024a91.2;
        Wed, 03 Sep 2025 17:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756947234; x=1757552034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fpt21/2dXymrTrGtlDxkh6WDP5Hwjh1uV/oV9OO6L3Q=;
        b=XjPXwJ9XZkdQwrU+G4UDa7RR/Oe7G4ISCtT2EWkRc0P2fdoywOXcaSMVOMJ/3gBtnK
         ep0kdQpc+zE6EjwRKx95U/hhIGFIu+rSWD0Nzk2Uf7hUNkjVpcWy5e/bxMFLQaBeGiLw
         8NaxqU1Wn+AUZZQK6853GlAe4vUkWpVghGURCtJSyJzGdhgR7O5WbEifsQcT9DhS6O5h
         kRJ1F9mqDkDe7pRqwYLGcD/hJi1kmDJkw77kbZCRGOt4xOqo3tN2N9nEqLnCogvw5wI9
         XHr26+6UIEuIrdVjzAKQVDA3jnoLU7bg503tI0hRRxTm2hugyXvJPMPzQYpn/ugY9YJO
         3eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756947234; x=1757552034;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpt21/2dXymrTrGtlDxkh6WDP5Hwjh1uV/oV9OO6L3Q=;
        b=OkFolfZn8ZtU9u46vxPjX6i5hjUtyMX8bdpEL74XU9pP3xpa6KnXCPNwWyqT4HajPB
         zINLqoofiky5beWUdfEC4+rZL93RcYPQtsVBhmGHuA9q9s+5hfg5b2xUqTwOSmiQHPlu
         RsG5FXqUogANfZEkkXv/eupf6CNa7AmX5AjtESIQht671rintwuiHaS2gUQ9SRB3FSOl
         qYAydNEa4F6jfKBqsu33LOr3SLzN7utUvRwsQUGRs115P6zTn6co4/BlHnklKN+2yK0X
         EoZXywDtxLHA8FnP69Sjqv4sdIydmO9SkJKX8AW//cDYZnC+X2FnSsDXfgndbLeHqT7x
         8Irg==
X-Forwarded-Encrypted: i=1; AJvYcCU1jqU++/F46xDCmgFUMjQ3zUNbUY7zzei3Ym1zRTJsCfFoVbe36g38wpUjwLTzvw43qVFINaHdIRs51a4=@vger.kernel.org, AJvYcCUBvpY51mWYooX7mtDqs+6Xgd5ceZPrN+C4poNqcU+AeSdESMONgaZywzerdZqlB+MFOxTzo8ghRPHu4v7sicPp71YS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Z2EUVsDb4ivm2GQICcpaJXyXv37gnjwRZAw6n1hH4rE10Jik
	2pyYGn2LC+zpO0vXduCDsBMeuIOET1rAoGZeZ04Kdx/E3NNUtmMDbuT4
X-Gm-Gg: ASbGnctAPZ4Urn+bGSM2yPeX9ZZeojH1+9+vgEIK+ioP0EwD5QXL17I1rvFpWj2c2kK
	j12cEYJ1Vg/zQph9gWWtD7M5/3UtwhmEkz/6aw/GomUXPrcfTSLlf+DqTq0z58X/teliukVYu6L
	jOVDoJ5Jp9sD1Vvl9J/KQ7srz12ISg/beob3ZEi121kZrrCzzxprlCb8909XUYx+rZIxtyctspb
	v5Jr9CV4HHAkhOW4/xnW70aHZSTzRQDhdZKfV6BUjiUNUTfjkBfqg2k7DTfX3jtH6B+1Adqyjr0
	PB+NnvCdhOcNv1WTSlUAigGECh/oloKq1vB/irx5TUA37jDowc+6pPbKI7xcXdinQbIAuOB3aTX
	m5Q9UvJw+R/gnq/rLau9amQVYmOPySnhaBPBg
X-Google-Smtp-Source: AGHT+IFS6U7cNiPi3jk1jx6kSKBR1YaQ2RMeDyXRDytuUUaEbR8NxZhWZ1vHQ4n9l+d2nUGFpF4tHw==
X-Received: by 2002:a17:90b:3bc7:b0:32b:97f8:d3fe with SMTP id 98e67ed59e1d1-32b97f8d486mr180700a91.6.1756947233684;
        Wed, 03 Sep 2025 17:53:53 -0700 (PDT)
Received: from [127.0.0.1] ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3299739e0aesm11478253a91.8.2025.09.03.17.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 17:53:53 -0700 (PDT)
Message-ID: <4ed45039-63c6-4639-b73c-7121d419a8d5@gmail.com>
Date: Thu, 4 Sep 2025 08:53:47 +0800
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
From: Jinchao Wang <wangjinchao600@gmail.com>
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
In-Reply-To: <5a6dde06-11ee-4ce7-9cb5-f0b8096e42ed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/25 15:58, Jinchao Wang wrote:
> On 9/2/25 22:11, Masami Hiramatsu (Google) wrote:
>> On Mon, 1 Sep 2025 18:23:44 +0800
>> Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>
>>> On 9/1/25 15:06, Masami Hiramatsu (Google) wrote:
>>>> Hi Jinchao,
>>>>
>>> Hi Masami,
>>>
>>>> On Mon, 18 Aug 2025 20:26:07 +0800
>>>> Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>>>
>>>>> Add arch_reinstall_hw_breakpoint() to enable atomic context 
>>>>> modification
>>>>> of hardware breakpoint parameters without deallocating and 
>>>>> reallocating
>>>>> the breakpoint slot.
>>>>>
>>>>> The existing arch_install_hw_breakpoint() allocates a new debug 
>>>>> register
>>>>> slot, while arch_uninstall_hw_breakpoint() deallocates it. However, 
>>>>> some
>>>>> use cases require modifying breakpoint parameters (address, length, 
>>>>> type)
>>>>> atomically without losing the allocated slot, particularly when 
>>>>> operating
>>>>> in atomic contexts where allocation might fail or be unavailable.
>>>>>
>>>>> This is particularly useful for debugging tools like kstackwatch that
>>>>> need to dynamically update breakpoint targets in atomic contexts while
>>>>> maintaining consistent hardware state.
>>>>>
>>>>
>>>> I'm also trying to find this interface for my wprobe. So the idea is 
>>>> good.
>>>> But this looks hacky and only for x86. I think the interface should be
>>>> more generic and do not use this arch internal function directly.
>>>>
>>>
>>> I agree with your point about the architectural dependency. I have been
>>> considering this problem not only for the hardware breakpoint
>>> reinstallation,
>>> but also for other related parts of the series, such as canary 
>>> finding and
>>> stack address resolving. These parts also rely on arch-specific code.
>>
>> Yes, even though, the hw-breakpoint is an independent feature.
>> Directly using arch_*() functions (which are expected to be used
>> internally) introduces a hidden dependency between these two
>> components and looses maintainability.
> 
> Yes, I am trying to improve this in the v3 series.
> 
>>
>>>> It seems that the slot is allocated by "type", thus, if this reinstall
>>>> hwbp without deallocate/allocate slot, it must NOT change the type.
>>>> See __modify_bp_slot. Also, provide CONFIG_HAVE_... option for checking
>>>> whether the architecture support that interface.
>>>>
>>> Regarding the slot allocation, I would like to clarify my point. I
>>> believe the
>>> event->attr.type should not be changed when reinstalling a hardware
>>> breakpoint, as this defines the fundamental nature of the event. The 
>>> type
>>> must always be PERF_TYPE_BREAKPOINT.
>>>
>>> The event->attr.bp_type, however, can be changed. For example, from a
>>> HW_BREAKPOINT_W to a HW_BREAKPOINT_RW without needing to deallocate and
>>> reallocate the slot. This is useful for future applications, even 
>>> though the
>>> current use case for KStackWatch only requires HW_BREAKPOINT_W.
>>
>> I understand your point, so it also needs another wrapper which checks
>> the type is compatible on the architecture.
>>
> 

> I think the wrapper should handle the type by type_slot, something like[1]:
> ...
> 
> For kernel breakpoints, we might also consider introducing a
> modify_kernel_hw_breakpoint() helper, similar to
> modify_user_hw_breakpoint(), to encapsulate the kernel-specific case.
> 

Hi Masami,
I have a new idea, indroducing hw_breakpoint_modify_local():
   - call hw_breakpoint_arch_parse to validate bp_{type,addr,len},
     eliminating the need for a separate type-only check
   - use a__weak arch_reinstall_hw_breakpoint for other archs

If other archs require additional checks, they could add that logic to 
hw_breakpoint_modify_local or their hw_breakpoint_arch_parse().

Seems clear and simple enough.

Regarding the arch dependency problems you mentioned, I have solved them 
and sent a v2 series:
https://lore.kernel.org/all/20250904002126.1514566-7-wangjinchao600@gmail.com/

>>
>>>
>>> Thank you again for your valuable review.
>>> -- 
>>> Best regards,
>>> Jinchao
>>
>>
> 
> 


-- 
Best regards,
Jinchao
