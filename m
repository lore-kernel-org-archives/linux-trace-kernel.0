Received: from yyz.mikelr.com (yyz.mikelr.com [170.75.163.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EC1A288;
	Mon, 30 Sep 2024 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.75.163.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727666238; cv=none; b=YRP9GPGRCDi66My95WiTMVT4TIOWuMnK5MecIDsOeLxKFIWfx/1jRCW5HeGzr8R7LeFirfzZf9JQwlHrLtHah8luSogrNin/kflLfzCOggkXSKrI3xqdr0ECr8G6uS4J5hYMazqiJw7SpF0lPlcAOW5+0O+ss7jPjo9MkjP69Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727666238; c=relaxed/simple;
	bh=ijKjfhqMhIly6LuC3gIrBHyqN6Pec3WfVZ1m+ada39Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoEkH56qhQ7KFp0a2A+VipmSO1RP2C2Ln1VACbEUOmKuSg+IWT+Vih6EVuU01kqzoo3U4HDwmy+XQ8BIiatutRHfkpCg9KknTC1GbGEMgs+qYbVb/s2dydk8i/rL6H+MJ4QJ2fNPNhWXTYb1dR5DFk2E6twcuQ7QiH/F0v6kO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com; spf=pass smtp.mailfrom=mikelr.com; arc=none smtp.client-ip=170.75.163.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikelr.com
Received: from basin.localnet (unknown [IPv6:2607:f2c0:e554:1200:4b8f:795f:f483:85bf])
	by yyz.mikelr.com (Postfix) with ESMTPA id 020CF717A8;
	Sun, 29 Sep 2024 23:17:14 -0400 (EDT)
From: Mikel Rychliski <mikel@mikelr.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: Fix MAX_TRACE_ARGS limit handling
Date: Sun, 29 Sep 2024 23:17:14 -0400
Message-ID: <9997571.eNJFYEL58v@basin>
In-Reply-To: <20240930084018.a725f6e59a3be7be3e356e27@kernel.org>
References:
 <20240929200939.162524-1-mikel@mikelr.com>
 <20240930084018.a725f6e59a3be7be3e356e27@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, September 29, 2024 7:40:18 P.M. EDT Masami Hiramatsu wrote:
> Good catch! But this silently drop the arguments after MAX_TRACE_ARGS.
> I rather like to reject such input with an error (-E2BIG) as below.
> (Hmm, and I also need a new ftracetest test case for this.)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 39877c80d6cb..3f6654127d8c 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -2194,6 +2194,9 @@ int trace_probe_create(const char *raw_command, int
> (*createfn)(int, const char if (!argv)
>                 return -ENOMEM;
> 
> +       if (argc > MAX_TRACE_ARGS + 2)
> +               return -E2BIG;
> +
>         if (argc)
>                 ret = createfn(argc, (const char **)argv);

I think the logic still needs to be cleaned up in the individual probe 
implementations (either to count consistently or remove the limit enforcement 
there), otherwise you can get an oops with something like:

	echo "f:testprobe copy_process" arg{1..127}=\$stack "\$arg*" > out
	cat out > /sys/kernel/debug/tracing/dynamic_events

BTF argument expansion results in >128 arguments, but we still attempt to 
process the excess unparsed ones.


