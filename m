Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046782;
	b=OJ7h1/RrRIL02TtEx9gDDlYOdQjSu2XNCOnm4Q/ZxNF9v3IHDb/r/itxwa/MMEKMK46i
	 x2ivuMY3wALNclbv1TDdlyO8Iuwrm3ixHQWcIR+4iwxxqfav9lRxopuitoB9IqRt7xeMI
	 Id3zvAcFEqA2v4mKGvV8Smw0nwmU0f1bvmU3ct2AM7NFb1APOE5L13i6SNWttTuPeZpi1
	 2iWq560pPv4vgMx52jbkxWjaDBWnzrrk3lMLJ2w5JR/7xc/WuPMKL+FmO+2/10GhXV2T9
	 HWwYAshQAJxRuwKPhUE0IIJ7Ri0gF1QQE6Ds7C6We6X0nWiW76QSALLCLK2q6W4MUGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046782;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=Y0n9Pif+8prsy1OUgMVKboyTwqg4OezgtGdxHdvVZOA=;
	b=BYkCJHVBSD0bATwFcAw5QkWZs6k8f5julNUnH3WAGntc/HjkzYpC1J3UybU+JiqYU4lp
	 pWaLdRk/Y+eBlW1t/hy7hKA0dFQQXxKijeDGDpwzkUFNv2AM1yap/Yhzk3vIpIjI+kCo1
	 A58u2MD3Vsw91Rr4Q3YycTm5rlcrK2gOtcIayVmKdTPOheMNBrSkjSAQTarmvAZIPVh9l
	 AzvHm778jbivaEUNgQVQxVINBspOr78kc1WqeRtdQLFb0jVX01VkSMVTe2WusgSzU3fOX
	 U/fjHmIwJzevmQGnb+HpDXeaoL8o/kE2m/j0BM27I/lCbpOKtBToDrVu27vCYIQ0vsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vHyaIy2b;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1D606A31A;
	Mon, 26 Oct 2026 20:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9C1D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=vHyaIy2b
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 72D291C41A6;
	Mon, 26 Oct 2026 20:33:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 8F6912003A;
	Mon, 26 Oct 2026 20:32:58 +0000 (UTC)
Date: Mon, 26 Oct 2026 16:32:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 5/9] tracing/filters: Fix function event operand
 parsing in parse_pred()
Message-ID: <20261026163257.434af154@gandalf.local.home>
In-Reply-To: <179291747675.492959.6739928041718890503.stgit@devnote2>
References: <179291742944.492959.11659339795290028998.stgit@devnote2>
	<179291747675.492959.6739928041718890503.stgit@devnote2>
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
X-Stat-Signature: 87oj1x3swnehbiikzjp6ekfua33enjk5
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8F6912003A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+8HdPT26W0ZVuuJNgaLFCbK7trRttRxpI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Y0n9Pif+8prsy1OUgMVKboyTwqg4OezgtGdxHdvVZOA=; b=vHyaIy2bDWNeSBGKTpmm7+z0Gfc1OuKbbKCYuHPYubo6rxF6gc4BBgUF8MzusEPIce4JOoIjgUTKZear3GcYkTqHmSL9ROQzHU/i+xeutxIiIY681G3YwYoOlui4WDIZL7A8PLPGDpYoC3JqymizMNsnA/L3VIVkzB3KC3owo2o=
X-HE-Tag: 1793046778-132600
X-HE-Meta: U2FsdGVkX1/VI5Bj3IEqQoMFgpAlwlk5IfzmSap4b1hCrEcmjZ70ESJFtrRsiEdHfdpiAdUDI3I9IjdSviNOmv4BRsvhLXkDnNhh4buxZhfyWVBvo8KN15CHsyHwmBZX90UOAliKv/+rt6zcs8HBt0b4N9OT1u18Gh5B1IqTF8wkRVf4q0PZ/3LazfUu5XtoJkTMWApMHW0/gFrnJSQqtzp+Dpg0oxu6aaw+sBL3PINRFkYpQWpZIhofdyNxFdryxWkf9OYihpZ8Jt0ipn3Q3JJ6YpnHKbur1J3GUUdNKsj3ztIv983VjnTmUtvLNH1ZS5lKVBwwf9lLXKvOxs0GkNEjSG0aG8Ur3huQqYgXTmS7hXvzbIDPjA==

On Sun, 25 Oct 2026 17:37:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In parse_pred(), the ftrace_event_is_function(call) branch has several
> bugs when parsing the string operand:
> 
> 1. The loop 'for (i++; str[i]; i++)' unconditionally increments 'i' before
>    checking whether str[i] is the NUL terminator. When the operand is empty
>    (e.g. 'ip == '), this advances 'i' past the NUL terminator and reads
>    out-of-bounds memory until another zero byte is encountered.

Can't this part simply be fixed with:

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 5e74d2dae40a..6a14c964c115 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1733,6 +1733,11 @@ static int parse_pred(const char *str, void *data,
 	while (isspace(str[i]))
 		i++;
 
+	if (!str[i]) {
+		parse_error(pe, FILT_ERR_INVALID_FILTER, pos + i);
+		goto err_free;
+	}
+
 	s = i;
 
 	pred = kzalloc_obj(*pred);

> 
> 2. When the operand is quoted (q != 0), the loop breaks with str[i] at the
>    closing quote, but 'i' is never incremented past it (unlike the regular
>    string literal parser which does 'i++'). Furthermore, it does not check
>    for a missing closing quote (!str[i]). Returning 'i' at the closing
>    quote causes predicate_parse() to immediately re-invoke parse_pred() on
>    the closing quote and fail with FILT_ERR_TOO_MANY_PREDS.

This is a separate bug and needs to be a separate patch.

> 
> 3. If the operand length is 0 (e.g. 'ip == )' or 'ip == ""'), it accepts an
>    empty pattern instead of rejecting it with FILT_ERR_INVALID_VALUE.

Well, empty value ("") is actually valid. May be meaningless, but it's not
wrong.

> 
> 4. When the operand is unquoted (q == 0), stray quotes or '(' inside the
>    operand are consumed as part of the pattern, desynchronizing
>    parse_pred() from calc_stack().

This is a separate bug and needs to be a separate patch, although it may be
the same as #2 above.

-- Steve

> 
> Fix this by advancing 'i' and 's' past the opening quote before the loop,
> starting the loop at the current 'i' without a blind increment, checking
> for missing closing quotes, advancing 'i' past the closing quote, and
> rejecting empty operands or stray quotes/'(' in unquoted operands.
> 
> Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
