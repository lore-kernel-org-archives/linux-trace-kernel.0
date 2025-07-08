Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD8018A6AE;
	Tue,  8 Jul 2025 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000864; cv=none; b=gJ7Wyw/jobB94YYfNu2urvaPG93O3PxD/PlBscus5+8XpVJWvEon+19i+V20HguqAd+IcFlChfbQZriRw3IFDg2Xz3HT3pjOh6S8nsoLVjqWa/tR2blVd5CchawlOYW9Gl3K12av2MKMLYLhEj24iIxWD6zKNVH4uwsk+iQU4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000864; c=relaxed/simple;
	bh=iHrprSWM7/6hpdqzqQ6gGLaagDMcN5uqUot4NgPKRyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW4RqA8LgO0Fx/WHtt4pSM+gIurjIrH3XTL0ST/PcmKyWdcX7AhUnHWF+FJuzmY6Qb5nTNHXCu2OdNwRBaoX9fWl8icbtWb2GWPnWA3oHkb7B5oNqOx4mcauu49PMWH/fS/7e/4pWu/hEcXbmH4gVbfNDJwqxEUPnLQTFbrvSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PNW8ZYDS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PNW8ZYDS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C1NkiKgWNE5ywbtL7S/nXgXmek8pvm/xPwVgZdNL1Fg=; b=PNW8ZYDS/YHlg9K8YLXO6sjcT9
	IwZ3aYoqzCRceXxjQS3miT7itxTCyZi8Fwcd3DyiqQtuFIwGMlZLnuFPI01WX3baZNezontr3kHSe
	sl4IEajWnIucTZ7l+8mdr3N39NOqRa7Z3rOgeh0hIzlac3fS1omvaFb29SQshYCNz+T42nN2/jV4H
	fou+3oG+0dcq0i0L1wXZ0y7qCW/OCBp7oNWWyidxFDDioZBIvT8PVdrhCwNJwMFgfKSEMrWU9+moz
	eaNeZ9zMYOeBi5vpLxgMN6402aRASF+nrM4bOV13iq22AjYhGNuJjMmpJfZVvMqnGs5L0YWc42kCV
	CaB+/9Gg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZDSH-00000008mM4-1U8K;
	Tue, 08 Jul 2025 18:54:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DF086300125; Tue, 08 Jul 2025 20:54:12 +0200 (CEST)
Date: Tue, 8 Jul 2025 20:54:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v3 2/2] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <20250708185412.GC477119@noisy.programming.kicks-ass.net>
References: <20250704170748.97632-1-wander@redhat.com>
 <20250704170748.97632-3-wander@redhat.com>
 <20250707112003.GY1613376@noisy.programming.kicks-ass.net>
 <33jax5mmu7mdt6ph5t5bb7fvprbypxhefrvgrc2ru4p2dpqldg@d6af6oc6442r>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33jax5mmu7mdt6ph5t5bb7fvprbypxhefrvgrc2ru4p2dpqldg@d6af6oc6442r>

On Tue, Jul 08, 2025 at 09:54:06AM -0300, Wander Lairson Costa wrote:
> O Mon, Jul 07, 2025 at 01:20:03PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 04, 2025 at 02:07:43PM -0300, Wander Lairson Costa wrote:
> > > Similar to the IRQ tracepoint, the preempt tracepoints are typically
> > > disabled in production systems due to the significant overhead they
> > > introduce even when not in use.
> > > 
> > > The overhead primarily comes from two sources: First, when tracepoints
> > > are compiled into the kernel, preempt_count_add() and preempt_count_sub()
> > > become external function calls rather than inlined operations. Second,
> > > these functions perform unnecessary preempt_count() checks even when the
> > > tracepoint itself is disabled.
> > > 
> > > This optimization introduces an early check of the tracepoint static key,
> > > which allows us to skip both the function call overhead and the redundant
> > > preempt_count() checks when tracing is disabled. The change maintains all
> > > existing functionality when tracing is active while significantly
> > > reducing overhead for the common case where tracing is inactive.
> > > 
> > 
> > This one in particular I worry about the code gen impact. There are a
> > *LOT* of preempt_{dis,en}able() sites in the kernel and now they all get
> > this static branch and call crud on.
> > 
> > We spend significant effort to make preempt_{dis,en}able() as small as
> > possible.
> > 
> 
> Thank you for the feedback, it's much appreciated. I just want to make sure
> I'm on the right track. If I understand your concern correctly, it revolves
> around the overhead this patch might introduce???specifically to the binary
> size and its effect on the iCache???when the kernel is built with preempt
> tracepoints enabled. Is that an accurate summary?

Yes, specifically:

preempt_disable()
	incl	%gs:__preempt_count



preempt_enable()
	decl	%gs:__preempt_count
	jz	do_schedule
1:	...

do_schedule:
	call	__SCT__preemptible_schedule
	jmp	1


your proposal adds significantly to this.
