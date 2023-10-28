Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5114F90
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jWi3rf9o"
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C029E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Oct 2023 09:40:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc2575dfc7so10954435ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Oct 2023 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698511225; x=1699116025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yPHi822EZvy0863Lz5ya5uesR27d3IKJFKpAAU673LA=;
        b=jWi3rf9oJY5T4bJQaB5/a2QHggwVgtcFer4GcoLViGH0G88/cqDOLgerVyhfs4F0KA
         hxxkOPrX5Edeny3rFKFCik4H6FH7hO4cm/A2Kq6h/JIOQD5zJtQkclmhLhdIGQK7iRXA
         77kXBKJz/1eTJ52V6+IlCnbbD02bMWoV4nV6HomcOUz/enfqvdLOWlekgOuXHxGDJPse
         +t7DPz0YmzVImhaCBXxbPLg1Vml6ilMkV55oZGFGQNPMMT4XRjJ0ogUXaPzRopQDbGaO
         TOfsxToFsPpYNzJaQwnY//v2/bVcTo2/ueC7E1BTwPi6Jn05myGT3SbxwvX6F3vmLoWo
         6Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698511225; x=1699116025;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPHi822EZvy0863Lz5ya5uesR27d3IKJFKpAAU673LA=;
        b=qdY9i1M1KZ6CvMU3VW2Sacd41YdGym9LtbvZVjcO+bwk+xJ7XsdFAMuiV2TfCxDoCi
         EX3q24SGxwjA+fMhFARIAiT6aXtmeiSqiYbP2+UgtTd7Z0a0D9dRi/bc+UZD50EHtXAe
         IMeZC1fSypKY1/wwXBtES7GtRSxLiBiuzY5nZE/TEqVZ+RRD5lcRpKCjdLRYY8w2bf+n
         H116PboKMzSmICizyvm7R+CNl2tUCziFHkf4cVBHft60KWsxr6PCvldp65F4KIdPIxiU
         Qn4O7EJQWQHes1bYJcYQTvLcsVRE1qV4Seq1eCcmKMKC3pgS+6vFzx0GmmCCjacAtuAl
         NTlg==
X-Gm-Message-State: AOJu0YzHS13tl6Tt2STnsB+fLRD2MNaEIV6S6fV1Dd3ZR3p5fdfYV/fd
	3caCkALXgIP6xFGzJs1SLLrqtw==
X-Google-Smtp-Source: AGHT+IEnZtQBQGiUamrt781dGb4iYygKVWheLl9p6Sc3rdm7KU3L7J3rdCAzVuBkjgkzns3y3b4SSg==
X-Received: by 2002:a17:903:124a:b0:1cc:bfd:b221 with SMTP id u10-20020a170903124a00b001cc0bfdb221mr5168348plh.31.1698511225255;
        Sat, 28 Oct 2023 09:40:25 -0700 (PDT)
Received: from ?IPV6:2606:4700:110:82f3:5936:4753:3e8:2d8d? ([2a09:bac5:21b1:1232::1d0:1d])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001cc2f9fd74csm1732444pld.189.2023.10.28.09.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 09:40:24 -0700 (PDT)
Message-ID: <99f9c3d4-0c9e-4542-9511-796f719c36e3@bytedance.com>
Date: Sun, 29 Oct 2023 00:40:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: Re: [PATCH 3/3] locking/atomic: openrisc: use
 generic_cmpxchg[64]_local for arch_cmpxchg[64]_local
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andi Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt
 <palmer@rivosinc.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 linux-trace-kernel@vger.kernel.org, mattwu@163.com,
 linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>
References: <20231026073932.702197-1-wuqiang.matt@bytedance.com>
 <1e3aba7d-89ac-4b62-840e-992527115a70@app.fastmail.com>
 <66f5645c-f9f5-4c53-9503-a1f8470a9bee@bytedance.com>
 <20231028214918.e32265f1dd2ef26fd9d2d1c2@kernel.org>
Content-Language: en-US
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <20231028214918.e32265f1dd2ef26fd9d2d1c2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/28 20:49, Masami Hiramatsu (Google) wrote:
> Hi Wuqiang,
> 
> On Thu, 26 Oct 2023 19:05:51 +0800
> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> 
>> On 2023/10/26 16:46, Arnd Bergmann wrote:
>>> On Thu, Oct 26, 2023, at 09:39, wuqiang.matt wrote:
>>>> arch_cmpxchg[64]_local() are not defined for openrisc. So implement
>>>> them with generci_cmpxchg[64]_local, advised by Masami Hiramatsu.
>>>>
>>>> Closes:
>>>> https://lore.kernel.org/linux-trace-kernel/169824660459.24340.14614817132696360531.stgit@devnote2
>>>> Closes:
>>>> https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com
>>>>
>>>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
>>>
>>> I think on architectures that have actual atomics, you
>>> generally want to define this to be the same as arch_cmpxchg()
>>> rather than the generic version.
>>>
>>> It depends on the relative cost of doing one atomic compared
>>> to an irq-disable/enable pair, but everyone else went with
>>> the former if they could. The exceptions are armv4/armv5,
>>> sparc32 and parisc, which don't have a generic cmpxchg()
>>> or similar operation.
>>
>> Sure, better native than the generic. I'll try to collect more
>> insights before next move.
> 
> So I will temporally remove the last change (use arch_cmpxchg_local
> in objpool) until these series are rewritten with arch native code,
> so that the next release will not break the kernel build.

Ok, it's fine to me. Thank you.


> But this must be fixed because arch_cmpxchg_local() is required
> for each arch anyway.

Yes. I'm working on the new update for arc/openrisc/hexagon. It would
be better resolve this issue first, then consider the objpool update
of using arch_cmpxchg_local.

>>
>>> You could do the thing that sparc64 and xtensa do, which
>>> use the native cmpxchg for supported word sizes but the
>>> generic version for 1- and 2-byte swaps, but that has its
>>> own set of problems if you end up doing operations on both
>>> the entire word and a sub-unit of the same thing.
>>
>> Thank you for pointing out this. I'll do some research on these
>> implementations.
> 
> arc also has the LL-SC instruction but depends on the core feature,
> so I think we can use it.

Right. The arc processor does have the CONFIG_ARC_HAS_LLSC option, but
I doubt the correctness of arch_cmpxchg_relaxed and arch_cmpxchg:

arch_cmpxchg_relaxed:
...
         switch(sizeof((_p_))) {
         case 4:
....

arch_cmpxchg:
...
	BUILD_BUG_ON(sizeof(_p_) != 4);		
...

_p is the address pointer, so I'm thinking it's a typo but I couldn't
yet confirm. There is not much about arc processors in the web :(


> Thank you,
> 
>>
>>>       Arnd
>>
>> Regards,
>> wuqiang
>>
> 
> 

