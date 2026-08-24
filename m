Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCFF30EF77
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556456; cv=none; b=HnIbUB2S1U/pSrjuKRWHaYFrZ7nUYDKr0KAr8o7kf63/gCI4tWQgwBjLPznmb9bCududbx8wg8UodJchsU2/i3zyByr99JAAhOe7GHqR+z1aZQhbW2oy7L+Gjpz3FrL4Wk4Kfdpe9UooIe77WSg0YIh2wXKjrn+h5Wv1Kk4iP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556456; c=relaxed/simple;
	bh=hB8U2CbWl2HpbjkCLOSjJQ6wrxls4ux9C7HC1LRoDEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eUCJb9jyCayF5mX7OIR0xQ7RufqVY6V16oqbIUkEBJVVQBFqDsuUXJnmTCEQZL+nT57HrjO/MUWxh7K7s8/o6Zfy7pHVkdim0FKcoUvSYESdSkUc0b3HQYvPW0PUFjIl+JS9EyNcwfnNL3CNjqx7O+cktcvXBlth4hf+ztHLAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8dcBvYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8dcBvYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE431F000E9;
	Mon, 24 Aug 2026 07:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787556455;
	bh=ZGtgoye9FTVnElDzC3v9MMqb096BsRsAyNC5pcRjhZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d8dcBvYi0gqJ3DpsCTGKmi6PsjPUZC5WOYFzfMe0s67QmAPWCjFKscbjEEoLCTdSO
	 vqObWp2RiAbIC+r4dyH5VD2RLggZhCTpe5MhGxTSu10asLuGLY6HJeZQhelfVvktrS
	 1n/bypP7j8hqO9F+yhENgJX/glrtV+Vbk2BeduPTmLmqx3iP9GBMqO9bVw71jzl+1p
	 eTsEot10bV4HJm2RADJO7npW57e1XfS9Wfv9KLkw6FCNspo16VXIrGiZMM+Zfl7KCu
	 1qBl2xvcTBcDVsVnqjvkxngdigpEvHI4LKkBb/iDWsQXB3G84ZsZq+82Ff1Ql6ZR1W
	 k3RyvyzolXwKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Fix use-after-free on field name/type of
 dynamic probe events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Henry Martin" <bsdhenrymartin@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260824071011.3507735-1-bsdhenrymartin@gmail.com>
References: <20260824071011.3507735-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 07:27:34 +0000
Message-Id: <20260824072735.2BE431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message claims that fields of static trace events ref=
erence their kernel or module rodata string literals directly without alloc=
ation, but module strings are unconditionally duplicated.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but if a user_event'=
s destruction fails because the trace event is busy, its fields are irrever=
sibly destroyed, leaving the active event in a corrupted state.
--

--- Patch [1]: [PATCH] tracing: Fix use-after-free on field name/type of dy=
namic probe events ---
commit cf6ec74d4b06c238fc3f0cc0f2463ea2e1435590
Author: Henry Martin <bsdhenrymartin@gmail.com>

tracing: Fix use-after-free on field name/type of dynamic probe events

This commit modifies dynamic event trace field registration to duplicate
field name and type strings using kstrdup_const(). This ensures the field
owns its strings and prevents use-after-free bugs when primary probes are
deleted but event calls remain active.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 0356cae0cf74e..13d7675bc5132 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -122,8 +122,18 @@ static int __trace_define_field(struct list_head *he=
ad, const char *type,
>  	if (!field)
>  		return -ENOMEM;
> =20
> -	field->name =3D name;
> -	field->type =3D type;
> +	field->name =3D kstrdup_const(name, GFP_TRACE);
> +	if (!field->name) {
> +		kmem_cache_free(field_cachep, field);
> +		return -ENOMEM;
> +	}
> +
> +	field->type =3D kstrdup_const(type, GFP_TRACE);

[Severity: Medium]
The commit message states that fields of static trace events reference their
kernel or module rodata string literals directly, as kstrdup_const() only
touches allocated memory.

Does kstrdup_const() actually handle module rodata this way? Looking at
kstrdup_const(), it delegates to is_kernel_rodata(), which only checks core
kernel boundaries.=20

Won't this cause module trace events to unconditionally duplicate their name
and type strings instead of referencing the module rodata?

> +	if (!field->type) {
> +		kfree_const(field->name);
> +		kmem_cache_free(field_cachep, field);
> +		return -ENOMEM;
> +	}
> =20
>  	if (filter_type =3D=3D FILTER_OTHER)

[ ... ]

While reviewing the string lifecycle in trace events, a related preexisting
issue in user events was identified:

kernel/trace/trace_events_user.c:destroy_user_event() {
        ...
        /* Must destroy fields before call removal */
        user_event_destroy_fields(user);

        ret =3D user_event_set_call_visible(user, false);

        if (ret)
                return ret;
        ...
}

[Severity: High]
This isn't a bug introduced by this patch, but if a user_event's destruction
fails because the trace event is busy (user_event_set_call_visible() returns
-EBUSY), the event's fields are already irreversibly destroyed.

Will this leave the active event in a corrupted state, where any subsequent
interactions with this event operate on an empty field list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824071011.3507=
735-1-bsdhenrymartin@gmail.com?part=3D1
