Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00259201113;
	Tue, 15 Jul 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592114; cv=none; b=D89WDiMMa0EnWI5XgGpTwQ+6AQw0oRVNFyrRxpYEsUrflAgLVRaKTU/0p4AL4A7TvKDSA6V5KJ5ycL3lMFTx8qm/NX+/YgYo7lWg0QTkq0pS56ztRdTNCC+hdyjU+x2bnhIuJONbPu6EsXenQPIQHZ15AcQ9/o5KS3rsNVs+JJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592114; c=relaxed/simple;
	bh=jhWYuzHfSU/QzFc5tJJbM9T7jtpb9Mt03OPW3Rb3VI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQfljodYDq2DrgjhYnJ4oHunxB0CZI8T4YMsN0odXqbCbObtDFCNSclEHb97D96s0EnAGBJlxFXVKCG1hTlAKa59/LtkD2ljaUP5BTdHiU/wKu3tIemeL/yV84kQuqDtGHyhvN8RBe90KEwQBi0DAiLpUVt+3XYtO5DUfpRBgvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MmWkrXNQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BjB05N8f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MmWkrXNQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BjB05N8f"
Date: Tue, 15 Jul 2025 17:08:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752592110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Kfo8oVzTYkqVbJzdcwk8CX5HRxjKm+62hOY8rE1oEM=;
	b=MmWkrXNQUMIrLsa2dSguMAuofh47D7zYnseR8/ASK4MfnFWc3wMBgQp1k4JCifPUSRftUw
	O9MWj41jj0rRKQ+w25nfvIdHx971cI3EuNgpJ41lREjVeIoTib9hWj0yFPLa6G08dJS9Sv
	fJLkbFC3uWYVTmMojJHhenOv4er1Y8rbgr+37pYN61FC/Eii+qj4455F9V1IMbpvja/44S
	k3lfPWhf/5porjvSj847xdjwDCXajXQdHY9eDAN38kT1A/rYY3HCpdusHBQrA48n7agXyT
	RsSNJ6JOyh5Rqt0vlH/TfJWtBeyjusQekeO3m4VF9wCDkqebdfwi8J80K22FbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752592110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Kfo8oVzTYkqVbJzdcwk8CX5HRxjKm+62hOY8rE1oEM=;
	b=BjB05N8f11C0F0CjcqUtJsm8gX45Gsj3isd0fXdBqKBgtg1B+zwDn8xDYOHARcuKrKplMg
	0IWeDXEkp17WugCg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 10/17] rv: Fix generated files going over 100 column
 limit
Message-ID: <20250715150828.BNdFfB8h@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715071434.22508-11-gmonaco@redhat.com>

On Tue, Jul 15, 2025 at 09:14:27AM +0200, Gabriele Monaco wrote:
> The dot2c.py script generates all states in a single line. This breaks the
> 100 column limit when the state machines are non-trivial.
> Recent changes allow it to print states over multiple lines if the
> resulting line would have been too long.
> 
> Adapt existing monitors with line length over the limit.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  kernel/trace/rv/monitors/sco/sco.h     | 12 ++++++++++--
>  kernel/trace/rv/monitors/snep/snep.h   | 14 ++++++++++++--
>  kernel/trace/rv/monitors/snroc/snroc.h | 12 ++++++++++--
>  3 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/rv/monitors/sco/sco.h b/kernel/trace/rv/monitors/sco/sco.h
> index 7a4c1f2d5ca1c..83ca9a03331af 100644
> --- a/kernel/trace/rv/monitors/sco/sco.h
> +++ b/kernel/trace/rv/monitors/sco/sco.h
> @@ -39,8 +39,16 @@ static const struct automaton_sco automaton_sco = {
>  		"schedule_exit"
>  	},
>  	.function = {
> -		{     thread_context_sco, scheduling_context_sco,          INVALID_STATE },
> -		{          INVALID_STATE,          INVALID_STATE,     thread_context_sco },
> +		{
> +			thread_context_sco,
> +			scheduling_context_sco,
> +			INVALID_STATE
> +		},
> +		{
> +			INVALID_STATE,
> +			INVALID_STATE,
> +			thread_context_sco
> +		},

I'm confused, these lines were not over 100 columns. Same for snroc.

From my understanding of the previous patch, the script does not break
lines which are not over the limit. Did I miss something?

Nam
