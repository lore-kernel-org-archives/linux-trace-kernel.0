Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603719E98D;
	Thu,  5 Mar 2026 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674675; cv=none; b=m6mk88jl4oFKbPQTXwXlk0RKGAMB5CxYPc5OEpyCed1aO/xtXPjlzLkdr5bKlhsz2N3slyQy1WETnVQ4PLHUjjpx7oj2aJ6k+Rte8exylvX8AICZBFOkLklIePZxmziyGNNFos4EsS8zdJeYaAgovY0ddrTAIysWBmr0d2GY+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674675; c=relaxed/simple;
	bh=kxTQsBwPgAtXjSA2KomBqcWSxnKdXwCBd1QQgZU92C0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNcY0METhR1EAanhAn2Y2s92E4dsDXnZdKhQTeb21B8x4fJKDbgGiRuBu/TwjQ2y3g0meaqF3c28BlN8SVMcEpLTGK55q4husYd7y7/qfyqU7mabENMnqiUZvVRKtVGRf6i6a0nabaj5z117+oxjmLysMWpf3aWjiCLAqjhQU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv/AjJSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv/AjJSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F41AC4CEF7;
	Thu,  5 Mar 2026 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772674674;
	bh=kxTQsBwPgAtXjSA2KomBqcWSxnKdXwCBd1QQgZU92C0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dv/AjJSIepwd69SfU/w8BV9lIvttrbA5Yl8wujfuWoDwIGhWXbI7cDGUZNa8ov+iv
	 zh/lct3TCsBvOesNkidaV4cpIzBsx9GTofAU4BzuDStJ11e6MDQdaECiHCqrxqAoFJ
	 suP8nNIBEyd/rVDj8wgyNb1ITbnoRE2yUaS7sUvMVgoK0bOJCMPdA80h8F8pZa75kj
	 7dXtz5Ih6biz9NBTHFeLr2AGMChloFxjvEeNNrpilqSvKaVBvYVQjvw/D+tGnVRijk
	 ArJhlgyRKzz6Nk0wNACIgaPSWPLWS80TYKCxgfFQ+Jkbn065o4jc9dYuaCSv9t43ID
	 bZJmpNP02vcjw==
Date: Wed, 4 Mar 2026 20:37:44 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Brian
 Geffon <bgeffon@google.com>, John Stultz <jstultz@google.com>, Ian Rogers
 <irogers@google.com>, Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH 1/2] tracing: Have futex syscall trace event show
 specific user data
Message-ID: <20260304203744.02e76dff@fedora>
In-Reply-To: <20260304090748.GO606826@noisy.programming.kicks-ass.net>
References: <20260303214735.002154462@kernel.org>
	<20260303214942.428502100@kernel.org>
	<20260304090748.GO606826@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Mar 2026 10:07:48 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 03, 2026 at 04:47:36PM -0500, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Add specific reporting of the futex system call. This allows for debugging
> > the futex code a bit easier. Instead of just showing the values passed
> > into the futex system call, read the value of the user space memory
> > pointed to by the addr parameter.
> > 
> > Also make the op parameter more readable by parsing the values to show
> > what the command is:
> > 
> >  futex_requeue_p-3251    [002] .....  2101.068479: sys_futex(uaddr: 0x55e79a4da834 (0x80000cb1), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)
> >  futex_requeue_p-3248    [001] .....  2101.068970: sys_futex(uaddr: 0x7f859072f990 (0xcb2), FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, val: 3250)
> >  futex_requeue_p-3252    [005] .....  2101.069108: sys_futex(uaddr: 0x55e79a4da838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, val: 0, timespec: 0x7ffe61076aa0, uaddr2: 0x55e79a4da834, uaddr2: 94453214586932, val3: 0)
> >  futex_requeue_p-3252    [005] .....  2101.069410: sys_futex(uaddr: 0x55e79a4da834 (0x80000cb1), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  kernel/trace/trace_syscalls.c | 266 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 263 insertions(+), 3 deletions(-)  
> 
> Egads, I really dislike how all sorts of syscall crud is 'duplicated' in
> this file, rather than near or in the actual syscall definition.

Now I did copy the futex_cmd_has_timeout() which I could just use the
futex one by exporting it. But the rest is due to printing the content.

What exactly is "duplicated"? The code is mostly done to display the
data, where as the futex syscall code is about implementing it.

What do you suggest in reuse? Or just move some of theses functions
into kernel/futex/syscall.c?

-- Steve
