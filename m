Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A3C19D899;
	Tue, 10 Dec 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832639; cv=none; b=ujAjv4VLICoMuoeJZSrLvdy3609bz4RnaSzZ1nHIEQcExA6d0Tts6+4y3UIzI6zDJYXuTq7uksUwrukbF0zACWsYVguJjpXAKbfyyMkxKrxkdYxUW6eXFmFD+davM/LZMt/O2L6oR6mslILAR60Jp+cooQ4o55OY4VRmpNllwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832639; c=relaxed/simple;
	bh=ChPXISFNkBTn9lx61v39GwBhIK/g0MTtWttTemrJYX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Punigy9G7oyPFPE4uPeZ8GiNwZS0agRBCWi4yL2VHwRRBncK1JEYBlL0xEk2goKi8RRcZXgf2SAvkM8GEd2qXflHZfbOcIgZdnLTGOYIvIKCtN9dc4VH7rfnkYK96QZrFZ18ULOYhsUtaiilHN/L21tLhSisTDovaHogWRUBumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dky6S9+C; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dky6S9+C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k8GfdO+Ullauf6fvJoHMqTp6+nzHeAoxcJADnrchoEQ=; b=dky6S9+CQvKH2o5+panXzjiWCo
	+oveWRmZxLDOTCybwmoBah0pWH9sflnrPzeEkYKJUtctSDGrMCV+bp58BEcXgG/Ijers4buwEQt4g
	khsrfW7lMIwcvBxssJvDUZtqBv5ko8PqBnMSTOvhqPI1ssnlAtSYiaG7o67pXvyAgzgUFgYqgS7A9
	sfhcmhBgwZhMbpsq3ps58rjXH7JXdmBOtOxxHBjjBhsje8OQ0keneMjkFChCAiGIMsRKzqGv3BRhj
	gRABKZJdZBP6z50VUV5UgcC495RwO74RuQu8WWB5rB7caqjP7vnt4Zmdeg2VGnJYh8e/QQ8ckKQBi
	7JMgXdkg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKz4N-00000003fTl-2zc7;
	Tue, 10 Dec 2024 12:10:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4AF4B30035F; Tue, 10 Dec 2024 13:10:27 +0100 (CET)
Date: Tue, 10 Dec 2024 13:10:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kprobes: Use guard() for external locks
Message-ID: <20241210121027.GM8562@noisy.programming.kicks-ass.net>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
 <173371208663.480397.7535769878667655223.stgit@devnote2>
 <20241209110411.GL21636@noisy.programming.kicks-ass.net>
 <20241210110428.aa5446ca9b2153c21f8fcdf9@kernel.org>
 <20241210111528.bb2c66d71fe38be92010264a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210111528.bb2c66d71fe38be92010264a@kernel.org>

On Tue, Dec 10, 2024 at 11:15:28AM +0900, Masami Hiramatsu wrote:
> On Tue, 10 Dec 2024 11:04:28 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Mon, 9 Dec 2024 12:04:11 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Mon, Dec 09, 2024 at 11:41:26AM +0900, Masami Hiramatsu (Google) wrote:
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > 
> > > > Use guard() for text_mutex, cpu_read_lock, and jump_label_lock in
> > > > the kprobes.
> > > 
> > > > @@ -853,29 +850,24 @@ static void try_to_optimize_kprobe(struct kprobe *p)
> > > >  		return;
> > > >  
> > > >  	/* For preparing optimization, jump_label_text_reserved() is called. */
> > > > -	cpus_read_lock();
> > > > -	jump_label_lock();
> > > > -	mutex_lock(&text_mutex);
> > > > +	guard(cpus_read_lock)();
> > > > +	guard(jump_label_lock)();
> > > > +	guard(mutex)(&text_mutex);
> > > >  
> > > 
> > > > @@ -1294,62 +1280,55 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
> > > >  	int ret = 0;
> > > >  	struct kprobe *ap = orig_p;
> > > >  
> > > > -	cpus_read_lock();
> > > > -
> > > > -	/* For preparing optimization, jump_label_text_reserved() is called */
> > > > -	jump_label_lock();
> > > > -	mutex_lock(&text_mutex);
> > > 
> > > Why does kprobe need jump_label_lock and how does it then not also need
> > > static_call_lock ?
> > 
> > Good catch! It has not been updated for static_call_text_reserved().
> > We need static_call_lock() here too.
> 
> Wait, this is for checking the jump_label_text_reserved(), but as far as
> I know, the text reserved area of jump_label will be updated when the
> module is loaded or removed. And the static call too, right?

Correct.

> In that case, what we need is to lock the modules (for the short term,
> can we use rcu_read_lock?) for using both jump_label_text_reserved()
> and static_call_text_reserved()?

Yes, rcu_read_lock() is sufficient to observe fully loaded modules. I
don't think you care about placing kprobes on modules that are still
loading (that doesn't really make sense).

Also see:

  https://lkml.kernel.org/r/20241205215102.hRywUW2A@linutronix.de
