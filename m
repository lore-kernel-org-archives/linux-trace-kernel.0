Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8EA80BFF;
	Tue,  7 Jan 2025 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250830; cv=none; b=lvlgAmaC2VidX2EzMy1+T1oU+78qufDthv5gXqdneFg8zT/CUv2x/SzbhQDRKA7H+enJT2PoWkZUQcCYBPxY/Ua6KBqfjGMhvIU1ElXHa1gf5Q6kHALalsizlE+D/sxvR2s5l4cOuQJbKirg11+ilEzCOOqBFDGXH4ABPxen9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250830; c=relaxed/simple;
	bh=943yzkcW2I092HTadSpCPvjBWOgJ0dWcgOzmvl3nxto=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XX9ToIsoRfw3AClQJHpaolEQYMEvIVoA2SwJLQQtlFDI2gdZy4AmLj6nVjZ92xKs1RtWVeiH4abq4Lym1QI04tnwsVeOZsWiyOmLGcPqE195oei2jqJZe6ymlFr6O29VGDoUeDGCv9xiHwcKd5IkFoSuVtefs1EeEk9TVPpePn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvgp67qD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvgp67qD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05A9C4CED6;
	Tue,  7 Jan 2025 11:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250830;
	bh=943yzkcW2I092HTadSpCPvjBWOgJ0dWcgOzmvl3nxto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvgp67qD521Ov3hoG7nziorRM+k1T4C499I9eAEqsm8feVp+VWXW/ziOHJD+Xx7bk
	 S9hKvYuYw2QBb54TeFdRHesQVqJZaP/zQ6KaeBSu17+jlfXEh4OdeVKo+O5dqP3EN7
	 i0nhFCRz0MD2XokNQaRYMbB6uSh7KRGLx5Wr6Me3pQhpHiZDNHA8+Qe9eZxU7qo2jH
	 lMw0LJdAMpHvy/o86dS/xOpVCrbrrymIvMwYM0kt1eLBkopJUgRqMRi4d+bKxksesP
	 7vYT/cIB/z5ho8Dlqg5ogU8TTif3YaKMme7cxI+QiziZnafi7UcJNp1ZOv6XAQrTvF
	 3gA4RsNyf5cWg==
Date: Tue, 7 Jan 2025 20:53:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] tracing/probes: Cleanup with guard and __free
 for kprobe and fprobe
Message-Id: <20250107205344.4636e3565c507a1322937dfd@kernel.org>
In-Reply-To: <173625060316.1375434.11048027439794595989.stgit@devnote2>
References: <173625060316.1375434.11048027439794595989.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 20:50:03 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 3rd version of the series to fix and cleanup probe events in
> ftrace with __free(). I resend this without dynevent and argv_free
> parts because it has been sent by Steve[1]. And I updated the version
> tag.
> 
> In this version, I fixed some issues[5/7] and update DEFINE_FREE() tag
> name to specify freeing function name so that reader can understand it
> easily[2/7].
> Also, I added trace_fprobe cleanup with free[7/7].

Ah, these numbers should be updated. So fixed some issues in [3/5] and
add trace_fprobe.c update in [5/5].

Thanks,

> 
> Thanks,
> 
> ---
> 
> Masami Hiramatsu (Google) (5):
>       tracing/kprobes: Fix to free objects when failed to copy a symbol
>       tracing: Use __free() in trace_probe for cleanup
>       tracing: Use __free() for kprobe events to cleanup
>       tracing/kprobes: Simplify __trace_kprobe_create() by removing gotos
>       tracing: Adopt __free() and guard() for trace_fprobe.c
> 
> 
>  kernel/trace/trace_fprobe.c |  129 +++++++++++++++++++-----------------------
>  kernel/trace/trace_kprobe.c |  133 ++++++++++++++++++++++---------------------
>  kernel/trace/trace_probe.c  |   52 ++++++-----------
>  3 files changed, 145 insertions(+), 169 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
