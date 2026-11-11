Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405064;
	b=FZb0ZjbB/LEfjSCk07aIgSzsmtw2dO/y+CiWloel11IG02KYTYYp4HhxX5e93y1kBrKH
	 J8P2clwwVQlmcZyXRI9kStmCwNty7f8nrALAtCCFZVgDejmz15SG2Qzf/R/uNOf9Bty9D
	 mwFUzQISNFjTSw1UOqXx1iagqPmk5BeetVVXUvzpUvOJHibIzZQwkaTWhTzF4E+JvBEU5
	 BVV8Tks594V9mFk4/mI3uB9OyWva31fn+JGofctYh//7n5PdLXVUeFH07HnviZOYoBZ/b
	 Fo+NIkW1b8WVj9UmDyWP0N1QHqBQkA7m5ewY4eB2wUkuSPc9tuIrtRDz7gb9qUfz+Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405064;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pqVBFq4L0EdSwEBh+ZJv7y/Y7IuCtLDMONwpbKSeq80=;
	b=Zkq2r6Kstu6a8BvtLwYUURw9hDnir64IY2KFKdSTWpoz/Hz4mLdX+7Od2fFJlSS201GM
	 0t7AE33q/VyL9dqFwf3Z/ruerBwlQQorSl5Ks+UNMhFyDamvHxciWSUj8DfQ4BfQo4E7p
	 KG/ZarGjCKry3m9yokXLk7JeJzqFT2EAyvjHRd3navROD66htVAFpKpEAxVDvsolVewRf
	 xhttQe+oocOKuWILK/5nFLbg2jOURyohVErd3bo5w60TO93YoSFlPJQWd4gVuT+lHDUHX
	 YdPwvXxORytyjbzpILawknT0Ei/i24RqqKKg5jBb9ugACWI2A/1uIZKcIJGWar0m0Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URQYwy+L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59B606A8BC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URQYwy+L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056011F00A05;
	Wed, 11 Nov 2026 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405063;
	bh=pqVBFq4L0EdSwEBh+ZJv7y/Y7IuCtLDMONwpbKSeq80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=URQYwy+LO9LnupWQSm6w869SxjXm++qLrZ2To2ewQspFam88iclfKnAleCCjTYvVP
	 fFf7tsFce9oa6DaVDFeydUhGcQqSQ9ePwwPtNrdSqNhuYGoq4Hz6WyKapPeU2FCVOy
	 Ff7vD9L61zryNzwkhSbeuEDmlwcZ8vqwdqf4TP1bRNFMGlQGajvq6TH89Bojvbi5Br
	 Cwtz9U1NHjWjQQzgPHm7epjLAfDqy23cYswKpE/F0g0XDIr6ectN8kmsHuH9BtAZE3
	 ULo5pophGtEXq7uEPwe8gyCmVx6Gnu+AZPF8ID9hR/XoeYBFSzDY/+6R15y9/SEhpn
	 eNCOly/Dd80QQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] kprobes: Add KUnit test cases for kprobes regressions
Date: Wed, 11 Nov 2026 22:51:01 +0900
Message-ID: <undine-1794405061116150649-65f8dbce8e4ad3dc@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-205975@kernel.org>
References: <179427358690.291326.2078291446658598883.stgit@devnote2> <179427362063.291326.12590758885048682193.stgit@devnote2> <sashiko-outbox-205975@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 10 Nov 2026 01:40:30 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] kprobes: test_optprobe_rearm_unoptimizing() misses jump
>   overwrite on re-arm
> --
> 
> commit d9ce37575f42c89c2d4a066b90a06cb4ee50df98
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> kprobes: Add KUnit test cases for kprobes regressions
> 
> This commit adds four KUnit test cases to lib/tests/test_kprobes.c covering
> regressions in kprobes registration, ftrace ops switching, and optimization
> state transitions.
> 
> > diff --git a/lib/tests/test_kprobes.c b/lib/tests/test_kprobes.c
> > index 06e729e4de051..d692612bc2245 100644
> > --- a/lib/tests/test_kprobes.c
> > +++ b/lib/tests/test_kprobes.c
> [ ... ]
> > +/* Test for: kprobes: Do not overwrite jump instruction when re-arming unoptimizing probe */
> > +static void test_optprobe_rearm_unoptimizing(struct kunit *test)
> > +{
> > +	struct kprobe opt_kp = {
> > +		.symbol_name = "kprobe_opt_target",
> > +		.pre_handler = kp_pre_handler,
> > +	};
> > +
> > +	current_test = test;
> > +	KUNIT_ASSERT_EQ(test, 0, register_kprobe(&opt_kp));
> > +
> > +	/* Allow background optimizer thread to jump-optimize the probe */
> > +	wait_for_kprobe_optimizer();
> > +
> > +	/* Temporarily disable probe (queues on unoptimizing_list, leaves jump) */
> > +	KUNIT_EXPECT_EQ(test, 0, disable_kprobe(&opt_kp));
> > +
> > +	/* Immediately re-enable (re-arm) before optimizer thread unoptimizes */
> > +	KUNIT_EXPECT_EQ(test, 0, enable_kprobe(&opt_kp));
> > +
> > +	/* Verify jump opcode was not corrupted by an unaligned INT3 overwrite */
> > +	preh_val = 0;
> > +	opt_target(rand1);
> > +	KUNIT_EXPECT_NE(test, 0, preh_val);
> > +
> > +	unregister_kprobe(&opt_kp);
> > +}
> > +#endif
> 
> [Severity: Medium]
> Does test_optprobe_rearm_unoptimizing() pass even when enable_kprobe()
> overwrites the jump instruction at opt_kp.addr with a breakpoint?

Hmm, good catch! I had mistakenly dropped the fix for __arm_kprobe().

> 
> When disable_kprobe() runs on the optimized probe, __disarm_kprobe() queues
> it on unoptimizing_list and skips arch_disarm_kprobe(), leaving the jump in
> place.  However, enable_kprobe() calls __arm_kprobe(), which unconditionally
> calls arch_arm_kprobe() before optimize_kprobe():
> 
> kernel/kprobes.c:__arm_kprobe() {
>     ...
> 	arch_arm_kprobe(p);

Yeah, we need to skip this if the kprobe is queued on unoptimizing list
(this means the kprobe is still optimized.)

> 	optimize_kprobe(p);	/* Try to optimize (add kprobe to a list) */
> }
> 
> arch_arm_kprobe() overwrites the jump opcode at p->addr with a breakpoint,
> while optimize_kprobe() sees KPROBE_FLAG_OPTIMIZED and
> optprobe_queued_unopt(op), dequeues the probe from unoptimizing_list, and
> returns early without re-optimizing it.  This leaves the probe permanently
> de-optimized with a breakpoint at p->addr while KPROBE_FLAG_OPTIMIZED
> remains set.  Because hitting that breakpoint still invokes kp_pre_handler(),
> checking only that preh_val is non-zero does not detect that the jump opcode
> was overwritten.

Right, let me fix it.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
