Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C527456;
	Tue, 10 Dec 2024 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796934; cv=none; b=eX6LKGIgFWZ0EUe4qYFWPcpJQKj65ersIWvNrMXDReGhU79SlBc05GIR4H69K/8p1nia8mphbaq+fWfRCAPcBLGzydZKd71ORCby9NT11n3JVChFHfgMFDeVgN+7GK3pLYkLll+ixEw3fIwOqnVZOSDRAkVWWplHvIA3mkoG9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796934; c=relaxed/simple;
	bh=T0hvG2GmhG1Kb6rsSuzQcmRDHQN0V2Tfv7B9VFr1efw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MM8ELfRMl47R9kDeGwdHEUie/JUTB8Qgy4uPft9ed9xsWomQWJ4xkzQmwu+jaHflyqsMoVYzgyaCS87gaIxwH/UDbz043lDoBvtGfVuHylwqc9Ux+37rmtXAXEaBavX6vI18IuCsML1GqLoie9Z4eFlshpk1SKZsbDVjXKYnLtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1q8qSzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1q8qSzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDF2C4CED1;
	Tue, 10 Dec 2024 02:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733796933;
	bh=T0hvG2GmhG1Kb6rsSuzQcmRDHQN0V2Tfv7B9VFr1efw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i1q8qSzY3Jm9ZEAa0fX/9WRMcweVQuuABsYBiq10rKLKMrW7xWlrlXoUvhELciWCd
	 vmMQixleDUd968KHkH7xpi//mz39mIe9iX/F03mLx4vaJT8+n51kZ2LOPkjHiNwB/2
	 2DJjXR76IY9fzk73gErO0IhOSaRkYOfE2234XHrt0+15CRw6yPOOwMCJJEdgGKGxRF
	 MODlTJtQfqRRXluRt9y631ApC43XLQY4ATcdut2oaKkvG+8XrIu296jq4JmSLaCDP0
	 2Mda3SkWWe2JTHpPCBe5kLucd2cIbGU3TtTGBHbtGePyJ2Ufo3NGr8FNBKBn82hN2r
	 8+rBaqY7o8caQ==
Date: Tue, 10 Dec 2024 11:15:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kprobes: Use guard() for external locks
Message-Id: <20241210111528.bb2c66d71fe38be92010264a@kernel.org>
In-Reply-To: <20241210110428.aa5446ca9b2153c21f8fcdf9@kernel.org>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
	<173371208663.480397.7535769878667655223.stgit@devnote2>
	<20241209110411.GL21636@noisy.programming.kicks-ass.net>
	<20241210110428.aa5446ca9b2153c21f8fcdf9@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 11:04:28 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 9 Dec 2024 12:04:11 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Dec 09, 2024 at 11:41:26AM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Use guard() for text_mutex, cpu_read_lock, and jump_label_lock in
> > > the kprobes.
> > 
> > > @@ -853,29 +850,24 @@ static void try_to_optimize_kprobe(struct kprobe *p)
> > >  		return;
> > >  
> > >  	/* For preparing optimization, jump_label_text_reserved() is called. */
> > > -	cpus_read_lock();
> > > -	jump_label_lock();
> > > -	mutex_lock(&text_mutex);
> > > +	guard(cpus_read_lock)();
> > > +	guard(jump_label_lock)();
> > > +	guard(mutex)(&text_mutex);
> > >  
> > 
> > > @@ -1294,62 +1280,55 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
> > >  	int ret = 0;
> > >  	struct kprobe *ap = orig_p;
> > >  
> > > -	cpus_read_lock();
> > > -
> > > -	/* For preparing optimization, jump_label_text_reserved() is called */
> > > -	jump_label_lock();
> > > -	mutex_lock(&text_mutex);
> > 
> > Why does kprobe need jump_label_lock and how does it then not also need
> > static_call_lock ?
> 
> Good catch! It has not been updated for static_call_text_reserved().
> We need static_call_lock() here too.

Wait, this is for checking the jump_label_text_reserved(), but as far as
I know, the text reserved area of jump_label will be updated when the
module is loaded or removed. And the static call too, right?

In that case, what we need is to lock the modules (for the short term,
can we use rcu_read_lock?) for using both jump_label_text_reserved()
and static_call_text_reserved()?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
