Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5218FDC6;
	Wed,  6 Nov 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906301; cv=none; b=Av3FWlCuZda1uppS+KFcvnv42ioZUBAznOohN/g8Wmz5hbxVRWcLDB2o1NU9Le395TI196hfa79s9Tm2RyI1yE0UnBmjz6WYHwvhubpMqhALwmiQ2x1eA6Q5fITRfhbPSfZysuVUlKcN9+RMDgOUt1zx+am7+DtroXmOh+R4Y/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906301; c=relaxed/simple;
	bh=7L2d0VRkBl2EnWFqlaEsHtgo5D8peTVTDkXGrdFcEQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFs6YnQnfOz8INnpM2mgBZQ9tKNmJNdGJI4IAF4ykWo9VcXhOsxjorN4bw0C7qBoWnqvjJweJC4TocBa0fvhBlI65Y1JQ/2bsve2mfjcuOljeEk6GHYVnBU4cMFfgN4b8uUXPZyKBMed+KsYQFkLrXaCaVypIdwRyXNXyQ/X9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAE1C4CEC6;
	Wed,  6 Nov 2024 15:18:20 +0000 (UTC)
Date: Wed, 6 Nov 2024 10:18:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Dmitry
 Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
Message-ID: <20241106101823.4a5d556d@gandalf.local.home>
In-Reply-To: <CANpmjNP+CFijZ-nhwSR_sdxNDTjfRfyQ5c5wLE=fqN=nhL8FEA@mail.gmail.com>
References: <20241105133610.1937089-1-elver@google.com>
	<20241105113111.76c46806@gandalf.local.home>
	<CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com>
	<20241105120247.596a0dc9@gandalf.local.home>
	<CANpmjNNTcrk7KtsQAdGVPmcOkiy446VmD-Y=YqxoUx+twTiOwA@mail.gmail.com>
	<CANpmjNP+CFijZ-nhwSR_sdxNDTjfRfyQ5c5wLE=fqN=nhL8FEA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 10:22:15 +0100
Marco Elver <elver@google.com> wrote:

> On Tue, 5 Nov 2024 at 18:22, Marco Elver <elver@google.com> wrote:
> ...
> > > > > I'm also surprised that the comm didn't show in the trace_pipe.  
> > > >
> > > > Any config options or tweaks needed to get it to show more reliably?
> > > >  
> > > > > I've
> > > > > updated the code so that it should usually find it. But saving it here may
> > > > > not be a big deal.  
> > >
> > > How did you start it? Because it appears reliable for me.  
> >
> > Very normally from bash. Maybe my env is broken in other ways, I'll
> > dig a little.  
> 
> Some trial and error led me to conclude it's a race between the logic
> looking up the comm and the process exiting: If the test program exits
> soon after the traced event, it doesn't print the comm. Adding a
> generous usleep() before it exits reliably prints the comm.

Thanks for letting me know. Let me see if I can fix that!

-- Steve
