Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238354;
	b=pBmSiP8+18UbQNtCl18iDWYm06A0J9/66+avu00SMWT97VNdrqZD4ajI9lTufAQ/PeTz
	 Kqv9F7yu/9MoCossSScIjg+1LeEU9+GQlNkA3aZt8pmUMSBoPmbdUo4PQ1S69w+J5m1pp
	 B+5hz9OBrMc6gYgMwnNT64G67OugHyLta8SkC7H6G+s2gj38zAOXEb0D6SHPE/ForFpTc
	 sDsEIwjH6KmIhjZpD1LJ6bBCSTmI3LJOTO5GDmihVDrIVnXLGbyEwF9Yi12dIsRk+midO
	 eyjhyFbXOXiqEcETHdMO/12IrnmJytnR8Z1w5vGmpaEI1/jyvlC43C8v4EhK/BVUYNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238354;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=caRfaUuoFZqEHx5LHXdDO9Dj6w/upOzu07kckMhttfA=;
	b=Y9HpCRD08MzzZ8iLPYVqWxyBD1cSGUHAlFWtIYx8kb/elPD52SNUXv5ssQJhIpsyyGo9
	 Dr7GOtVKXquM74aTwYZ/AGvL1bEYsTbp+WPYwNrLSS194GoqDtBQYCwH3TdNZ7LhmG7l2
	 YS9ooU7eiiCttVJmYk7bL+N79pj45iXLoe8Q9NSX30awBuprkvxhcm3zvV4Z7M6NU7hLK
	 GyI/pubij4mUegrgmZIq6evolmD5XaAYwnzNlXmAUDkmty9Lxqz0r7oU2rGtvE8w4hJe+
	 PIUHDDqAYrUgQv2tAgpJLYJWgbrHQASlCJ99BNbaKbszyU2JoTKhQZ3hpmbBNn3O9dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFQUC1PK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68680606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gFQUC1PK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4EF1F01825;
	Thu, 29 Oct 2026 01:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793238353;
	bh=caRfaUuoFZqEHx5LHXdDO9Dj6w/upOzu07kckMhttfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gFQUC1PK8csizjwos8hK5GznjYhLbPWHC8KHFL17V4b+sdb3JatAhrubzGHHBKTnF
	 e8Ow8uznzH7Wfh+drZ7veUtfGHU/xVvowp8IU4txn70u0ktQLr+7YKY9+5y2UBPAl/
	 nxZr3mJFrZRk5zYjoMYfFT0Uv10Ipz1kQ4SAHVyAjy10FaCxI+GqSe1br6zBV0nk0M
	 /PgUiDIBpAxbzGisA82R4lTWUJAUG9/XCp1sZ6AX9LvLsCvpTVbnyROtfnqJljvr9o
	 PPqBy1Gpmaw4nJ41UpVYIHOyfChZ6UP237z4GFqjKy3YfBY4T9OazLvqPPfU2vqhAo
	 NahOcmHefusNg==
Message-ID: <sashiko-outbox-188613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/15] tracing/filters: Fix false success return in
 process_system_preds()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179323786427.740114.10413984130946236850.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
 <179323786427.740114.10413984130946236850.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 01:45:53 +0000
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
- [Medium] tracing/filters: process_system_preds() returns 0 on ENOMEM afte=
r match
--

commit a15564919ee696f8c1b9df5aeee0a37935f51db7
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/filters: Fix false success return in process_system_preds()

This commit replaces the boolean fail flag in process_system_preds() with
ret so that process_system_preds() returns -EINVAL when no event in the
subsystem matches the filter. It also consolidates the fail and fail_mem
error cleanup paths.

> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_even=
ts_filter.c
> index 28977d10e60b6..b35ecb01697b8 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -2337,7 +2337,7 @@ static int process_system_preds(struct trace_subsys=
tem_dir *dir,
>  	struct filter_list *filter_item;
>  	struct event_filter *filter =3D NULL;
>  	struct filter_head *filter_list;
> -	bool fail =3D true;
> +	int ret =3D -ENOMEM;
>  	int err;
> =20
>  	filter_list =3D kmalloc_obj(*filter_list);
> @@ -2364,8 +2364,10 @@ static int process_system_preds(struct trace_subsy=
stem_dir *dir,
>  			filter_disable(file);
>  			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
>  			append_filter_err(tr, pe, filter);
> -		} else
> +		} else {
>  			event_set_filtered_flag(file);
> +			ret =3D 0;
> +		}
> =20
> =20
>  		filter_item =3D kzalloc_obj(*filter_item);
> @@ -2380,11 +2382,9 @@ static int process_system_preds(struct trace_subsy=
stem_dir *dir,
>  		filter_item->filter =3D event_filter(file);
>  		event_set_filter(file, filter);
>  		filter =3D NULL;
> -
> -		fail =3D false;
>  	}
> =20
> -	if (fail)
> +	if (ret)
>  		goto fail;
> =20
>  	/*
> @@ -2396,19 +2396,18 @@ static int process_system_preds(struct trace_subs=
ystem_dir *dir,
>  	return 0;
>   fail:
>  	/* No call succeeded */
> -	free_filter_list(filter_list);
>  	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
> -	return -EINVAL;
> +	ret =3D -EINVAL;
>   fail_mem:
>  	__free_filter(filter);
> =20
> -	/* If any call succeeded, we still need to sync */
> -	if (!fail)
> +	/* If any filter was replaced, we still need to sync */
> +	if (!list_empty(&filter_list->list))
>  		delay_free_filter(filter_list);
>  	else
>  		free_filter_list(filter_list);
> =20
> -	return -ENOMEM;
> +	return ret;

[Severity: Medium]
Can process_system_preds() return 0 instead of -ENOMEM when an allocation
fails after at least one event matches the filter?

In kernel/trace/trace_events_filter.c:process_system_preds(), ret is
initialized to -ENOMEM and cleared to 0 as soon as process_preds() succeeds
for an event:

	err =3D process_preds(file->event_call, filter_string, filter, pe);
	if (err) {
		...
	} else {
		event_set_filtered_flag(file);
		ret =3D 0;
	}

	filter_item =3D kzalloc_obj(*filter_item);
	if (!filter_item)
		goto fail_mem;

If kzalloc_obj(*filter_item) fails on that same iteration, or if
kzalloc_obj(*filter), kstrdup(), or kzalloc_obj(*filter_item) fails on a
subsequent event in the loop, jumping to fail_mem returns ret (which is now
0) instead of -ENOMEM.

That causes create_system_filter() and apply_subsystem_event_filter() to
treat the aborted update as a success, leaving the remaining events in the
subsystem without the new filter applied. Also, if kzalloc_obj(*filter_item)
fails right after event_set_filtered_flag(file) runs, EVENT_FILE_FL_FILTERED
is set and trace_buffered_event_enable() is called, while fail_mem frees the
new filter without installing it via event_set_filter(file, filter).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179323784538.740114=
.15323117974242744566.stgit@devnote2?part=3D2
