Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CF36E467;
	Wed, 29 Apr 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478257; cv=none; b=ShX3J1OhcBOR7NdKZPDa1p3B4GZE6XskjMEP2LML67DwadoP8vMRjb7MyCeydSzykYK0MddexagQoDQrYSZ+NJpeoPtKUqMm8FxYv41T7XrRh7BDXgjOeS4l5muMoTr0NRvvxl1DqjwB0LeGYp2yl9/cQZCm/qRkdhGPfVPs458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478257; c=relaxed/simple;
	bh=W3aAqhgNLh1ST2Eodh9VcOC2+rBVkz1uRY1/DBQc2TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aa2OBfBeeyeaH+AgKqMX6poNyPOLP/jNhjvv1U9N0FmbrFfaGiOMu1XGDJ2T6h4m0gm8GVN0+BJDUa2QnJuTo6yeX0bn+LQvhjkfgfAaYuw/9WGW8EKUrW1pQIhqKHay5pvKwfXZCt+4KLRHTE4ga6Q3th8aGV7cWIs9Ksd/8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7TTd+pl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7TTd+pl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A58C19425;
	Wed, 29 Apr 2026 15:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777478256;
	bh=W3aAqhgNLh1ST2Eodh9VcOC2+rBVkz1uRY1/DBQc2TQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H7TTd+plUVa4wzQ/fHqQjG0iriLs4wpCz6j5WCh8aC+F3cKzoD1j7pRzMa8T2s+C0
	 88RF2XIB0uOhGePQm/6C+GbKSMseS/qUjr8UofH48qO/KF9lQwIpTq5/1h0oocDY6V
	 Qq8GWIpZJhhjxVl+/gjvBla7PMthRe9G/M0gPPEMZR9jAdlf+Z6OHp2f/Xuv+cHN+N
	 yIjGZfB3uOmgB6nfCpXnCzdIeLj/F0bzP5cnNm1Ycrj6cDWEdMhgqKtLUUrFveqyGS
	 R2LZ4l14/Izp7AnzL9bogvm9rgJudd6T0AcRneJGFpll2pKY9SZ5Q81iHuRxcpwaPt
	 yVIarw9SYNZFQ==
Date: Wed, 29 Apr 2026 11:57:52 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing/probes: Limit size of event probe to 3K
Message-ID: <20260429115752.6a87a3e3@gandalf.local.home>
In-Reply-To: <20260429175144.9d3d6e13e935f1dfd480f6a0@kernel.org>
References: <20260428122302.706610ba@gandalf.local.home>
	<20260429175144.9d3d6e13e935f1dfd480f6a0@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 17:51:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> BTW, to prevent regressions during future expansions, how about adding the following line?

Nothing against this, but I think it should be a separate patch.

Thanks,

-- Steve


> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 2cabf8a23ec5..c5ee7920dec6 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -979,6 +979,7 @@ static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
>  	ucb = uprobe_buffer_get();
>  	ucb->dsize = tu->tp.size + dsize;
>  
> +	BUILD_BUG_ON(MAX_UCB_BUFFER_SIZE < MAX_PROBE_EVENT_SIZE);
>  	if (WARN_ON_ONCE(ucb->dsize > MAX_UCB_BUFFER_SIZE)) {
>  		ucb->dsize = MAX_UCB_BUFFER_SIZE;
>  		dsize = MAX_UCB_BUFFER_SIZE - tu->tp.size;
> 
