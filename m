Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB49155C83;
	Mon, 17 Feb 2025 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812589; cv=none; b=ulm91gpmfUnr0jSjFSdDDXnYGLcv4E6zpiDDUJ9z1mTzRpI0sHV4zRqlAxYb9OL3J9XouXk012Tb+8TKELmq9KF8CvgCJgffjKaAn7gdRRFNsn0enYKoV6ppBQaeYOghfHQDbt/6Yep9CnEBUaNBRqx6PhPHi4RqMeyJnPyWxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812589; c=relaxed/simple;
	bh=vU8tIRAuuXZCU920XSuNW0iGdqX5Q9N94wDalhr2TRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qh5PnFEzYH2vS/Q+gelvUpHTQ54VQ2OQ6R/ngWUrDQM0S9kqoA+T4PeX90tAZha5hs7GRWaEYyfSixZuYmkR8OIFF6L6NCbn1S8bW2UnIy34r9dn1QYqXJvQ/yXYVFgcVUQZjheP4eOPfd/05TK/2ppfwuGEGm/FUV+E9p66zoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABBCC4CED1;
	Mon, 17 Feb 2025 17:16:28 +0000 (UTC)
Date: Mon, 17 Feb 2025 12:16:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <20250217121647.0b9ead66@gandalf.local.home>
In-Reply-To: <20250217164917.GB40464@noisy.programming.kicks-ass.net>
References: <20250213090819.419470-1-gmonaco@redhat.com>
	<20250213090819.419470-4-gmonaco@redhat.com>
	<20250217113844.5ad7893c@gandalf.local.home>
	<20250217164917.GB40464@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 17:49:17 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 17, 2025 at 11:38:44AM -0500, Steven Rostedt wrote:
> 
> > > +void __do_trace_set_current_state(int state_value)
> > > +{
> > > +	__do_trace_sched_set_state_tp(current, current->__state, state_value);  
> > 
> > And this should not be using the internal macros of a trace point. It should be:
> > 
> > 	trace_sched_set_state_tp(current, state_value);
> > 
> > (I removed the current->__state as mentioned above).  
> 
> But the static branch is already in the caller, no point duplicating
> that.

Regardless, you should not be using internals of the tracepoints. That can
change at any time and is not reliable (as the kernel test robot pointed out).

It's a static branch, who cares if it's added twice? One is used to jump to
the function, the other is for the tracepoint logic itself.

There's several places that do this.

Perhaps, in the future we could create a normal API that will always call
the tracepoint, but until then, let's not use code that wasn't meant for
that purpose.

-- Steve
