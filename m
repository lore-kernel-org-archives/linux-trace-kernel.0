Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA5227E87;
	Wed, 11 Jun 2025 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641417; cv=none; b=abksqOMWlkJpAQOWBqLthQK2wYyFWuK8cTg/A4eD0UZ0bd2QCCSc1BadVXNPLVahHD6+g9YH+O4Gh6DDn19CV4zyIBgxQSKcAncwAAVr284qSXouGLdEkJipturNHJS9fY321jpIoiXTM1isaFHavSjLHQzkR8flx561I+n82yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641417; c=relaxed/simple;
	bh=m6blkxtSiFevkn9+SEbUvI5bgj1njuddm9OXkMQ48Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIG8dkU8coirj2xTHD0j5qUwoi9BFv/JivD0hfir00+3jCvbyX9TUXFwINLxVYS0619VYfFO5aJFbKQvOd+cow++FfiOpYZ8lZBeI4nOgmfGKJFp2tue2GSIXqH4uWTn61vGfyq7wI5iY4tLkJl9atQqD1JQJICRoSoD3StTjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cr85IuBV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cr85IuBV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zbZtV+ASXG/xMvGIVDeJhxlEcfyIM+8fV7E63+SUj7Q=; b=Cr85IuBVTCeAC+RH1C5XYpgQhO
	gxD4B+I8JzVnANm3DHp9zp9NYJNt+qRsHD05OLpU7KuFjrQpWHBCFYdKn+TxRihnZdX5jw+rDUeOt
	RPin8Qq9kj9aNOKVq3fGBY00di26U1iylDh6vmTRAOJyVgNI7jezIcOTlPbeX27s1ctai69TLQdwC
	6dAouMmbwaifqwdp88AZKWmApOGq0cOGgLs/B/4Fz0SRHqhi0k/azinqwMasTco8ajdMbhrXPXbsx
	jghQ1/DT4pCzfTKSKvxgNDlJWpnK5jpBHXosjMKtVLa5bQcGYtbzrL6MX2Me2Aaa+GXarMLTnZgSj
	OtnJsoHQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPJeb-0000000Aa8i-3umN;
	Wed, 11 Jun 2025 11:30:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3121F30863B; Wed, 11 Jun 2025 13:30:01 +0200 (CEST)
Date: Wed, 11 Jun 2025 13:30:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [RFC PATCH 2/2] x86: alternative: Invalidate the cache for
 updated instructions
Message-ID: <20250611113001.GC2273038@noisy.programming.kicks-ass.net>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
 <174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>

On Tue, Jun 10, 2025 at 11:47:48PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Invalidate the cache after replacing INT3 with the new instruction.
> This will prevent the other CPUs seeing the removed INT3 in their
> cache after serializing the pipeline.
> 
> LKFT reported an oops by INT3 but there is no INT3 shown in the
> dumped code. This means the INT3 is removed after the CPU hits
> INT3.
> 
>  ## Test log
>  ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
>  starting test ftrace-stress-test (ftrace_stress_test.sh 90)
>  <4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI
>  <4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
>  6.15.0-next-20250605 #1 PREEMPT(voluntary)
>  <4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>  BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>  <4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50
>  <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
>  00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
>  0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
>  12 e4 fe
> 
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

This sounds all sorts of wrong. x86 is supposed to be cache-coherent. A
store should cause the invalidation per MESI and all that. This means
the only place where the old instruction can stick around is in the
uarch micro-ops cache and all that, and SERIALIZE will very much flush
those.

Also, TLB flush != I$ flush. There is clflush_cache_range() for this.
But still, this really should not be needed.

Also, this is all qemu, and qemu is known to have gotten this terribly
wrong in the past.

If you all cannot reproduce on real hardware, I'm considering this a
qemu bug.


