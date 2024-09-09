Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B561BB6BE;
	Mon,  9 Sep 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890179; cv=none; b=jPBQEMzL3OxJD1DYU5byqjjLat8doVgeKnXXhVLrvVSdnRo8joon7q/oRhstQBTiQadj3mRX8yUhqyHV6LN16gQ7mCduyuhGjGVtCkw1Neaplvn6qLYlnw/2oHH0yRZhDWWVvDTcincdn929P3jJv5ZJXowkMYUJIiHlUJniaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890179; c=relaxed/simple;
	bh=ziCNmukqSoa9NT917TReyruuvMtETI5Xgy5zWsDcB/o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G+YcrGQQmmDuD88l2bNnvTomAW3QIe9QESOMCSMD60AZf6u4QPxG3jCCMuoH76BY4i54mp/8fOMU9iDS07Cf0mUUETsQdmQ0TJy79PGZHFIwati/lSCPi21hZJj1nmJXEvBlOplK9bkO55SbncppnJ30AOFawdShC4VPivzr8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+8areK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+8areK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AEEC4CEC5;
	Mon,  9 Sep 2024 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725890178;
	bh=ziCNmukqSoa9NT917TReyruuvMtETI5Xgy5zWsDcB/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T+8areK0Mx0oT7YCzbvUb849ygLqRMa624fTVjsD1OBpI9HgfkOEKNDjmRC8XVTMX
	 xsEto2R9oBzNulxYD2t2Mq5gtqy7dven94GQJTW+7o+7JcaS0FCXUH1c/tnrCCgYoy
	 2Xsd5XUwwFvQR1flLKZGBnQSbFHe2w0chsEvmrICU73W4TVJMIXm/mYafwEKe54H6k
	 z3Nl0tvAFYvOmPgnfJcxF2tuk9lPDqupRj2Lk7WRzocwOvYJmrpcTC2GBC1oFk8gC+
	 8i1Urcje+93yzV007O16IOZcjSN09MvU4oeAEcNT/GdAaUD/redY0jr3Vvk32eBuaP
	 69T07pFDbEiOg==
Date: Mon, 9 Sep 2024 22:56:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Zheng Yejian <zhengyejian@huaweicloud.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] tracing: add config option for print arguments in
 ftrace
Message-Id: <20240909225614.4f6d022e58f1276113c8492b@kernel.org>
In-Reply-To: <yt9dcylddyx4.fsf@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240904065908.1009086-6-svens@linux.ibm.com>
	<69b78634-3295-c22e-c09c-e41aa4554df3@huaweicloud.com>
	<20240908223048.8bd6961dbc741d971f57b5c2@kernel.org>
	<yt9dcylddyx4.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Sep 2024 10:16:55 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
> 
> > On Fri, 6 Sep 2024 11:36:11 +0800
> > Zheng Yejian <zhengyejian@huaweicloud.com> wrote:
> >
> >> On 2024/9/4 14:58, Sven Schnelle wrote:
> >> > Add a config option to disable/enable function argument
> >> > printing support during runtime.
> >> > 
> >> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >> > ---
> >> >   kernel/trace/Kconfig | 12 ++++++++++++
> >> >   1 file changed, 12 insertions(+)
> >> > 
> >> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> >> > index 721c3b221048..8b9b6cdf39ac 100644
> >> > --- a/kernel/trace/Kconfig
> >> > +++ b/kernel/trace/Kconfig
> >> > @@ -242,6 +242,18 @@ config FUNCTION_GRAPH_RETVAL
> >> >   	  enable it via the trace option funcgraph-retval.
> >> >   	  See Documentation/trace/ftrace.rst
> >> >   
> >> > +config FUNCTION_TRACE_ARGS
> >> > +	bool "Kernel Function Tracer Arguments"
> >> > +	depends on HAVE_FUNCTION_ARG_ACCESS_API
> >> > +	depends on DEBUG_INFO_BTF && BPF_SYSCALL
> >> 
> >> Nice feature!
> >> 
> >> Just a nit, DEBUG_INFO_BTF currently depends on BPF_SYSCALL,
> >> so BPF_SYSCALL may not be necessary here. This feature
> >> also doesn't seem to depend on bpf.
> >
> > Indeed. Sven, you can check the PROBE_EVENTS_BTF_ARGS as
> > an example.
> >
> > config PROBE_EVENTS_BTF_ARGS
> >         depends on HAVE_FUNCTION_ARG_ACCESS_API
> >         depends on FPROBE_EVENTS || KPROBE_EVENTS
> >         depends on DEBUG_INFO_BTF && BPF_SYSCALL
> >         bool "Support BTF function arguments for probe events"
> 
> Now i'm confused - Zheng wrote that DEBUG_INFO_BTF depends on
> BPF_SYSCALL. I just verified that. So i could just remove BPF_SYSCALL
> from the dependencies - but your example also has BPF_SYSCALL listed.

Ah, sorry for confusion. In this case, just need DEBUG_INFO_BTF.
Hmm, I think I also need to remove BPF_SYSCALL.

Thanks,

> 
> Regards
> Sven


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
