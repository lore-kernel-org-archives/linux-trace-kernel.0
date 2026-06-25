Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3F373BFE;
	Thu, 25 Jun 2026 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374194; cv=none; b=ZfdOO2ncHioSVH7WhsLoRo1zjElGmT2snqltJV7Ev3mDK/oPkdtxrsbDZE0P0mZT2ivJH3JSEFNQfnr/hZpuq0U1I7DPUoEW2XTMn1VuUFRGYRfSHqTRNMI41xkAkBlk670xDTZ18OhXojQr8LykpZvITZJwqwn8y7PI4DydWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374194; c=relaxed/simple;
	bh=GI+5cdJFQGWH/Vj3YGt0iUABLXOSVE5pUwcLrZieLj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGpkHEIDWmxML1I6FSmuBk2fyXCV91LMSUsdzjchN0IZV4hgQMskpHrBPYjnFZZHZ0WABmmgMXJA70WXKZ5nAmOKJXX2DIdRXmsb9UUHoVJAITS19xQ41MH4NNu0iiNdsBTSvlO/ZZw0qSCmi5cqZV/gQ91wrMdGNwsC/RkUL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0wMavDgK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=72hl69/Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0wMavDgK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="72hl69/Z"
Date: Thu, 25 Jun 2026 09:56:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782374191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GI+5cdJFQGWH/Vj3YGt0iUABLXOSVE5pUwcLrZieLj0=;
	b=0wMavDgK0ABsrURyz7L7zr73hQHk5Te+JdfXZL1q1USuxdxC7W0vJSyIXDGNTgHkajI90F
	Uq7lEoyuMnmV7TLhSOfirtNwyk/K95m6OGkE3mzNOSU4gNeXA0Go7IxtL9buVvabTo7mge
	4YrZsxFRtFsTecJ8mpF/++J4obxJp/voKgCWidMOLQnOJB4xEp1PUc0nXfa+htAZty/dKq
	tEmNH8ewG8T9hs5R0Yap2QvNVfK6mAsifWnam/imzTP5e4S4oMKEr//Hz3M4nCgTtuU0Tc
	OPspIqA+lqu7hqjpwdjpk92mGhMQVL+zQhQvKv/lyY7tuwUCmicMKcJEDWTaNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782374191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GI+5cdJFQGWH/Vj3YGt0iUABLXOSVE5pUwcLrZieLj0=;
	b=72hl69/ZqKLLtsYiGLfk4rPI6Ol0yKDJZ2RRQNn3hVRCW/o5X41HhiBogJa1sYl43OtG9s
	SJYo57fB1RzF09Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v3 0/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260625075630.lHa_0r-P@linutronix.de>
References: <20260624081806.120105649@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624081806.120105649@kernel.org>

On 2026-06-24 04:18:06 [-0400], Steven Rostedt wrote:
> Remove trace_printk.h by creating a trace_controls.h for those places that
> need access to tracing prototypes like tracing_off() and for the places that
> need trace_printk() directly, to have it included directly.

That sounds reasonable. Thank you for doing it.

Sebastian
