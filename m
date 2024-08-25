Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E74A05
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724630223; cv=none; b=f+xpWwqYj7kRyrNEIeQcuKkgJxPHkBv8jT4wjpMxG9A9W6mb8HdpmKnUHW+yIHMI6u8SCFcv0Y4d1VpBn3bZTV8f0GvrI1aqhPi4VYOGfQC+7ATKfg0l6sOOd+QoUZZN3Xo/4RYXe9suyKO7q2OF5SykT26OrgazW0h18s2oxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724630223; c=relaxed/simple;
	bh=hvYokzFMe5UePsZ/nPOmknU2+X/+l6fJD+GOtsiVj/o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mo9Z3AkpN3yfwEwjfPApilBR49mBINxuClIHqF+SDMmOud0Ab7h0GHU3tnhb+qMNZO+QKbZs2KKUNKkH1z5i0hbyz3mbd1DnvtUfxZtFmDkznXkSwbJuis9/E27MdWak5YI31U8j/NF/gz5PmrPYr+cFixm02OySL8JgdcfvTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crdHDiAy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crdHDiAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D07C4AF09;
	Sun, 25 Aug 2024 23:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724630222;
	bh=hvYokzFMe5UePsZ/nPOmknU2+X/+l6fJD+GOtsiVj/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=crdHDiAyhvle7PKuFj5mB/HhXqqjmw5KQw2p7CggMXfFroLuw/A1zTvv2c4MEkBcn
	 B0Ckrn//CijqwLmZLeUUUE8VH/8FxtwZGjvs9RkRrlSAWtQy8as93gJm0YUqjg7pFX
	 BmQ8E7TYQYiZZqxA5Q+/9Zhg5m48jE/h2dD0lNprWvild7Cnb+VA4b9+r7tOpujn7B
	 DSQDyGuYpkzSlTRkG62pmI3mRy8/oAVV68MswQ4Nu/qkImlbVyPv2banIYTxTCH+qK
	 370/gJYT2DO3oIa39SGnh4JwP+fuBdXB/LotfWaHnm2kDWDuqmWhbrk3WVSXMQYNC3
	 ylcsk5cnJU1kA==
Date: Mon, 26 Aug 2024 08:56:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Fernando F. Mancera" <ffmancera@riseup.net>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: fix traceprobe out-of-bounds argument
 allocation
Message-Id: <20240826085659.939bde641e4bf13249dec6ec@kernel.org>
In-Reply-To: <fc31cca4-bec6-461c-9843-b4121ac1ba20@riseup.net>
References: <20240813172546.3151-1-ffmancera@riseup.net>
	<20240825164132.024faee7897e0ac126d8c58e@kernel.org>
	<fc31cca4-bec6-461c-9843-b4121ac1ba20@riseup.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Aug 2024 19:06:22 +0200
"Fernando F. Mancera" <ffmancera@riseup.net> wrote:

> Hi,
> 
> On 25/08/2024 09:41, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > On Tue, 13 Aug 2024 13:25:40 -0400
> > Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> > 
> >> When initializing trace_probes::nr_args, make sure the maximum number of
> >> probe arguments is honored. Oherwise, we can hit a NULL pointer
> >> dereferences in multiple situations like on traceprobe_set_print_fmt().
> >>
> >> Link: https://bugzilla.redhat.com/2303876
> > 
> > Sorry for replying later. I'm not sure why but I did not found this in my mbox...
> > 
> 
> No worries!
> 
> > Anyway, trace_probe_init() should return -E2BIG in this case because
> > it is actuall wrong value.
> > 
> > Can you update your patch?
> > 
> 
> I agree this is the right solution but it would mean a change in 
> behavior. Is that fine? Before merging 035ba76014c0, it was writing up 
> to the maximum number of arguments and ignoring the rest. If you confirm 
> it is fine to change the behavior, I will update the patch.

Yes, I think this is the better behavior for users too, rather than
silently droping some arguments.
We also need to handle this error code in callsite and log an error,
and add a testcase in the syntax error testcase. But that should be done
in another series. We should fix this first.

Thank you,


> 
> Thank you!
> 
> > Thank you,
> > 
> > 
> >>
> >> Fixes: 035ba76014c0 ("tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init")
> >> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> >> ---
> >>   kernel/trace/trace_probe.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> >> index 39877c80d6cb..f577b5e71026 100644
> >> --- a/kernel/trace/trace_probe.c
> >> +++ b/kernel/trace/trace_probe.c
> >> @@ -2043,10 +2043,14 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
> >>   		goto error;
> >>   	}
> >>   
> >> -	tp->nr_args = nargs;
> >> +	if (nargs > MAX_TRACE_ARGS)
> >> +		tp->nr_args = MAX_TRACE_ARGS;
> >> +	else
> >> +		tp->nr_args = nargs;
> >> +
> >>   	/* Make sure pointers in args[] are NULL */
> >>   	if (nargs)
> >> -		memset(tp->args, 0, sizeof(tp->args[0]) * nargs);
> >> +		memset(tp->args, 0, sizeof(tp->args[0]) * tp->nr_args);
> >>   
> >>   	return 0;
> >>   
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
