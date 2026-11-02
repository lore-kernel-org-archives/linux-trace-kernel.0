Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621451;
	b=dvwXYy2ovmRol66dbey5Xb4JOhYxiN+OUCVIKh8CQnER+o5q10vv0zsy20N9emP2D9fh
	 LtrznGkc7xQeX6TtcoBKXswmiIgO8alWL5z7ySgwZEJt0lznpCmD5CtQlw+9lVeKn9iRs
	 4EBGdbe9HlTRRFGvmd3WWTW/Nei+tFyb/H/4AxHOYQaMAfzL+fldGMEotuxKi1XqZyiSA
	 HjK1qJF+oFHa3sj7PGZnylfjj9/khVjxiXRRvoASxnVWGYy9kwvq9Su3TcngahQDSM/zH
	 Y02zMmifpuCAu+5WZ67Gk5WCcqLugBxGoFiLJj1z8jNirtQreU6XLwyie3FVl9wZN/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zHhnSfmCxi4LPlup55E2DgppTfqzi+1MwMcIeSt1IiQ=;
	b=4XeFNtY5qAj3yurj4gAvxdi+1eqMEW8+ooql5SpZbQqPB2g8FmRIP3a62LENFu//PBvv
	 W10WG19c57tT+PeOro3L8JOqVPYHCtcyUd7thST4aubHvSoweJtzKV+VnH/X119Jo1Ws6
	 BjPP4kx1kEUkBVoPBzDCvtWrJ4dnIJlAiOFDlbD9PsUBN/XI2qfZgg1plUIUV0X8f1lhE
	 SN9KYhNj4l1XC29qXe7jYZrSMPpfc0ijOKMmfjbpIB/DjFmnJhlGP7crICXrxB7qfXRkQ
	 xSQ+W277oTzHlGHMd1HmtlFoLKpqaFArR8gCXuGlVNmj3XT8/BzPoREhERlISfouYVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IziYnIaL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847C606A324
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Nov 2026 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IziYnIaL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFC71F00A17;
	Mon,  2 Nov 2026 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621450;
	bh=zHhnSfmCxi4LPlup55E2DgppTfqzi+1MwMcIeSt1IiQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IziYnIaLUjTvvIiVOAmetkuteMR0XBLe3+Du9i5wW2DTCAHYtBh+6wPt69SqSpN4f
	 LUlSlrggf2oAbUDOIS0nXJwZTrqZpNRf+XCT5Oeu7OI1cW4o7CMp7QqZDRO0Ohewbr
	 qmA0Fcz9sOlY3p7yc/YFdWJJS+6iw0TUsTGx8dgCTVZG3bIO9zso8IkCSC9G6uoxeV
	 xETs6ac/kbDPj/1EHPxw01khlBjkvzOmMbpbzl5ObUDnOgNRRyk8AffAj8sQ1pIwrb
	 oYDTTLFckrjUf7rgea+hmwYZjmDAwoY/houd1Brt1AlyyTpdcDivMZv4dKvSAGocjt
	 K+M9q5FyDdEYg==
Message-ID: <sashiko-outbox-193372@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tracing/user_events: reject overflowing field
 offsets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Zhang" <yfzhang23@stu.pku.edu.cn>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179362071771.29269.8333068920166316746@stu.pku.edu.cn>
References: <179362071771.29269.15129360535376085397@stu.pku.edu.cn>
 <179362071771.29269.8333068920166316746@stu.pku.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:10:49 +0000
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
- [High] tracing/user_events: u32 struct size wrap in user_event_parse_fiel=
d()
--

commit 3b2945a002d22d5a8a1ae3cae8f4c9ec6c460511
Author: Yifan Zhang <yfzhang23@stu.pku.edu.cn>

tracing/user_events: reject overflowing field offsets

This patch adds an overflow check in user_event_parse_field() to reject fie=
ld
offsets that overflow a u32 or exceed INT_MAX when registering a user event.

> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events=
_user.c
> index 85938b45b7618..88d384c9e101f 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1207,6 +1207,7 @@ static int user_event_parse_field(char *field, stru=
ct user_event *user,
>  {
>  	char *part, *type, *name;
>  	u32 depth =3D 0, saved_offset =3D *offset;
> +	u32 new_offset;
>  	int len, size =3D -EINVAL;
>  	bool is_struct =3D false;
> =20
> @@ -1287,7 +1288,11 @@ static int user_event_parse_field(char *field, str=
uct user_event *user,
>  	if (size < 0)
>  		return size;
> =20
> -	*offset =3D saved_offset + size;
> +	if (check_add_overflow(saved_offset, (u32)size, &new_offset) ||
> +	    new_offset > INT_MAX)
> +		return -E2BIG;

[Severity: High]
What happens when a user supplies a struct field size between INT_MAX + 1 a=
nd
U32_MAX?

Earlier in user_event_parse_field(), the struct size is parsed into the sig=
ned
int variable size via kstrtou32():

	case FIELD_DEPTH_SIZE:
		if (!is_struct)
			return -EINVAL;

		if (kstrtou32(part, 10, &size))
			return -EINVAL;
		break;

When part is in [2147483648, 4294967295], kstrtou32() succeeds and writes a
value into size that is negative when interpreted as a signed int. The
preceding check:

	if (size < 0)
		return size;

then returns that user-controlled negative integer directly instead of
reaching the new overflow check.

When reached through user_events_ioctl() -> user_events_ioctl_reg() ->
user_event_parse_cmd() -> user_event_parse() -> user_event_parse_fields() ->
user_event_parse_field(), or through create_dyn_event() ->
user_event_create(), could this return arbitrary negative values (including
kernel-internal restart codes like -ERESTARTSYS, values outside [-MAX_ERRNO,
-1], or -ECANCELED) to the caller? Also, since both saved_offset and size a=
re
bounded to INT_MAX after the size < 0 check, can check_add_overflow() ever
trigger here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179362071771.29269.=
15129360535376085397@stu.pku.edu.cn?part=3D2
