Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062201C6FE8;
	Fri, 27 Jun 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036533; cv=none; b=ncFLeWzl8ZQic1IpLvtt//ZJDNsHL07g2rdFBXAv5jD1drSpMEx5fextISIGHlMNZqdqKCJgV65eZckU3mTe0vqWmNjtPF5H+qy57yKMNk7yUzxFbVnLwherih4C3B+oVIZWO2lXX2RpyuDxohyGBsxPgMVar6GR8JFbdO8bPjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036533; c=relaxed/simple;
	bh=tfA2QwKxRkMhYuRZ4z56nNCSRBWnKU7G/mMuN72yeQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYHdIcwFk/poZhev65TyKkH8nhuITty5jUDlla88t8ZS03TP+MBofozB3+wOh5ayZ4Nvu7XmFZPjxnE6c9ZKsc1HW5htTfw5Bh4vs/xyDsxf+qDLKaUQpae72I6VDK7GA8/RryAtGxRO4kHmnvUioU8qkWE953ecg0zY6jB9ees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uimzMe/l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZtmcqdM7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uimzMe/l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtmcqdM7"
Date: Fri, 27 Jun 2025 17:02:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751036530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvgCwM0cdIwDopQL4iWKyespTMSawwFYARJ4z6iapCs=;
	b=uimzMe/lNCg5DwWLgcstXiuhS9ZGjYA29YnnyZVA0C0NdTl5X4YQjW2/yGE14g8AfpGg2R
	8R1itLoVHpsM1lpMn/UB2IqikBGegRkbEcx3kzFO/KgI/6oROZb+RoGQ1JLakXBKvOaUGJ
	DXMWMj/K+OlGd8mZN3tZ8BbidcvF/QiqAXoGqwKyC1XBKUSX6CkxmdvVMxuV1wsknySZpW
	cduhYJjtQNo975BdapCOehvH9MO61ne2ijBt2gNxt3b/6N5h+BkZ777mstshOGIYk29rFL
	8+yah6JCukYpCD9T+gVftr6PJur3j8fM+Lz/Cp+AZH/SIZjjueAil96ehTp/QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751036530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RvgCwM0cdIwDopQL4iWKyespTMSawwFYARJ4z6iapCs=;
	b=ZtmcqdM7kqIh7pogk432eZI1DM41Uo0AyWFrVZGpTocwuSlDNYlTZavN+dRvCnnVYtpNWB
	e5KbLBfm3XvsnSCQ==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	john.ogness@linutronix.de
Subject: Re: [RFC PATCH v2 09/12] rv: Replace tss monitor with more complete
 sts
Message-ID: <20250627150208.xrOGCPrw@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-10-gmonaco@redhat.com>
 <20250624073609.OA9Q1V4g@linutronix.de>
 <e2b2e78a9c66973d90a9dbeea83b88b97182c36e.camel@redhat.com>
 <20250624155053.wOoDw8ff@linutronix.de>
 <20250624153125.56eab22a@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624153125.56eab22a@batman.local.home>

On Tue, Jun 24, 2025 at 03:31:25PM -0400, Steven Rostedt wrote:
> So WRT tracepoints, it's the same as a tree falling in the woods[1].
> 
> If a user space ABI "breaks" but no user space tooling notices, did it
> really break?
> 
> The answer is "No".
> 
> As for tracepoints, its fine to change them until it's not ;-)
> 
> We had only one case that a tracepoint change broke user space where
> Linus reverted that change [2]. That was because powertop hard coded
> the addresses to the tracepoint field offsets and didn't use the format
> files (what libtraceevent gives you). And I removed an unused common
> field, which shifted everything and broke powertop.
> 
> But I converted powertop to use libtraceevent, waited a few year until
> all the major distros provided the new powertop, and then I removed the
> field. Guess what? Nobody noticed. (And old powertop would still break).
> 
> BPF taps into most tracepoints that change all the time. I'm cleaning
> up unused tracepoints which included a couple that were left around to
> "not break old BPF programs". I replied, if an old BPF program relies on
> that tracepoint, keeping it around (but not used) is *worse* than
> having that BPF program break. That's because that BPF program is
> still broken (it's expecting that unused tracepoint to fire) but now
> it's getting garbage for output (that being no output!). It's worse
> because it's "silently failing" and the user may be relying on
> something they don't know is broken.
> 
> So yeah, change the tracepoint when the code its tracing changes. That
> way any tooling depending on it, knows that it can no longer depend on
> it.
> 
> Anything using tracepoints are pretty much tied to the kernel anyway,
> and when the kernel updates, the tooling that is relying on it also
> needs to be updated otherwise it's not getting the information it is
> expecting. That most definitely includes monitors.

Alright, thanks for sharing. That was an interesting discussion you had
back then.

Let me keep an eye out for any user tools based on RV, making sure they use
our API properly.

Best regards,
Nam
