Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792861330;
	b=WP6wdQVbP8yBuVZwtD5wNzO3Are3V33C/zCVi0qGuKonswRTsLG9OV6PSsrC5J4CbBsq
	 EGtu718K+uK+GeGlAjrT1fgtomHArI8WNtmBvCDAo9bL6Y2NRqtr9DTfgEQk2vEwCTA6K
	 C8UOr4HAqlGiv1AiYHv2/lq3eCGE9IbqVgTo9XfFiEISIB0V/AGx69bZnR5PDI/qSUlIr
	 VqzD5W6Vi8R5bKF4Khow3EuNLcWi3T1oqVqRr1425LEmQMId+vVzV93V6GPCC+VzUg/KG
	 LNIu/VO+5bED5Grs1o6WUfCe+1/NMcLOJt2LilW70fjoR6eBJRND61cJPb03d6/in3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792861330;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZN1q3OpdTtkTl6lYtgdJLI+u3Y9AmSjTt6a8RY1Dyp8=;
	b=InBuzUMZX/VCutJDeXXsjM8qLmBqhj56kSXkaDEUu83ToBdmL7YWx0bPcG0/551eccna
	 /QXWPTHxDW3NAHvI+FVEozSgjHOEGglhfc6h7Vrekpzfa9G/ALzvsP+pWBxp/9APu/SLp
	 7vvv/cQtLZeCH7KY5B5VAB4eonk9eJsccWY54uG4rVFjoJ8laZ7RcnO+kFpDYHpbJe7+d
	 p7y4wSPDRyos2jsf5+TdFJwzRk94VGwTeS/JIbd+zsWWF58q4+9DW+fu5JHvVKa4vIE6Q
	 pu5qZQ4nKN1ZYG9RQBFrrXCCS+3vW7g6zTX91n/YtvTgcyaTnoqbSDxuFCADkM+S0UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxMppTqd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05483606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxMppTqd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778CB1F01825;
	Sat, 24 Oct 2026 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792861329;
	bh=ZN1q3OpdTtkTl6lYtgdJLI+u3Y9AmSjTt6a8RY1Dyp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FxMppTqdejM2+nLgHHVmG1lrW4qT7ZWvXKPKtUevDsMjV2ZGE2C2kOuL76cBmwhXK
	 fnsYwNCMhXm7tA3MUO6DTQJ5Rfz/GZ9PFHxJ9HYN0SSoCCqYZ4Y1ml2xCgqvHRckLH
	 tQ08eZq0SUEddwEsGjIQq+Pq7dEDEUedzghIvzbjLY16FnHXPy/mJcir6O3FlpaoMo
	 T/Oauq3TKdmh/WsCOamnJNeYA59buHuMk7tl3xRVfbLiDxzc8J5sJJH/EV+Gfp7Pff
	 PRVGRH5kzbM34zZ76oMCgkLn1IW/qTZSxbbP/h9qBFCwSBaV9xwAmzea2tncEJWJrB
	 XaqUxxoMQfFDQ==
Message-ID: <sashiko-outbox-183814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] tracing/filters: Fix MATCH_END_ONLY regex
 matching for fixed-size strings
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179285913336.466249.16045710288666912574.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
 <179285913336.466249.16045710288666912574.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 17:02:09 +0000
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
- [High] tracing/filters: out-of-bounds read in regex_match_end() when len =
is 0
--

commit 1023475f1fd5bcb5e8b46a2be2fb9fe7ea16d624
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings

This commit updates regex_match_end() to compute string length via strnlen()
when len is non-zero and strlen() when len is zero, fixing suffix filter
matching on fixed-size and dynamic string fields.

> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_even=
ts_filter.c
> index 5e74d2dae40a3..18ce3ec00d34f 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1075,10 +1075,10 @@ static int regex_match_middle(char *str, struct r=
egex *r, int len)
> =20
>  static int regex_match_end(char *str, struct regex *r, int len)
>  {
> -	int strlen =3D len - 1;
> +	int slen =3D len ? strnlen(str, len) : strlen(str);

[Severity: High]
Can calling strlen(str) when len =3D=3D 0 cause an out-of-bounds read past =
the
end of the trace event record?

While filter_pred_string() passes pred->regex->field_len =3D=3D 0 for
NUL-terminated dynamic strings, regex_match_end() is also called by
filter_pred_strloc() and filter_pred_strrelloc(), where len is the runtime
byte length extracted from the locator:

kernel/trace/trace_events_filter.c:filter_pred_strloc() {
	u32 str_item =3D *(u32 *)(event + pred->offset);
	int str_loc =3D str_item & 0xffff;
	int str_len =3D str_item >> 16;
	char *addr =3D (char *)(event + str_loc);
	int cmp, match;

	cmp =3D pred->regex->match(addr, pred->regex, str_len);
}

When a dynamic char array has a runtime length of 0, str_len is 0 and addr
points to the end of the event or uninitialized trailing memory without a
NUL terminator.

For example, in fs/xfs/xfs_trace.h, xfs_da_class defines a dynamic char arr=
ay
that isclassified as FILTER_DYN_STRING, and when xfs_dir_init() ->
xfs_dir2_sf_create() runs with args->namelen =3D=3D 0, 0 bytes are reserved=
 and
nothing is written:

	__dynamic_array(char, name, args->namelen)
...
	TP_fast_assign(
		__entry->dev =3D VFS_I(args->dp)->i_sb->s_dev;
		__entry->ino =3D I_INO(args->dp);
		if (args->namelen)
			memcpy(__get_str(name), args->name, args->namelen);

Similarly, in kernel/trace/trace_events_user.c, user_event_validate() allows
a user_events string locator with size =3D=3D 0 and pos =3D=3D end as long =
as the
preceding byte *(char *)(end - 1) is '\0':

		pos +=3D size;

		if (unlikely(pos > end))
			return -EFAULT;

		if (likely(validator->flags & VALIDATOR_ENSURE_NULL))
			if (unlikely(*(char *)(pos - 1) !=3D '\0'))
				return -EFAULT;

In both cases, evaluating a MATCH_END_ONLY filter calls regex_match_end()
with len =3D=3D 0 and str pointing at or past the end of the event buffer, =
where
strlen(str) and memcmp() will read out of bounds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179285912318.466249=
.7425922682086130057.stgit@devnote2?part=3D1
