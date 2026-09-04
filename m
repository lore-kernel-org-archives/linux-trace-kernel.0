Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF05845199D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523937; cv=none; b=lqTMMOXvmPWoBieU6ZJ7iJ7GsQVmsiPSefmbRhKZVCyQifLRizXuOsCC6U19/3HSXqokH/tUza5T/q4pJQ57CGSWcsKJUKf5EbFuUmgrkFb8p/8ci5l1POSyTeLQa1rmwtGEiQ6az9Cm7RoWY8bHGM6OrNndFxFpsLSmvRpwYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523937; c=relaxed/simple;
	bh=xDjTYvd5q+JVI/1jVm1QSX3UywCbYjsBBk7WROkg1Ls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rEtz6qPwX+mcEmL3CmeDI9QYKVjJR2x0Hm9sjGA4NM5FU8wQUweuuuWZTpXoQP9dSLdUiQN6eGoydJACSYH8dib0/Gn3841S4VZTbByTVH6zdMOF2xJrCHYHbIbU3IGNfqF2Bd529urvclzXrJJxEc/rOz9f2r3cwddbSmXf37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbIHTDeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbIHTDeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD2F1F00A3E;
	Fri,  4 Sep 2026 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788523935;
	bh=Qlx8zHpGb2ELQVl1bHo0u3wsV5MXGnqgImvRXv3+TsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbIHTDeI/5k2zAQ47uMtQxJT4TODufB5MoNkUfDjoNBe5eC7e9pTVgVWw9Kkx1AJ7
	 NqMgFNk/BvY7RZyE8zrLg+Ug2YWn4CItCrRco44aXsi/cG4t3vL6lCYoUIqemmmQrx
	 nF1DQ1Kmo7a1kc8JBxPlpQ/Nl6TFtt/Lfhxv5YR3gPoS9GckpF6HOouyKXeW+yflOo
	 VI665K0J1NDwhdNWFF+F1Zb8u8NJFCgOKMC2Bf4vFzwU2u6+QjA3xFTkHBJoqT90vi
	 LbQVO5CJsaRGvs5jXE7Gbj81/zQuaJqzFzH5U3QsYZu/PkJIDH+nKczrEdPu/wEr9a
	 mmdg6Qg54uPaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing/user_events: Don't destroy fields when event
 removal fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Henry Martin" <bsdhenrymartin@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904115223.2976446-1-bsdhenrymartin@gmail.com>
References: <20260903182903.GA62-beaub@linux.microsoft.com>
 <20260904115223.2976446-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 12:12:14 +0000
Message-Id: <20260904121215.4BD2F1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race leading to out-of-bounds read and BPF context size check=
 bypass when event removal races with BPF attach.
--

commit 67af0e963857d01d3ef2cc1bd224b3d373fe0483
Author: Henry Martin <bsdhenrymartin@gmail.com>

tracing/user_events: Don't destroy fields when event removal fails

destroy_user_event() previously destroyed fields before attempting to
remove the trace event call. This patch moves the field destruction after=20
the call removal and temporarily moves the fields to a local list to prevent
them from being irreversibly destroyed if the removal fails.

> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events=
_user.c
> index 2bbc89d4a2666..dbd8e9f95a4a7 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
[ ... ]
> @@ -1499,17 +1498,32 @@ static int user_event_set_call_visible(struct use=
r_event *user, bool visible)
> =20
>  static int destroy_user_event(struct user_event *user)
>  {
> +	LIST_HEAD(fields);
>  	int ret =3D 0;
> =20
>  	lockdep_assert_held(&event_mutex);
> =20
> -	/* Must destroy fields before call removal */
> -	user_event_destroy_fields(user);
> +	/*
> +	 * Detach the fields before removing the call. Removing the event
> +	 * frees the field list memory (trace_destroy_fields() is run on
> +	 * successful removal and kmem_cache_free()s the fields), but the
> +	 * fields here are allocated and owned by user_events. Destroy
> +	 * them separately once removal has succeeded.
> +	 */
> +	list_splice_init(&user->fields, &fields);

[Severity: High]
This is a pre-existing issue, but both the old behavior and this new=20
list_splice_init() leave the published field list temporarily empty while=20
the event is still active. Does this create a data race with concurrent=20
BPF attaches?

A concurrent PERF_EVENT_IOC_SET_BPF can call trace_event_get_offsets(),=20
which locklessly accesses this list without holding event_mutex or=20
trace_event_sem:

    tail =3D list_first_entry(head, struct ftrace_event_field, link);
    return tail->offset + tail->size;

Because the list is empty at this point, list_first_entry() resolves to the
list head itself (&user->fields). This causes tail->offset and tail->size
to read garbage values from adjacent struct members (such as
user->put_work).

Could this out-of-bounds read result in the BPF verifier bypassing context
size checks, potentially allowing a kernel memory information leak?

> =20
>  	ret =3D user_event_set_call_visible(user, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904115223.2976=
446-1-bsdhenrymartin@gmail.com?part=3D1
