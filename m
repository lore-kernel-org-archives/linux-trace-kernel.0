Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536851D79A6;
	Wed,  6 Nov 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928220; cv=none; b=dnEHMXe6oo1UeO+lBXz2WKfMZbMKrg6/ztASR/1jjEGG3F/yKtFTr5yp8XZvh5HO08Lfa03TUnYa/lfu5dRZoxFlgr5durbte0ldtif6SCdIkUz+qaeCTD0zaYKydfEARy1lQvCvxs/Yv8tUqpPHfPhc4ak2aRw7rOTKFO4ZO7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928220; c=relaxed/simple;
	bh=jNB9GSoj9ccitn/QDVyGDHTPdAXyp8BshEdqrD2sK+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcV8cVi7aKwFN4UXGGNbYrufGrkM0/HnfXAqJLie2nYzhvbfHdS5C5LNJFHB9VZmdjGLzGMPVO643VeXM8paRZpP05AJBwQUmrjtXyJK5VJKdvxi1SPwNuwApZCaOELNYbXyMKHfuSInmQfrUgDTFXQem8Py0kA+zCthgBDalPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5192C4CEC6;
	Wed,  6 Nov 2024 21:23:38 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:23:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Dmitry
 Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
Message-ID: <20241106162342.3c44a8e9@gandalf.local.home>
In-Reply-To: <ZyuxmsK0jfKa7NKK@elver.google.com>
References: <20241105133610.1937089-1-elver@google.com>
	<20241105113111.76c46806@gandalf.local.home>
	<CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com>
	<20241105120247.596a0dc9@gandalf.local.home>
	<CANpmjNNTcrk7KtsQAdGVPmcOkiy446VmD-Y=YqxoUx+twTiOwA@mail.gmail.com>
	<CANpmjNP+CFijZ-nhwSR_sdxNDTjfRfyQ5c5wLE=fqN=nhL8FEA@mail.gmail.com>
	<20241106101823.4a5d556d@gandalf.local.home>
	<20241106102856.00ad694e@gandalf.local.home>
	<ZyuxmsK0jfKa7NKK@elver.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 19:12:42 +0100
Marco Elver <elver@google.com> wrote:

> No other events should be traced. This is the test program I've used:
> 
> 	#include <sys/prctl.h>
> 	#include <unistd.h>
> 
> 	int main(int argc, char *argv[])
> 	{
> 	  prctl(1234, 101, 102, 103, 104);
> 	  if (argc > 1)
> 	    usleep(1000);
> 	  return 0;
> 	}
> 
> Kernel config is x86_64 default + CONFIG_FUNCTION_TRACER=y +
> CONFIG_FTRACE_SYSCALLS=y. For the test, once booted all I do is:
> 
> 	% echo 1 > /sys/kernel/debug/tracing/events/task/task_prctl_unknown/enable
> 	% cat /sys/kernel/debug/tracing/trace_pipe
> 	... wait for output ...
> 
> That's pretty much it. I've attached my kernel config just in case I
> missed something.

OK, it's because you are using trace_pipe (which by the way should not be
used for anything serious). The read of trace_pipe flushes the buffer
before the task is scheduled out and the comm saved, so it prints the
"<...>". If you instead do the cat of trace_pipe *after* running the
command, you'll see the comm.

So this is just because you are using the obsolete trace_pipe.

-- Steve
