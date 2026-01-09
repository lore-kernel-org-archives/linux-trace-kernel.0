Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD7225408;
	Fri,  9 Jan 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975286; cv=none; b=rpFOEXwXl1Et3TeGjGSxz3FMnjL5kVeVaR+7mbrgYy2B3jvgokFUM2Cox5wyWwpqhHwcsa97jkiSFoW92K5C7+TXr8SeV/nZrqoLADMrzC53djZ6dESqGZ3u2hcEgEy+tQDX8Tk4WS/yM9KLkSlzWCzMa25ubtmguzEEPsQPeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975286; c=relaxed/simple;
	bh=OWC1ntZBQKWTkIZk633veMv1AKus1gRIEYKhERIX7BA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWpauoXs3DlgULeBNMEqKC6Newh2DVtQ3RpSPvbU/qfFg4K40qAd6nVShV+68s+BN7fd1G8qZVowtQB49ezmXsgzWRN9dAhhzZOSGAIdwJF8FkQRgSLj1sYPUrO3aysVL0r9+bV90PGimXNKdevnSZRZQJ5W4Koy9bXTtpOOP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 8CCA61A0325;
	Fri,  9 Jan 2026 16:14:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 77B3730;
	Fri,  9 Jan 2026 16:14:35 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:15:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260109111506.66ad545a@gandalf.local.home>
In-Reply-To: <20260109095756.13deb429@mordecai>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
	<20260107111935.3befc296@gandalf.local.home>
	<20260108093932.252f6bc7@mordecai>
	<20260108115800.7a7fc8a7@gandalf.local.home>
	<20260109095756.13deb429@mordecai>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ihb8rxsfsw8zrdo3szasojjm3ouwg3zs
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 77B3730
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+oky8s4MPjftNUIdm5FDOaAGDH+y5fxEA=
X-HE-Tag: 1767975275-701826
X-HE-Meta: U2FsdGVkX19shqUHAwfxAoXdYF4FPvcwR/jQmaYQwN2e1O6cR4XGs/kBLqxWcBQDErfEO2PCfRGVEMCv+MuQz/T1PTHAWDFTEK4tKq+KpqLUDPtVsyPPBCynXC3nOGDTpLBqcaJRw1phM2Rd0l7MW0S8UYxv1mRA+VOifB4Kw07DJssOj5YUDQOPYlsJhR3mev3uce6rLBKzjzTXnYz071S9YpkYTUt9ZaPUvZ7AYC2eaBtm4q+OcZQnLjIeM8oHqK0VQv3vCqr8vKAg95uZQm3V9P7vkDUR/MajcHlHaMZ7hWj1XntnsmW5XD9dF7dkomoUZXs5Hak9z37u0giCxYbZ51k5mXYIMUusxjcuOQpteWDA2i0vAT2iOkUYGYio

On Fri, 9 Jan 2026 09:57:56 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> I have removed both "inline" and "noinline" in v2, leaving it at the
> discretion of the compiler. If you believe it deserves a "noinline",
> feel free to add it. FWIW on x86-64, I didn't observe any measurable
> diference either in latency or instruction cache footprint.

Please add the noinline. I went through and added strategic "noinline" and
"__always_inline", as well as placing "likely()" and "unlikely()" and
dropped the cost of adding an event from just under 300ns down to less than
150ns.

This code is called during function tracing (hit at every function call),
and yes, every little bit helps!

-- Steve
