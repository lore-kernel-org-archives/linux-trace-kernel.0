Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAAD1553B5;
	Tue, 11 Jun 2024 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147469; cv=none; b=WMzZ/qS/aFhH7oz6EY7sI8v1HbBiAwCDzWrqavEqFqnr4GxRLYVYqIOZwRoTfoMPXbL83LT4ybzdGDMpsOzqzZWtAJeZptqUnoi5wmS9lLisYQ9/jE3fIKQzBB/LXEAtCg1DilsbPPS4rzR5jlx7cDg6PXtekqPWvd17P94ip4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147469; c=relaxed/simple;
	bh=xvhHnmrvk2xymlEu8vY7mr2+y/6ekkGuhOrg4CBKlP8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E9nIV04L8WELH2Mt+0Hrkx3x5vXRqVLlrUx6h3VnZTbCfea0OepLd5AG/hRfYwoi0MfUgTLVfPQRmg4r2txTZMlUpbAUSAF1e5YGjrZJVooVw7Hh1H29bIt5lM6ahZUXGe1hBrkCzw7lKfzulxeRjBIzlTqOK0PR/Jq35eAUoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTAkRYBv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTAkRYBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3C7C2BD10;
	Tue, 11 Jun 2024 23:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718147468;
	bh=xvhHnmrvk2xymlEu8vY7mr2+y/6ekkGuhOrg4CBKlP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XTAkRYBvY4usQZ1W9lbEwH6Oq1EacduyFVbTLlRq8gqTA/md7WwGZYBNd7dXLg3xF
	 CoK1FlGCIPAeBgbwvECqh/2dp76E8lXcsA/m7uiDW5eMiGZDkHdZ9eA8eulfDr8Ptw
	 Zoy3iqRjnUj7XcgKwwSneerdLxhRvFO1dk7Sh9k3tkw59G4UKZPtu4lBxW0Py9Qx0M
	 0NksLUFEMjApmnhlI7DTfzci6KDSJwNFGLa7/yQP6myWaKzBS/jzrYB7vwPcS+uPeQ
	 Qh2B3DqbwgmQymY5V5zxJ0pLk1PDM7m1wTpjIeXdHQKbO7xR1+oxa0erpUHulgcK6u
	 apYQlUa3sQ1MQ==
Date: Wed, 12 Jun 2024 08:11:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3 3/3] tracing/kprobe: Remove cleanup code unrelated to
 selftest
Message-Id: <20240612081105.7fa1280d38e57d2fb0905e80@kernel.org>
In-Reply-To: <20240611102500.27493dd2@gandalf.local.home>
References: <171811262833.85078.12421348187962271050.stgit@devnote2>
	<171811265627.85078.16897867213512435822.stgit@devnote2>
	<20240611102500.27493dd2@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 10:25:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 11 Jun 2024 22:30:56 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > This cleanup all kprobe events code is not related to the selftest
> > itself, and it can fail by the reason unrelated to this test.
> > If the test is successful, the generated events are cleaned up.
> > And if not, we cannot guarantee that the kprobe events will work
> > correctly. So, anyway, there is no need to clean it up.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks for review!

> 
> -- Steve
> 
> > ---
> >  kernel/trace/trace_kprobe.c |    4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 8c5816c04bd2..7fd0f8576e4c 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -2114,10 +2114,6 @@ static __init int kprobe_trace_self_tests_init(void)
> >  
> >  
> >  end:
> > -	ret = dyn_events_release_all(&trace_kprobe_ops);
> > -	if (WARN_ONCE(ret, "error on cleaning up probes."))
> > -		warn++;
> > -
> >  	/*
> >  	 * Wait for the optimizer work to finish. Otherwise it might fiddle
> >  	 * with probes in already freed __init text.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
