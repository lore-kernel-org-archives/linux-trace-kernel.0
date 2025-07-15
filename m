Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151F2561AE;
	Tue, 15 Jul 2025 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588716; cv=none; b=it3EZO7KS9/nh2VG9SVitKEV/Xhub9zko01uF0umqAzH8vEk9EHT4F0kKicUM0GKQBWKftqvyS3Ab/8TMKRtC+L+OBlvFFjckMkoP729RJL4mEXdUZTxHBiGLq7OlukSxqgFkNx8jyl9/Ya1GKvs9A1T/AHdXhla3Yc4U+9PWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588716; c=relaxed/simple;
	bh=f0yyRzxUY/OWJKz6Zg2JZo6iXvzMdkDQC9RwmZjCa4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSRXPg2aSdNXglTLXHSpu14S4GI+kQdyen4E2pBEhlDwZX8iu3ebuQ3PCg+luizOD0WEfdl+8dTcRREBWL3zNjowMN1TwB25yJnTQnAJWBsFT/fBMkxdO4PlIuM2/46ntLnhdM0wcP2vUj3qkQpq2gmqXCSJQimLeL5JVPFYrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G9fMskTb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ia4pUYiT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G9fMskTb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ia4pUYiT"
Date: Tue, 15 Jul 2025 16:11:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752588711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5UUm0MYkiusb6g4b2WpMBZ3nji8/GfrfbjkL3l4bUs=;
	b=G9fMskTb6WQ8LEqHBU/SJv2cJ8CUbb+afpKiH447SedL6OLXA0tVI1udOMyDMIrYHARHJ5
	umONrpFCfmkopRpNBWfqgZ08Q8m/l/5nnMTuOTg32rnG9WFumXycBc+5z50MfruPIl8bbg
	/Ja6+YXB2lKFuZZm0u3KaVF9zvL2BQWqwpwJsZmOZaMIGOM4XCQxqX+DDPM9+Z10YdKfaL
	wfjweYiuPYgYfIEP8Sw/Y5pMHDJp70DhNB6v4BsEbWNXXWAG3LwgLCpJVuY6IdHYKasFD6
	CCBpnkN1GDIx+4RkQ86HPN4fgYsDdB23DcQOpnnB333SgvKTkHeVYWwUSCtbaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752588711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5UUm0MYkiusb6g4b2WpMBZ3nji8/GfrfbjkL3l4bUs=;
	b=Ia4pUYiTHbDGULiIOah+JP55avXqf/X5ezsULJEL5p0pWSnDwp/+/vaF8WNIls3AgG4PSP
	atAcgGgdL2k8ZmBA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 06/17] rv: Use strings in da monitors tracepoints
Message-ID: <20250715141150.V4bWibVh@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-7-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071434.22508-7-gmonaco@redhat.com>

On Tue, Jul 15, 2025 at 09:14:23AM +0200, Gabriele Monaco wrote:
> Using DA monitors tracepoints with KASAN enabled triggers the following
> warning:
> 
>  BUG: KASAN: global-out-of-bounds in do_trace_event_raw_event_event_da_monitor+0xd6/0x1a0
>  Read of size 32 at addr ffffffffaada8980 by task ...
>  Call Trace:
>   <TASK>
>  [...]
>   do_trace_event_raw_event_event_da_monitor+0xd6/0x1a0
>   ? __pfx_do_trace_event_raw_event_event_da_monitor+0x10/0x10
>   ? trace_event_sncid+0x83/0x200
>   trace_event_sncid+0x163/0x200
>  [...]
>  The buggy address belongs to the variable:
>   automaton_snep+0x4e0/0x5e0
> 
> This is caused by the tracepoints reading 32 bits __array instead of
                                               ^
                                               bytes

> __string from the automata definition. Such strings are literals and
> reading 32 bytes ends up in out of bound memory accesses (e.g. the next
> automaton's data in this case).
> The error is harmless as, while printing the string, we stop at the null
> terminator, but it should still be fixed.

I'm not sure about the "harmless" part. What if this string is at the very
end of kernel image? Wouldn't unmapped memory be read?

> Use the __string facilities while defining the tracepoints to avoid
> reading out of bound memory.
> 
> Fixes: 792575348ff7 ("rv/include: Add deterministic automata monitor definition via C macros")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

The change ifself looks good:

Reviewed-by: Nam Cao <namcao@linutronix.de>
