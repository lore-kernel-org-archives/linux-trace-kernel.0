Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149519;
	b=Ij5aJMW+8VnKK1CGED1uGTgK4bwhanJS4NIVYTQ/5D4dVLgWrjysBqWHuUydNgZG55g6
	 ER2Abu04YcsztV8WLbpcvne3qUpBDKHTDPIcUrqbY19wAftsp4p4nqjt+koSIgo1AB7v0
	 0+bwwHwjPsx4kLle48jHylKZKSYWoAh/eEUOhbUbnIa4FpPT7+NCbOFc2E1pnYuKqrZpA
	 B5pIFdiH3BK8vuegbTY4POPacjgN0kGz+fQWwmvaf7tvcEWGyfsbZmYQe3jFEQphy6qFd
	 Rhcjee184ahiX3whsQ8dX5XR+XHENbYQ8RqRwFuXipBdVq+PIqrWA8x5ZmMiveNNFRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149519;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=szoEDWTwAfJgUM/XjAfJzEfU2Hrm2J3J757AHXdl3Es=;
	b=1+n/OXwlJuCkzFOb0+Nn73sbyLOVVXZA3oX0VhDPAZalTafUBjCJRkdkVd21jTjmmMMV
	 41Jts2V0AZKm7C6KA5jhDYgKMcDVfYtT/tBkVGsNctvtI9p0RegVsBzdEx1LGyk57HFhs
	 8huV/BryGb3b4tNSaue1QWkPpfDopFpu1+I/LdH22SVrW2fF6oWG+vlj5vheDz6dq/Eg4
	 iCDUmW1rAmgp2hu+4+Cg0Exz1ukXrolkLj7VQSQVyhjkU+koNMpnwPCdjidVK70v+j0Zs
	 JhaGz7HMJHpIROsAlxtUybBNsPzKyHfhqoxZlhMsqaN8kyULQes0moQDxLmjBXo59ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZhHMAfk/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91388606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhHMAfk/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401401F01828;
	Wed, 28 Oct 2026 01:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149519;
	bh=szoEDWTwAfJgUM/XjAfJzEfU2Hrm2J3J757AHXdl3Es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZhHMAfk/d3Gy5ezVuoJwyVvZJlAGJ+Ir5Gtuxe9/hDFoozmQUlw4zg0Ur12/mb37e
	 5APoI8j3Ra8d19gxT0xHiOdgwZehVUOR9qcWpCyXXxVYVdi2D5VocVf6+frTin4HEx
	 DbN8g3UJsZlFZMmseI/u+GzuVhJ2k0TCwrxWm77YkH0PVVnaITDHkhtn3SoeNCsbGA
	 881Oj4G3ujcQNccb6OAfIvPOLoJQcyeTXXHBM43SIIKhpSR2O856ENRwGSxMCnqy3a
	 +DYGINwlwS8drvVHmb6hill5LpT9K+F/uvMdlJXvt9InZX0nBXTQfyz9OmZ++ZfEYZ
	 G14v6pbGfd4vQ==
Message-ID: <sashiko-outbox-187301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/16] tracing/filters: Fix MATCH_END_ONLY regex
 matching for fixed-size strings
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179314822364.684037.9099512445135198750.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
 <179314822364.684037.9099512445135198750.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:05:18 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tracing/filters: unhandled zero len in regex_match_end_str()
--

commit 92251abf42afdb93bef9298fec46088f078a4aa8
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings

This commit introduces regex_match_end_str() to handle suffix regex matching
on fixed-size string buffers using strnlen(), and assigns it in parse_pred()
for comm and static string fields.

> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_even=
ts_filter.c
> index 59a0d3ba72740..f7c067a58ba41 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1087,6 +1087,20 @@ static int regex_match_end(char *str, struct regex=
 *r, int len)
>  	return 0;
>  }
> =20
> +static int regex_match_end_str(char *str, struct regex *r, int len)
> +{
> +	int slen;
> +
> +	if (len < r->len)
> +		return 0;
> +
> +	slen =3D strnlen(str, len);
> +	if (slen >=3D r->len &&
> +	    memcmp(str + slen - r->len, r->pattern, r->len) =3D=3D 0)
> +		return 1;
> +	return 0;
> +}

[Severity: Medium]
How does regex_match_end_str() behave when len is 0?

For the ftrace/print event, the buf field is defined in
kernel/trace/trace_export.c with a size of 0:

#undef __dynamic_array
#define __dynamic_array(_type, _item) {					\
	.type =3D #_type "[]", .name =3D #_item,				\
	.size =3D 0, .align =3D __alignof__(_type),				\
	is_signed_type(_type), .filter_type =3D FILTER_OTHER },

Because its type is "char[]", filter_assign_type() classifies it as a static
string field while field->size remains 0. In parse_pred(),
pred->regex->field_len is set to field->size (0) and pred->regex->match is
set to regex_match_end_str():

		} else if (field->filter_type =3D=3D FILTER_STATIC_STRING) {
			pred->fn_num =3D FILTER_PRED_FN_STRING;
			pred->regex->field_len =3D field->size;
			if (pred->regex->match =3D=3D regex_match_end)
				pred->regex->match =3D regex_match_end_str;

When a trigger or eprobe with a suffix filter (such as buf ~ "*foo") is
evaluated via write_marker_to_buffer() -> event_triggers_call() ->
filter_match_preds() -> filter_pred_string(), regex_match_end_str() is call=
ed
with len =3D=3D 0.

As noted in the comment above regex_match_full() (added in commit
10f20e9f9da9 ("tracing: Have zero size length in filter logic be full
string")), a len of zero indicates that str is a NUL-terminated string, whi=
ch
regex_match_full(), regex_match_front(), and regex_match_middle() handle
explicitly:

static int regex_match_full(char *str, struct regex *r, int len)
{
	/* len of zero means str is dynamic and ends with '\0' */
	if (!len)
		return strcmp(str, r->pattern) =3D=3D 0;

In regex_match_end_str(), however, when len is 0, the (len < r->len) check
returns 0 for any non-empty pattern, and strnlen(str, 0) also returns 0.

Should regex_match_end_str() check for !len and use strlen(str) in that cas=
e,
so that suffix filters on ftrace/print work as expected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179314820431.684037=
.4147763044424284198.stgit@devnote2?part=3D2
