Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640855;
	b=VL/YN2YrHTi/fma+DEtvjyQZ7a3mfXG2BPRjtmxec2cIaMNsny0vc0d8kyfe2qhGgli2
	 1tEAFCwqePxpnSwFmWRyhfdu8VWOV0S9hq5ar67utUIcH6/9ELOd83QqET/wtel4tmVGT
	 56TIwuJWPsTbjVr6YLRHPfCTX/zYHYztNYfjznezdgwmkFr9QRzVt35HUXY7jGj2npKo8
	 jC7zCCtYQG0I4ALwQykreMWIWTOi74Y5Pz6AXV7vt0+oxexXYtRe8ujsyFvNgObMaH6g7
	 EgM5kAARzDbgFGQtZU4yU/yVtqy8sU5HpUjNnyTlMKJsNIQGeEgNYAbHlrKloqawKJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640855;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=qpq7lIG5/HRt+2swVzeYdkDxOzJtStedVh4a/jEaJD8=;
	b=r+UuV+ZhMj5cq9iq8ilybG35DgCOvRbr3w5HvM2vI9tFt/hVGGWv3demUNGm0aRIFqWe
	 KKOFsR7z7iKSsghC2hLfr3Eoth+drl3fl6zj+jgIZ3iMb1HntT+9+3TVDqt9l5tMFgH67
	 b8zvikm1BelGWukH6GRRPmKZ0TNDwNobVecFsUpMaDFMOaIC+ylK0ZDVHc1MtIXKfkVuQ
	 R+uVn6AZhBJSJehw1j9kk/MWDTSmHQxMA68oB1Z+h1rVKhzJjOzetlOuhuYSTNVsppXmO
	 C9V2svxwpgAXkLZ3puG5iJ7V1wpETKc7u9R+jslIobNgyUQxLyQXnLY5b1q6u9KGaWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=5KCmrODy;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FB606C3FE;
	Mon,  2 Nov 2026 17:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 468FB606C3FE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=5KCmrODy
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D48011C0B81;
	Mon,  2 Nov 2026 17:34:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 3FAA72002D;
	Mon,  2 Nov 2026 17:34:09 +0000 (UTC)
Date: Mon, 2 Nov 2026 12:34:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Naveen N Rao <naveen@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] probes: Use trace_printk() in probe handlers
Message-ID: <20261102123408.0fb950bf@gandalf.local.home>
In-Reply-To: <179360345418.115681.193455787480210412.stgit@devnote2>
References: <179360345418.115681.193455787480210412.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3FAA72002D
X-Stat-Signature: 7ckdacpycu7hbqk64obfj93p47cit5qh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/guh2Tz/bFMPzEWGFSiw4+Tr0ihxK2MSI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=qpq7lIG5/HRt+2swVzeYdkDxOzJtStedVh4a/jEaJD8=; b=5KCmrODyWfBoGvRe+QqlpeXT4OKDHJN4t1gtVIqx8xdkV5NbI6dAilJx6THR4qE1j6TUNYDbOGrFJP0WGwxxGx+5lzY2itfP6QSu8zhR9fC7FtQJR/b9p6iYzZRifBh2Babe05GQHXzDzROooiY7HCWc7pNeTvcx8rl99a/rjoI=
X-HE-Tag: 1793640849-471523
X-HE-Meta: U2FsdGVkX1/cHMCQNDM9YHYra2VrVZpn3rMXZqoKFr9Um4okpo1JBddl+5jKSfjOfD/U3u1uTSMtWsIw4eIzu5a2PgP1iExl08tr+3AstoqZe5Abx/0FEXbrxyRBo0CgKe5QEu4ncFHJ9Z1wGTBzT6aFAEG/4xQ/1RR8fC1mnRelRlfiqk98d/eiRj71r5dMK+s4OPx+LmWDL9ItUrdit09lihy2DbuZWTsGvAIX3+AGIYr767O6K7EEJ6qnZIcZW9XsMjx9or50Q/d1nkfPHy9XJBmqBgk4gmgUwpOjx+RGbq/LuKvJN9/Raiwtlf5/0AkVI77Zl5Pe5HBkwmJpkB8q3B2t47kA


[ Cc'ing John Ogness ]

On Mon,  2 Nov 2026 16:10:54 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here are patches to update the probe sample code to use trace_printk
> instead of normal printk. Since the fprobe and kprobe/kretprobe handlers
> can be called from somewhere where console is locked, using printk() is
> basically unsafe. Only the unoptimized kprobe on x86 is safe because it
> is ran with NMI context (in this case, the kernel uses printk_deferred()
> automatically), but optimized kprobe/kretprobe/fprobe are not.

I don't think printk() is unsafe in these situations anymore.

John?

-- Steve

> 
> Thus, this series replaces those printk() (pr_*()) with trace_printk()
> which should be safe to output the result into trace buffer, and use
> trace_dump_stack() instead of stack_trace_print().
> 
> The similar issue had been reported by Tiezhu Yang [1] in 2023, but
> it was pointed different reason, and not applicable to upstream.
> I investigated it again.
> 
> [1] https://lore.kernel.org/all/d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn/
> 
> Thank you,
> ---
> base-commit: bc71431221f5ba8bb33918399552636e059c2c45
> 
> Masami Hiramatsu (Google) (3):
>       samples/kprobes: Use trace_printk() in probe handlers
>       samples/fprobe: Use trace_printk() and trace_dump_stack()
>       docs: trace: Warn against using printk() in probe handlers
> 
> 
>  Documentation/trace/fprobe.rst      |    5 +++
>  Documentation/trace/kprobes.rst     |   11 +++++-
>  samples/Kconfig                     |    4 +-
>  samples/fprobe/fprobe_example.c     |   49 +++++--------------------
>  samples/kprobes/kprobe_example.c    |   69 ++++++++++++++++++-----------------
>  samples/kprobes/kretprobe_example.c |   10 +++--
>  6 files changed, 66 insertions(+), 82 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

