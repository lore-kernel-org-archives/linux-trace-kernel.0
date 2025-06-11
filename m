Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67575EBE;
	Wed, 11 Jun 2025 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749601274; cv=none; b=MGvXXss9bO6ITo0HJtGAiP5vjP6cDcdLNfgNSkaQ6ehI0C4UASEZRmWBo5E9oAFh5Y8z8hk7cbg2TEYF2SKXBh3IDDxuZdUk4CxmwedUF1iBh9Ve1nBahTvZxLDoBz9yM3DxZzzZc9MpJkphJEhdfkMM9uMNFfTTAmA3dMEhPaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749601274; c=relaxed/simple;
	bh=5M7maN+cSHCHwskgXnnjymfOkGGLppKSjzBoq/C0N5c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oLpTmPCeE+p61XJ64TKVYIiu1E2csnmv8ipXO7Uf2a77SurmVPNHgKr7f0qXJnL184hG2rVSBf4ijpE4nmfmQOlQ1PSlr9uK/Bn2ZKQAADstPHWejpxWRXcvLvOo5SAukyn5JYmp4M2UmUVJ95T/+YRe4oE3VSRfsSgEpdVocdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKrrE0aT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKrrE0aT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036D1C4CEED;
	Wed, 11 Jun 2025 00:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749601274;
	bh=5M7maN+cSHCHwskgXnnjymfOkGGLppKSjzBoq/C0N5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZKrrE0aTEJiPmix6kRun20+sEoLWU244WzGiSNFGF/AjRTLqiPglpkdVmui/meK5U
	 LmeG5BTN8pRclJghk7zc4jpbhLaDGelhs0C3PCYQXIcexT66y8BpGqmyJbbd7CgYJb
	 DTprKSoQQhqx3LWl9L+uHzBXGLArSJ3kd6e7yU+q2x3MVasgOv+rA+8gDuuEiChpAc
	 RHY2IaceKbzvNBS1Q9F83+OEphS6AHOMqNYdwtdXDNt6b74RB4XV16dq04Dyd1I0Xa
	 ub/2gMCjqsFbh/89xEuhSudlSXf3irNqfuEjvv/x7vZ5ExmL5/n/+tCyt6S8d5eaf7
	 QiMijxkbqHqJQ==
Date: Wed, 11 Jun 2025 09:21:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20250611092110.f285e7943666941dfa3b29d3@kernel.org>
In-Reply-To: <20250610115030.0d60da65@gandalf.local.home>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
	<174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
	<20250610115030.0d60da65@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 11:50:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Jun 2025 23:47:48 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Maybe one possible scenario is to hit the int3 after the third step
> > somehow (on I-cache).
> > 
> > ------
> > <CPU0>					<CPU1>
> > 					Start smp_text_poke_batch_finish().
> > 					Start the third step. (remove INT3)
> > 					on_each_cpu(do_sync_core)
> > do_sync_core(do SERIALIZE)
> > 					Finish the third step.
> > Hit INT3 (from I-cache)
> > 					Clear text_poke_array_refs[cpu0]
> > Start smp_text_poke_int3_handler()
> 
> I believe your analysis is the issue here. The commit that changed the ref
> counter from a global to per cpu didn't cause the issue, it just made the
> race window bigger.

Agreed. That is a suspicious commit, but even though, as you said
it might just cause the bug easier. Here I wrote refcount as a
per-cpu array because of showing the current code.

> 
> > Failed to get text_poke_array_refs[cpu0]
> > Oops: int3
> > ------
> > 
> > SERIALIZE instruction flashes pipeline, thus the processor needs
> > to reload the instruction. But it is not ensured to reload it from
> > memory because SERIALIZE does not invalidate the cache.
> > 
> > To prevent reloading replaced INT3, we need to invalidate the cache
> > (flush TLB) in the third step, before the do_sync_core().
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/all/CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com/
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  arch/x86/kernel/alternative.c |   10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index ecfe7b497cad..1b606db48017 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -2949,8 +2949,16 @@ void smp_text_poke_batch_finish(void)
> >  		do_sync++;
> >  	}
> >  
> > -	if (do_sync)
> > +	if (do_sync) {
> > +		/*
> > +		 * Flush the instructions on the cache, then serialize the
> > +		 * pipeline of each CPU.
> 
> The IPI interrupt should flush the cache. And the TLB should not be an
> issue here. If anything, this may work just because it will make the race
> smaller. 

I'm not sure, I'm searching it in the Intel SDM.

> 
> I'm thinking this may be a QEMU bug. If QEMU doesn't flush the icache on an
> IPI then this would indeed be an problem.

Does the qemu manage its icache? (Is that possible to manage it?)
And I guess it is using KVM to run VM, thus the actual cache or TLB
operation has been done by KVM.

Thanks,

> 
> -- Steve
> 
> 
> > +		 */
> > +		flush_tlb_kernel_range((unsigned long)text_poke_addr(&text_poke_array.vec[0]),
> > +				       (unsigned long)text_poke_addr(text_poke_array.vec +
> > +								text_poke_array.nr_entries - 1));
> >  		smp_text_poke_sync_each_cpu();
> > +	}
> >  
> >  	/*
> >  	 * Remove and wait for refs to be zero.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
