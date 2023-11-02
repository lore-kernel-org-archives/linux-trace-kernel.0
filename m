Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66631FA1
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVICs0oh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D2AC433C7;
	Thu,  2 Nov 2023 04:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698900796;
	bh=b0KGNE6x/h29Z2T8T9S2Xy4wGWhLbh3W04APGfGzXzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JVICs0ohKtVqpPsZEUHAH/fC/mp0V4N+IZTopM66fevT3qcb3BJ5+y6zHsR/7XHN7
	 r1A23ATKpGXmIoFHPf99bvusJkCp5H0+Bx8dXka2V771oaLVY5eJTzlaMBWxxlicfi
	 x7uCHvvL5OW6RkXE/PHckvdthWc7Wn8ax+ER7lKLqQpDLGMgTabRnARWY4/fXHzd0q
	 5PtxJEY7b+2gaHzuXuD63nxA996fnxhHCi/s7GCkdrutVCgZhdB2v0pxtJa1OuUEYk
	 HQ/meDg/vWWLh3IOSW1H3y+CmP9D+Ks7B+juio9iEDciDU90oRQEaGF4Ryiq9UN4jb
	 zBc3gFAfzL2DQ==
Message-ID: <67f536b5-1b42-49b1-b219-f5fd8906495d@kernel.org>
Date: Wed, 1 Nov 2023 21:53:14 -0700
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
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 Vineet Gupta <vgupta@kernel.org>,
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
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <7836be7b-ed41-4e0f-8983-9603bd6fcde0@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/29/23 20:41, wuqiang.matt wrote:
>>>>
>>>> arch_cmpxchg_relaxed:
>>>> ...
>>>>           switch(sizeof((_p_))) {
>>>>           case 4:
>>>> ....
>>>>
>>>> arch_cmpxchg:
>>>> ...
>>>>     BUILD_BUG_ON(sizeof(_p_) != 4);
>>>> ...
>>>>
>>>> _p is the address pointer, so I'm thinking it's a typo but I couldn't
>>>> yet confirm. There is not much about arc processors in the web :(
>>> Hmm, indeed. This seems like a bug but it depends on the 'llock  %0, 
>>> [%1]'
>>> can take a 32bit address or 32bit data register. Usually it should
>>> check the size of data, but need to check with ISA manual.
>>>
>>> Vineet, can you check this suspicious bug?
>>
>> ARCv2 is a 32-bit ISA and LLOCK/SCOND work on 32-bit data.
>> So the pointers will be 32-bit anyways. Is the issue that 
>> pointer/cmpxchg operation could be on a smaller data type ?
>
> For ARCv2 with CONFIG_ARC_HAS_LLSC, better add the data size checking and
> only permit 32bit data size. Even for 32-bit system, data should can be
> 64bit 'long long'.

Right, makes sense. Can you send a patch ?

>
> And In the case that CONFIG_ARC_HAS_LLSC is undefined, in 
> arch_cmpxchg: the
> pointer size checking is unnecessary, since it's using spinlock 
> internally:

Correct, I had the same thought.

>
> https://elixir.bootlin.com/linux/v6.6-rc7/source/arch/arc/include/asm/cmpxchg.h#L60: 
>
>     BUILD_BUG_ON(sizeof(_p_) != 4);                    \
>                                     \
>     /*                                \
>      * spin lock/unlock provide the needed smp_mb() before/after    \
>      */                                \
>     atomic_ops_lock(__flags);                    \
>     _prev_ = *_p_;                            \
>     if (_prev_ == _o_)                        \
>         *_p_ = _n_;                        \
>     atomic_ops_unlock(__flags);

Can you do that fix in same patch as well ?

> Another question about the naming: arch_cmpxchg_relaxed() implemented if
> CONFIG_ARC_HAS_LLSC is configured and arch_cmpxchg() defined for the 
> rest.
> Are there any reasons for difference names ?

Yes the atomics API consists of _relaxed, _acquire, _release and unadorned.
_relaxed is the most efficient, with rest having some extra barriers.
If arch provides _relaxed, generic code can create the rest - assuming 
arch hardware can support the relaxed ones.
That is true for LLSC.

However for !LLSC, spinlock versions already have full barriers due to 
spinlock, so relaxed variant doesn't make sense.

>
> As I checked, Synopsys has released 64bit ARC processors (HS66/HS68), but
> I don't know the status of Linux kernel support.

Yes there's an internal ARC64 port running but it is not ready for 
upstreaming yet.

-Vineet
