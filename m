Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F32472B0;
	Fri, 13 Jun 2025 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784171; cv=none; b=CggI9QDPkKsnMnk4aBuPOZ7L2HgfXayk7gB5t2Is6uj7DhjcQ96mCppRPb09RgOzBlOGKFHFhdBDAnWVE/aDvQnlRflT5nkxl5+L41+rIe4QMDF1Ji6S1cJ+58OatObK2/zRl0H5J7++pRBaV5AX9bavRO8LjMzqfPMSkIuzO9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784171; c=relaxed/simple;
	bh=ko9xFiAtVkoCHS1Cc0Is5tNLABIf7lXljr/UCuSRbPM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Dx6NK+aMCQnxLYRB5ITAt7+edTfMosspv+pNJE2suwBEz4fA5EZA8K0ByWzxxG0YtPNDntmJX3etq+Tx+ccwTXrqhIMDskWcwe1RkldMozCGev2AuYg94gAbngfbj8lF27tlvfa5IimsfWCRLJn1w+Fu90quJIjSgH5GpgmtqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knB6J9ly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knB6J9ly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFDFC4CEEA;
	Fri, 13 Jun 2025 03:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749784170;
	bh=ko9xFiAtVkoCHS1Cc0Is5tNLABIf7lXljr/UCuSRbPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=knB6J9lywSaiV7Akpzeng5Ldco541PHxe3j5DNMiaUyH7fjyIj2XRTbuZk4MyjiNj
	 RxgluXjgclE6ppcclJU6bb8nueCn0Wov80T6XHBvuSYmGK6m9DI0DbYEeBcvqcCZuM
	 CtOHgqbt0exmdmz9rft309PWyM8ocuihbA/JV49t+SCp6UNmi+b5klC66egTKLvm7n
	 xj9tDtwdpvDEXiM8KQ69Ct6z43SL6woamwyVGHAYAOlbRE+eFmuORwu4f5usIi+vFu
	 BwhuIIye8CXJJxSrKhBhFya4J2+0847QJ+xuQmVh56ANy3LWSOvLlIhnIHiPAA1X32
	 xVOIPql2ssBoA==
Date: Fri, 13 Jun 2025 12:09:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 x86@kernel.org, open list <linux-kernel@vger.kernel.org>, Linux trace
 kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: [RFC PATCH 2/2] x86: alternative: Invalidate the cache for
 updated instructions
Message-Id: <20250613120922.ca63de7d90c9e20265c89ce6@kernel.org>
In-Reply-To: <CA+G9fYt=zY4Xt1ZrkKqENdrJ41=iT5JcKnYn004=paANbG6UPA@mail.gmail.com>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
	<174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
	<20250611113001.GC2273038@noisy.programming.kicks-ass.net>
	<20250612091754.b56ed1faf47cdcc1b90aafcd@kernel.org>
	<CA+G9fYt=zY4Xt1ZrkKqENdrJ41=iT5JcKnYn004=paANbG6UPA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 21:54:05 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> On Thu, 12 Jun 2025 at 05:47, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 11 Jun 2025 13:30:01 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > On Tue, Jun 10, 2025 at 11:47:48PM +0900, Masami Hiramatsu (Google) wrote:
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > > Invalidate the cache after replacing INT3 with the new instruction.
> > > > This will prevent the other CPUs seeing the removed INT3 in their
> > > > cache after serializing the pipeline.
> > > >
> > > > LKFT reported an oops by INT3 but there is no INT3 shown in the
> > > > dumped code. This means the INT3 is removed after the CPU hits
> > > > INT3.
> > > >
> > > >  ## Test log
> > > >  ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
> > > >  starting test ftrace-stress-test (ftrace_stress_test.sh 90)
> > > >  <4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI
> > > >  <4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
> > > >  6.15.0-next-20250605 #1 PREEMPT(voluntary)
> > > >  <4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > > >  BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > > >  <4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50
> > > >  <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
> > > >  00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> > > >  0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
> > > >  12 e4 fe
> > > >
> > > > Maybe one possible scenario is to hit the int3 after the third step
> > > > somehow (on I-cache).
> > > >
> > > > ------
> > > > <CPU0>                                      <CPU1>
> > > >                                     Start smp_text_poke_batch_finish().
> > > >                                     Start the third step. (remove INT3)
> > > >                                     on_each_cpu(do_sync_core)
> > > > do_sync_core(do SERIALIZE)
> > > >                                     Finish the third step.
> > > > Hit INT3 (from I-cache)
> > > >                                     Clear text_poke_array_refs[cpu0]
> > > > Start smp_text_poke_int3_handler()
> > > > Failed to get text_poke_array_refs[cpu0]
> > > > Oops: int3
> > > > ------
> > > >
> > > > SERIALIZE instruction flashes pipeline, thus the processor needs
> > > > to reload the instruction. But it is not ensured to reload it from
> > > > memory because SERIALIZE does not invalidate the cache.
> > > >
> > > > To prevent reloading replaced INT3, we need to invalidate the cache
> > > > (flush TLB) in the third step, before the do_sync_core().
> > >
> > > This sounds all sorts of wrong. x86 is supposed to be cache-coherent. A
> > > store should cause the invalidation per MESI and all that. This means
> > > the only place where the old instruction can stick around is in the
> > > uarch micro-ops cache and all that, and SERIALIZE will very much flush
> > > those.
> >
> > OK, thanks for pointing it out!
> >
> > >
> > > Also, TLB flush != I$ flush. There is clflush_cache_range() for this.
> > > But still, this really should not be needed.
> > >
> > > Also, this is all qemu, and qemu is known to have gotten this terribly
> > > wrong in the past.
> >
> > What about KVM? We need to ask Naresh how it is running on the machine.
> > Naresh, can you tell us how the VM is running? Does that use KVM?
> > And if so, how the kvm is configured(it may depend on the real hardware)?
> 
> We do not use KVM and are running the Qemu version (10.0.0).
> 
> >
> > >
> > > If you all cannot reproduce on real hardware, I'm considering this a
> > > qemu bug.
> 
> It is reproducible intermittently on x86_64 device and qemu-x86 device
> with and without compat mode.

Interesting, so it seems not a KVM/qemu issue, but a real bug in the
INT3 (maybe text_poke?).

> 
> This link is showing how intermittent it is on Linux next tree.
> 
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250606/testrun/28685600/suite/log-parser-test/test/oops-oops-int3-smp-pti/history/?page=2

I found this example did not remove INT3 but failed to handle it.

https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250501/testrun/28300874/suite/log-parser-test/test/oops-oops-int3-smp-pti/details/

>>>>>>
[   77.103476] Oops: int3: 0000 [#1] SMP PTI
[   77.103481] CPU: 2 UID: 0 PID: 10062 Comm: cat Not tainted 6.15.0-rc4-next-20250501 #1 PREEMPT_{RT,(full)} 
[   77.103484] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS 2.7 12/07/2021
[   77.103485] RIP: 0010:kmem_cache_alloc_noprof+0x10a/0x2c0
[   77.103490] Code: 4c 89 e7 e8 28 e4 cd 00 66 90 f7 c5 00 00 40 00 0f 85 89 01 00 00 f6 43 09 20 0f 85 7f 01 00 00 4c 8b 24 24 48 8b 74 24 38 cc <1f> 44 00 00 48 8b 44 24 08 65 48 2b 05 cd e5 23 02 0f 85 8e 01 00
[   77.103491] RSP: 0018:ffffa0954960bac0 EFLAGS: 00000202
[   77.103493] RAX: 0000000000000001 RBX: ffff9105c0229700 RCX: 0000000000000007
[   77.103494] RDX: ffff9105c7589180 RSI: ffffffffb6fc247e RDI: ffff9105c7589180
[   77.103495] RBP: 0000000000000cc0 R08: 0000000000000006 R09: 00000000000000c0
[   77.103496] R10: ffffa0954960bbb8 R11: ffff9105cd06310c R12: ffff9105c3583300
[   77.103497] R13: 00000000000000c0 R14: ffffffffb6fc247e R15: ffff9105c3b7c200
[   77.103499] FS:  0000000000000000(0000) GS:ffff9109668b7000(0000) knlGS:0000000000000000
[   77.103500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   77.103501] CR2: 00007ffdbe756f50 CR3: 0000000103e24003 CR4: 00000000003726f0
[   77.103502] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   77.103503] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   77.103504] Call Trace:
[   77.103505]  <TASK>
[   77.103507]  vm_area_dup+0x1e/0xe0
[   77.103510]  __split_vma+0xa0/0x320
[   77.103513]  vms_gather_munmap_vmas+0xab/0x230
[   77.103514]  __mmap_region+0x211/0xb80
[   77.103521]  do_mmap+0x3fa/0x5a0
[   77.103524]  vm_mmap_pgoff+0xfc/0x1d0
[   77.103528]  ksys_mmap_pgoff+0x149/0x1f0
[   77.103531]  ? do_syscall_64+0x7e/0x1d0
[   77.103535]  do_syscall_64+0xb2/0x1d0
[   77.103537]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>>>

The code pattern looks like a text_poke_batch() 

cc <1f> 44 00 00 = BYTES_NOP5 with INT3.

But since it is not at the entry of the symbol, it may not a ftrace entry,
maybe a tracepoint?

-------
void *kmem_cache_alloc_noprof(struct kmem_cache *s, gfp_t gfpflags)
{
	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE, _RET_IP_,
				    s->object_size);

	trace_kmem_cache_alloc(_RET_IP_, ret, s, gfpflags, NUMA_NO_NODE);

	return ret;
}
-------

Hmm, it seems like smp_text_poke_batch_finish() in the first step
(add INT3 on NOP) or the second step (right before removing INT3).

Thanks,

> 
> - Naresh
> 
> >
> > OK, if it is a qemu's bug, dropping [2/2], but I think we still need
> > [1/2] to avoid kernel crash (with a warning message without dump).
> >
> > Thank you,
> >
> > >
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
