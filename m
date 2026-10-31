Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481350;
	b=l4oA3fnwI4PzvUuZtLFEREuPJHgjr0X2Gi+lRe/2izYH6EzjxyYQ/RJd5jtxZtkTb9bA
	 gvHhCNwsq2gj6gvicHw41aGIAOZAcZB8nu6frLD1cv/E/6ZTgzwQJ3WwxfBD2BWjdhIyz
	 axqOsw1qyn0qqKXKHq7OQaSqlVyHRLwjwZGteZ/1gKxHyQehFa8lTaMddjVCGSV6vf8fS
	 z1o1S6swCx2X2i6GBYzZc7TjkbmN6aDEurF/GTYZBScFYvJZ7oCU1p3u8YDIssx16PLV2
	 zeOCEfNBW00gf8ZTmOwO8qWHlrjByGQKANguoHjF/bYn6UOKpfQ5ulf5gH24m6ll8iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481350;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZdRVZRh3GC2UssZIIrTuxSBFXKo6DAh6+mrCCAPLuRM=;
	b=kAfmtqn3mFtPlQx3BC386ulRSb+UsHHAtxVeoyP0bI+gF7rdwBxFFMnesifMwtyNHK1q
	 Z6fF5dFvmTG89QMV/FEWpeUjeVaJxD7rIJODEI5J9JbKOfgjx6eOkPVZ0NOGzdJMtSaci
	 JaqTMcln/DdOpa1hKfDrlkcG8aixp8c+jVHpixlt8vx/jSjurL5MuO3sciCofl6WjiSEu
	 cP/mhBxYcbsIjidofzZnWIOizp9cmcBLH6jxcNr8b/KbfU/FjHmEJ2qpP5Y5dX5QZzrwV
	 QaoovLEGJmXenapNzPP8/3xsxe0b90Kxi8aif0KKfx8UIV8e0fR986Rynzrezrq7m9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjnXTSii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96C606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjnXTSii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8AF1F000C1;
	Sat, 31 Oct 2026 21:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793481350;
	bh=ZdRVZRh3GC2UssZIIrTuxSBFXKo6DAh6+mrCCAPLuRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjnXTSiir/2Ge7eTrPtRvL6biWaCo9EWPQ3h3mrIbfj2B2QjVAw10L41rogeA/NaN
	 1Lo7kSHiBoN8/Tbj6WHYZGB+L3xPskWQnKTeOFKFCKq5/GCpDFI6c1Rs2zNh3UcAYx
	 Qp7TppyR80eDA/Uis51HUlD8zQusC5iqpnmc9Mvhb9R7PXNd/jbqK7Gr2LeHuxc68b
	 ZVQ87V+I3ayQqY+7eeNwws7njcy1xKUPynYuKM51SQNmn8/9Z7JjO29DqT6E8D2GZm
	 rdqgamBfkVojJ6YDQeKDRtU6s83umiQF6e7ovtrk6FcdNwmOMhsB6Wg17B+21h4oQT
	 lkf1koYCuPpKQ==
Message-ID: <sashiko-outbox-192162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing/user_events: Don't free an event that a dynamic
 event still references
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261031210420.501187-1-devnexen@gmail.com>
References: <20261031210420.501187-1-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 21:15:49 +0000
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
- [High] tracing/user_events: permanent leak of non-persistent event in des=
troy_user_event()
--

commit 426e76d7362e855d5b85cce6bb2e395443a0a474
Author: David Carlier <devnexen@gmail.com>

tracing/user_events: Don't free an event that a dynamic event still referen=
ces

This commit prevents destroy_user_event() from freeing a user_event while a
dynamic event still holds a reference on user->call by checking
trace_event_dyn_busy(&user->call) and returning -EBUSY.

> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events=
_user.c
> index f658c3a77aa7a..49b857a7f1d78 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1506,6 +1506,10 @@ static int destroy_user_event(struct user_event *u=
ser)
> =20
>  	lockdep_assert_held(&event_mutex);
> =20
> +	/* If there is a reference to a dynamic event */
> +	if (trace_event_dyn_busy(&user->call))
> +		return -EBUSY;

[Severity: High]
Does returning -EBUSY here cause non-persistent user_event instances to leak
and become permanently undeletable if their last reference is dropped while
user->call.refcnt is non-zero?

When a non-persistent event is created via DIAG_IOCSREG without
USER_EVENT_REG_PERSIST, user->refcnt tracks active user and probe reference=
s.
If a dynamic event consumer holds a reference on user->call (such as an
eprobe via find_and_get_event(), a histogram action via
trace_get_event_file(), or an enable_event trigger during teardown in
event_enable_trigger_free() before trigger_kthread runs
enable_trigger_private_data_free()) when the last user->refcnt reference is
dropped in user_event_put(), delayed_destroy_user_event() runs:

kernel/trace/trace_events_user.c:delayed_destroy_user_event() {
	...
	if (!refcount_dec_and_test(&user->refcnt))
		goto out;

	if (destroy_user_event(user)) {
		...
		pr_warn("user_events: Unable to delete event\n");
		refcount_set(&user->refcnt, 1);
	}
out:
	mutex_unlock(&event_mutex);
}

Because destroy_user_event() now returns -EBUSY, delayed_destroy_user_event=
()
resets user->refcnt to 1 without setting USER_EVENT_REG_PERSIST in
user->reg_flags, and with no owner holding that reference.

Once the eprobe or trigger later drops its reference on user->call, how can
this user_event ever be freed?

1. Manual deletion via dynamic_events in user_event_free(), via DIAG_IOCSDEL
in delete_user_event(), or via dyn_events_release_all() ->
user_event_is_busy() all check user_event_last_ref():

kernel/trace/trace_events_user.c:user_event_last_ref() {
	int last =3D 0;

	if (user->reg_flags & USER_EVENT_REG_PERSIST)
		last =3D 1;

	return refcount_read(&user->refcnt) =3D=3D last;
}

Because USER_EVENT_REG_PERSIST is not set, user_event_last_ref() requires
user->refcnt to be 0, so manual deletion permanently fails with -EBUSY.

2. Re-opening and closing the event increments user->refcnt from 1 to 2 and
decrements it back to 1 in user_event_put(), never reaching 0 to re-queue
delayed_destroy_user_event().

As a result, the struct user_event, its fields and validators, its tracefs
entry, and a current_user_events quota slot appear to be leaked until reboo=
t.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031210420.5011=
87-1-devnexen@gmail.com?part=3D1
