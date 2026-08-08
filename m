Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4363B6C06;
	Sat,  8 Aug 2026 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786162601; cv=none; b=iQ3Ydyzb7nHzmaT0msp9mMxDZGR47aULB+95QLy7pegkn0HMi/RK5ZOx7HYR9CJUVMzxrWZcMNLm1L+Syj1zo1Nhlqblj2v/Ya2Wfp9KzMp+dNc/fUwmoPWUMvBzOpN8NCnDHqVNbprOA0hzW/xSYYTnCT2n3kClTATpoVvbJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786162601; c=relaxed/simple;
	bh=lzMYgoMCo0GABOu1TIfHfipBbVKdqxV4rAiWKOQbB2w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o0Ks5yFwq+8Xsnlh1qSAMjkPK0ia7zBG5zwNMkgKXPnOQb781YFa49nS87X3lCtoZbHGPgurJRjdM/hDvPMPjrxTwdWJfyWxKU1C2hrxTx1EyhXxje8YNVL6gj4gI1IBolopj8HQLSK9J9x8DHlHs3U7GsPVHneAGyyhSiPO8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=He9pQrBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He9pQrBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97341F000E9;
	Sat,  8 Aug 2026 04:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786162598;
	bh=Fz3hQs7dGPKGj3P4TL+iHFB8vT287v23iLsb4YLkVNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=He9pQrBpOGOgxzd/42LlA1uIsWsDzMalZQ+kiNf3xPzzsN8JJSj3YAClfVUkyKA8a
	 QfjY39OtPfHktEjC1bdJXMzsaUWSQkZhiDfI5YP+YI1fuK/FeffvSxoT7COmpTQkaD
	 silKovzkc6NURV3co9Ue9uwuqxVIxZlpbxzq0zH/WPKxEdHjqboAKGsWb4Dah47uZK
	 IFeba/8ASG7uJoOauEYFfEh8NusCx/x6te8eILh/g6IOiYItTZUXBb1XTxYaFvENkR
	 FmtHt3aZBPUcM2Pt3dSC1TaS4xRX/10fqrPRDQroEm/3DL/Ymh+1hGtx4Bj4zYxOFh
	 18DeahCMApwbg==
Date: Sat, 8 Aug 2026 13:16:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Pekka Paalanen <ppaalanen@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] tracing/mmiotrace: Clean up coding style and
 redundant debug logs
Message-Id: <20260808131634.4dafadc203a58e9f5b0e7613@kernel.org>
In-Reply-To: <20260807205053.7000eef0@gandalf.local.home>
References: <178524298182.56416.7520852015178187644.stgit@devnote2>
	<178524301945.56416.2087305624947649637.stgit@devnote2>
	<20260807205053.7000eef0@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 20:50:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 28 Jul 2026 21:50:19 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Clean up coding style issues in trace_mmiotrace.c:
> > - Remove redundant pr_debug() entries in tracer callbacks.
> > - Fix opening brace placement for mmio_tracer.
> > - Prefer 'unsigned int' to bare 'unsigned'.
> > - Add missing blank lines after local variable declarations.
> > 
> > Assisted-by: Antigravity:gemini-3.6-flash
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_mmiotrace.c |   16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
> > index 77120d467e11..ce16e1c53d12 100644
> > --- a/kernel/trace/trace_mmiotrace.c
> > +++ b/kernel/trace/trace_mmiotrace.c
> > @@ -36,7 +36,6 @@ static void mmio_reset_data(struct trace_array *tr)
> >  
> >  static int mmio_trace_init(struct trace_array *tr)
> >  {
> > -	pr_debug("in %s\n", __func__);
> 
> So how are these redundant?
> 
> Are there pr_debug() prints elsewhere?

No, that is not redundant, but just like only for debugging mmiotrace.
Maybe we can leave it.

[...]
> > @@ -322,6 +318,7 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
> >  void mmio_trace_rw(struct mmiotrace_rw *rw)
> >  {
> >  	struct trace_array *tr = mmio_trace_array;
> > +
> >  	__trace_mmiotrace_rw(tr, rw);
> >  }
> >  
> > @@ -353,6 +350,7 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
> >  void mmio_trace_mapping(struct mmiotrace_map *map)
> >  {
> >  	struct trace_array *tr = mmio_trace_array;
> > +
> >  	__trace_mmiotrace_map(tr, map);
> >  }
> 
> Honestly, for one line functions like the above, I think it looks better
> without that blank line.
> 
> -- Steve

Yeah, this is somewhat machinary fix against the checkpatch.pl.
Or, maybe it is better to just pass mmio_trace_array directly?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
