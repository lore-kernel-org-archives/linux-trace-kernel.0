Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153054A01;
	Thu, 12 Jun 2025 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687478; cv=none; b=k3pA6ocPVOExRlTyv6KrOVTMnuM1UVb2LL3XPbnwqF2cxhaaf4gra+OP45dCbfjIroQOT3oZSwogbiEMKTuArW+D6mMbYRyjvmeXqEUKmkc6RMnl+IvxQU5cl/GCS2FdNPzE5H+JDAb2ygJuR/6wbmpdNxW7wIFWXeIVDXvLttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687478; c=relaxed/simple;
	bh=wc6IDSsiTBjfnBqqZFbqig/BqFc9LpOYJ/FQ4qGZhWQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Erub2femZeKAZAJgrBeDsa2oxqrP0GofMZgS3IFnFFpKnoAjUC4DEQOEYv6zrbgQf5aVw6A6jfxNJlSSBz/4j7uGICKeNAlig5wGjYjvlGPOw7LYAEwmZnB5btP6uWkSg8U3iPMpcTrnfqsrvjcPS1GInU7+0Bdd0QClR0tnqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVLzBx4j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVLzBx4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A54C4CEE3;
	Thu, 12 Jun 2025 00:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749687477;
	bh=wc6IDSsiTBjfnBqqZFbqig/BqFc9LpOYJ/FQ4qGZhWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVLzBx4j2/wBlZy5lFzhydvDxUtaPGu8kg5azIKoQbhd4/fnRrJ99+jh7qcWSkWtK
	 lTU7uxOSutlSno6kfJ3rFMnFaF/cw5CDJakXkCqq/N7DS0WN7BNeiqj5eJBaBHQDKf
	 QtFtTVGczFPnqEc1NkPxs1Xv8KpleLJQLNYca4d2J1XiWpb6i7gkCa7vx8qmzN76CM
	 E31CxNFjLEQgvYQPZ2/USpilBsuMEri5d/Sy6H2KreEHbrn7+tVICib9pYlNyGKbLW
	 93VboTT+Maq5Kbr2Hg24k/vBp9nnmVXoHiw/7wZnlH4zm3bknsjI/Yapz67EiHOVqS
	 tJt6Bk1g42j/g==
Date: Thu, 12 Jun 2025 09:17:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Naresh Kamboju
 <naresh.kamboju@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org, Naresh Kamboju
 <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: [RFC PATCH 2/2] x86: alternative: Invalidate the cache for
 updated instructions
Message-Id: <20250612091754.b56ed1faf47cdcc1b90aafcd@kernel.org>
In-Reply-To: <20250611113001.GC2273038@noisy.programming.kicks-ass.net>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
	<174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
	<20250611113001.GC2273038@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 13:30:01 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 10, 2025 at 11:47:48PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Invalidate the cache after replacing INT3 with the new instruction.
> > This will prevent the other CPUs seeing the removed INT3 in their
> > cache after serializing the pipeline.
> > 
> > LKFT reported an oops by INT3 but there is no INT3 shown in the
> > dumped code. This means the INT3 is removed after the CPU hits
> > INT3.
> > 
> >  ## Test log
> >  ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
> >  starting test ftrace-stress-test (ftrace_stress_test.sh 90)
> >  <4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI
> >  <4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
> >  6.15.0-next-20250605 #1 PREEMPT(voluntary)
> >  <4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> >  BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> >  <4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50
> >  <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
> >  00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> >  0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
> >  12 e4 fe
> > 
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
> 
> This sounds all sorts of wrong. x86 is supposed to be cache-coherent. A
> store should cause the invalidation per MESI and all that. This means
> the only place where the old instruction can stick around is in the
> uarch micro-ops cache and all that, and SERIALIZE will very much flush
> those.

OK, thanks for pointing it out!

> 
> Also, TLB flush != I$ flush. There is clflush_cache_range() for this.
> But still, this really should not be needed.
> 
> Also, this is all qemu, and qemu is known to have gotten this terribly
> wrong in the past.

What about KVM? We need to ask Naresh how it is running on the machine.
Naresh, can you tell us how the VM is running? Does that use KVM?
And if so, how the kvm is configured(it may depend on the real hardware)?

> 
> If you all cannot reproduce on real hardware, I'm considering this a
> qemu bug.

OK, if it is a qemu's bug, dropping [2/2], but I think we still need
[1/2] to avoid kernel crash (with a warning message without dump).

Thank you,

> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
