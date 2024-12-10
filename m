Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D371CF7B8;
	Tue, 10 Dec 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872632; cv=none; b=fAMMpnSbAjchoeTZAz1WzeD2l3lIGndtokrH3m9l4I6J1ok9MUn/IAlj7BZ/VwU9ggvSKFVSFHPc7Gn5MylkyXos+0wuo6iUGySmJ1q6RnOZvp9fV8z1oXmVYFB718QKBczdM1PPUkKCucA2S8IyM6zLPhktvei0nQSHzXS3y94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872632; c=relaxed/simple;
	bh=pvLgzqvT8heMfxqBWCzQLTJLGu/Nu+xIER9KJT1b1rs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rHrC/1HE1NVthq5isWTDQ9R8jg8wRKJSgSm7QmTqBgOCz+f5qXIhg00tX70xqFIcnLz0zamY46f5liyF8J8gTL+43Ig54ZlDFuGSRCfyhfP6juuSrs4zPfMqzhEdeQMc7WvKOsOW6qmIsnDMmEsYoi6bc20SVhRhecGfBKDfSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbA3ybWN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbA3ybWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18797C4CED6;
	Tue, 10 Dec 2024 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733872631;
	bh=pvLgzqvT8heMfxqBWCzQLTJLGu/Nu+xIER9KJT1b1rs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NbA3ybWNbtSc32RkGczm1Ssbsu5GtmZMY2/rB7BfoxWxMXhUTk+zB1uAempd/c4Lh
	 ifqiy4pHzONqB5I8uMiZhjCjttHdmqujjjohGISGYuE3vBiurr5WCVxOKxzfwtW1K6
	 xuKRaV0lH+bLVXyfpCHp9SWvGIdhp+50Covb1DiMo2GZhiMOjeOhT+VVGMdN9jbn/L
	 DKgd1DYqJHsP/Ik8NR/XCq7oBIioaUOkE1K5OnT5ZscwSIwO2pwzB/jE5EYQI6P/oc
	 zWGvKFaBHPcdRqKoQUhveClt/e5X0dk7TlrpzC6FtX5737nzhmpDQZTO4CFyV/q4NF
	 0CLt+cTS4GspQ==
Date: Wed, 11 Dec 2024 08:17:04 +0900
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
Message-Id: <20241211081704.1bb59a96be45f6e9a3d9d45a@kernel.org>
In-Reply-To: <20241210231241.88c0ed24004b2bda2985ad99@kernel.org>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
	<173371208663.480397.7535769878667655223.stgit@devnote2>
	<20241209110411.GL21636@noisy.programming.kicks-ass.net>
	<20241210110428.aa5446ca9b2153c21f8fcdf9@kernel.org>
	<20241210111528.bb2c66d71fe38be92010264a@kernel.org>
	<20241210121027.GM8562@noisy.programming.kicks-ass.net>
	<20241210231241.88c0ed24004b2bda2985ad99@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 23:12:41 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 10 Dec 2024 13:10:27 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > 
> > > Wait, this is for checking the jump_label_text_reserved(), but as far as
> > > I know, the text reserved area of jump_label will be updated when the
> > > module is loaded or removed. And the static call too, right?
> > 
> > Correct.
> > 
> > > In that case, what we need is to lock the modules (for the short term,
> > > can we use rcu_read_lock?) for using both jump_label_text_reserved()
> > > and static_call_text_reserved()?
> > 
> > Yes, rcu_read_lock() is sufficient to observe fully loaded modules. I
> > don't think you care about placing kprobes on modules that are still
> > loading (that doesn't really make sense).
> 
> Actually, to probe module's __init function, it may put a probe during
> loading modules (by trace_kprobe.c) which has been done by module
> notification callback.
> 
> trace_kprobe_module_callback()
>  -> register_module_trace_kprobe()
>    -> __register_trace_kprobe()
>       -> register_kprobe()
>          -> check_kprobe_address_safe()
> 
> Anyway, unless we run the module notifier callbacks in parallel,
> it should be safe.

Hmm, this is still a problem. We need to acquire jump_label_lock()
even for the jump_label_text_reserved().

If user runs module load and register_kprobe() in parallel, 
jump_label_module_notify() and check_kprobe_address_safe() may run
in parallel.

jump_label_module_notify()
  -> jump_label_add_module()
     -> jump_label_sort_entries() <- update mod->jump_entries

check_kprobe_address_safe()
  -> jump_label_text_reserved()
      -> __jump_label_mod_text_reserved() <- read mod->jump_entries

So there is a race on mod->jump_entries. jump_label_lock() avoids
this race.
(IIRC, module can get the reference in the MODULE_STATE_COMING state.)

On the other hand, static_call_text_reserved() does not need a lock
because it does not sort the list, nor update the static_call_site::addr.

In conclusion, we need jump_label_lock() as it is, and don't need
static_call_lock().

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
