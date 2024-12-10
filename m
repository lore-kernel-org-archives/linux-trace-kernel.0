Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038495FDA7;
	Tue, 10 Dec 2024 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796276; cv=none; b=Hv/x99uORzZ5+sxAaejsYjrvssYxdwXLu6+ATRsSZGUIfEM/fVVz8Y34ivbToyxqIXE3hyvb2/MkTi7FCwbf75xuns8Gso9ku/0BcWjWs/ncGCQQi5sOCxLoOAQv1S5Mviv5VROWuUV6Y/Pd0zKe92LNBMugAuFF6DrQVlVr3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796276; c=relaxed/simple;
	bh=oPZZN+mwOAYFn85jtDrCczgEYZMHPEWfpX3ZfHCQARI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mTdlF8GrZPslaiCK+DnyxSfsD/heRhbkJQwePwB7h5o7RUZePCHhZwG6qfyabKpaxoHXGhBHxH1fx4Jlv/12U16+VowcFgdv1udreBfPTkli80RauoOwaxEs4iQ7TUIbaFdQKQmoCjFaRI+lIpvgT/4r74LB4TAzPoavBHwxzv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld/zC4m+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld/zC4m+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC75C4CED1;
	Tue, 10 Dec 2024 02:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733796274;
	bh=oPZZN+mwOAYFn85jtDrCczgEYZMHPEWfpX3ZfHCQARI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ld/zC4m+xupGCW2EUBrjZnpcZfmDygF5+GZHa6+zh5zLDZyZSoZHaR00Im0YJlOiU
	 /yXoCfqnJZumHo237u//g1VqiieSYz55JWo2ei/MAJ+r2FnpQaDjQKEl0fboADJLRW
	 M52pcYxeYpKf1DGLjfd6ajXgFglkpPsFA1ozUyJqLPNuwJepjuMYhWzPefNYQCz/N1
	 /q7hrmQKBIkfhdygrZxcuUvzqVAqzfzmS0aJQI/g1ls6grgzG3eo3m3x7tPXxvWkJq
	 Ka6KkRc058U/p8+UNVLLVE63FDPxnpZlcZCP+KJrk0YUHefc7+kj1umMLuWq+GM2Pi
	 qvwFXdfgRL0AA==
Date: Tue, 10 Dec 2024 11:04:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kprobes: Use guard() for external locks
Message-Id: <20241210110428.aa5446ca9b2153c21f8fcdf9@kernel.org>
In-Reply-To: <20241209110411.GL21636@noisy.programming.kicks-ass.net>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
	<173371208663.480397.7535769878667655223.stgit@devnote2>
	<20241209110411.GL21636@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 12:04:11 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Dec 09, 2024 at 11:41:26AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Use guard() for text_mutex, cpu_read_lock, and jump_label_lock in
> > the kprobes.
> 
> > @@ -853,29 +850,24 @@ static void try_to_optimize_kprobe(struct kprobe *p)
> >  		return;
> >  
> >  	/* For preparing optimization, jump_label_text_reserved() is called. */
> > -	cpus_read_lock();
> > -	jump_label_lock();
> > -	mutex_lock(&text_mutex);
> > +	guard(cpus_read_lock)();
> > +	guard(jump_label_lock)();
> > +	guard(mutex)(&text_mutex);
> >  
> 
> > @@ -1294,62 +1280,55 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
> >  	int ret = 0;
> >  	struct kprobe *ap = orig_p;
> >  
> > -	cpus_read_lock();
> > -
> > -	/* For preparing optimization, jump_label_text_reserved() is called */
> > -	jump_label_lock();
> > -	mutex_lock(&text_mutex);
> 
> Why does kprobe need jump_label_lock and how does it then not also need
> static_call_lock ?

Good catch! It has not been updated for static_call_text_reserved().
We need static_call_lock() here too.

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
