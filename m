Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5D328BAAF;
	Wed,  6 Aug 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484232; cv=none; b=Am1425u2YHZVw2gaPi2HkfrzFw9nHKI2GEEUr8UW47/erBl+5Z1OhBoIGMGIEl4VX9UdGv125My501XnXKx2fN6kBNZ5gL2byLTObEkwmvUNz8hTeu3JSzZe9Ie7jPoChImeVHIQ2RRyPp5G9Q/n9NHygpPxKnob8SHtao9NN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484232; c=relaxed/simple;
	bh=/7IndVma90HA7/q28zkq66FvY805P6nZspAQNyovBd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEyhzxuCwDbQOOd4Q0AkTmRb/3cvfYvpDGIAa8oWpgMPyqBnuCIUuvjySegOVLYyKH6UKQtZdNg6kVc/NXwztH6ClpydkF3pVywEcGor9+8kNgDVp+yXnLccYdUyC0RMZerZu7Abalz7j8OZHTRkbX72Dd19o32hj6pZDYrowE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxsItseI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxsItseI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9B8C4CEF6;
	Wed,  6 Aug 2025 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754484231;
	bh=/7IndVma90HA7/q28zkq66FvY805P6nZspAQNyovBd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WxsItseI/3NXWPMhjClCJ64zZTR5+c6qvZrMWHcmLGFWRiVCCLml/T3/L8YWYd1kq
	 5bDOvL0TVaED4zm3TwF5my+DDCyM/KhqfL4uHOm5zUdhZgQIp1fpjAQxjoV2MvMjj0
	 cnJqlsPj0KfQKmCz/3vtdHmOVepjQErYy/19IGCORbJNR/Yc8jRoaVgbJAMMPmFGaI
	 Q9MPwX6lgwaNMbxhXPecsuHDcnhgYHf/Ec5pPfzy78Kzb2V4MZGT1atGh9qnAOUV/4
	 EN7j5sGTRx46V7NiZj9pRfqsV8lCc0uvLbNC73XtXgWf03StB683x1n7HUMmgyGo/j
	 uXBt19yiQgN+w==
Date: Wed, 6 Aug 2025 08:43:47 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Douglas Raillard <douglas.raillard@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>, Tom
 Zanussi <zanussi@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, aahringo@redhat.com
Subject: Re: [PATCH 7/7] tracing: Add syscall_user_buf_size to limit amount
 written
Message-ID: <20250806084347.79360a5e@batman.local.home>
In-Reply-To: <91cd9924-aaff-404a-8be7-79a6c7452a89@arm.com>
References: <20250805192646.328291790@kernel.org>
	<20250805193235.747004484@kernel.org>
	<91cd9924-aaff-404a-8be7-79a6c7452a89@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Aug 2025 11:50:06 +0100
Douglas Raillard <douglas.raillard@arm.com> wrote:

> On 05-08-2025 20:26, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > When a system call that reads user space addresses copy it to the ring
> > buffer, it can copy up to 511 bytes of data. This can waste precious ring
> > buffer space if the user isn't interested in the output. Add a new file
> > "syscall_user_buf_size" that gets initialized to a new config
> > CONFIG_SYSCALL_BUF_SIZE_DEFAULT that defaults to 128.  
> 
> Have you considered dynamically removing some event fields ? We routinely hit
> the same problem with some of our events that have rarely-used large fields.

We do that already with eprobes. Note, syscall events are pseudo events
hooked on the raw_syscall events. Thus modifying what is displayed is
trivial as it's done manually anyway. For normal events, it's all in
the TRACE_EVENT() macro which defines the fields at boot. Trying to
modify it later is very difficult.

> 
> If we could have a "fields" file in /sys/kernel/tracing/events/*/*/fields
> that allowed selecting what field is needed that would be amazing. I had plans
> to build something like that in our kernel module based on the synthetic events API,
> but did not proceed as that API is not exported in a useful way.

Take a look at eprobes. You can make a new event based from an existing
event (including other dynamic events and syscalls).

I finally got around to adding documentation about it:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/trace/eprobetrace.rst

-- Steve
