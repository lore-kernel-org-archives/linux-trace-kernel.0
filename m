Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE76333439
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790556676; cv=none; b=XljBclvOqtYMeSJuaYEj8ombZ2WfzLfJdtgISFKX9MTX2SQP4c4n9A6c85OpGxKmHC5G7YDOKpGTpDba7wZhUKLpCvm9mSnorLyXhFAk631JpA5IZOKAldc5aDWbjMQBmste7Fd4rUjpHNZvi8MJqjs4zTiQDS/D6XjA+9rRJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790556676; c=relaxed/simple;
	bh=XjeyXMjpC621Iz/XZfAHm+J5tkS1Tf6+KjbSw3rE+h8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WgNF0q5cvvyWAoHApG7uPsA5tUL6bH54QRtgeDiChlZJvlaFJoT9OA4WxiIJIktcPkwtseSt+p8ASbqgwmXSFjaIqoGlthJlhv8lqURgfQgs6F+DCAW+jKXxyO/Z17PRonyruaw7hILcQsJBmA89fbZxJRJazJXzwJ5QYMAaG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB8rWFfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB8rWFfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9FC1F000FF;
	Mon, 28 Sep 2026 00:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790556674;
	bh=jyJyF11T9JG7MzguXU3EO0WJKBGmpjCawGYZEAWCoc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UB8rWFfpD4MLL7EclCfdFe1LYzwujcPX6K8cdx4xu1fhrxiuHRz2HN1gAm/KuXiFP
	 IQjLdu3wTkM3+3ymN2qV6Is9IH0ZeRgDyZsw600gxH2ylmksu89OpyoCmbLRaPtcJr
	 RM+HQkR1eRn13D8wZTLot33BMQQHCyY2p/vLaAFe6+EOyVwb89ouWp61/1rX75fAPN
	 Xekn8M/fg2U20ogW9YdlsTnwLavn9aH201MrMy0Ysd0R3sZpaJSt1lvmA2q+EV9QR3
	 I4XEhW5e6hy4kbDfzo3Ev4TtGvZDCVCJdYOTGOQPQgVc4PDzscTkmxUMq/q3lEJmfj
	 uW3rzFaK99FnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fprobe: Protect fprobe_return() with guard(rcu)()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179055575973.241711.6618845269004184577.stgit@devnote2>
References: <179055575009.241711.6358052647499787191.stgit@devnote2>
 <179055575973.241711.6618845269004184577.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 00:51:14 +0000
Message-Id: <20260928005114.9C9FC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tracing: fprobe UAF and lockdep splat due to invalid guard(rcu)
--

commit 4b472c8849c5257c65478348507af6f9fee7c3af
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

fprobe: Protect fprobe_return() with guard(rcu)()

In fprobe_return(), the shadow-stack iteration and exit_handler
invocations were protected by preempt_disable_notrace().
However, unregister_fprobe() and unregister_fprobe_async() (used
by BPF kprobe-multi) rely on standard RCU grace periods (synchronize_rcu()
and call_rcu()) to wait until the fprobe is no longer in use before
freeing it.

In preemptible kernels (CONFIG_PREEMPT_RCU=3Dy), standard RCU grace
periods do not wait for pure preempt_disable_notrace() critical
sections. Consequently, an unregistered fprobe may be freed while
a concurrent CPU executing fprobe_return() is still running
fp->exit_handler(), causing a use-after-free.

To resolve this, protect fprobe_return() with guard(rcu)() matching
fprobe_fgraph_entry(). This ensures both synchronous unregister_fprobe()
and asynchronous unregister_fprobe_async() safely wait for in-flight
exit_handlers to complete via standard RCU grace periods.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-e46bcd68-4a56-4f19-a255-e3772980e5e3
Fixes: 657b594b2084 ("fprobe: Fix unregister_fprobe() to wait for RCU grace=
 period")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 1e9b00997ff27..e34c3f7667848 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -656,7 +656,7 @@ static void fprobe_return(struct ftrace_graph_ret *tr=
ace,
>  	size_words =3D SIZE_IN_LONG(size);
>  	ret_ip =3D ftrace_regs_get_instruction_pointer(fregs);
> =20
> -	preempt_disable_notrace();
> +	guard(rcu)();

[Severity: High]
Since ftrace operations lacking the FTRACE_OPS_FL_RCU flag can execute in
idle contexts where RCU is not watching, does adding guard(rcu)() here
trigger an illegal RCU lock usage splat?

Additionally, since RCU doesn't track read-side critical sections that
start when RCU isn't watching, does this mean synchronize_rcu() during
unregistration will fail to wait for these handlers, leaving the fprobe
vulnerable to the same use-after-free this patch attempts to fix?

[ ... ]


Looking at fprobe_fgraph_entry() in the same file:

kernel/trace/fprobe.c:fprobe_fgraph_entry() {
    ...
	if (WARN_ON_ONCE(!fregs))
		return 0;

	guard(rcu)();
	head =3D rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but fprobe_fgraph_entry() also
uses guard(rcu)(). Could this pre-existing usage cause the same lockdep
splats in idle contexts?


Looking at how fgraph operations are initialized:

kernel/trace/fgraph.c:fgraph_init_ops() {
	dst_ops->flags =3D FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;

#ifdef CONFIG_DYNAMIC_FTRACE
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of
FTRACE_OPS_FL_RCU in these global fgraph operations expose all fgraph
users to execution when RCU is not watching? Should this flag be added
here to prevent tracing callbacks from being invoked in contexts where
RCU is offline?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179055575009.241711=
.6358052647499787191.stgit@devnote2?part=3D1
