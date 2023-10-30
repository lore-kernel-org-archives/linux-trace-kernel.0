Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0F806
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJC57WeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98C1C433C8;
	Mon, 30 Oct 2023 02:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698632582;
	bh=dP5qPGLJ1wP5L7WcvuSAve7OUMyWpR3+PWRGKBvoZfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CJC57WeJlFXsZHC84C0/mby9MImhr/Ea36rrmuEM5aIgfCaEBeDWGRsf+lELRPVzQ
	 YUd/N04gOdc/879fa+AfITC6joXTk4rtEwAFS9q8WOF1A812XFVDCcyIUk8pXskJLj
	 Og1w0rZWHtiQ8ur8QyTunhBtNYIFO/oOLlKuk0YN+SN1YfU2evXzJgfxfuwted40Kf
	 aw79QKxRTWnC9tQXku03gbvbUq2RPLF89grSiLCsrtNyDJIb59Z3Vq9cThQQSs5FxK
	 y6/YjTmalUpY+R/nEJTxNNCNlt5gMPfFZPjpgQRXvls7Yc1S1vff7Jr/GGGM95vwhQ
	 l2GufYrc4plzA==
Message-ID: <391884b5-12b3-4377-bd44-9ae69a4a13df@kernel.org>
Date: Sun, 29 Oct 2023 19:22:59 -0700
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
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 "wuqiang.matt" <wuqiang.matt@bytedance.com>, Vineet Gupta <vgupta@kernel.org>
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
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20231029122641.a8c90d5e6bdfa6e7175bbe97@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/28/23 20:26, Masami Hiramatsu (Google) wrote:
> On Sun, 29 Oct 2023 00:40:17 +0800
> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
>
>> On 2023/10/28 20:49, Masami Hiramatsu (Google) wrote:
>>> Hi Wuqiang,
>>>
>>> On Thu, 26 Oct 2023 19:05:51 +0800
>>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
>>>
>>>> On 2023/10/26 16:46, Arnd Bergmann wrote:
>>>>> On Thu, Oct 26, 2023, at 09:39, wuqiang.matt wrote:
>>>>>> arch_cmpxchg[64]_local() are not defined for openrisc. So implement
>>>>>> them with generci_cmpxchg[64]_local, advised by Masami Hiramatsu.
>>>>>>
>>>>>> Closes:
>>>>>> https://lore.kernel.org/linux-trace-kernel/169824660459.24340.14614817132696360531.stgit@devnote2
>>>>>> Closes:
>>>>>> https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com
>>>>>>
>>>>>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
>>>>> I think on architectures that have actual atomics, you
>>>>> generally want to define this to be the same as arch_cmpxchg()
>>>>> rather than the generic version.
>>>>>
>>>>> It depends on the relative cost of doing one atomic compared
>>>>> to an irq-disable/enable pair, but everyone else went with
>>>>> the former if they could. The exceptions are armv4/armv5,
>>>>> sparc32 and parisc, which don't have a generic cmpxchg()
>>>>> or similar operation.
>>>> Sure, better native than the generic. I'll try to collect more
>>>> insights before next move.
>>> So I will temporally remove the last change (use arch_cmpxchg_local
>>> in objpool) until these series are rewritten with arch native code,
>>> so that the next release will not break the kernel build.
>> Ok, it's fine to me. Thank you.
>>
>>
>>> But this must be fixed because arch_cmpxchg_local() is required
>>> for each arch anyway.
>> Yes. I'm working on the new update for arc/openrisc/hexagon. It would
>> be better resolve this issue first, then consider the objpool update
>> of using arch_cmpxchg_local.
>>
>>>>> You could do the thing that sparc64 and xtensa do, which
>>>>> use the native cmpxchg for supported word sizes but the
>>>>> generic version for 1- and 2-byte swaps, but that has its
>>>>> own set of problems if you end up doing operations on both
>>>>> the entire word and a sub-unit of the same thing.
>>>> Thank you for pointing out this. I'll do some research on these
>>>> implementations.
>>> arc also has the LL-SC instruction but depends on the core feature,
>>> so I think we can use it.
>> Right. The arc processor does have the CONFIG_ARC_HAS_LLSC option, but
>> I doubt the correctness of arch_cmpxchg_relaxed and arch_cmpxchg:
>>
>> arch_cmpxchg_relaxed:
>> ...
>>           switch(sizeof((_p_))) {
>>           case 4:
>> ....
>>
>> arch_cmpxchg:
>> ...
>> 	BUILD_BUG_ON(sizeof(_p_) != 4);		
>> ...
>>
>> _p is the address pointer, so I'm thinking it's a typo but I couldn't
>> yet confirm. There is not much about arc processors in the web :(
> Hmm, indeed. This seems like a bug but it depends on the 'llock  %0, [%1]'
> can take a 32bit address or 32bit data register. Usually it should
> check the size of data, but need to check with ISA manual.
>
> Vineet, can you check this suspicious bug?

ARCv2 is a 32-bit ISA and LLOCK/SCOND work on 32-bit data.
So the pointers will be 32-bit anyways. Is the issue that 
pointer/cmpxchg operation could be on a smaller data type ?

-Vineet
