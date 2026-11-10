Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271073;
	b=u26ZMLLZ0FpNEvuaJ/jtY3TSzV5I45Gwq3ms2I/X/HLh1guRuNpR8g6DjbKvM5Pp99QJ
	 EjBVWIwdP1OwuLIivRZz/QyZBQS1YQaQjExB5uTogzInIAO8skXKtcfADxRoG0megrAgR
	 9N+GXIAPYQPgYe0obvuY9ol9jLBwYJMsHVZNSqiNDSWTazsyNsvGkAHhvdY43I8oVXhLd
	 TNNV6l1SpDr0NIv4TyafRXVzZeYN/WnSgKze2gcJDNfjJeScrpspKIj+hYiIvt4iLfjJW
	 GDmB+Dc45mCeMMPXQWUuVtdtvXTc1SClS8r27ozizg89uuDuZwOIRaSuXAScZ1ZHP4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271073;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=11VwdvWVBjicfkhCNHfmdTnfJSk3QGGQVEbbWOcy4jo=;
	b=GuFVqbSrGl75N+VB3SJPoAvxen7P6C5rWZnf4j44v2bXDwa1XuAjmUChlXzWa8v2aMlw
	 By5dNRvqecGQo9E1fnqdZhc0pD+iHaH2oJ2U5u6fjHeZ7gNYxWANCl8klplI4DEusRO7t
	 JjFNHZSVURfxAS6omfxVWcK1HhYc1iMYtohyTWhT/SwgZBkFgnd1rG5xlKrNcXaj2DYjc
	 BgxWBGSXrrF0AE+6M2WaLxVSG4ABTSYFNdZphEySQmeuBJhn0Bawmn6okWf7VQysRUDyn
	 a8NwXdQPcCg9MP+IaLE4fPdUppu7A3PjHaP9qB01VSwwcs4/WwI0kLcS7rPVNYnKqqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCamavtj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3480606A32A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCamavtj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4656B1F008A3;
	Tue, 10 Nov 2026 00:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794271072;
	bh=11VwdvWVBjicfkhCNHfmdTnfJSk3QGGQVEbbWOcy4jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCamavtjF2X0MviAGc7tEez/R0890GmTl85g+q0Ok990NXE2UkoQxsGfMMwXTFn1M
	 VFi3IZP54gi2vUtDB1On7TBJhlHeu4GvsFH7scGvXewfCOwQlz3LzGTfW/7EH5qXWi
	 zuwqPZbIBZ0CEWksm89FtID0lrNKMwla3EYOSLlEXymMi4othPfnj1BOeG/GWe8GBo
	 xgAsMtcFTwMK6cL7Rz1ygaNNBFLVPpRHHySoT4/JvcTyRZVQvtjPTHQnK9PjRSVw0R
	 0TpLDxWjB1NofeJs8NAV6/GshdhOOEGh1rGqkqf0H/Rg/jngVTcBGsGP+xD59Yojb3
	 yrj0b/VoHut9g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] kprobes: Switch ftrace ops when adding probe with post_handler
Date: Tue, 10 Nov 2026 09:37:50 +0900
Message-ID: <undine-1794271070437179827-50fc36883ce50b95@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-196280@kernel.org>
References: <179375029807.247640.13024754173032838618.stgit@devnote2> <179375033462.247640.15676311043239442590.stgit@devnote2> <sashiko-outbox-196280@kernel.org>
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

On Wed, 04 Nov 2026 00:11:35 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> 
> [ ... ]
> 
> > @@ -1654,18 +1657,51 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
> >  					| KPROBE_FLAG_DISABLED;
> >  		}
> >  
> > +		if (p->post_handler && !ap->post_handler) {
> > +			reset_post_handler = true;
> > +			if (kprobe_ftrace(ap) && !kprobes_all_disarmed &&
> > +			    !kprobe_disabled(ap))
> > +				ftrace_switch_ops = true;
> > +			else
> > +				ap->post_handler = aggr_post_handler;
> > +		}
> > +
> >  		/* Copy the insn slot of 'p' to 'ap'. */
> >  		copy_kprobe(ap, p);
> > -		ret = add_new_kprobe(ap, p);
> > +		add_new_kprobe(ap, p);
> > +	}
> 
> [Severity: High]
> When ftrace_switch_ops is true in register_aggr_kprobe(), add_new_kprobe(ap, p)
> publishes p onto ap->list via list_add_rcu() while ap is still armed on
> kprobe_ftrace_ops and ap->post_handler is still NULL.

Nice catch!

> 
> If another CPU hits the probed function before disarm_kprobe_ftrace(ap)
> finishes updating the ftrace callsite, kprobe_ftrace_handler() will call
> aggr_pre_handler() -> p->pre_handler(), and then skip aggr_post_handler()
> because ap->post_handler is NULL:
> 
> arch/x86/kernel/kprobes/ftrace.c:kprobe_ftrace_handler() {
> 	...
> 	if (!p->pre_handler || !p->pre_handler(p, regs)) {
> 		if (unlikely(p->post_handler)) {
> 			instruction_pointer_set(regs, ip + MCOUNT_INSN_SIZE);
> 			kcb->kprobe_status = KPROBE_HIT_SSDONE;
> 			p->post_handler(p, regs, 0);
> 		}
> 	...
> }

Indeed.

> 
> In addition, p->pre_handler() executes under kprobe_ftrace_ops before
> arm_kprobe_ftrace(ap) has verified that kprobe_ipmodify_ops
> (FTRACE_OPS_FL_IPMODIFY) does not conflict with an active livepatch. A similar
> window also occurs in the error path below if arm_kprobe_ftrace(ap) fails,
> where ap->post_handler is reset to NULL and ap is re-armed on
> kprobe_ftrace_ops before list_del_rcu(&p->list) removes p.
> 
> Could add_new_kprobe(ap, p) be deferred until after ap has been switched to
> kprobe_ipmodify_ops, or could p be removed from ap->list before re-arming ap
> on rollback?

Hmm, good catch! OK, let's defer adding p until switching to
kprobe_ipmodify_ops.

> 
> > +
> > +	if (ftrace_switch_ops) {
> > +		/*
> > +		 * Must switch ftrace ops outside of text_mutex and cpus_read_lock
> > +		 * to prevent deadlocks when ftrace code modification acquires text_mutex.
> > +		 */
> > +		ret = disarm_kprobe_ftrace(ap);
> > +		if (ret) {
> > +			list_del_rcu(&p->list);
> > +			synchronize_rcu();
> > +			return ret;
> > +		}
> > +		ap->post_handler = aggr_post_handler;
> > +		ret = arm_kprobe_ftrace(ap);
> > +		if (ret) {
> > +			ap->post_handler = NULL;
> > +			arm_kprobe_ftrace(ap);
> > +			list_del_rcu(&p->list);
> > +			synchronize_rcu();
> > +			return ret;
> > +		}
> >  	}
> 
> [Severity: High]
> What happens if the rollback call to arm_kprobe_ftrace(ap) in
> register_aggr_kprobe() also fails (for example, with -ENOMEM in
> ftrace_set_filter_ip() -> alloc_and_copy_ftrace_hash())?
> 
> Because the return value of the rollback arm_kprobe_ftrace(ap) is ignored and
> KPROBE_FLAG_DISABLED is not set on ap->flags, ap remains marked as enabled
> even though it is no longer registered in kprobe_ftrace_ops's filter hash.

Ah, indeed. OK, let me add KPROBE_FLAG_DISABLED if rollback fails.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
