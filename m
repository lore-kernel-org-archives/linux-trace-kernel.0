Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEAE296147;
	Wed, 11 Jun 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651622; cv=none; b=Uk0uM2GTP5dJuckIr1TlqAoWwCQEXgKnHmEEqf7UojmS8qqDBlQ15Glvp192ApzoQtfOaT8QKNKwTfAJ+j1g2nJhA3noYQ/uxUOB7kqyX2Awnon/XeDjSoVHyHyrTjLgVbYkiCa/w2DNpFnO1pQvmofnGOn2Mcq0RZenLVmTr+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651622; c=relaxed/simple;
	bh=AG0Bs9vpCQ4T8QEl8ZO9vLvDMYsYLyqpe1wrOEo4RWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpMlqxto+w0n2VpuA7E+ykiBsv1za8vKpg09NwgD2PB80NFom7ExV0LKDoGC7TjDxa2fmgkt9kVe4riCWAL8+oRPPwCbTBVbQzm+wyi8qmloLar614hijzsvylda9xA7N6bldiEel0LFF9YIBsyHRDvF42a5cHp4Fa1p/BTH/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 529F780E2D;
	Wed, 11 Jun 2025 14:20:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 95CCA20027;
	Wed, 11 Jun 2025 14:20:11 +0000 (UTC)
Date: Wed, 11 Jun 2025 10:20:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Naresh Kamboju
 <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo  Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav  Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Subject: Re: [RFC PATCH 2/2] x86: alternative: Invalidate the cache for
 updated instructions
Message-ID: <20250611102010.1bf7c264@batman.local.home>
In-Reply-To: <20250611192610.6edf9713f6ee84c26f653ea5@kernel.org>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
	<174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
	<20250610115030.0d60da65@gandalf.local.home>
	<20250611192610.6edf9713f6ee84c26f653ea5@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 95CCA20027
X-Stat-Signature: rhy6xig8f8wkqqnjpmmytqx9dmy49ou7
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19mYjjxbE8STn8J2hKAdlQENeelbUtZG70=
X-HE-Tag: 1749651611-325749
X-HE-Meta: U2FsdGVkX1/2aM+oDd68kNXfBzofjOaafPkaVS0pnksX1xew9r6cjHEwJ4izXAJYQbx8MTAV21VwjnOr1iZ69Pq7JftqNEf7NpShANf7/ykgE/TcSnX+UK00rN+ieIwcw9tGM7VkVKPD6QF/7nwAftGkk2wpD/lF6DTNOSS2udxOzMtbf6le4PPGlalfxyJBp24xMw3mtmYEL4me12gH7BoBVM50q7cFhI3cBbzfEqOY5l/dPUM8JMMk/0PSn4lNlrngkM4UnmOepWaeHbKiEYiyec8gIYPFtf+wtqDI8mfYq9MJ0UwxazkzaXGfMGu6PSYrkQSoNH8VHpq4mK7fBWwMQc3tRjxFTQ4e+Q5NoTl7gBHv8DAqHizWgdFeMRRR0jEhxrQ4Mbds7aCafjkDuw==


[ I just noticed that you continued on the thread without the x86 folks Cc ]

On Wed, 11 Jun 2025 19:26:10 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 10 Jun 2025 11:50:30 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 10 Jun 2025 23:47:48 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> >   
> > > Maybe one possible scenario is to hit the int3 after the third step
> > > somehow (on I-cache).
> > > 
> > > ------
> > > <CPU0>					<CPU1>
> > > 					Start smp_text_poke_batch_finish().
> > > 					Start the third step. (remove INT3)
> > > 					on_each_cpu(do_sync_core)
> > > do_sync_core(do SERIALIZE)
> > > 					Finish the third step.
> > > Hit INT3 (from I-cache)
> > > 					Clear text_poke_array_refs[cpu0]
> > > Start smp_text_poke_int3_handler()  
> > 
> > I believe your analysis is the issue here. The commit that changed the ref
> > counter from a global to per cpu didn't cause the issue, it just made the
> > race window bigger.
> >   
> 
> Ah, OK. It seems more easier to explain. Since we use the
> trap gate for #BP, it does not clear the IF automatically.
> Thus there is a time window between executing INT3 on icache
> (or already in the pipeline) and its handler disables
> interrupts. If the IPI is received in the time window,
> this bug happens.
> 
> <CPU0>					<CPU1>
> 					Start smp_text_poke_batch_finish().
> 					Start the third step. (remove INT3)
> Hit INT3 (from icache/pipeline)
> 					on_each_cpu(do_sync_core)
> ----
> do_sync_core(do SERIALIZE)
> ----
> 					Finish the third step.
> Handle #BP including CLI
> 					Clear text_poke_array_refs[cpu0]
> preparing stack
> Start smp_text_poke_int3_handler()
> Failed to get text_poke_array_refs[cpu0]
> 
> In this case, per-cpu text_poke_array_refs will make a time
> window bigger because clearing text_poke_array_refs is faster.
> 
> If this is correct, flushing cache does not matter (it
> can make the window smaller.)
> 
> One possible solution is to send IPI again which ensures the
> current #BP handler exits. It can make the window small enough.
> 
> Another solution is removing WARN_ONCE() from [1/2], which
> means we accept this scenario, but avoid catastrophic result.

If interrupts are enabled when the break point hits and just enters the
int3 handler, does that also mean it can schedule?

If that's the case, then we either have to remove the WARN_ONCE() or we
would have to do something like a synchronize_rcu_tasks().

-- Steve
