Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0971DD9D3;
	Tue, 10 Jun 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749544900; cv=none; b=oaZEnBClHOUk84e3j85X0y8rCEXN5X5CsPmPAEohblmdgxh8UeN+9FI7DzwHNtXiWvxMaGg0X2xvCMdMF044T07qGeuz4bdtSyT/uYH2H4h8g++2mG0tsi9V9N1oOJ+ENnfRlN7WxhdfdyWDdQEz8BOxK2sHlLmcY3XihgCJ0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749544900; c=relaxed/simple;
	bh=ln5MjJzHQG7ZWw3NC74Hj688AJ7slzwp1oytTIRVk40=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PJEea7K47tvWJ0Uy7HIzUg0w79r/GBIFEBluCvBOE+F/ZImPz9b/Oj7ipJ8zEocnf9HipVdHmJBDwZKu5pm/tUQHZ7mztCHm7Ky4HHSegvXAvqerK+kt4jTX7jJMpPvKF4/fyxF5szzHP2iCz9clsEfC+I4Dp4QZMzvyVxFonZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltiS+IDc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltiS+IDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C79C4CEEF;
	Tue, 10 Jun 2025 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749544899;
	bh=ln5MjJzHQG7ZWw3NC74Hj688AJ7slzwp1oytTIRVk40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ltiS+IDcUQAI0c5QSox1FawCBRerhP6by1wyMHss+mYDQUlBL9bl89WbWacxl9XpU
	 F/ELM/mkYHI6mwY90t4hgyu1a31LOFdq2unS/Undgewq2N/R1gXzP9DyVpbCllrMuD
	 mwU/wzjRXpiGGKBSJM0zgb2T4gOSAG++NDAoWAdYTyQ66p0OL1R0e2PSND2qaRJpK3
	 V7fMOaBQtKFgytxN+vIXhno0Ng11a2t9Nc3AQIPepVOaS+4UJt2nuTWR2OIt1kx+jl
	 4KToxlpP8Xmy7wyq9yNiCZg6e3r0SOgNvID7a1DYXkiZEDvXJF6wDngQVB51pHuEtc
	 ikIIGt35xyOPw==
Date: Tue, 10 Jun 2025 17:41:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-Id: <20250610174136.b88bd16959a4d7eff27cc3fa@kernel.org>
In-Reply-To: <20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Jun 2025 22:09:34 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

[...]
> Here is the compiled code of _raw_spin_lock.
> 
> ffffffff825daa00 <_raw_spin_lock>:
> ffffffff825daa00:       f3 0f 1e fa             endbr64
> ffffffff825daa04:       e8 47 a6 d5 fe          call   ffffffff81335050 <__fentry__>
> 
> Since int3 exception happens after decoded int3 (1 byte), the RIP
> `_raw_spin_lock+0x05` is not an instruction boundary.
> 
> > <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
> > 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> > 0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
> > 12 e4 fe
> 
> And the call is already modified back to a 5-bytes nop when we
> dump the code. Thus it may hit the intermediate int3 for transforming
> code.
> 
> e8 47 a6 d5 fe
>  (first step)
> cc 47 a6 d5 fe
>  (second step)
> cc 1f 44 00 00 <- hit?
>  (third step)
> 0f 1f 44 00 00 <- handle int3
> 
> It is very unlikely scenario (and I'm not sure qemu can correctly
> emulate it.) But if a CPU hits the int3 (cc) on _raw_spin_lock()+0x4
> before anoter CPU' runs third step in smp_text_poke_batch_finish(),
> and before the CPU runs smp_text_poke_int3_handler(), the CPU' runs
> the thrid step and sets text_poke_array_refs 0, 
> the smp_text_poke_int3_handler() returns 0 and causes the same
> problem. 
> 
> <CPU0>					<CPU1>
> 					Start smp_text_poke_batch_finish().
> 					Finish second step.
> Hit int3 (*)
> 					Finish third step.
> 					Run smp_text_poke_sync_each_cpu().(**)
> 					Clear text_poke_array_refs[cpu0]
> Start smp_text_poke_int3_handler()
> Failed to get text_poke_array_refs[cpu0]
> Oops: int3
> 
> 
> But as I said it is very unlikely, because as far as I know;
> 
> (*) smp_text_poke_int3_handler() is called directly from exc_int3()
>    which is a kind of NMI, so other interrupt should not run.
> (**) In the third step, smp_text_poke_batch_finish() sends IPI for
>    sync core after removing int3. Thus any int3 exception handling
>    should be finished.

Maybe one possible scenario is to hit the int3 after the third step
somehow (on I-cache?).

------
<CPU0>					<CPU1>
					Start smp_text_poke_batch_finish().
					Start the third step. (remove INT3)
					on_each_cpu(do_sync_core)
do_sync_core(do SERIALIZE)
					Finish the third step.
Hit INT3 (from I-cache?)
					Clear text_poke_array_refs[cpu0]
Start smp_text_poke_int3_handler()
Failed to get text_poke_array_refs[cpu0]
Oops: int3
------


SERIALIZE instruction may flash pipeline, thus the processor needs
to reload the instruction. But it is not ensured to reload it from
memory because SERIALIZE does not invalidate the cache.

If that hypotheses is correct, we need to invalidate the cache
(flush TLB) in the third step, before the do_sync_core().

Or, if it is unsure, we can just evacuate the kernel from die("int3")
by retrying the new instruction, when the INT3 is disappeared.


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
