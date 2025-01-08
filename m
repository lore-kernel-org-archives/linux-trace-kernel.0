Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6730B1FECB5;
	Wed,  8 Jan 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348825; cv=none; b=rxNlnazTSI328gFf9/mSoX54yEQ90RK3WtgdRfErD/cd4SpHeLKdwTdGlP+bQc/zgJkcbPRYgDlfNf3vjRzdC46C3aZ14hHgnjRzw58CXZM/lNiD+LM6ouXhCsO7BVGE9qjJ9nGkd1wG9ukTsEOX8ZiXXjLFN0Cu7DGmNO4NDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348825; c=relaxed/simple;
	bh=c3jRtkJm4c78CEmiXZKOkfdgU7bKNpfFMX1I2jbbi48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqNajD97yPbyDdPSRnb8dL9l0h+BCqd3YNd9awCvPh5po19ki28+CX8K0QFK6oZ0l7iEjgRGjQytGkV20gxjrsqH8ymKdmKoEp0sgzJn6Y1TO3qJtagHCXux/EbrjpnT6d/B+poCAasf18eromXSlqrEYcpBSHvCtpRG+DZsqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC5AC4CEDD;
	Wed,  8 Jan 2025 15:07:03 +0000 (UTC)
Date: Wed, 8 Jan 2025 10:08:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] tracing/kprobes: Fix to free objects when failed
 to copy a symbol
Message-ID: <20250108100834.44b070b9@gandalf.local.home>
In-Reply-To: <173630224589.1453474.3336291076637629730.stgit@devnote2>
References: <173630223453.1453474.6442447279377996686.stgit@devnote2>
	<173630224589.1453474.3336291076637629730.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jan 2025 11:10:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In __trace_kprobe_create(), if something fails it must goto error block
> to free objects. But when strdup() a symbol, it returns without that.
> Fix it to goto the error block to free objects correctly.
> 
> Fixes: 6212dd29683e ("tracing/kprobes: Use dyn_event framework for kprobe events")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
