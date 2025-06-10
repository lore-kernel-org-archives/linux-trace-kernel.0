Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261381D9663;
	Tue, 10 Jun 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566591; cv=none; b=DgoYR6zBQE0cXiANFYNv7j6h/6avdMLze/eIudQFtHvCfyvVjO5zJVK4PaW5O3TDSWAfgEdh3s2h1sUPUpzobmTfdix67l4dP6MWRINnAsCkUMU3JR/rfgvtfYGvNFooIGEjWhkrXIpCjOYPfPzCeyH7lQdDPlwxNgv0PxAHMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566591; c=relaxed/simple;
	bh=MF0dcFpAqtGoyY5jQ6eX039UjEzV1Wn1PuoFF9aLEVU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NwFEUfxY1uifbe+uZdlZxgLDKxvVULnvRFmPDq/jjsC4JBekZus1NU/tQTlcA+ew8Vw0TIjLQyfpwuRJgN6PZSaeVX73NweDDf0BzD+ltzfV4o+ZfuzDrSao6N63n7BmF+bOcvMA5eshD8gKruI9K7/ua8ld3STfrhVsy8zT1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBJj/E4b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBJj/E4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F2EC4CEED;
	Tue, 10 Jun 2025 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749566590;
	bh=MF0dcFpAqtGoyY5jQ6eX039UjEzV1Wn1PuoFF9aLEVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fBJj/E4b2XHbrxZ4z3vtjbIHzZ0F+kMpnCt5/Cy+9dh6QGUA+2Y3b5ZmgURMmGUtM
	 4EO6K0LxP3L5ZaIB40X89/SF2fb7aP0C4NBJF9sKSaHrFiIPL039sJ+QGIqfmjTyRB
	 MpBkZ+0D+NWiSmIj1Ur91Ir7CTEglm0cAyK/9NstK9lcQCGag+uXs4EH9h3f1Kquyn
	 +c3DnRokkfWvWu2Y0oioNa6Hj73syYEcnv6oc2/b8mBX+OuaCAxFmftZzDvBpjpSpl
	 jHeddXS1Z5G6+5mS9VyxAuHMkXdVCUu8IXE0IZStdZRSihGhQZyo3HIVSyod1afwzf
	 Piit/phTGTHVg==
Date: Tue, 10 Jun 2025 23:43:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-Id: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
In-Reply-To: <CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 18:50:05 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> On Mon, 9 Jun 2025 at 18:39, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 5 Jun 2025 17:12:10 +0530
> > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > > Regressions found on qemu-x86_64 with compat mode (64-bit kernel
> > > running on 32-bit userspace) while running LTP tracing test suite
> > > on Linux next-20250605 tag kernel.
> > >
> > > Regressions found on
> > >  - LTP tracing
> > >
> > > Regression Analysis:
> > >  - New regression? Yes
> > >  - Reproducible? Intermittent
> > >
> > > Test regression: qemu-x86_64-compat mode ltp tracing Oops int3 kernel panic
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > ## Test log
> > > ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
> > > starting test ftrace-stress-test (ftrace_stress_test.sh 90)
> > > <4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI
> > > <4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
> > > 6.15.0-next-20250605 #1 PREEMPT(voluntary)
> > > <4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > > BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > > <4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50
> >
> > Interesting. This hits a stray int3 for ftrace on _raw_spin_lock.
> >
> > Here is the compiled code of _raw_spin_lock.
> >
> > ffffffff825daa00 <_raw_spin_lock>:
> > ffffffff825daa00:       f3 0f 1e fa             endbr64
> > ffffffff825daa04:       e8 47 a6 d5 fe          call   ffffffff81335050 <__fentry__>
> >
> > Since int3 exception happens after decoded int3 (1 byte), the RIP
> > `_raw_spin_lock+0x05` is not an instruction boundary.
> >
> > > <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
> > > 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> > > 0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
> > > 12 e4 fe
> >
> > And the call is already modified back to a 5-bytes nop when we
> > dump the code. Thus it may hit the intermediate int3 for transforming
> > code.
> >
> > e8 47 a6 d5 fe
> >  (first step)
> > cc 47 a6 d5 fe
> >  (second step)
> > cc 1f 44 00 00 <- hit?
> >  (third step)
> > 0f 1f 44 00 00 <- handle int3
> >
> > It is very unlikely scenario (and I'm not sure qemu can correctly
> > emulate it.) But if a CPU hits the int3 (cc) on _raw_spin_lock()+0x4
> > before anoter CPU' runs third step in smp_text_poke_batch_finish(),
> > and before the CPU runs smp_text_poke_int3_handler(), the CPU' runs
> > the thrid step and sets text_poke_array_refs 0,
> > the smp_text_poke_int3_handler() returns 0 and causes the same
> > problem.
> >
> > <CPU0>                                  <CPU1>
> >                                         Start smp_text_poke_batch_finish().
> >                                         Finish second step.
> > Hit int3 (*)
> >                                         Finish third step.
> >                                         Run smp_text_poke_sync_each_cpu().(**)
> >                                         Clear text_poke_array_refs[cpu0]
> > Start smp_text_poke_int3_handler()
> > Failed to get text_poke_array_refs[cpu0]
> > Oops: int3
> >
> >
> > But as I said it is very unlikely, because as far as I know;
> >
> > (*) smp_text_poke_int3_handler() is called directly from exc_int3()
> >    which is a kind of NMI, so other interrupt should not run.
> > (**) In the third step, smp_text_poke_batch_finish() sends IPI for
> >    sync core after removing int3. Thus any int3 exception handling
> >    should be finished.
> >
> > Is this bug reproducible easier recently?
> 
> Yes. It is easy to reproduce.

Good, can you test the following 2 patches (I'll send a series)?
I think [1/2] may avoid the kernel crash, but still shows a
warning, and [2/2] may fix it if my guess is correct.

Thank you,

> 
> >
> > Thanks,
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> - Naresh


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
