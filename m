Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1561371
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7mBYws+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B8CC433C7;
	Tue,  7 Nov 2023 00:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699317649;
	bh=/XpXG2F9SG0xMGW2+ycU4gMGALDI8qHOnUTmJhAQsMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l7mBYws+qxsXIfiDgkvJ5xM0GQzcjV/nG6yf/ADJQKUao/Eb95s7lgZdXqLSx7vZF
	 8nnEaUKorFqpRDSX+UESXJg4hIukMQ4v00BY2WJF8QxBu808SgRNy9aYBy4J7Y5Gjv
	 MQLpZyH0yt+K3zpC6C9kftGNFxnSdtQ0ZXpmTiPXKQeWc7NRKkhyEYdfx76eCQfb2H
	 KSFbby5umpgOEJQXeM55ejgxbeTVADc96aF8OVCgqCJyzhtuTvQzm3FmsOTzOH9PvY
	 l+QqnuclLT9V2g9Oe5O/dfcBfFvx/GWf68+Le+E1D707cPCDdqPoPVsHcWfbRArns7
	 yHtW2+SC+DbiQ==
Date: Tue, 7 Nov 2023 09:40:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe-event: Fix to check tracepoint event
 and return
Message-Id: <20231107094045.db1d982c42712b8f26891ec6@kernel.org>
In-Reply-To: <20231106172811.25066d33@gandalf.local.home>
References: <169902753361.313086.6662802092416198593.stgit@devnote2>
	<20231106172811.25066d33@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Nov 2023 17:28:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat,  4 Nov 2023 01:05:34 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Fix to check the tracepoint event is not valid with $retval.
> > The commit 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is
> > a return event by $retval") introduced automatic return probe
> > conversion with $retval. But since tracepoint event does not
> > support return probe, $retval is not acceptable.
> 
> Can you add the command that causes this to fail.

Actually this doesn't command fail but it expected to fail.

$ echo "t kfree $retval" >> dynamic_events

This should be rejected because 't' (tracepoint) should not be
a return probe. Without this fix, this is accepted.
(But it traces a random return value because the tracepoint function
will return 'void'.)

Thank you,

> 
> -- Steve
> 
> > 
> > Fixes: 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is a return event by $retval")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_fprobe.c |    9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > index 8bfe23af9c73..7d2ddbcfa377 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -927,11 +927,12 @@ static int parse_symbol_and_return(int argc, const char *argv[],
> >  	for (i = 2; i < argc; i++) {
> >  		tmp = strstr(argv[i], "$retval");
> >  		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
> > +			if (is_tracepoint) {
> > +				trace_probe_log_set_index(i);
> > +				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
> > +				return -EINVAL;
> > +			}
> >  			*is_return = true;
> > -			/*
> > -			 * NOTE: Don't check is_tracepoint here, because it will
> > -			 * be checked when the argument is parsed.
> > -			 */
> >  			break;
> >  		}
> >  	}
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
