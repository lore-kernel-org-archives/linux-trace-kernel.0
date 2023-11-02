Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BE12B61
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ErM1K3D/"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD318C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:05:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc329ce84cso6265735ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Nov 2023 03:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698919512; x=1699524312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=//kTyjVjcUFtCf9fvPHX0Mi7MlvS7YMHsnweLRC1MB4=;
        b=ErM1K3D/7cECClribYoezZiuhkUqRdL+3YcTOU1W3Bd+Uq5k4lWZTc3lNlC7t8PCiu
         zSN2BOC1MFk8E7df+p4lUzGsEuQH0ZCwvKJMKAp61otAHJIiOCiW/0g0L/nKiinHtoB3
         vtdiLXmh/Yb21wK7NxRJy6maI4wQhoc1/Spyu9s8cG9RQbs5QmqQfr9Fpl08oq+TW/3T
         C1zROiH78nbwtI3Kq2gGO0xQa6bzt6qxAYRfOOGeVxhtrXwe/AiUqhygu1Z/y/Y7aeYZ
         ZT1LQLat4e2xfIZCWPffPIT+DHAKXtLAEqNvatc4ZOauDhqG2DDlkgdLQpB+VO7mat42
         t8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698919512; x=1699524312;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//kTyjVjcUFtCf9fvPHX0Mi7MlvS7YMHsnweLRC1MB4=;
        b=NblJiWAFrwnpQ57klznkepZZSpkgLrgqbFmlr+x7aSKHWmfEpebky9BwfE2QUtXe0V
         ULvW+B42JfP29wLPak7jgticuOcQ/FG8tOWv3bvDTMAzNwPc6geMOW2xEpL88lWLz5NU
         5A/XYG4P5iTiMwpfp0/HIxfQJjAYFekWJUt7sX66IYnwa38sOuLg1vpzUcYIaK5UFTHk
         Dn4m8gHS5iQTleMOl+2dr4vaBeLC4mUgufmwPsWKyUVJ0tkHoNDllCiePJg5HRp0k7Ka
         XqLuV1Nqho+r9x9yIumkJoSjVIk1E7N+xfBLMQfeHEzDZNY9tLeUomFn5bZa+SwcBBwp
         MPYA==
X-Gm-Message-State: AOJu0YzxwkpQnBFdSmNSTWOpYi1ZaTwbc3QSFeIWumGqRnAtOpKV7+o2
	21IebKLfi1SEyK3m2l1lfwS+eg==
X-Google-Smtp-Source: AGHT+IFqiDDKukwnOWMz0Wq+wYfcP0JSBT0Rbrlx+LOINIfwxDRgn2ncQILFCg6RE0JbKhtb3u1h4w==
X-Received: by 2002:a17:902:ecca:b0:1cc:54b5:b4fa with SMTP id a10-20020a170902ecca00b001cc54b5b4famr10812060plh.18.1698919512127;
        Thu, 02 Nov 2023 03:05:12 -0700 (PDT)
Received: from [192.168.6.6] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id az5-20020a170902a58500b001c728609574sm2753180plb.6.2023.11.02.03.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 03:05:11 -0700 (PDT)
Message-ID: <8511e096-365f-4625-88d1-affd498685e1@bytedance.com>
Date: Thu, 2 Nov 2023 18:05:04 +0800
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
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
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
 <7836be7b-ed41-4e0f-8983-9603bd6fcde0@bytedance.com>
 <67f536b5-1b42-49b1-b219-f5fd8906495d@kernel.org>
 <3c7cc279-d5ea-4071-ba68-88563a6a0877@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 xsDNBGOidiIBDADKahCm8rTJ3ZgXTS0JR0JWkorMj3oNDI0HnLvHt8f9DBmjYyV11ol0FYUr
 uJ230wjVVKLMm0yBk3jX7Dsy0jggnIcVlINhaXV9DMxzLBM7Vc55FuB9M5/ZaSrM+V5LeG+t
 nPbZie6yzJbNpdGBdVXnXiOAEgT9+kYqgCRBOJdpzZyEHv14elfGOMo8PVCxiN2UEkCG+cg1
 EwfMgy2lZXsGP/By0DaEHnDtyXHfNEwlyoPHOWu7t+PWCw3FgXndX4wvg0QN0IYqrdvP+Tbl
 YQLAnA9x4odjYvqwfUDXavAb7OHObEBrqNkMX7ifotg64QgZ0SZdB3cd1Az5dC3i0zmGx22Q
 pPFseJxGShaHZ0KeE+NSlbUrz0mbiU1ZpPCeXrkuj0ud5W3QfEdHh00/PupgL/Jiy6CHWUkK
 1VN2jP52uUFYIpwUxaCj1IT9RzoHUMYdf/Pj4aUUn2gflaLMQFqH+aT68BncLylbaZybQn/X
 ywm05lNCmTq7M7vsh2wIZ1cAEQEAAc0kd3VxaWFuZyA8d3VxaWFuZy5tYXR0QGJ5dGVkYW5j
 ZS5jb20+wsEHBBMBCAAxFiEEhAnU1znx1I9+E57kDMyNdoDoPy8FAmOidiMCGwMECwkIBwUV
 CAkKCwUWAgMBAAAKCRAMzI12gOg/LzhCC/sEdGvOQbv0zaQw2tBfw7WFBvAuQ6ouWpPQZkSV
 3mZihJKfaxBjjhpjtS5/ieMebChUoiVoofx9VTCaP3c/qQ/qzYUYdKCzQL92lrqRph0qK/tJ
 QPxFUkUEgsSwY7h/SEMsga8ziPczBdVf+0HWkmKGL1uvfS6c72M2UMSulvg73kxjxUIeg30s
 BTzh6g94FiCOhn8Ali2aHhkbRgQ2RoXNqgmyp6zGdI3pigk1irIpfGF6qmGshNUw/UTLLKos
 /zJdNjezfPaHifNSRgCnuLfQ1jennpEirgxUcLNQSWrUFqOOb/bJcWsWgU3P84dlfpNqbXmI
 Qo6gSWzuetChHAPl0YHpvATrOuXqJtxrvsOVWg9nGaPj7fjm0DEvp32a2eFvVz7a3SX8cuQv
 RUE915TsKcXeX9CBx1cDPGmggT+IT6oqk0lup3ZL980FZhVk7wXoj1T4rEx9JFeZV5KikET1
 j7NFGAh2oBi19cE3RT+NEwsSO2q8JvTgoluld2BzN57OwM0EY6J2IwEMANHVmP9TbdLlo0uT
 VtKl+vUC1niW9wiyOZn1RlRTKu3B+md/orIMEbVHkmYb4rmxdAOY+GRHazxw30b88MC0hiNc
 paHtp7GqlqRJ9PkQVc1M6EyMP4zuem0qOR+t0rq3n8pTWLFyji+wWj2J06LOqsEx36Qx+RbV
 8E2cgRA3e43ldHYBx+ZNM/kBLLLzvMNriv0DQJvZpNfhewLw/87rNZ3QfkxzNYeBAjLj11S5
 gPLRXMc5pRV/Tq2bSd9ijinpGVbDCnffX2oqCBg2pYxBBXa9/LvyqK+eZrdkAkvoYTFwczpS
 c5Sa6ciSvVWHJmWDixNfb8o9T5QJHifTiRLk2KnjFKJCq6D8peP93kst5JoADytO2x0zijgP
 h+iX+R+kXdRW8Ib1nJVY96cjE08gnewd9lq/7HpL2NIuEL6QVPExKXNQsJaFe554gUbOCTmN
 nbIVYzRaBeTfVqGoGNOIq/LkqMwzr2V5BufCPFJlLGoHXQ4zqllS4xSHSyjmAfF7OwARAQAB
 wsD2BBgBCAAgFiEEhAnU1znx1I9+E57kDMyNdoDoPy8FAmOidiQCGwwACgkQDMyNdoDoPy9v
 iwwAjE0d5hEHKR0xQTm5yzgIpAi76f4yrRcoBgricEH22SnLyPZsUa4ZX/TKmX4WFsiOy4/J
 KxCFMiqdkBcUDw8g2hpbpUJgx7oikD06EnjJd+hplxxj+zVk4mwuEz+gdZBB01y8nwm2ZcS1
 S7JyYL4UgbYunufUwnuFnD3CRDLD09hiVSnejNl2vTPiPYnA9bHfHEmb7jgpyAmxvxo9oiEj
 cpq+G9ZNRIKo2l/cF3LILHVES3uk+oWBJkvprWUE8LLPVRmJjlRrSMfoMnbZpzruaX+G0kdS
 4BCIU7hQ4YnFMzki3xN3/N+TIOH9fADg/RRcFJRCZUxJVzeU36KCuwacpQu0O7TxTCtJarxg
 ePbcca4cQyC/iED4mJkivvFCp8H73oAo7kqiUwhMCGE0tJM0Gbn3N/bxf2MTfgaXEpqNIV5T
 Sl/YZTLL9Yqs64DPNIOOyaKp++Dg7TqBot9xtdRs2xB2UkljyL+un3RJ3nsMbb+T74kKd1WV
 4mCJUdEkdwCS
In-Reply-To: <3c7cc279-d5ea-4071-ba68-88563a6a0877@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/11/2 17:30, wuqiang.matt wrote:
> On 2023/11/2 12:53, Vineet Gupta wrote:
>>
>>
>> On 10/29/23 20:41, wuqiang.matt wrote:
>>>>>>
>>>>>> arch_cmpxchg_relaxed:
>>>>>> ...
>>>>>>           switch(sizeof((_p_))) {
>>>>>>           case 4:
>>>>>> ....
>>>>>>
>>>>>> arch_cmpxchg:
>>>>>> ...
>>>>>>     BUILD_BUG_ON(sizeof(_p_) != 4);
>>>>>> ...
>>>>>>
>>>>>> _p is the address pointer, so I'm thinking it's a typo but I couldn't
>>>>>> yet confirm. There is not much about arc processors in the web :(
>>>>> Hmm, indeed. This seems like a bug but it depends on the 'llock  %0, [%1]'
>>>>> can take a 32bit address or 32bit data register. Usually it should
>>>>> check the size of data, but need to check with ISA manual.
>>>>>
>>>>> Vineet, can you check this suspicious bug?
>>>>
>>>> ARCv2 is a 32-bit ISA and LLOCK/SCOND work on 32-bit data.
>>>> So the pointers will be 32-bit anyways. Is the issue that pointer/cmpxchg 
>>>> operation could be on a smaller data type ?
>>>
>>> For ARCv2 with CONFIG_ARC_HAS_LLSC, better add the data size checking and
>>> only permit 32bit data size. Even for 32-bit system, data should can be
>>> 64bit 'long long'.
>>
>> Right, makes sense. Can you send a patch ?
> 
> Okay, I will.
> 
>>>
>>> And In the case that CONFIG_ARC_HAS_LLSC is undefined, in arch_cmpxchg: the
>>> pointer size checking is unnecessary, since it's using spinlock internally:
>>
>> Correct, I had the same thought.
>>
>>>
>>> https://elixir.bootlin.com/linux/v6.6-rc7/source/arch/arc/include/asm/cmpxchg.h#L60:
>>>     BUILD_BUG_ON(sizeof(_p_) != 4);                    \
>>>                                     \
>>>     /*                                \
>>>      * spin lock/unlock provide the needed smp_mb() before/after    \
>>>      */                                \
>>>     atomic_ops_lock(__flags);                    \
>>>     _prev_ = *_p_;                            \
>>>     if (_prev_ == _o_)                        \
>>>         *_p_ = _n_;                        \
>>>     atomic_ops_unlock(__flags);
>>
>> Can you do that fix in same patch as well ?
> 
> Sure.
> 
>>> Another question about the naming: arch_cmpxchg_relaxed() implemented if
>>> CONFIG_ARC_HAS_LLSC is configured and arch_cmpxchg() defined for the rest.
>>> Are there any reasons for difference names ?
>>
>> Yes the atomics API consists of _relaxed, _acquire, _release and unadorned.
>> _relaxed is the most efficient, with rest having some extra barriers.
>> If arch provides _relaxed, generic code can create the rest - assuming arch 
>> hardware can support the relaxed ones.
> 
> Definitely Yes! The generic cmpxchg will prefer arch_cmpxchg_relaxed rather
> than arch_cmpxchg.

It should be arch_cmpxchg (if defined) rather than arch_cmpxchg_relaxed. I
just double checked with v6.6:

	...
	#if defined(arch_cmpxchg)
	#define raw_cmpxchg arch_cmpxchg
	#elif defined(arch_cmpxchg_relaxed)
		#define raw_cmpxchg(...) \
		__atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
	#else
	extern void raw_cmpxchg_not_implemented(void);
	#define raw_cmpxchg(...) raw_cmpxchg_not_implemented()
	#endif
	...
	#if defined(arch_cmpxchg_relaxed)
	#define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
	#elif defined(arch_cmpxchg)
	#define raw_cmpxchg_relaxed arch_cmpxchg
	#else
	extern void raw_cmpxchg_relaxed_not_implemented(void);
	#define raw_cmpxchg_relaxed(...) raw_cmpxchg_relaxed_not_implemented()
	#endif
	...

I made the mistake since the definitions of v5.2 confused me. The followings
are for v5.2, and these conditions are removed from v5.14:

	...
	#if !defined(arch_cmpxchg_relaxed) || defined(arch_cmpxchg)
	#define cmpxchg(ptr, ...) \
	({ \
		typeof(ptr) __ai_ptr = (ptr); \
		instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
		arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
	})
	#endif
	...
	#if defined(arch_cmpxchg_relaxed)
	#define cmpxchg_relaxed(ptr, ...) \
	({ \
		typeof(ptr) __ai_ptr = (ptr); \
		instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
		arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
	})
	#endif
	...

Sorry for the noise.

>> That is true for LLSC.
>>
>> However for !LLSC, spinlock versions already have full barriers due to 
>> spinlock, so relaxed variant doesn't make sense.
>>
>>>
>>> As I checked, Synopsys has released 64bit ARC processors (HS66/HS68), but
>>> I don't know the status of Linux kernel support.
>>
>> Yes there's an internal ARC64 port running but it is not ready for 
>> upstreaming yet.
> 
> Thanks for the update.
> 
>> -Vineet
> 
> Regards,
> wuqiang

