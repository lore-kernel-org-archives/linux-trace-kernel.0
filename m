Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D9194C8D;
	Mon, 30 Sep 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710854; cv=none; b=qOyogNFRk13F6c4/kF5OBW6Hh5CZvKu88gzBQhyESqIj+plluYRBB805k0ZGReKC6uH4OAttzxORJr87AsuyM+5ec8pL9hRPCrN3BcqZFqKeUwcBTgnvC7zUYS4lEj6rlbg+26+g2Kx9jdPgiw62SKwmUsRvb92h6tQWAwnhTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710854; c=relaxed/simple;
	bh=yS8q76uDBDEybV0ZgHGPddMVx2CIA0l917rWxvAPHeA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YQSAGN76k7R4vMoMKszjrlsUJ7L/kfnniRJcoNYK3t75ovyFMYWAyhC/ixIKHdjXoRHWm2Dk+VnkNUhKj6o3YN88WtWJPJ+fbDFB7FdsHJc75ErVvRxwWflLmE8uYJIbhdT5FAD0O7UnmYOAfF1YYFpVQegT/Q/kQDT1KJm3odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idXlI+RQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idXlI+RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643F0C4CEC7;
	Mon, 30 Sep 2024 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727710853;
	bh=yS8q76uDBDEybV0ZgHGPddMVx2CIA0l917rWxvAPHeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=idXlI+RQYXaIyxu0iLpu1jiq4kjdYodVoTCqd4Tovm5YfPbk4Wb4Aw4kI8UTv3Kgl
	 3g6MQFCE1dI/isZ/SAgCXvWFQbLIKWEZnA0lLv5bTsclr9gk2gI1LpX//Ix8CWtW8K
	 O46/PKri49d72NL8bocdYE7WZmqu7Cph7MSDQqgjsPMd73XJTxeoUUJby2n3OHHdVZ
	 SM/rukAjF40b7UHySJrQisMXbrP/5k6BkfVl3xmveU+HJ/wYvjJejhVHbZv/9zOoQg
	 tcCz4bcGQG0hrPTniscWEXgE6bvQQiJonTGldMZuGiTFzPBx5AFLW70fb8gVfWX6TY
	 gwHxTXkEc1m/A==
Date: Tue, 1 Oct 2024 00:40:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mikel Rychliski <mikel@mikelr.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: Fix MAX_TRACE_ARGS limit handling
Message-Id: <20241001004050.972e999c644d0e45fd2a94f8@kernel.org>
In-Reply-To: <9997571.eNJFYEL58v@basin>
References: <20240929200939.162524-1-mikel@mikelr.com>
	<20240930084018.a725f6e59a3be7be3e356e27@kernel.org>
	<9997571.eNJFYEL58v@basin>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Sep 2024 23:17:14 -0400
Mikel Rychliski <mikel@mikelr.com> wrote:

> On Sunday, September 29, 2024 7:40:18 P.M. EDT Masami Hiramatsu wrote:
> > Good catch! But this silently drop the arguments after MAX_TRACE_ARGS.
> > I rather like to reject such input with an error (-E2BIG) as below.
> > (Hmm, and I also need a new ftracetest test case for this.)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 39877c80d6cb..3f6654127d8c 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -2194,6 +2194,9 @@ int trace_probe_create(const char *raw_command, int
> > (*createfn)(int, const char if (!argv)
> >                 return -ENOMEM;
> > 
> > +       if (argc > MAX_TRACE_ARGS + 2)
> > +               return -E2BIG;
> > +
> >         if (argc)
> >                 ret = createfn(argc, (const char **)argv);
> 
> I think the logic still needs to be cleaned up in the individual probe 
> implementations (either to count consistently or remove the limit enforcement 
> there), otherwise you can get an oops with something like:
> 
> 	echo "f:testprobe copy_process" arg{1..127}=\$stack "\$arg*" > out
> 	cat out > /sys/kernel/debug/tracing/dynamic_events

Ah, good catch. Yes, the "$arg*" problem is still there.

> 
> BTF argument expansion results in >128 arguments, but we still attempt to 
> process the excess unparsed ones.

OK, can you update your version to return an error from each probe?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
