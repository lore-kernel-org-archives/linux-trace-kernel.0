Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74182DA775;
	Mon, 21 Jul 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107055; cv=none; b=ri6UuUHZAcpzS31azn2+8rDD24TbRs+69VJxw/wde57BFjUq23fBRXYe4IUXaGOw4rG0xbTUSH1QnobOwKsKqoZenLQWvSUsZg8mYaLgE/bcO3PbA8yzg7R+v785liM698yiRPNuTrwZrTrSwC0lJC0qY1wwQVC6Sw9NJppBwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107055; c=relaxed/simple;
	bh=70yFJi1mfoZnJc6voh4zfMggd8lCh8C9yeiLMJqM22s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UthKPVtKW6VV+zahUZsEMZYII0oA1o3KKWC3plLt7HaRkCycPqHacYrISg7g+N6n/5IE5WkgL6Rnjcm0fKdFXQag403gITJuIZLB/uJZ+F1QPxraTWRNgfSlWBfNv9Oo4N0rsmjIpEeWxVbI0GQ5rZSiq+x3QK+DNlVCgBJ/b5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4b1QHR3O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTDPibE5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4b1QHR3O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTDPibE5"
Date: Mon, 21 Jul 2025 16:10:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753107051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFLTPOt8EYhXgl11BLktas1qh/5JZA8mOSDVcQCX6TQ=;
	b=4b1QHR3OusogzrkZD61N7d+Jkd4FI4wY6BKjuMjfNwXTTjiNwdOQyVbsTTBq8jU356+VwW
	MD9Wd9C3nNlek+Dfm6XcQHjjpXsT7hln1iz4zNrJqrLOYgUndJqLXjEIOD4O6+H0Q7NedU
	8IzHB0EdksKixlpg6pn+ScikwVGQuRJCZ7Jy6uEX28DmFYyMyThjbpJwKMx31Ue0gBLZA3
	S4wL7Mb2gey7fAgLr+PKX1//viwDiuG4ERCszPuZjCEqahnOnFMH8mKvhGtg20LU4mqwUv
	RWmqdJ6T9gunw5Pu5rjlM5QcZ0vV2/AX6zF9KvcW+Bp3urRBEixXiu7MGEmBvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753107051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFLTPOt8EYhXgl11BLktas1qh/5JZA8mOSDVcQCX6TQ=;
	b=VTDPibE5ruppfMtnbaMtjS/cpDfXdm96A+xs2IyqiFov3eHTDE+mD53xz3aFo2OCxKcrQX
	6/9PRvFCNpD4sFBg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] rv: Remove the nop reactor
Message-ID: <20250721141050.E-MjrEbf@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
 <21a530ffb705887d7aed18255572521e5b880bc0.1753091084.git.namcao@linutronix.de>
 <feae7a189afa69091816074dcf66a496b11bdd38.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feae7a189afa69091816074dcf66a496b11bdd38.camel@redhat.com>

On Mon, Jul 21, 2025 at 12:29:24PM +0200, Gabriele Monaco wrote:
> On Mon, 2025-07-21 at 11:47 +0200, Nam Cao wrote:
> > As suggested by the name, the nop reactor does not do anything. It is
> > the
> > default reactor when nothing else is selected.
> > 
> > However, the monitors already null-check the reactor function
> > pointers.
> > Thus, instead of a nop reactor, just set the react function pointer
> > to
> > NULL. The nop reactor can then be removed.
> > 
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> 
> Thanks for the patch, I'd need to go through this a bit more in detail.
> 
> As far as I remember, the only way to disable reaction is to set it to
> the nop reactor.
> With your patch the behaviour changes and, to disable the reactor, you
> now need to write an empty string, this should be documented somewhere,
> at the very least. Perhaps userspace tools (tools/verification/rv)
> might break and would need adaptation.
> 
> We could still remove the kernel side implementation, but from
> userspace (tracefs) we might want to keep the nop reactor available,
> setting it would set the reactor to NULL under the hood.
> 
> If you really want to change also the user space interface, we might
> want to imitate other tracefs features and use something like printk /
> !printk to enable/disable a reactor.
> 
> What do you think? Did I miss anything here?

You didn't miss anything, I miss that this "nop" interface is inspired by
tracefs.

Although I prefer writing empty string, compared to writing "nop"; it is
better to be consistent with tracefs.

Let me drop this patch.

Best regards,
Nam
