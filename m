Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45E145355;
	Tue, 24 Jun 2025 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780265; cv=none; b=tBu/j2HkFnNDO2tUsXlzZIqqwEONRlq9ffYyo7W8zVzsilrAZP+4nFU8RA+0hSWQb/vpTCD1WKiGZXIUX+ZZy9J5Tk3W+SQv1t/tVE6Sveqcf6pUm9AW3dB228Uqdpmin30TZ9xEyldQq8P2/2IYc31uhZKM5UZs/tFDfR0Wn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780265; c=relaxed/simple;
	bh=kJvxkJFb2m2TQQBRPn9W6akGT4m5Eh0lljLjb0hb4Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTKQr9FsIItYJgC0WeOUqBKnxoqC1AQ9aZeWgofiW8QwvjDuDoKbqPHhi3ZtpHnwQmF/+sh7EFmCKabv7GRwO7gbqM13pIYageUf7F7GAXbVaGsz61wrJRtR8TpL0/tZfwhbSE0d41eHXKFuuk72XscOCls4of3IQ6qWJgUF6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LW+SQ19a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TfGvdKj2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LW+SQ19a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TfGvdKj2"
Date: Tue, 24 Jun 2025 17:50:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750780259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LjzWaJlszZfB0Iyg0kS6b0Zp49oz/zJ1JIviTq6SFMM=;
	b=LW+SQ19aZvzIbswT6KS1HbbIIbExEAtnbVuKpkEmmSZYgyqU9mksm7p2MdbUx0tvVjADn4
	iuIKfTaCEV9OmFvTSxdY8cODysE2FS1Fobcj/bjsR/YfuzqPszIBdFJQHHTs3VvuFmtHo0
	LNkt06uwElmgpUjE8YTRr0vHzSlvwEC07dDoSq6gZVfG+4O9vG89QxTuBhr1r+y/WzyECS
	Vg8ll0W5qgi69MUQjo+IJC2Lv6tMUDo+qLsPLz2JpAg5pZpATHkJhfVCI9OUXkBde5x/gZ
	cQouXMepfMjLS6GYoHtHGKui23XHD4sufcG2I+Te1rtaM2mn7fW2YUBCCCSHWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750780259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LjzWaJlszZfB0Iyg0kS6b0Zp49oz/zJ1JIviTq6SFMM=;
	b=TfGvdKj2ZV13WApOUMTYTHY3M6KXB7O8jJOBJhvfJGrqiTbeLqwobWNUYp0qxIjKACtpI7
	f+uDVXceqXaBF1Cg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	john.ogness@linutronix.de
Subject: Re: [RFC PATCH v2 09/12] rv: Replace tss monitor with more complete
 sts
Message-ID: <20250624155053.wOoDw8ff@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-10-gmonaco@redhat.com>
 <20250624073609.OA9Q1V4g@linutronix.de>
 <e2b2e78a9c66973d90a9dbeea83b88b97182c36e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2b2e78a9c66973d90a9dbeea83b88b97182c36e.camel@redhat.com>

On Tue, Jun 24, 2025 at 04:44:49PM +0200, Gabriele Monaco wrote:
> As you mentioned, nobody is likely relying on those tracepoints names
> at the moment, but I would rather be cautious basing userspace tools on
> some monitors to exist at all.
> 
> In my opinion, RV tracepoints are useful as an alternative of
> reactors/rv userspace tool but cannot be used without considering the
> RV interface itself (e.g. available_monitors and friends).
> 
> We could at least stick to the following assumptions:
> 1. monitors can change names, be added or removed
> 2. tracepoints are consistent to monitor names (in available_monitors)
> 3. the tracepoint structure does not change (i.e. event_/error_, args.)
>    (can change for new monitors types where seen fit)
> 
> If in the future we allow the possibility to build RV monitors as BPF
> programs, we'd probably also allow monitors without tracepoints at all,
> but I'd say for now those assumptions are sensible.
> 
> What do you think?

I would like that. Ideally, the userspace tools only use tracepoints based
on available_monitors.

However, people may not do that, and just use tracepoints directly.

You could argue that those tools are not correctly designed. Therefore it
is their fault that the tools are broken after updating kernel.

On the other hand, there is this sentiment that we must never break
userspace.

I don't know enough to judge this. Maybe @Steven has something to add?

Best regards,
Nam
