Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A015B54A;
	Wed, 16 Jul 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653993; cv=none; b=dY1ZAZI39r42kTDa+GuQlIGCEZDZACBVxfQpWPG/MfbhwwY21ZlsTFFX0Y7j4uBfJ2DoArh/LtCA6t/TZduST0L3ZFfOu/r82ejd5PCOj5ipuB7oD0yg/w7pMShKWrVcZOudlIUDeVXRtId5cX6pmNl/+Z5nsqkej5r8FrFL/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653993; c=relaxed/simple;
	bh=GlZGZ1Asl3My2cESBoIWYFU4aEn0Uw1o/58kn2trcmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM/mBsQpvW4fzARsmJx2lAlMij3kjOu9Mhz+O6c+B+UIbDLgslHYdt/hvXgrMFSu5+96C9NW2dcy+k4JWJfli1LMDihvWhbY9DbsDGMGyag/psmHa7obtanyyNNMNpTEd+FFJXUvl4U8gmCISSE3rjbJ0N3AUzAShOu8tUbUUnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t5emyOiZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=huOeqmCU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t5emyOiZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="huOeqmCU"
Date: Wed, 16 Jul 2025 10:19:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752653989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjxjS9PKFz3BH3h+gd4btvCfqCFk/UfxSV3pkCM3P6M=;
	b=t5emyOiZqQuOYF+sEYlxGXyqPsXdUGpibXR7E0S0vLBDppEDzdlj4lU+heruwIeHnlJxdQ
	I1jxFMFZF+kyj7snFlmp5uxxe9WWHwzzwDUE7dOsS9nJgu+PFhD8ZHzTG9jZ/ZSzGb7inU
	92U9ItT/mdCXbSAz0N6229d7ozsNG1DtcNrJobBDqg0I9pQuouxPVCVxCKHM0Ikh5NK3yq
	x+uaxPJBcHIoEZMBfkl76hbNlkqUb60dD+jFg8ek3PFuiIOZEhhZvKVfMy01Huwqw0NK+W
	hLefMhDG+XgSO8pwAs8ATqRv+7yc+rtf5kkuTw7uA70uakOHl3I1PH2xVlWgPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752653989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjxjS9PKFz3BH3h+gd4btvCfqCFk/UfxSV3pkCM3P6M=;
	b=huOeqmCUd/PsAWd8ESaSOWgVuWPW5Au7v0WsIdxQB+qWrtPbRClj6NEUfNXADy2a7LESKe
	THjEjQPVikZ+vyDw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 07/17] rv: Adjust monitor dependencies
Message-ID: <20250716081948.gpIAM97C@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-8-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071434.22508-8-gmonaco@redhat.com>

On Tue, Jul 15, 2025 at 09:14:24AM +0200, Gabriele Monaco wrote:
> RV monitors relying on the preemptirqs tracepoints are set as dependent
> on PREEMPT_TRACER and IRQSOFF_TRACER. In fact, those configurations do
> enable the tracepoints but are not the minimal configurations enabling
> them, which are TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS (not selectable
> manually).
> 
> Set TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS as dependencies for
> monitors.
> 
> Fixes: fbe6c09b7eb4 ("rv: Add scpd, snep and sncid per-cpu monitors")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

I still dislike this. TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS are not
selectable manually, making it hard to enable the monitors. You would need
to manually enable PREEMPT_TRACER and IRQSOFF_TRACER.

I prefer "select" instead.

But well, if you insist on doing it this way. It is not broken, it is just
inconvenient to configure.

Acked-by: Nam Cao <namcao@linutronix.de>
