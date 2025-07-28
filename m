Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E63248F4B;
	Mon, 28 Jul 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712312; cv=none; b=tBqPOsTY6uuIC6Xv1kAzsB35VYwEQeh2X8PkDCXzPn/7iNNqF8GGmf1DMKpY+KxCS7rvvMcTeRSa5smPnW7x+H1+FD9OcOeSVrScuiToM8A6LJFCtO/YXXtaTsrUT1VeXDpYT7ZBJ0CfrI0ihzIU5I92sG4OWi9zPqj4k51aFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712312; c=relaxed/simple;
	bh=ryovv6Yed9UbejW+3E0eLeMGIJ35qqrNA5wEFN5jXXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBXMaQpR18qmYqIXcWWykEVkAM6OxFaEm7y77VLnC+gG+1mew0zafhaEJPScBGqveMs/8RF+U9jNI2Fz9ZWfiimUFQIouQtv8YA3PvAtOJK9GkXLMIFGtpyEZyr6Syl471zCcGvqLVyFaSyumIYQeEOX6ZwH4B59Vu3C2gP7dJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w4FC25YE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6rOJRZBJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w4FC25YE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6rOJRZBJ"
Date: Mon, 28 Jul 2025 16:18:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753712309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ojfq/l+Y6sJ0dydzcKjQ7bgvQeTepM46LPXKEA0zZgs=;
	b=w4FC25YEJZ/zBlZ4rzk1llHucrC6ptN2moSli3C3B9ppGseAVOuVKVtICb3UYSu9z55hjd
	UlfQCKQxvV+ZT3jEcSMEqAjWoIUU3xXPmeja5jZXs7nQ0OAmKJQjNDtv0dUVzl/Vl+mgma
	iJK49KA62BWKwQNB3r2XUVbMwCxszYPWNzL2PSIxVzJzFhEBbp2SZgkUtKnK6KXSIyVwuK
	6Srg2uouQkbRCno8McoKk/tkyt5iXFL8p8ec2n7dkSaU64AM37qM+bndnO3U8u5fR1HC3s
	CUJiZ4twCHAszMr05BH5d5GfDROPYIppeywDCbcbrRSQl5atWrUKY7JbYPky2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753712309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ojfq/l+Y6sJ0dydzcKjQ7bgvQeTepM46LPXKEA0zZgs=;
	b=6rOJRZBJTGAnEcNaCTQutU0n66iJamovuIXtDsKjXgtjTcafNIwkd5A9Ao0wKM3X7I7SJQ
	TJLPfwSfmqgiOOAw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 5/9] rv: Retry when da monitor detects race conditions
Message-ID: <20250728141828.5hnoS6n1@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-6-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135022.255578-6-gmonaco@redhat.com>

On Mon, Jul 28, 2025 at 03:50:17PM +0200, Gabriele Monaco wrote:
> DA monitor can be accessed from multiple cores simultaneously, this is
> likely, for instance when dealing with per-task monitors reacting on
> events that do not always occur on the CPU where the task is running.
> This can cause race conditions where two events change the next state
> and we see inconsistent values. E.g.:
> 
>   [62] event_srs: 27: sleepable x sched_wakeup -> running (final)
>   [63] event_srs: 27: sleepable x sched_set_state_sleepable -> sleepable
>   [63] error_srs: 27: event sched_switch_suspend not expected in the state running
> 
> In this case the monitor fails because the event on CPU 62 wins against
> the one on CPU 63, although the correct state should have been
> sleepable, since the task get suspended.
> 
> Detect if the current state was modified by using try_cmpxchg while
> storing the next value. If it was, try again reading the current state.
> After a maximum number of failed retries, react by calling a special
> tracepoint, print on the console and reset the monitor.
> 
> Remove the functions da_monitor_curr_state() and da_monitor_set_state()
> as they only hide the underlying implementation in this case.
> 
> Monitors where this type of condition can occur must be able to account
> for racing events in any possible order, as we cannot know the winner.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
