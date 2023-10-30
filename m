Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250AEA3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Vrv2vMou"
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE839B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Oct 2023 20:41:57 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2988d62eso2805738a34.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Oct 2023 20:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698637317; x=1699242117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFA7XAcFie/JhCiQl6pMzZYEdRmFHLdXEhUI5ZhUkqE=;
        b=Vrv2vMouiLQzoymbp2dqgwDdBrIFepIwMCtP/nqZIP9S9bGpXGx/gVtnDnheh0g3VV
         WF9vNybW2+sxIBLnTKd9cHCAyJewEuODp9dMpppFKE40xKVeFk/OYlple58x6I5DD9E7
         tAu859N6iEh4OMoMaEbSNC7MxyDOOLHoKSP2kVG0ibySl2+WYe0WGvC+oB23SX4aGV9r
         E4OdhnLowFYsNoKh0H8yHdhvruc7yD2ZLa4P4q+g42yllA4LnrAS9IzbWb7xBOUc6g9f
         gbty3ZbgDrZGNg9XC8NF8hzIswg+IXyqqxRaoecvj1hwmap8B2Vn7fud3XXim+im5dm2
         9r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698637317; x=1699242117;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFA7XAcFie/JhCiQl6pMzZYEdRmFHLdXEhUI5ZhUkqE=;
        b=ST8yk6LXYRQymlg2IIPtvJBNPnMQWohJiG4YGo0X0kDYecdIQ7qQ3r6VLnaTxvs1J7
         ZXJdJ2nxYMltPvr1LmdiKETMuUBsNZLg3Mjek541Ql7i6b/hYgk9LSj9vSuhJUH8pBG+
         AVP7zcrFNeWcR05yertpwhnuF19nP15E8MQWBxxykC9W8ina9RK4IWISViboZJCYSTn2
         nGY/5QhlHdQ7WN/G7FnoKYilv3iovRZouclGw1wHVDhCDosyypsmnN+oyTPqjqgO0hl8
         8BPADZdHxDPEAdbfVad1vKCZaSYblniqoPUCJzB/e912VHIZ6I2lFjzkXydulmPixHg1
         UkWg==
X-Gm-Message-State: AOJu0YwV4amyfBAQs8Sa1GTiOjLFUu5mkLX9zY+a2LB74b7ZDN5YWLvm
	H6w3lMsPSSD36jPf4wfBOiA7zg==
X-Google-Smtp-Source: AGHT+IFBKTulY1yGKK6SLWJybdyT0GD4yTFgaLeyz3OyhlaBhZJXJVcFwNDCd2OdyltcXlX0JMsjvA==
X-Received: by 2002:a9d:6245:0:b0:6bf:3f4:3edc with SMTP id i5-20020a9d6245000000b006bf03f43edcmr9342918otk.22.1698637317202;
        Sun, 29 Oct 2023 20:41:57 -0700 (PDT)
Received: from [192.168.3.101] ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id gx13-20020a056a001e0d00b0068aca503b9fsm4886767pfb.114.2023.10.29.20.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 20:41:56 -0700 (PDT)
Message-ID: <7836be7b-ed41-4e0f-8983-9603bd6fcde0@bytedance.com>
Date: Mon, 30 Oct 2023 11:41:41 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] locking/atomic: openrisc: use
 generic_cmpxchg[64]_local for arch_cmpxchg[64]_local
Content-Language: en-US
To: Vineet Gupta <vgupta@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andi Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt
 <palmer@rivosinc.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 linux-trace-kernel@vger.kernel.org, mattwu@163.com,
 linux-snps-arc@lists.infradead.org
References: <20231026073932.702197-1-wuqiang.matt@bytedance.com>
 <1e3aba7d-89ac-4b62-840e-992527115a70@app.fastmail.com>
 <66f5645c-f9f5-4c53-9503-a1f8470a9bee@bytedance.com>
 <20231028214918.e32265f1dd2ef26fd9d2d1c2@kernel.org>
 <99f9c3d4-0c9e-4542-9511-796f719c36e3@bytedance.com>
 <20231029122641.a8c90d5e6bdfa6e7175bbe97@kernel.org>
 <391884b5-12b3-4377-bd44-9ae69a4a13df@kernel.org>
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <391884b5-12b3-4377-bd44-9ae69a4a13df@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/10/30 10:22, Vineet Gupta wrote:
> 
> 
> On 10/28/23 20:26, Masami Hiramatsu (Google) wrote:
>> On Sun, 29 Oct 2023 00:40:17 +0800
>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
>>
>>> On 2023/10/28 20:49, Masami Hiramatsu (Google) wrote:
>>>> Hi Wuqiang,
>>>>
>>>> On Thu, 26 Oct 2023 19:05:51 +0800
>>>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
>>>>
>>>>> On 2023/10/26 16:46, Arnd Bergmann wrote:
>>>>>> On Thu, Oct 26, 2023, at 09:39, wuqiang.matt wrote:
>>>>>>> arch_cmpxchg[64]_local() are not defined for openrisc. So implement
>>>>>>> them with generci_cmpxchg[64]_local, advised by Masami Hiramatsu.
>>>>>>>
>>>>>>> Closes:
>>>>>>> https://lore.kernel.org/linux-trace-kernel/169824660459.24340.14614817132696360531.stgit@devnote2
>>>>>>> Closes:
>>>>>>> https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com
>>>>>>>
>>>>>>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
>>>>>> I think on architectures that have actual atomics, you
>>>>>> generally want to define this to be the same as arch_cmpxchg()
>>>>>> rather than the generic version.
>>>>>>
>>>>>> It depends on the relative cost of doing one atomic compared
>>>>>> to an irq-disable/enable pair, but everyone else went with
>>>>>> the former if they could. The exceptions are armv4/armv5,
>>>>>> sparc32 and parisc, which don't have a generic cmpxchg()
>>>>>> or similar operation.
>>>>> Sure, better native than the generic. I'll try to collect more
>>>>> insights before next move.
>>>> So I will temporally remove the last change (use arch_cmpxchg_local
>>>> in objpool) until these series are rewritten with arch native code,
>>>> so that the next release will not break the kernel build.
>>> Ok, it's fine to me. Thank you.
>>>
>>>
>>>> But this must be fixed because arch_cmpxchg_local() is required
>>>> for each arch anyway.
>>> Yes. I'm working on the new update for arc/openrisc/hexagon. It would
>>> be better resolve this issue first, then consider the objpool update
>>> of using arch_cmpxchg_local.
>>>
>>>>>> You could do the thing that sparc64 and xtensa do, which
>>>>>> use the native cmpxchg for supported word sizes but the
>>>>>> generic version for 1- and 2-byte swaps, but that has its
>>>>>> own set of problems if you end up doing operations on both
>>>>>> the entire word and a sub-unit of the same thing.
>>>>> Thank you for pointing out this. I'll do some research on these
>>>>> implementations.
>>>> arc also has the LL-SC instruction but depends on the core feature,
>>>> so I think we can use it.
>>> Right. The arc processor does have the CONFIG_ARC_HAS_LLSC option, but
>>> I doubt the correctness of arch_cmpxchg_relaxed and arch_cmpxchg:
>>>
>>> arch_cmpxchg_relaxed:
>>> ...
>>>           switch(sizeof((_p_))) {
>>>           case 4:
>>> ....
>>>
>>> arch_cmpxchg:
>>> ...
>>>     BUILD_BUG_ON(sizeof(_p_) != 4);
>>> ...
>>>
>>> _p is the address pointer, so I'm thinking it's a typo but I couldn't
>>> yet confirm. There is not much about arc processors in the web :(
>> Hmm, indeed. This seems like a bug but it depends on the 'llock  %0, [%1]'
>> can take a 32bit address or 32bit data register. Usually it should
>> check the size of data, but need to check with ISA manual.
>>
>> Vineet, can you check this suspicious bug?
> 
> ARCv2 is a 32-bit ISA and LLOCK/SCOND work on 32-bit data.
> So the pointers will be 32-bit anyways. Is the issue that pointer/cmpxchg 
> operation could be on a smaller data type ?

For ARCv2 with CONFIG_ARC_HAS_LLSC, better add the data size checking and
only permit 32bit data size. Even for 32-bit system, data should can be
64bit 'long long'.

And In the case that CONFIG_ARC_HAS_LLSC is undefined, in arch_cmpxchg: the
pointer size checking is unnecessary, since it's using spinlock internally:

https://elixir.bootlin.com/linux/v6.6-rc7/source/arch/arc/include/asm/cmpxchg.h#L60: 

	BUILD_BUG_ON(sizeof(_p_) != 4);					\
									\
	/*								\
	 * spin lock/unlock provide the needed smp_mb() before/after	\
	 */								\
	atomic_ops_lock(__flags);					\
	_prev_ = *_p_;							\
	if (_prev_ == _o_)						\
		*_p_ = _n_;						\
	atomic_ops_unlock(__flags);

Another question about the naming: arch_cmpxchg_relaxed() implemented if
CONFIG_ARC_HAS_LLSC is configured and arch_cmpxchg() defined for the rest.
Are there any reasons for difference names ?

As I checked, Synopsys has released 64bit ARC processors (HS66/HS68), but
I don't know the status of Linux kernel support.

> -Vineet

Regards,
wuqiang
