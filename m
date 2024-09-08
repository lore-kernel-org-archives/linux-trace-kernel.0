Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B71D272;
	Sun,  8 Sep 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725802253; cv=none; b=W6Gw18aVQDyHaXUnp03jsdW4hPobN6p6mVshYZ9hWyGUtCluyaRjBRds3vzLO3OZO8dXeoDmOuGr8K2fhocDKLFqJWkScAVOJiFQZDPI5U0yem3AgIxzoqj9nb7OjRM7C5BlVXB4jhrZAIwMQctlsL8GY31kGBjGv7Y+ovAxTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725802253; c=relaxed/simple;
	bh=06b1TC/iLGnM4QRdcpRyvjIokKNse0VVHgIaEOzq4Js=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FnUo6puW+OuyUCHLf7L5bEFaLsWaNLBKvIj40Od08Ui4GP4Ht6o3NLdm5KEKGPVAx+oeqUix9pLdvqEPR80Mw/v4zKq3IDGRgVfa4yCoM/PmYyVkszzrgIMYireePdErjH+BCrUh0s/AGrevmuIxvPeWH3DuJmPMYW6k5sK2Yiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5G8XIoT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5G8XIoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0048BC4CEC3;
	Sun,  8 Sep 2024 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725802253;
	bh=06b1TC/iLGnM4QRdcpRyvjIokKNse0VVHgIaEOzq4Js=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W5G8XIoTOtTWPGz1v+dtfcSAsGh7cWtpw2+1Yqfd3SigwbgK9P+ML7pYhPZV2t/LA
	 9h3H+xFmAgRCX2MYNG8aqckkW19hQcrF9RmHNl+Ep4j5UUjVGN529XB2QfYBgYoF91
	 I6klpbOcRp4o2sZc9IioQSCvlR1br0iubIXCEk7RmTBw+QnpR14JQRsBaJAxPBEKNv
	 V+KuQFyyAl73e9nkuOm/46ZHNnhN+44gYjKe92WdqbE0gvUlqcZ6ltrAvqlEI5Komw
	 yd2d2iXDD2ATKlFO+GnWYcR9wcOBZ3NbjWPYhx34R/EqqslgMWRz5zCaSqiKfSx3FE
	 4MMMWfPtYsd8g==
Date: Sun, 8 Sep 2024 22:30:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] tracing: add config option for print arguments in
 ftrace
Message-Id: <20240908223048.8bd6961dbc741d971f57b5c2@kernel.org>
In-Reply-To: <69b78634-3295-c22e-c09c-e41aa4554df3@huaweicloud.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240904065908.1009086-6-svens@linux.ibm.com>
	<69b78634-3295-c22e-c09c-e41aa4554df3@huaweicloud.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 11:36:11 +0800
Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

> On 2024/9/4 14:58, Sven Schnelle wrote:
> > Add a config option to disable/enable function argument
> > printing support during runtime.
> > 
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> > ---
> >   kernel/trace/Kconfig | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 721c3b221048..8b9b6cdf39ac 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -242,6 +242,18 @@ config FUNCTION_GRAPH_RETVAL
> >   	  enable it via the trace option funcgraph-retval.
> >   	  See Documentation/trace/ftrace.rst
> >   
> > +config FUNCTION_TRACE_ARGS
> > +	bool "Kernel Function Tracer Arguments"
> > +	depends on HAVE_FUNCTION_ARG_ACCESS_API
> > +	depends on DEBUG_INFO_BTF && BPF_SYSCALL
> 
> Nice feature!
> 
> Just a nit, DEBUG_INFO_BTF currently depends on BPF_SYSCALL,
> so BPF_SYSCALL may not be necessary here. This feature
> also doesn't seem to depend on bpf.

Indeed. Sven, you can check the PROBE_EVENTS_BTF_ARGS as
an example.

config PROBE_EVENTS_BTF_ARGS
        depends on HAVE_FUNCTION_ARG_ACCESS_API
        depends on FPROBE_EVENTS || KPROBE_EVENTS
        depends on DEBUG_INFO_BTF && BPF_SYSCALL
        bool "Support BTF function arguments for probe events"

Thank you,

> 
> > +	default n
> > +	help
> > +	  Support recording and printing of function arguments when using
> > +	  the function tracer or function graph tracer. This feature is off
> > +	  by default, and can be enabled via the trace option func-args (for
> > +	  the function tracer) and funcgraph-args (for the function graph
> > +	  tracer).
> > +
> >   config DYNAMIC_FTRACE
> >   	bool "enable/disable function tracing dynamically"
> >   	depends on FUNCTION_TRACER
> 
> -- 
> Thanks,
> Zheng Yejian
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
