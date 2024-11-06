Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE71D63D3;
	Wed,  6 Nov 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906934; cv=none; b=BbiVQO4GuuGjWBvY/IlURWwGytxmOdlFDx4PWs0/geD5Wm2wibrv3gx5Ug1YhzHJfDXGtGfocarI3X3Qtuhz4uQL9rmP6UncZq8IyEcgj4iU3wxPT8zseCmWswPVNrAz5xcWst7QnwzXiTtFPxLauamqH1Rri7Nennm15Nkd9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906934; c=relaxed/simple;
	bh=HFkx8A9c/DXmyKVip2S9IgWa1WaXKPYCzOdOTEw+6lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDK3hfebmPpUMov/TZ7EFBcxSZ6sWsjLf2zHMciROIlfjhol0WBNTYICX2CU54cMWgR3uyt+bhjOqdDePsS4v0tq6vRlqrcdynLVxSU8zKLO+YP15LfrjYp7vwkyvK0llfoXmzVdm3qiRCU5q7l7WIXSmdnlqzDNFAQilsip59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFFDC4CECC;
	Wed,  6 Nov 2024 15:28:53 +0000 (UTC)
Date: Wed, 6 Nov 2024 10:28:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Dmitry
 Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
Message-ID: <20241106102856.00ad694e@gandalf.local.home>
In-Reply-To: <20241106101823.4a5d556d@gandalf.local.home>
References: <20241105133610.1937089-1-elver@google.com>
	<20241105113111.76c46806@gandalf.local.home>
	<CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com>
	<20241105120247.596a0dc9@gandalf.local.home>
	<CANpmjNNTcrk7KtsQAdGVPmcOkiy446VmD-Y=YqxoUx+twTiOwA@mail.gmail.com>
	<CANpmjNP+CFijZ-nhwSR_sdxNDTjfRfyQ5c5wLE=fqN=nhL8FEA@mail.gmail.com>
	<20241106101823.4a5d556d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 10:18:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Some trial and error led me to conclude it's a race between the logic
> > looking up the comm and the process exiting: If the test program exits
> > soon after the traced event, it doesn't print the comm. Adding a
> > generous usleep() before it exits reliably prints the comm.  
> 
> Thanks for letting me know. Let me see if I can fix that!

Hmm, that still doesn't make sense. Is this just a single line or do you
have other events being recorded?

The way the caching works is during the sched_switch tracepoint which still
gets called when the task exits. If a trace event is triggered, it sets a
per cpu flags to have the next sched_switch record the comm for both the
previous and next tasks.

Now the reason it can miss is that there's contention on the lock that
saves the comms (it does a trylock and if it fails, it just skips it). Or
if another task hits the same "comm cache line".

This is why I wonder if you have other events being traced.

-- Steve
