Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792796761;
	b=h9GgI3auT5uOiMiBvNrxCEOlxBfutxoN7eMkddQgOZJamwFZqgiG7JnSSFneC7rS6DKp
	 V2U66yQyYh10sRZ3Nt/rfV8b4E26yqb0vMJt3MK2g9AYqNqpZiWKfrSCBYePQOoF6+Kyn
	 MvqXMuKzwYyfGy/zJFk8LffHdxGcPmmkuVWncvIKPfyjVtc+PEcw9pjB+8lme/UzZmPV1
	 LhH1Q6m35TR/yzQdjJWDsvtMh95MbNdEZozLGmzQToFirQFxWDqrtTUXaY9kUla1cHql/
	 wcQxpREnuVPr9Jt1/Za/TJuQ9j8Cly4VBOvrRs48xfvBpV266ao0akCx4W/E89uN3eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796761;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4hO5+EGFbdIm2PTIgbiacmjxZaBmEcffaEf0XoWXSK4=;
	b=QT9f9N2u2nx0RPTf9AA45sWpAYmPIX9nbLz29m5nTXZ+o1Dnao9HgWHaJiSRHXcq2bWT
	 rnsAZzFhwelc/Kl/OW5U4WJIgqzFVh6Qx+h4+tyNqu5wnpCoOMXPNw+NhbniCJcXJqlwc
	 3awYUvWzKjX9DBOz/9aAAHCB7OplP1PEeIcVXACw+d1vT4/6GUeM+0UH3lc1oSVP8uXSm
	 aLgjTek4i31+oIlU6MVWPCLdyLNLLjzzpA1Kh5rn0aUHtTwnTp7YmNXhr/WO5hvk0tYv/
	 lzYmSlbIZx9GwgETlq99bixIxrsXgcglVilFmtU3a+nIPisdbSAyxUsbh77qpi4dJpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TweHw2ud;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D6606A31A;
	Fri, 23 Oct 2026 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TweHw2ud
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528B31F01825;
	Fri, 23 Oct 2026 23:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792796760;
	bh=4hO5+EGFbdIm2PTIgbiacmjxZaBmEcffaEf0XoWXSK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TweHw2udvWyXiKqm3c5lu35mhP6gmVs3YMu0SzLRbY/apOG3u1mllvefHp/zqH5V7
	 wxDDNcV0NlZRxi5uXe3ex753z832pjdxzapOVVEQ3pa9+bUJIjUsLXvdJ75OhhERbd
	 w7mLZsiVjlKXiEMrx3Xa6pOnMHc5OSFRqtNmLCz/jrVXlgzfvNQllxMRrQUo+LmS7a
	 d8YpZucCYBAR3sQ6l1Zvsgtac9vkAGkiXPiXE6wETTtBNl15RzWFZNlsLVY446QZ1S
	 ss3yE/AV9lvNeNUyxR7/U6vUQVCsLd3PgKTiCyhFF0f6hyewHUBBN4GaTfMAq5ONYE
	 sTfLHl7rNTv2w==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Reject incomplete event filter expressions
Date: Sat, 24 Oct 2026 08:05:57 +0900
Message-ID: <undine-1792796757155612044-8d9146e334f59909@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261023174620.91969-1-kylebot@openai.com>
References: <20261023174620.91969-1-kylebot@openai.com>
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

On Fri, 23 Oct 2026 10:46:20 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> A non-empty expression normally finishes in predicate_parse()'s inner
> loop, which resolves the pending logical operators before jumping to
> finalization. If the input ends after an operator, possibly followed by
> unary '!' tokens, the outer loop instead falls through with unresolved
> operator state.
> 
> For example, "common_pid == 1 || common_pid == 2 &&" leaves
> prog[0].target equal to -1. The second pass then reads prog[-1] before
> the forward-jump check can reject it. Depending on adjacent slab
> contents, it can also copy an out-of-bounds word into a branch target
> that passes the forward-only check. A self-targeted perf tracepoint
> counting event can reach this path through PERF_EVENT_IOC_SET_FILTER.
> 
> Reject the outer-loop fallthrough when a predicate has already been
> parsed. This ensures that non-empty expressions only reach finalization
> after the inner loop has resolved their operators. Keep the existing
> no-filter error for input that has no predicates. Add a regression test
> for trailing logical operators and unary negations.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
>  kernel/trace/trace_events_filter.c            |  6 +++++
>  .../test.d/filter/event-filter-incomplete.tc  | 24 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 2b46ca536045..405651be9c93 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -596,6 +596,12 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
>  			top--;					/* #12 */
>  		}
>  	}
> +	/* Only the inner loop can complete a non-empty expression. */
> +	if (N) {
> +		ret = -EINVAL;
> +		parse_error(pe, FILT_ERR_INVALID_FILTER, ptr - str);
> +		goto out_free;
> +	}
>   out:
>  	if (top != op_stack) {
>  		/* Too many '(' */
> diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
> new file mode 100644
> index 000000000000..cc6df762845f
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event filter - reject incomplete logical expressions
> +# requires: events/sched/sched_switch/filter
> +# flags: instance
> +
> +filter=events/sched/sched_switch/filter
> +
> +for base in \
> +    'common_pid == 1' \
> +    'common_pid == 1 || common_pid == 2' \
> +    'common_pid == 1 && common_pid == 2' \
> +    '!(common_pid == 1 || common_pid == 2)'
> +do
> +    printf '%s' "$base" > "$filter"
> +    for tail in '&&' '||' '&& !' '|| !' '&& !! ' '|| !! '; do
> +        if printf '%s' "$base $tail" > "$filter" 2>/dev/null; then
> +            echo "Accepted incomplete filter: $base $tail"
> +            exit_fail
> +        fi
> +    done
> +done
> +
> +echo 0 > "$filter"
> 
> base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
