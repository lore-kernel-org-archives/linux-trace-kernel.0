Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029071;
	b=mQt8pWjpLFXnjUfj5TK7a89wY4gTucKnaLZUFjBo6vYAaV9kGM3GW+tsufUIP575ciNX
	 +jEfd98eQKLbYzh1NF5IunsT7P6+lTEq5QfM1VOHy+EaaCowlChjI4EZffwtkXvEmpDxM
	 iha5LM5NtL/ymUjxtDAxYvp45vWb3oraFRI2KZ5kJIWgDtA6l2VeMaMwKjy93W6acB4YU
	 zB0HVjCAKSOBS4HZ6wqK6CAMdYv3n1xIXEc+vk4ubLsQcivVmTSQrKf/fFBcz+Qv6k7lv
	 Vb7YDnoaVu5JYGuiEYnxpZuiOlg/R5clNSX6lVk3eDh+i9o/8Geo/pMbydHyxsxvjUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AlEfw0KnnnKeOGuKhIjsydPMLj3rMy80oPafK21417A=;
	b=GNZx3+76KOrpp7gpDGjCCFMKF9rQgqduL/axHeOSysXreKjrBzXSTCCtzBdbq9O82bJ+
	 FtMjtpAEL3mIP3YGZ5M9CbjGLCs+EoaRLUwkBif+cuFwbSNXJOFp9g0seXeAwFxMXhgVf
	 3JuN0BvGtVWTVJeR5MtdGu+XOy3F5K0XWFfsInlfOXyi4MmDvxSr1f2vacL0ICf2OrSKS
	 oe824LaArMbT2Uq/1NBGEIUc6gUAXauEvNmtju7jm8wGdrSo5kO2eyuJAAKixJIZ7Zok8
	 J2yMG58jxdd+nMIrP5HN78P8bvbYJ8t8gWog4FpmXKnfSH1Hs64kVq95D3BqZulKX8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRYEkbzI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CABE606A31A;
	Mon, 26 Oct 2026 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRYEkbzI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A561B1F031E7;
	Mon, 26 Oct 2026 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029070;
	bh=AlEfw0KnnnKeOGuKhIjsydPMLj3rMy80oPafK21417A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aRYEkbzIjC0hd1TndRRHR4lM7VbZ0Q5QCANjMJ6oBgumR1bl6mxOap6fZ9YpmiY9n
	 7y7CCepF5dqMevsqA4fkpg4QPPNkyB1zSjUZR2m1voxHlUsOrRbeH0rtwg4pdKLVxm
	 4y24uEBW7z8v1gHxNrCX2NJU5k/AxP2qOOUMEXF2s/tqyfF/nc34j9v2jtPhEI9kbx
	 X/PilGZ6HUaUWcDOPcDZCFwqn2wjxZnYYLht2T25tYDeVPiLdPIBvGZjGuXaqauY5M
	 35xqztCmdKIoVZZ1olBPWOtUB/ljeqSXaAcC4NnRrgPxumJ+YqkdaSxMxtbXrThZI4
	 vCKG9/hbAmTuQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/10] tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
Date: Tue, 27 Oct 2026 00:37:47 +0900
Message-ID: <undine-1793029067840938152-7968d068467a5db1@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261026095441.6a1a7357@gandalf.local.home>
References: <179285912318.466249.7425922682086130057.stgit@devnote2> <179285913336.466249.16045710288666912574.stgit@devnote2> <20261026095441.6a1a7357@gandalf.local.home>
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

On Mon, 26 Oct 2026 09:54:41 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sun, 25 Oct 2026 01:25:33 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > regex_match_end() calculated string length as "len - 1", assuming @len is
> > the string length including trailing '\0'. However, for fixed-size string
> > fields, filter_pred_string() passes field->size as @len, and for "comm",
> > filter_pred_comm() passes TASK_COMM_LEN as @len.
> > 
> > Because @len in these cases represents the buffer capacity rather than the
> > actual length of the string, regex_match_end() tests against the tail of
> > the buffer (typically trailing '\0' padding) rather than the end of the
> > string. Furthermore, if @len is 0 (denoting a dynamic string ending with
> > '\0'), "len - 1" underflows to -1 and never matches.
> > 
> > Compute the actual string length using strnlen(str, len) when @len is
> > non-zero, and strlen(str) when @len is zero.
> > 
> > Fixes: a3291c14ecf0 ("tracing/filters: Fix MATCH_END_ONLY filter matching")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_events_filter.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index 5e74d2dae40a..18ce3ec00d34 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -1075,10 +1075,10 @@ static int regex_match_middle(char *str, struct regex *r, int len)
> >  
> >  static int regex_match_end(char *str, struct regex *r, int len)
> >  {
> > -	int strlen = len - 1;
> > +	int slen = len ? strnlen(str, len) : strlen(str);
> >  
> > -	if (strlen >= r->len &&
> > -	    memcmp(str + strlen - r->len, r->pattern, r->len) == 0)
> > +	if (slen >= r->len &&
> > +	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
> >  		return 1;
> 
> This slows down the code as it adds more strlen() calculations (it could
> have already been done.

I sent v2 already, which is slightly lighter (but still using strnlen)

https://lore.kernel.org/all/179291743946.492959.9624495647021680807.stgit@devnote2/

(anyway, 3/10 is already fixed as Sashiko mentioned.)

> 
> Let's fix the callers instead and have them pass in the real length.

OK, let me check it.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
