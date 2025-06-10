Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80323A99D;
	Tue, 10 Jun 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570548; cv=none; b=MJ262U52KskTPQ58N7VewWQXYkFHD1/g7tUAjOwpV8NKtQ8XqG9Rv63Mv0S1m7JpU3XyGPgToFgvsQ1W/FZJk3RXNvkefIUrR90pTjANqmyesK/uoMPz8frodZ80NFiwy6Dq8yplk4TdRNY4Ayi/+2V4j9ElDL1ZOs1JfZwOp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570548; c=relaxed/simple;
	bh=V4tHes/IIVg1jqX+Ct0xk1PjTUOkWhWVAb1ShBKNSXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bz6ZycOsvvgzvdH0kjmxK8GayN1hhBnOWeJgao0IhYYvGLzqRJUymXQmhQmCJUtJOBXmTgJlnVdZemO/27gFjCJ7XmU/Qe3HAH+ng+fDXBIf/48i1wlFxhZzjlv3KAkzlqcwZ4VaENNhFpj/h1gFdVZGpN/q2e1bDLpdKEHYzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 0C7CCE3A82;
	Tue, 10 Jun 2025 15:49:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id A3E8B8000F;
	Tue, 10 Jun 2025 15:49:00 +0000 (UTC)
Date: Tue, 10 Jun 2025 11:50:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Naresh Kamboju
 <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: [RFC PATCH 2/2] x86: alternative: Invalidate the cache for
 updated instructions
Message-ID: <20250610115030.0d60da65@gandalf.local.home>
In-Reply-To: <174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
	<174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A3E8B8000F
X-Stat-Signature: btc1whwobcsppfxog961a7zz8aund8cf
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+66znbe2HhnZqCoZnA2V3tB1XX0Vz9A78=
X-HE-Tag: 1749570540-55510
X-HE-Meta: U2FsdGVkX1/F2SJyN4sNJx3EpcJ6DBc4FcT1KbCSoIFXGTb28Nwg6vzEFOrBaxY+l6kWl/iV/P8WBiztKeHX+3N433I6bpQKr7d1nLPKlFBM3ONKIyff3sOVsKEVqphVEktl4bMSEnDZGDZrarrbsUpDOcbwrQ2LBEYNp+ZIWcn4lZtR5T3Zjub0ld8hM2hBhobAz1ZGASqokTeqBdjsB+zKjp9oeXlPGuWIMRUh4Wdnz5LDJpFeEyJBaGNE+G/FmSPY/vXFv/N71sXZK5Vt19bV+lqs1iX1XO02doj4lcKTJ7tnORwww/yBrn4v+jMicExeoa5yzfxq8P+6bPAMW4pf8ulOP/ZSQaIR+SEnsgiyD3FroahWG6J4ZSR3ObPIra4QaJ0AUmOoXqX7RtY1cZvAUWatR6kns1R3ZUVecf8=

On Tue, 10 Jun 2025 23:47:48 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Maybe one possible scenario is to hit the int3 after the third step
> somehow (on I-cache).
> 
> ------
> <CPU0>					<CPU1>
> 					Start smp_text_poke_batch_finish().
> 					Start the third step. (remove INT3)
> 					on_each_cpu(do_sync_core)
> do_sync_core(do SERIALIZE)
> 					Finish the third step.
> Hit INT3 (from I-cache)
> 					Clear text_poke_array_refs[cpu0]
> Start smp_text_poke_int3_handler()

I believe your analysis is the issue here. The commit that changed the ref
counter from a global to per cpu didn't cause the issue, it just made the
race window bigger.

> Failed to get text_poke_array_refs[cpu0]
> Oops: int3
> ------
> 
> SERIALIZE instruction flashes pipeline, thus the processor needs
> to reload the instruction. But it is not ensured to reload it from
> memory because SERIALIZE does not invalidate the cache.
> 
> To prevent reloading replaced INT3, we need to invalidate the cache
> (flush TLB) in the third step, before the do_sync_core().
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/alternative.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index ecfe7b497cad..1b606db48017 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -2949,8 +2949,16 @@ void smp_text_poke_batch_finish(void)
>  		do_sync++;
>  	}
>  
> -	if (do_sync)
> +	if (do_sync) {
> +		/*
> +		 * Flush the instructions on the cache, then serialize the
> +		 * pipeline of each CPU.

The IPI interrupt should flush the cache. And the TLB should not be an
issue here. If anything, this may work just because it will make the race
smaller. 

I'm thinking this may be a QEMU bug. If QEMU doesn't flush the icache on an
IPI then this would indeed be an problem.

-- Steve


> +		 */
> +		flush_tlb_kernel_range((unsigned long)text_poke_addr(&text_poke_array.vec[0]),
> +				       (unsigned long)text_poke_addr(text_poke_array.vec +
> +								text_poke_array.nr_entries - 1));
>  		smp_text_poke_sync_each_cpu();
> +	}
>  
>  	/*
>  	 * Remove and wait for refs to be zero.
