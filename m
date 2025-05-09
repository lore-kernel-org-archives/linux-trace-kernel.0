Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C9723D28F;
	Fri,  9 May 2025 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746834086; cv=none; b=AJ62KnpwX8NrLA3NikzIe71vnuITGsrQk0rpnXeMyNeizebnuAi/84YX6EfXvqcMFurk1e/zv077N2zXGaSYGR0nbLfMt+KTGodSzwFYc3q2BTmasj1Y3EFp2ELTGuaB0Cm1Wc1Ro9dmLkAQJ/BoSyQ1loyKyTp+tKckeW44pjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746834086; c=relaxed/simple;
	bh=s3WXTNpXmvd1y+KZ3neguifRa9suGq/l7JbN+GuEU1k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dP8H37Omo7IUrHgChk7lmzTx7sqwNaE1RK+GuZrswDIN9huM4AtwXpEqOF538ucYd1DZfV7QY2UJdPkE49ntock4qNvX4YNweoqUd1X3iHyYm9DGL8O7SBL9fFzXntCgzTREnGWTrWRvq7bYigeP8d8R1LahVvfKQLnuEqZBKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4gEMgx9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4gEMgx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C76C4CEE4;
	Fri,  9 May 2025 23:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746834085;
	bh=s3WXTNpXmvd1y+KZ3neguifRa9suGq/l7JbN+GuEU1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e4gEMgx9/v2sGpiiP+qZRohfNslCxcKKu2DTK9DgLGnkQKBtmUtIyl/FqL5A8Gn+y
	 GpdX679dY4R5CFymNdNQfCpIRUplmzQ88sucwAhry1n0L2tCQPFYYCjgnlmgHrUSaN
	 1WutplHQ46ai7AGUDjGuBRUNZjuxemJoA4/ejhoO4WVU+j1zKdFShhDYr0mbVbki2f
	 WtfR0sQITBO4Chc2f2CuYAeLIiXRMD1KbZrF7Jkwm4ne9Dlbek4FHwGGTJlCxdnRmS
	 5e/2Wd9sc1kjm0kXQSgFn15fd+RO2oRsOM9GCvneYMD+gMukL6CkqFJ+XKD6h/YWxq
	 lSuR0nImq/X1g==
Date: Sat, 10 May 2025 08:41:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: tprobe-events: Register tracepoint when
 enable tprobe event
Message-Id: <20250510084122.0ea22ec2156b260565a1892a@kernel.org>
In-Reply-To: <20250501112712.755d238c@gandalf.local.home>
References: <174212767109.348872.18231451508464729427.stgit@devnote2>
	<174219859655.549159.12584048778295152488.stgit@devnote2>
	<20250501112712.755d238c@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 May 2025 11:27:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 17 Mar 2025 17:03:16 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > As same as fprobe, register tracepoint stub function only when enabling
> > tprobe events. The major changes are introducing a list of
> > tracepoint_user and its lock, and tprobe_event_module_nb, which is
> > another module notifier for module loading/unloading.  By spliting the
> > lock from event_mutex and a module notifier for trace_fprobe, it
> > solved AB-BA lock dependency issue between event_mutex and
> > tracepoint_module_list_mutex.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_fprobe.c |  382 +++++++++++++++++++++++++------------------
> >  1 file changed, 218 insertions(+), 164 deletions(-)
> 
> Is this patch still needed? It doesn't apply cleanly.

This is a kind of performance optimization. Without this patch,
tprobe always registers a stub function to the tracepoint. This
*may* introduce an overhead, and it depends on how frequently the
tracepoint is used. But I guess it is not noticable unless we
create so many tprobes because the stub function is just a 'ret'.

Thus this is not so hurry. Anyway, I will update it for for-next
because this can clean up __tracepoint_probe_module_cb() logic too.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
