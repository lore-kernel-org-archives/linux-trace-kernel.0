Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861823;
	b=UapTRIuXEu4v3JZuYxpgBmenhDoPR5xqO7zCSAzy6+tUbGuLFbGin5IsrspKjYVzeiE3
	 jxIVThTyvHBq4OXPPIwFvKO4eD+irJBeby/kMQNxVtaC0NVqPeMTueBQDRuBYtc2rueTO
	 GBI/YBuv6NcgBfgIF0e8DHHRlAtvFRpYsUacq1mpj4SwSe2FUQUhrQVzxGcYnil8vfDgH
	 vXdIOdR76MVWcw7Slz/nAtFIv8N11H0sVyYW3VTinezUVKaW3+h8Izbz2d/Z/Csa6uoN6
	 mlT2wOlnLAX4skvrBD4qcSo7hII12KSCd1ewGfNDHiqpq7H/fz0l7Op9N8DfoPu23lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ucG103OtGB0uXp5vLgmcqXc8IoTb+p29U9i3AaC9Yc8=;
	b=nF1rR3NojUxSuwKCbTG3r+030XFERcKpXCYWizCJfBQiXYlKndK4t8lBB8qRfBvHahpX
	 hPOtzlH6NFZJZZQhATUu941/mEVxOWBmknETXSmMx7UskzzTP3iwD1kElkbHx6tEN6/RF
	 SCvu4PCovcNwznSUlByl9XZlYUXqye8HjcenXiwhUlxjS7VwM+44FdC54jntr6cgLMTRn
	 /ZwR91DdCASWOG+IeGXPevWUoBtAJDFdq9TlKfQSs2EWXIWGJNNfYQZv81RmsexRwDia/
	 5VY36WlBSOuDsro5g6xXwumRy910+KJ4j8SyUKRWx7yIznTTNk3vklXvJ2zNGtdjwog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHArR55J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D24606A31F;
	Sat, 28 Nov 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHArR55J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B3C1F000C1;
	Sat, 28 Nov 2026 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861822;
	bh=ucG103OtGB0uXp5vLgmcqXc8IoTb+p29U9i3AaC9Yc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kHArR55Jlyf2Fv07KwPTVGMh7dAVYtDpQoUdwbGpk9wGwEQrAGH4MGKDUDbncc78C
	 CPCrrGmUB0GsrlYsPwoQxkqffPKriVE5KtrPReCPQBKFNdJ+O3PalVXpZH/6f9s5es
	 SbZUos2y/YtW1A/SBqrtpjINEkvv3YCqQ7KHKy7EQ7dnUHrSCxjOb2lvD+tzfi7Py4
	 eNBtAJiem7JS8e2MLMFeqZx/j++ABnvjwY9S9eVe2V0jMcNvTxQtZkkF+fQg3vs96d
	 euriVR0uTFjt58BbfupZYs9EzXpEBsjaGBMb8wHWgboYI3aYlzK/XrnpfbtVEN8J+Y
	 rlb+L2J0eUTgw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Ren Wei <enjou1224z@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, vega@nebusec.ai, rakukuip@gmail.com
Subject: Re: [PATCH 1/1] tracing/uprobes: Reject unregistering enabled trace_uprobe to prevent UAF
Date: Sat, 28 Nov 2026 19:30:19 +0900
Message-ID: <undine-1795861819518649294-8d01b129ddd6b6da@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <4ac73dd24e3123cdcdb3e938dc7bd74be66a3f77.1785227724.git.rakukuip@gmail.com>
References: <cover.1785227724.git.rakukuip@gmail.com> <4ac73dd24e3123cdcdb3e938dc7bd74be66a3f77.1785227724.git.rakukuip@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 23:19:59 +0800, Ren Wei <enjou1224z@gmail.com> wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
>
> When unregistering a trace_uprobe, if the probe has a sibling
> (i.e. trace_probe_has_sibling() is true), unregister_trace_uprobe()
> jumps directly to unreg, bypassing event busy checks and
> unregister_uprobe_event().
>
> However, if the trace_uprobe is currently enabled, freeing it without
> disabling it allows uprobe callbacks (such as uprobe_dispatcher()) to
> continue accessing the freed trace_uprobe structure. This leads to a
> use-after-free (UAF) condition.
>
> Fix this by checking trace_probe_is_enabled() at the entry of
> unregister_trace_uprobe(). If the probe is enabled, return -EBUSY
> immediately to prevent unregistering and freeing an active probe.

I found this had been already fixed by f1d9b7a3fe99（"tracing/probes: Check
enabled and busy state before unlinking sibling probes")

Thanks,

>
> Fixes: 41af3cf587f4 ("tracing/uprobe: Add multi-probe per uprobe event support")
> Cc: <stable@vger.kernel.org>
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  kernel/trace/trace_uprobe.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c274346853d1..a514a82c4ae0 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -396,6 +396,9 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
>  {
>  	int ret;
>  
> +	if (trace_probe_is_enabled(&tu->tp))
> +		return -EBUSY;
> +
>  	if (trace_probe_has_sibling(&tu->tp))
>  		goto unreg;
>  
> -- 
> 2.43.0
>
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
