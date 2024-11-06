Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B911925B7;
	Wed,  6 Nov 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932221; cv=none; b=XECItFzVbpaC0hyTIkWI2ausdr2oES4zFxyTvfT0L39/Q0UY6nvwKN4utaA7B1AFLsrAZ+kDNkDJ+ruVoJ9AdE7GgneIijOkL/IrgXHFZhbI6L17p9CPQnkiBtOklDtHg0uvetwZhZ+QJuLFtE7vlaimwC9XYRXzcxc5D9Ecnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932221; c=relaxed/simple;
	bh=Dr9iONoy6m9CSWCI8Z4YSKmqzeS9S2/hoP45JK+tQ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQV3PYGw2OCVap4dW/cTjNlLzFQg2VLmanpczcGFrbRdYxflfd+SDrUv7hBwObyl4QWTh/Mjv+A9DEAh8mtFr+8z8TFrIlF8yjMVCe0FTdC2qfHkaJtotC90GK+YOKyfvZRgC5dfA4h9/Y0zjoi1IIzt27YdxRjF5FUZUsgDnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F8DC4CEC6;
	Wed,  6 Nov 2024 22:30:19 +0000 (UTC)
Date: Wed, 6 Nov 2024 17:30:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Dmitry
 Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
Message-ID: <20241106173023.09322117@gandalf.local.home>
In-Reply-To: <CANpmjNMMvZPWJG0rOe=azUqbLbo8aGNVZBre=01zUyST40pYxw@mail.gmail.com>
References: <20241105133610.1937089-1-elver@google.com>
	<20241105113111.76c46806@gandalf.local.home>
	<CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com>
	<20241105120247.596a0dc9@gandalf.local.home>
	<CANpmjNNTcrk7KtsQAdGVPmcOkiy446VmD-Y=YqxoUx+twTiOwA@mail.gmail.com>
	<CANpmjNP+CFijZ-nhwSR_sdxNDTjfRfyQ5c5wLE=fqN=nhL8FEA@mail.gmail.com>
	<20241106101823.4a5d556d@gandalf.local.home>
	<20241106102856.00ad694e@gandalf.local.home>
	<ZyuxmsK0jfKa7NKK@elver.google.com>
	<20241106162342.3c44a8e9@gandalf.local.home>
	<CANpmjNMMvZPWJG0rOe=azUqbLbo8aGNVZBre=01zUyST40pYxw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 22:59:25 +0100
Marco Elver <elver@google.com> wrote:

> On Wed, 6 Nov 2024 at 22:23, Steven Rostedt <rostedt@goodmis.org> wrote:
> ...
> > > That's pretty much it. I've attached my kernel config just in case I
> > > missed something.  
> >
> > OK, it's because you are using trace_pipe (which by the way should not be
> > used for anything serious). The read of trace_pipe flushes the buffer
> > before the task is scheduled out and the comm saved, so it prints the
> > "<...>". If you instead do the cat of trace_pipe *after* running the
> > command, you'll see the comm.
> >
> > So this is just because you are using the obsolete trace_pipe.  
> 
> I see, thanks for clarifying.  I always felt for quick testing it
> serves its purpose - anything equally simple you recommend for testing
> but doesn't suffer from this problem?

You can run trace-cmd, or cat trace after the run.

-- Steve
