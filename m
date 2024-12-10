Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9081A9B55;
	Tue, 10 Dec 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839967; cv=none; b=Jdt52Cpshlqy4kRsU2QQtMP4TQCN3AuwDCk0w9SWdp20Dw/kGN/1dRDWkMN8lEJCgSdVtwU83Om8eos101Ebiih3FBtaY+Rwybw3+QOC92c+FS6cZng7MLyYxeNVWTmkysgH3RSn0L00nqKeD625x1wycFKkENCfOlDo6t5v4gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839967; c=relaxed/simple;
	bh=KsuCpCpU4NCI4skx9geIqKf8RaGjHnVWPpoq4+ibDFY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DYE1I2rG5Lv72sMjDSGmHDw7fYwOSuoB7TyzyucL5svDY+KZ/Hn8ik4H2lrdyH1NDVoMptk4vVzEoQeOU59fbvLQ1TksQonFIwgMPtZCMDT+RIFl36Z6uFJFgn1oxwBi3vtlegex+VMVkBQD5W9XZAiqq7zC0gA8kcaNtYYkdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzwoPKOv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzwoPKOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D792FC4CED6;
	Tue, 10 Dec 2024 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733839967;
	bh=KsuCpCpU4NCI4skx9geIqKf8RaGjHnVWPpoq4+ibDFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rzwoPKOvMq/9sNXD14y/0WAeUy8VC6FvFT2D9HDD7YqaawBKSaIF1MZJ07QeiJVNs
	 kGTqqEnWI6J3NRE73mhplFFu1s2Dra/t2HBZxZFNR1b1LHvCqVzudIbrJvKzuHmqru
	 5bCSBShAU2uIwjjF0xZYcxtYrgyOnrLXUnpSQ8yZXLQpNwN1B7+KNQikNWpfJaL8gK
	 sgVyf2G8KvaNOQ7vDOSimY3mzWJAijOIcKvhWZ3yjoPHwMcPdr5uMKW5GlFX4o6KXt
	 C3hDcGiJ1OvpezxQQ4HYdScfho1D3tbuUY1qSqf/O3HUuXKEKTqPq0wJBaFTulAMxL
	 qfCIAyru97bfg==
Date: Tue, 10 Dec 2024 23:12:41 +0900
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
Message-Id: <20241210231241.88c0ed24004b2bda2985ad99@kernel.org>
In-Reply-To: <20241210121027.GM8562@noisy.programming.kicks-ass.net>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
	<173371208663.480397.7535769878667655223.stgit@devnote2>
	<20241209110411.GL21636@noisy.programming.kicks-ass.net>
	<20241210110428.aa5446ca9b2153c21f8fcdf9@kernel.org>
	<20241210111528.bb2c66d71fe38be92010264a@kernel.org>
	<20241210121027.GM8562@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 13:10:27 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> 
> > Wait, this is for checking the jump_label_text_reserved(), but as far as
> > I know, the text reserved area of jump_label will be updated when the
> > module is loaded or removed. And the static call too, right?
> 
> Correct.
> 
> > In that case, what we need is to lock the modules (for the short term,
> > can we use rcu_read_lock?) for using both jump_label_text_reserved()
> > and static_call_text_reserved()?
> 
> Yes, rcu_read_lock() is sufficient to observe fully loaded modules. I
> don't think you care about placing kprobes on modules that are still
> loading (that doesn't really make sense).

Actually, to probe module's __init function, it may put a probe during
loading modules (by trace_kprobe.c) which has been done by module
notification callback.

trace_kprobe_module_callback()
 -> register_module_trace_kprobe()
   -> __register_trace_kprobe()
      -> register_kprobe()
         -> check_kprobe_address_safe()

Anyway, unless we run the module notifier callbacks in parallel,
it should be safe.

Hmm, however, it seems that trace_probe's module notifier priority
is not correct. It must be lower than jump_label but it is the same.

OK, let me remove jump_label_lock() from kprobes (if it gets
module reference), and give a lower priority to the trace_probe's
module notifier to ensure it is called after jump_label is updated.

> 
> Also see:
> 
>   https://lkml.kernel.org/r/20241205215102.hRywUW2A@linutronix.de

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
