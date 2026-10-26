Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043395;
	b=QufXn8WE6U+UPSHs4xL9xO1tyjMyLGmZ56VcS3OAJBvZx07gYsWzGgW66YSUEl25drWa
	 rX8Rk15RkJqrAOTG/P4ntrJVgfR8vl1pXSVveP5zVWIzYojqPTACKVDoeN6FotG9kPwie
	 y416AwAD/cB5i8os/+vnT7rX4H0bC6BOx3OJenISYTuXSuAFLbK1XobXA6+N+Sju2kIn/
	 mnyObZ5n7iZAng4ZftyXVp6jzZXvzR0DXfGOih/YT8Wlns6vLCu8ZpdVIvfNMxFyNZxkH
	 CtjCa2ewlQdhwI1IWkPT12pZSbYQfSG20tMqhseBz3NJEkoZ2T+oWGmJ9cVKUUKCc4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043395;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=X5aClXi+RvvDyTQXjRyICM6l8FafIXGlhi8mXXeP/sw=;
	b=1GxfGvt3z3Mpa7j6uRbvxKKNYCD49FMv7hLE7BzMsECzQr8ytmYtrtN0ANDzJxI1x0VQ
	 azoS98Dx+PBH2dhi6mYTUuwI4PnYY+QfL4s8WlpIb6lVJLCoXyXr+jLL1gUm0zoxt0pyQ
	 DL3v7WIzfFETeXrNzB8nfk5nSDBpBoH5za2WqTbKINg5iXb7xiVsFOOBrhz9Y3lL2WyXg
	 tVCva39Gq0JgfJvMDRyK8/aAX9cDlGzCpJsg8Sw2gsUz/A4s3wswpbYIs2daPl6Z0fsXM
	 Do0ZLPFTStn41S/4aynbGJIAPhIEj9Q0DzXYCIgQddHwFab5KybHiQwg/8ZtDQLamMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=F5s43r02;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33935606A31A;
	Mon, 26 Oct 2026 19:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33935606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=F5s43r02
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id ED39C14083D;
	Mon, 26 Oct 2026 19:36:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 33B5E2F;
	Mon, 26 Oct 2026 19:36:25 +0000 (UTC)
Date: Mon, 26 Oct 2026 15:36:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 03/10] tracing/filters: Check CPU bounds before
 cpumask_test_cpu() in do_filter_cpumask_scalar()
Message-ID: <20261026153624.0244fdbe@gandalf.local.home>
In-Reply-To: <179285915196.466249.7067056297377577459.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
	<179285915196.466249.7067056297377577459.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: s9omrmkj66i7izwpz33s9kqbxcfp9r4k
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 33B5E2F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18CKajAcX0zNUxKJaQul//Dhc0rTFcG7io=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=X5aClXi+RvvDyTQXjRyICM6l8FafIXGlhi8mXXeP/sw=; b=F5s43r02xToa4QrZ8YhlbDprk7344gZ+1BGGgtGUchgrPlaOr6PaEhSs7OGSiHyIP0gqJQr/VISAFW5kJkDNr7ftCIZfKrvI0teate5kekzBdtqGj8K5rAIzjgMoE2BZprFLYMTsTBwE9VN7RRI2T1y6Vg8zkxNcACZrbfP0QPc=
X-HE-Tag: 1793043385-456693
X-HE-Meta: U2FsdGVkX18sni8XWVbH7Uy44c7oWZnrHgGH4ngDYpJIwQURxiZYsDJwppYCWmpTULqiCriDFl49aq8DNRF1ON54JguxuF8iHHI9wNqzsgASmse17ag7gtDz2OpaQXWUitDYff+6DWV4j85fMkviGtbRRanA3aMHhatYWhPTX1+QK+3RE3J57/MRPIN5ARyfORpE2SoHEOGZJDyzV2FHhjImrA0cFEx/7FutPsaepvu6sxGJJ394jShWN6igtMKGpUSqixl2jWZiu7iM4xvPhrzhTpkRZYOvkWtO/zNAeiQIJakjKVW98hYXn7gpRTlHbcnybh4HnKPH3iTvQ5jw4ZE6XV0Ltl+P

On Sun, 25 Oct 2026 01:25:52 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In parse_pred(), single-CPU cpumask filters are parsed via cpulist_parse(),
> which checks against nr_cpumask_bits (NR_CPUS). When NR_CPUS > nr_cpu_ids,
> a user can provide a CPU number where cpu >= nr_cpu_ids.
> 
> When evaluating such a predicate in filter_pred_cpumask_cpu(),
> do_filter_cpumask_scalar() calls cpumask_test_cpu(cpu, mask) without
> checking cpu against nr_cpu_ids. This triggers a WARN_ON_ONCE under
> CONFIG_DEBUG_PER_CPU_MAPS and causes an out-of-bounds bit test.
> 
> Check "cpu >= nr_cpu_ids" at the start of do_filter_cpumask_scalar(). When
> the CPU index is out of bounds, return "op == OP_NE" since an out-of-range
> CPU is never present in a valid cpumask.
> 
> Fixes: 38c6f6808389 ("tracing/filters: Further optimise scalar vs cpumask comparison")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_events_filter.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index c2c35b4de85e..69da95f42541 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -695,6 +695,9 @@ do_filter_scalar_cpumask(int op, unsigned int cpu, const struct cpumask *mask)
>  static inline int
>  do_filter_cpumask_scalar(int op, const struct cpumask *mask, unsigned int cpu)
>  {
> +	if (cpu >= nr_cpu_ids)
> +		return op == OP_NE;
> +
>  	switch (op) {
>  	case OP_EQ:
>  		return cpumask_test_cpu(cpu, mask) &&

I wonder if we should just make the filter fail with -EINVAL, and not let
it get this far.

-- Steve
