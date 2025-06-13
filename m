Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F4214228;
	Fri, 13 Jun 2025 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833077; cv=none; b=pQJDHFNTwhOC0+uWUUD1+vcjP/ibvX1vmLS8aKSwSWqiT7RBTmeToQZt/1MM0jAqo7PUKVR+I40ftAoxxpwJEKa7hJKdtrZUQ6vPKbcCCwr44xQ5zUHvN6iFowFcYcR1mi1CVBLkYKnt7Sx9f0VVyjitqofAFYXtPdpgEXQw6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833077; c=relaxed/simple;
	bh=F5UXD9OQ0uuvVUWWCaPtRUrUDNf57a+QVebKBuU6C9c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=j8HyuRKvfExcTg97UGlaEA3jCEaqNUuaxTxLkHPJB6cNWbFSzlxdHFtraN+COUvjBGblzbbwxjJkMocFXUgH14uWdrbz81pxPkjaTVawCXppMmJnrpzK8pcpmdiayFN8kjaE65Vs+rKH7o0HZ5sZSKODB4cw4L0S789tUNZvR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qe59wTWN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J3Nyz6m4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qe59wTWN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J3Nyz6m4"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749833074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=F5UXD9OQ0uuvVUWWCaPtRUrUDNf57a+QVebKBuU6C9c=;
	b=qe59wTWN3TaPNQfOOPcz2nezF7metl2eWz2Uf7I4ww8I53QM7VYvBni70wS3iNPfjEWpao
	QKMHYtBrM2/hxH3pHfjVoBUrbSUWHcMDN2V0BwJNPPAl2qwZB5uWWIw3RiUOz55RiLZMn0
	/NUPNU8u77PpLZOGwHH9QWtE6B5kkFIRIKCb27YWcZI+Xis20HBqxhphvZA9p/8hnBylUC
	lfggAKIaKro2dt4bVFu2ssRb58k6jH5/8Q9rhDMXTvB5yU+PhzGbgv+Rnvo7sV1qUmYLQI
	z+miDu3+0Eb/nXm5SviIceZMe+d5oZHZQBAXaVq6Ccjqr0ulqS4R8YjncmUeCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749833074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=F5UXD9OQ0uuvVUWWCaPtRUrUDNf57a+QVebKBuU6C9c=;
	b=J3Nyz6m4cH2J/sbl7gsh0QwKvV09fWaokZQxKuQMH9vyIRMi9V5Li2uDvWciXNByrRAc6L
	Pmi/sLNmu5JG/rBg==
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] alarmtimer: Hide alarmtimer_suspend event when
 RTC_CLASS is not configured
In-Reply-To: <20250612095828.6d75dfa3@batman.local.home>
Date: Fri, 13 Jun 2025 18:44:33 +0200
Message-ID: <871prnr3pq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 12 2025 at 09:58, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> The trace event alarmtimer_suspend is only called when RTC_CLASS is not
> defined.

s/not//

No?

> As every event created can create up to 5K of text and meta data
> regardless if it is called or not it should not be created and waste
> memory. Hide the event when CONFIG_RTC_CLASS is not defined.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Other than that:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
