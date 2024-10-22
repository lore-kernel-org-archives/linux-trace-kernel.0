Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5911E529
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575647; cv=none; b=AgEyFfJWkba4qz/uvFn9Xfspe/MbIgFEHmdU8VAylfHrJ6kbpde7HIU+oRZQGRfvZo02rqHHPytJbbQF2XxtGhOqEylL8exLBLdwb/7brAv+TPBGdWFlbbPwQfkMd+vC579KlYpFA1uvsAntS/L4aJ84vjO1pgNli78IChAuGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575647; c=relaxed/simple;
	bh=Mb7JhqCvq9zWyWaH2IMdYtj2uPTjgXsNZM+/E7mA9gk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CqxLCP28P3iOzkmBS0yIEvdzEE64SdJxQZRYE+mmeRMkw6hioQ2SVKKBJXnjn9+Edfyfnr0NoO1Nvs0BNuywXShFdhbgfVbl3Yulrb4Frd5i768pNwuPx1zyjppVDOVaKPFJ4JyJOoUZJO1CGD2vKtCmDd5JOa1XvkmE6UvkiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFUK+6wM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFUK+6wM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6625C4CEC3;
	Tue, 22 Oct 2024 05:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575647;
	bh=Mb7JhqCvq9zWyWaH2IMdYtj2uPTjgXsNZM+/E7mA9gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tFUK+6wMzPudd5dacyBElrz590pkEPY/5UGOnqSMe6TyQM9ldAknJFZ0okT38ZDHm
	 UMLI1bINWts4bJCKDKHwI11KGBgGOZP+nOoaaAv+CRmzIzqv4PfE0it/1hPrzPwEvZ
	 GETbsvFpH0VpkNoVToLLQuMvV7q30vqOvIN8fhUgHADjqRBpEiqyvMuwQiMn4VzSeF
	 u++mxLbvr7gzHsgg+lCSMH8QpaRp558Cr5WRSWv4DwnO4ja/fmXTi2EmxxMXBd+/Z1
	 hotHQycKulnlLY2FJksV1S5KUkxV/vw15+Ws/DvjcoVBWbNNf5I0WmjiYo4LOMX504
	 tFhwHBxzGJSuQ==
Date: Tue, 22 Oct 2024 14:40:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Fernando F. Mancera" <ffmancera@riseup.net>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: fix traceprobe out-of-bounds argument
 allocation
Message-Id: <20241022144045.429a1a8a3f55e9df43d9a869@kernel.org>
In-Reply-To: <88bc4212-8bca-45ff-9078-d0f7b9e6a64b@riseup.net>
References: <20240813172546.3151-1-ffmancera@riseup.net>
	<20240825164132.024faee7897e0ac126d8c58e@kernel.org>
	<fc31cca4-bec6-461c-9843-b4121ac1ba20@riseup.net>
	<20240826085659.939bde641e4bf13249dec6ec@kernel.org>
	<88bc4212-8bca-45ff-9078-d0f7b9e6a64b@riseup.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 5 Sep 2024 00:19:16 +0200
"Fernando F. Mancera" <ffmancera@riseup.net> wrote:

> Hi,
> 
> On 26/08/2024 01:56, Masami Hiramatsu (Google) wrote:
> > On Sun, 25 Aug 2024 19:06:22 +0200
> > "Fernando F. Mancera" <ffmancera@riseup.net> wrote:
> > 
> >> Hi,
> >>
> >> On 25/08/2024 09:41, Masami Hiramatsu (Google) wrote:
> >>> Hi,
> >>>
> >>> On Tue, 13 Aug 2024 13:25:40 -0400
> >>> Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> >>>
> >>>> When initializing trace_probes::nr_args, make sure the maximum number of
> >>>> probe arguments is honored. Oherwise, we can hit a NULL pointer
> >>>> dereferences in multiple situations like on traceprobe_set_print_fmt().
> >>>>
> >>>> Link: https://bugzilla.redhat.com/2303876
> >>>
> >>> Sorry for replying later. I'm not sure why but I did not found this in my mbox...
> >>>
> >>
> >> No worries!
> >>
> >>> Anyway, trace_probe_init() should return -E2BIG in this case because
> >>> it is actuall wrong value.
> >>>
> >>> Can you update your patch?
> >>>
> >>
> >> I agree this is the right solution but it would mean a change in
> >> behavior. Is that fine? Before merging 035ba76014c0, it was writing up
> >> to the maximum number of arguments and ignoring the rest. If you confirm
> >> it is fine to change the behavior, I will update the patch.
> > 
> > Yes, I think this is the better behavior for users too, rather than
> > silently droping some arguments.
> > We also need to handle this error code in callsite and log an error,
> > and add a testcase in the syntax error testcase. But that should be done
> > in another series. We should fix this first.
> > 
> 
> Just in case this fell through the cracks, I've sent a V2 patch. In 
> addition I also have a series ready for the logging and syntax error 
> testcase in kselftest but I didn't send it because it requires this 
> patch to be applied.

I think that v2 was lost in my mailbox, but I found that in patchwork.
Let me pick it.

Thanks, 

> 
> Thank you,
> Fernando.
> 
> > Thank you,
> > 
> > 
> >>
> >> Thank you!
> >>
> >>> Thank you,
> >>>
> >>>
> >>>>
> >>>> Fixes: 035ba76014c0 ("tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init")
> >>>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> >>>> ---
> >>>>    kernel/trace/trace_probe.c | 8 ++++++--
> >>>>    1 file changed, 6 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> >>>> index 39877c80d6cb..f577b5e71026 100644
> >>>> --- a/kernel/trace/trace_probe.c
> >>>> +++ b/kernel/trace/trace_probe.c
> >>>> @@ -2043,10 +2043,14 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
> >>>>    		goto error;
> >>>>    	}
> >>>>    
> >>>> -	tp->nr_args = nargs;
> >>>> +	if (nargs > MAX_TRACE_ARGS)
> >>>> +		tp->nr_args = MAX_TRACE_ARGS;
> >>>> +	else
> >>>> +		tp->nr_args = nargs;
> >>>> +
> >>>>    	/* Make sure pointers in args[] are NULL */
> >>>>    	if (nargs)
> >>>> -		memset(tp->args, 0, sizeof(tp->args[0]) * nargs);
> >>>> +		memset(tp->args, 0, sizeof(tp->args[0]) * tp->nr_args);
> >>>>    
> >>>>    	return 0;
> >>>>    
> >>>
> >>>
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
