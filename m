Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793151397;
	b=grPDUNOr02bPRrFezxUWWKXRqUCf/cVmgPztJH56pCFgRhjLaeOHZG7/xani0iP64iSC
	 ABmGwx09FoldqCbx4/wDqzBXq14pcvYv7o7OCdy1JQHEDBSPwReQ3rUJuwEESU2RAMLZE
	 M38zlfXJPOgMsQywrBH16zTPtPa5eqTAWiPO+4kocAIZg3AP6WTDnkxcZwjUk9bdWPhTu
	 S/pLq1/+zF40/KvEBanWZoVZ1VO+YAsVcM5IAN5q+CtYdyaFdha91OLYgC9zOzqYhc18L
	 SV86SD1TUZDG2ohhqf7EWUNS975NrX5P/R9CKaGjJ/hg+NZYfq5Du4lPPPk+z/Afz0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151397;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5D7stKc56HS9FFceJOHD+aSTvyyeXeTrf5re3Zvqxu8=;
	b=WOyA7w3P4/kdfUpkxRjigIZKUyFK7VPTbv6yz93WrrcRiQn9X61SYwgnYO0eNIDgu2cs
	 BcXSlblslhmkhuFF9QPGdPZHZSXh4zaHBnrdDiHj0FLCxS6x0oc9ceq8p71zr7jUqDDti
	 l68gQ/36qUv/LxFDTJrzbqHbLwsxxGkycyO9FCAr+i1Hecb0AEbi8lHyyd9rcI4DAiRup
	 f5+QbjpTzIXrin6l+fUsGOYPCcXoI7AV4v+XoXhKaMHK6B/xR+mQOqIEQQhGDGUaLHCjE
	 7bUoniyyyU2ElVN1unIoDLt9pRtvvj5uDCft0ySmN1QRTVRsOHGpI+KAh4aTqxBnwDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J9yXC/Pt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27A606A31A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9yXC/Pt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84A91F01825;
	Wed, 28 Oct 2026 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793151396;
	bh=5D7stKc56HS9FFceJOHD+aSTvyyeXeTrf5re3Zvqxu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J9yXC/PtXFCjVrYduyIdopJiOcwfqYjxqtPrdVtuvRMgCMwkQn77UyT0VZYQDmEfd
	 r2sKR7ZQgIQbploC0nGh36apc/vY22nUcYdywdH1tpFteWkGdutItRNmWJOpoOhXJL
	 wY2XfJk13IWh/Q8QwoX6GYswMgZ+Lc7nXFCPXYmyjB6IKWi+uIcGEaXGdnOtVp5Ie4
	 i2dOpTUo6e+ryJmvE0WG9CfyEo30OMK8h+3Ueofmj8nSAYButecTlmRZDPqocrFGIh
	 3wEAMhh0u4ZgTawqxcey0DDxcS6kRhagKx6dC11KjMEHNL0FCPdAf/3J72J7ty9KHa
	 kWO3FyXsFNh7A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/16] tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
Date: Wed, 28 Oct 2026 10:36:34 +0900
Message-ID: <undine-1793151394494774416-9d9d9da0ddabc611@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-187301@kernel.org>
References: <179314820431.684037.4147763044424284198.stgit@devnote2> <179314822364.684037.9099512445135198750.stgit@devnote2> <sashiko-outbox-187301@kernel.org>
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

On Wed, 28 Oct 2026 01:05:18 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] tracing/filters: unhandled zero len in regex_match_end_str()
> --
> 
> commit 92251abf42afdb93bef9298fec46088f078a4aa8
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
> 
> This commit introduces regex_match_end_str() to handle suffix regex matching
> on fixed-size string buffers using strnlen(), and assigns it in parse_pred()
> for comm and static string fields.
> 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index 59a0d3ba72740..f7c067a58ba41 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -1087,6 +1087,20 @@ static int regex_match_end(char *str, struct regex *r, int len)
> >  	return 0;
> >  }
> >  
> > +static int regex_match_end_str(char *str, struct regex *r, int len)
> > +{
> > +	int slen;
> > +
> > +	if (len < r->len)
> > +		return 0;
> > +
> > +	slen = strnlen(str, len);
> > +	if (slen >= r->len &&
> > +	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
> > +		return 1;
> > +	return 0;
> > +}
> 
> [Severity: Medium]
> How does regex_match_end_str() behave when len is 0?
> 
> For the ftrace/print event, the buf field is defined in
> kernel/trace/trace_export.c with a size of 0:
> 
> #undef __dynamic_array
> #define __dynamic_array(_type, _item) {					\
> 	.type = #_type "[]", .name = #_item,				\
> 	.size = 0, .align = __alignof__(_type),				\
> 	is_signed_type(_type), .filter_type = FILTER_OTHER },
> 
> Because its type is "char[]", filter_assign_type() classifies it as a static
> string field while field->size remains 0. In parse_pred(),
> pred->regex->field_len is set to field->size (0) and pred->regex->match is
> set to regex_match_end_str():
> 
> 		} else if (field->filter_type == FILTER_STATIC_STRING) {
> 			pred->fn_num = FILTER_PRED_FN_STRING;
> 			pred->regex->field_len = field->size;
> 			if (pred->regex->match == regex_match_end)
> 				pred->regex->match = regex_match_end_str;
> 
> When a trigger or eprobe with a suffix filter (such as buf ~ "*foo") is
> evaluated via write_marker_to_buffer() -> event_triggers_call() ->
> filter_match_preds() -> filter_pred_string(), regex_match_end_str() is called
> with len == 0.

Good catch... this may be yet another issue.

I think we need another different set of matching functions for dynamic
string. Sharing it with static string (where len = 0 means zero length)
and dynamic string (where len = 0 means variable length string) is
a bad idea.

> 
> As noted in the comment above regex_match_full() (added in commit
> 10f20e9f9da9 ("tracing: Have zero size length in filter logic be full
> string")), a len of zero indicates that str is a NUL-terminated string, which
> regex_match_full(), regex_match_front(), and regex_match_middle() handle
> explicitly:
> 
> static int regex_match_full(char *str, struct regex *r, int len)
> {
> 	/* len of zero means str is dynamic and ends with '\0' */
> 	if (!len)
> 		return strcmp(str, r->pattern) == 0;
> 
> In regex_match_end_str(), however, when len is 0, the (len < r->len) check
> returns 0 for any non-empty pattern, and strnlen(str, 0) also returns 0.
> 
> Should regex_match_end_str() check for !len and use strlen(str) in that case,
> so that suffix filters on ftrace/print work as expected?

I rather like to have regex_match_end_dynstr() in this case.

Anyway, we should have a unit test for filters.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
