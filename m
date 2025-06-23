Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A925393A;
	Mon, 23 Jun 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687047; cv=none; b=YMjpf9hc6cRQpibCyW/EQiJF9OgZScZrHzqvY6hnvwLP8pb+jCd1gap1m5h/33LDapzzpf6hZlrqBAWPxnIed7R4GKJkfZIE7gMGesk+24UKd/byUQufQ9uzH11madWHkZVtFYg86v2vNHvSXCbluVzDksOP2t20Uk0yYMklrm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687047; c=relaxed/simple;
	bh=P0sFolHUxrVuoCE+6NvZQkcDRze9W1xjSNhVu3bmqhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp+7IkfZ7zQ5C1o/7d7PCR8LQrdbnsuAn5LS9C3cXkPruBCKrppMS8Uf8WBKELtXQUNM/fm+fjXAzbCuB+2LLRaBp34s1/9MXnAadzbY7tAw+iUf+pG3avk/6Sac+R6Tgykd3Olz2mFeAeXzCAw8ckHJUupaafbK2AjlFeW9PXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b09dcOmP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CsVWcb5X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b09dcOmP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CsVWcb5X"
Date: Mon, 23 Jun 2025 15:57:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750687043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz2DKQba7gyNT9FBfEsFGB/ebwSNeejJWsxrap/HXEc=;
	b=b09dcOmPJ9WTZdJ9Kx8pzwR2kDkG7WFul9r4XEla56yKYobxoiK0xLz2r+ipAhcSCCONRf
	AmLdDXIn7LqLrpjA6Oj/Ys41/BqyAEkGwGzQb/uL0VjQnx/x8D/m0rXi5z6F5IeNG9ObtI
	bnDw82nlc5hcYDbjka2S/rjj4r1L1I+LvkQ62MzC5hfc2vTbxAjF0mjNfl76tUIVciYoHE
	+L4QrtVe5ZgkEA8jDkd9oEtBuE02ftphYOI4KERp0tt9+JFNYwDDjW4Yvlu0TXcwMPnR3c
	emCvFtj4JTGXRFPZSAQ6fdOStyC3u0PVf1cKHf+AhrQeIJN6YGvhJkaHhTXS5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750687043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz2DKQba7gyNT9FBfEsFGB/ebwSNeejJWsxrap/HXEc=;
	b=CsVWcb5Xttzpchn17VPyWnYIsveUNvKtggmh1ypIzkTZDaPBH96sZiLd6BAHgeELRXJK8S
	BjrZWIEcxbc4dwBw==
From: Nam Cao <namcao@linutronix.de>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 RESEND] x86/tracing: introduce enter/exit tracepoint
 pairs for page faults
Message-ID: <20250623135718.Zc4hKa-u@linutronix.de>
References: <2dda8c03-072a-43b2-af0c-bb996d64c388@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dda8c03-072a-43b2-af0c-bb996d64c388@cs.wisc.edu>

On Sun, Jun 15, 2025 at 07:32:00PM -0500, Junxuan Liao wrote:
> Merge page_fault_{user,kernel}, rename it page_fault_enter, and add
> page_fault_exit. This pair is useful for measuring page fault handling
> latencies.
> 
> Add a new field to the merged tracepoints to indicate whether the page
> fault happened in userspace. We no longer need the static key associated,
> since it was used just to avoid checking user_mode when the tracepoints
> were disabled.

(I think) this breaks lttng which uses the old tracepoint names [1]. But
I'm not sure if we should worry about that.

Do you plan to add this to other architectures?

Perhaps it is better to implement the other approach suggested by Frederic
[2], using trace_user_exit/trace_user_enter? So that more architectures are
covered, and avoid breaking user tools?

(Btw, you would need to rebase this patch. The tracepoint has been moved,
and the static key has been deleted.)

Best regards,
Nam

[1] https://github.com/lttng/lttng-modules/blob/master/include/instrumentation/events/arch/x86/exceptions.h#L88C48-L88C63
[2] https://lore.kernel.org/lkml/Z_mO6_m0bV-Q8NEa@pavilion.home/#t
