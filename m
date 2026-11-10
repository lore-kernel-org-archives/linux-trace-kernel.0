Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269147;
	b=I/bwLzVjVUHPhOAEbnFJOV8Y0SdGIt097gHAVjJXrSHvMRVCuwNXYMa6M+Mb8klXDZBv
	 muzM5+BZP6AV9sUXiZMGl6XIoRs7sAm/s1aSX/Eaj/XXwMBLim6P71r0yXZSNk7OYp0um
	 f0WaqptmHDwtFGhjsYcM82a7jXbO//aJL3VvHPf5cgX1GN1J5GIikST1FiHClyobCcoRY
	 A+aSNO7yRQQVxEzrQn6hDeHar4Q3LRYef4uAoi0EkOVgSgu3tzGiVYES3487K/rZU5OVi
	 IFyXOc97JqlowQcPKSfSEXK3UXUv2mu4X5uS2PR7lTfIWVxj8xo4FQZxVMzOf3pGmBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269147;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b1eSNN0WEYptdKwa09tpVnYv57hqS3AaYj4W144T8MY=;
	b=eLrgYw6FR3PnCS57Fkx3UHk8BRCk4pmcdrWAsdolMaFn6MZa89Iyc+KLkP5Wo1L4GKLb
	 O++ECXjxGPM2fIC183ug0/SxCxppeTKJXei6YzcvxKs03Udw5dB1o3g9vnDyLDefcA29f
	 9nDydwsAt0hqAVKMWstD2B8ajgzTE4CTu/3MC/5l5mOJF/mhBBwW9K0PFZE1k3bPsgB6z
	 IglclhGc96zVBhxNq2RIQuU2+dj2CJLyaXzKEkxQHHA6LrFDNwRFTL3rXbb8u09eDxHmi
	 h4joyo+mI2SyBg5iA3hGKeyalU4zXQuW1qd8GPy7QE/W/kpPT3HwIn0PhNPxgPtCwDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZgUOtY1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF8606A31C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZgUOtY1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708121F0089F;
	Tue, 10 Nov 2026 00:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269146;
	bh=b1eSNN0WEYptdKwa09tpVnYv57hqS3AaYj4W144T8MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WZgUOtY1RYA3GIZiVsnYDiLi35g2rtGnRIYT2oIdgz7AjH8hpls+rCPTPXFvbnhtF
	 ILMopWW4yUmkDQe8yReOOecahncRLCGYNkr3LCyqcNUDBNQljbGA9ajFoV1134pDBQ
	 P1khMt9O/3QXH8lB/KewaChVc3FUtR31/zhZRHpJoKX5fImb3/eePJc4JvmBr6Bxmg
	 wr9PxyQtvckC0l8NwkzjhTCjouxDwzWYNNHzCnbcuYhmBFxrhwurQ2eOU6cey0Scx8
	 jzWIXECQgQW+b7yfNYwNghtZyzxayKYh+OpyuDPJpYOI21GLcG4KmoJQe+kt6Gqx/O
	 Z9agr2Gcb03UA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] kprobes: Fix UAF and queue cooling probes on forced unoptimization
Date: Tue, 10 Nov 2026 09:05:44 +0900
Message-ID: <undine-1794269144616511103-5b423eda65978402@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-196308@kernel.org>
References: <179375029807.247640.13024754173032838618.stgit@devnote2> <179375034391.247640.7677208599009420639.stgit@devnote2> <sashiko-outbox-196308@kernel.org>
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

On Wed, 04 Nov 2026 00:25:03 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] kprobes: unreachable kprobe_unused() branch in unoptimize_kprobe()
> --
> 
> commit c6680d6b1b284ca1b2cdf402fac410e5adfc1db4
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> kprobes: Fix UAF and queue cooling probes on forced unoptimization
> 
> This patch fixes a use-after-free on forced unoptimization of an active
> optimized kprobe by queueing the probe onto the current generation's list
> and waiting for a Tasks RCU grace period before freeing it. It also separates
> newly unoptimized probes into a local list in do_unoptimize_kprobes() so
> probes already on freeing_list are not disarmed twice.
> 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 135fec5d49cf5..ceacd56245c24 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> 
> [ ... ]
> 
> > @@ -1039,6 +1039,15 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
> >  	if (force) {
> >  		/* Forcibly update the code: this is a special case */
> >  		force_unoptimize_kprobe(op);
> > +		if (kprobe_unused(&op->kp)) {
> > +			if (!kprobe_gone(&op->kp))
> > +				arch_disarm_kprobe(&op->kp);
> > +			hlist_del_init_rcu(&op->kp.hlist);
> > +			list_add(&op->list, &cur->freeing_list);
> > +		} else {
> > +			list_add(&op->list, &cur->cooling_list);
> > +		}
> > +		kick_kprobe_optimizer();
> 
> [Severity: Low]
> Can kprobe_unused(&op->kp) ever evaluate to true here?
> 
> At the start of unoptimize_kprobe(), the function checks:
> 
> 	if (!kprobe_aggrprobe(p) || kprobe_disarmed(p))
> 		return; /* This is not an optprobe nor optimized */
> 
> where kprobe_disarmed(p) for an aggregator probe is:
> 
> 	return kprobe_disabled(p) && list_empty(&op->list);
> 
> And earlier in unoptimize_kprobe(), the !list_empty(&op->list) block handles
> all probes already on a list and returns.

Oops, indeed. OK, let's drop that branch.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
