Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4837F001
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Oct 2026 03:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791345554; cv=none; b=BFs0NFtA4onotAbns3SkdC2khqIYWzIdtYz6+i8PX0ZMtQOmYLu/JglFkeAQmzSCWZuKmuGACiD3/cPn4/93ZP/PwDs9SJOWLYi7RSiZDZ3yH/ehFCiAJba04QMsH0j1CIpKQ9Gw6GPI5iUZb/RgJWBZ/TAHlh8Y4MV07n0chGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791345554; c=relaxed/simple;
	bh=dE6zj191P7kIAULoinqx1f3NJptp7nmBmJVPLlRZcvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=EkaFfx3l+a/vSGCePXcPRnEElsPkNx7ThyhngL7RPTIu0RIpf3WoqjMp1eXYKhwOymrhna/FAjNKvejEzj5YD2XD/3f+2TGlefEiPDL+8AVVq0is386eKF8x9jbZq4rYLTbTJwoUkCL9SpWCLEnYf1/cBBZjDq0gAiejfq6JB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa3wglG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa3wglG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401641F0089B;
	Wed,  7 Oct 2026 03:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791345553;
	bh=eKjIOdzXtiBYHRuWe1w39ylUdlk9A4SFVxPdn0IbdXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fa3wglG+vzcG7L7aBd5YFxEtTIrYWtJ/aeKfNse9v3y06IAVKzq+h/TU6YfLOSxVR
	 zrZY1Et0tSq+wRWnas3AR4MItyyghpZEi1SHz8QelFyVvr5YzUn4e5fH1vc/lzEYoF
	 VHRxzwWTarKUlldnsKAQfy7df/Mm+UnwYJYEVOo9Rj4AclmE12Fu/aSnJT9l2GE7TR
	 cD1Sp2s1DN+0NPqrL44mVbmSP2JZN1UsLv9KH31HmkzttOEuo1EJpSzTvx4bBXocoi
	 /PBXQV6qJuT5+O44051tAYDjvbiJA4/miylA4iKV7mvhhfDeIBpmsRXw7c0n9XOZd6
	 n1Ll89L4d1QFQ==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: Kyle Zeng <kylebot@openai.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/filters: Check perf permissions before resolving
 .function
Date: Wed, 07 Oct 2026 03:59:09 +0000
In-Reply-To: <sashiko-outbox-162502@kernel.org>
References:
 20261006225112.53503-1-kylebot@openai.com <sashiko-outbox-162502@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261007035912.401641F0089B@smtp.kernel.org>

On Tue, 06 Oct 2026 23:06:23 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:

> [Severity: High]
> This successfully prevents KASLR bypass via the .function suffix, but does
> it leave a similar memory disclosure oracle open for standard string matches
> on pointer fields?
>
> Later in parse_pred(), if the field is a pointer and the user omits the
> .ustring suffix, the predicate is assigned FILTER_PRED_FN_PCHAR without
> checking perf_allow_tracepoint():
>
> kernel/trace/trace_events_filter.c:parse_pred() {
>     ...
> 		if (ustring)
> 			pred->fn_num = FILTER_PRED_FN_PCHAR_USER;
> 		else
> 			pred->fn_num = FILTER_PRED_FN_PCHAR;
>     ...
> }
>
> Could an unprivileged user create a counting perf event without
> PERF_SAMPLE_RAW on a syscall tracepoint like sys_enter_openat (which is
> allowed because syscall tracepoints have the TRACE_EVENT_FL_CAP_ANY flag)?
>
> If they set a string wildcard filter (e.g., ~ "secret*") on a pointer field
> like filename, wouldn't the filter engine read from the user-controlled
> kernel_addr when evaluating FILTER_PRED_FN_PCHAR?
>
> kernel/trace/trace_events_filter.c:test_string() {
>     ...
> 	/* For safety, do not trust the string pointer */
> 	if (strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE) < 0)
> 		return NULL;
>     ...
> }
>
> If the kernel memory successfully matches the wildcard, the perf counter
> increments, which could allow an attacker to extract arbitrary kernel memory
> byte-by-byte.
>
> Should perf_allow_tracepoint() also be checked before assigning
> FILTER_PRED_FN_PCHAR to prevent this disclosure?

Ah, indeed. Kyle, can you update the patch according to this comment?

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
