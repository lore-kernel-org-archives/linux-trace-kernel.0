Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490771;
	b=zZtLmDzqp90M93iAWAB8GvZMoUrUfAn5b+QHdgFtB4oC7EVZfsq3dJFj0+DgtwawEB1v
	 fkdbLAnpbM5fkdj3yEsnX6nHGs8BK2UQ5ONOhafJmp0E7kdKKWcaK5P5rV9on5FPp5n+k
	 Da3g7X+0R09x1bYaWCS+bASPuTdHFcuS8FfsI+QH5HlExrfQRQlCzSZJcXoiH9jDY81iP
	 ImcTWpGjwukVKqH4ORNQeu8e5gg9vhHZEMjnPCgTyAMatcQ8rNegVm2h5pXpavEFUGw8z
	 ScY5fC4B0aVg+d8eYagxXie/xbVjadM+KYOV171FFKwTxE5yfPeKF3R/3S9eanYmfhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aUQcLhBLPcEiiqfeRhPzr+uw5kKPMbksUmOJ0feLy/I=;
	b=wW1uRAePdQuC1M1vARWxE8JmPlfXgSQFSgvNGbJimRzfSVfvXE3rLxQSX0t96xMNYyFm
	 xMHwlARfluXyArgtpAs5s8rN0VOYGMyv20QuEWZka/sxFZ9G5UDCrlb+5lqq2blJZ2xIe
	 onODYT8dGrp+/aQ+X7o5WQEmYhiE44Vv1A9oQ+N3yAsfAdhdRAtrgZFaZWoVt8kFBRtKe
	 PIl83geW64DPExuxkP7S9X/mJs79IZ2q2gL+y005mDYIL9D4IXPyRl9WYFlktyCOQYEhN
	 K7c7yEcPg4uLDbx5lXvWo+xXlRZoQkVZBfRebP1rAmRWcJ5pneGX8qrz+WtJt3DSx0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYmPReCR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22539606A31A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYmPReCR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC201F000C4;
	Tue, 20 Oct 2026 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490771;
	bh=aUQcLhBLPcEiiqfeRhPzr+uw5kKPMbksUmOJ0feLy/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZYmPReCRHlJfXt33YA2jQyjfeSUdTcA4d7muVz/xsu/cz/QpYZhwuWpi3a3dIy9nv
	 hZgK/axLskVZa26J6mH8YUAg+ZbmLp2ved/8v3Rffh5xR6RD94N8HgocW6kaUneDxi
	 IfabUdHBMw7QTZs4dMBlK/iDGT84g/9OYfLLDArTNNG1J3w3Q5q3W0lfD257n/HYoC
	 OfeHVqrQd/yMSkR7eOhaKgPMN+CSQs8hIl/kumudWjI/4CgnG4JH6XpZJqFnjPOSU4
	 l3qgGZ7sEnh7zedKbUsvyu8NdS4L9+B0Fnh1vantcCxwowbqTCGnNpFGHmeiJk0YG4
	 ctwuPfNeom+7w==
Message-ID: <sashiko-outbox-178792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] rv: collect per-edge dwell time for per-cpu
 DA/HA monitors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schaffner" <tobias.schaffner@siemens.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261020095512.863754-4-tobias.schaffner@siemens.com>
References: <20261020095512.863754-1-tobias.schaffner@siemens.com>
 <20261020095512.863754-4-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:06:10 +0000
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
- [Medium] rv: bogus initial dwell time in __da_handle_start_run_event()
--

commit 296c211b8b28be395fee98f1ad59896cd58a9336
Author: Tobias Schaffner <tobias.schaffner@siemens.com>

rv: collect per-edge dwell time for per-cpu DA/HA monitors

This commit hooks the edge-stat facility into the DA and HA monitor layers
to record per-edge state dwell times for per-CPU automaton monitors and
documents the resulting stats file in runtime-verification.rst.

> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 6fc5ef8142aca..c8f7497800d07 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h

[ ... ]

> @@ -113,7 +114,7 @@ static inline void da_monitor_reset(struct da_monitor=
 *da_mon)
>   */
>  static inline void da_monitor_start(struct da_monitor *da_mon)
>  {
> -	da_mon->curr_state =3D model_get_initial_state();
> +	da_mon->curr_state =3D da_state_entered(model_get_initial_state());
>  	da_monitor_init_hook(da_mon);
>  	/* Pairs with smp_load_acquire in da_monitoring(). */
>  	smp_store_release(&da_mon->monitoring, 1);

[ ... ]

> @@ -689,9 +696,11 @@ static inline void da_trace_error(struct da_monitor =
*da_mon,
>  static inline bool da_event(struct da_monitor *da_mon, enum events event=
, da_id_type id)
>  {
>  	enum states curr_state, next_state;
> +	da_state_t old;
> =20
> -	curr_state =3D READ_ONCE(da_mon->curr_state);
> +	old =3D READ_ONCE(da_mon->curr_state);
>  	for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
> +		curr_state =3D da_state_of(old);
>  		next_state =3D model_get_next_state(curr_state, event);
>  		if (next_state =3D=3D INVALID_STATE) {
>  			react(curr_state, event);
> @@ -699,7 +708,8 @@ static inline bool da_event(struct da_monitor *da_mon=
, enum events event, da_id_
>  				       model_get_event_name(event), id);
>  			return false;
>  		}
> -		if (likely(da_state_try_commit(&da_mon->curr_state, &old,
> -					       next_state, event))) {
> +		if (likely(da_state_try_commit(&da_mon->curr_state, &old,
> +					       next_state, event))) {
>  			if (!da_monitor_event_hook(da_mon, curr_state, event, next_state, id))
>  				return false;
>  			da_trace_event(da_mon, model_get_state_name(curr_state),

[Severity: Medium]
Does stamping da_mon->curr_state with da_state_entered() in
da_monitor_start() record a bogus dwell time when starting a monitor via
__da_handle_start_run_event()?

Unlike __da_handle_start_event(), which calls da_monitor_start() and
returns immediately when entering the initial state,
__da_handle_start_run_event() is used when the system is already in the
initial state for an unknown duration and an outgoing transition occurs:

include/rv/da_monitor.h:__da_handle_start_run_event() {
	if (!da_monitor_enabled())
		return 0;
	if (unlikely(!da_monitoring(da_mon)))
		da_monitor_start(da_mon);

	__da_handle_event_common(da_mon, event, id);

	return 1;
}

When !da_monitoring(da_mon) is true (such as in the opid monitor on the
first handle_sched_need_resched() or handle_sched_waking() event after
enabling or resetting), da_monitor_start() stamps curr_state with a
non-zero local_clock() timestamp via da_state_entered().

Immediately afterwards, __da_handle_event_common() calls da_event(), where
da_state_try_commit() takes a second local_clock() timestamp and calls
rv_edge_account(). Because the timestamp in old is non-zero, won't
rv_edge_account() record the few nanoseconds spent between
da_monitor_start() and da_state_try_commit() as the dwell time for the
initial state's outgoing edge?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020095512.8637=
54-1-tobias.schaffner@siemens.com?part=3D3
