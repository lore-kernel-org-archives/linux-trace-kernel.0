Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC151AEC7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687172; cv=none; b=pSvmhzi6z3vG0hsSr7weba1z86QjT8fnQFoljxa/IEaZSdfW8MjWyDX1+qxSj29ypWDb+3b5TIWh5/v8odzNU4qyvt+D+TW1jL68G7cq+dYIWvrYlHZrU9PKUBoKBtx3azq0f7pdt3IHnKpMWcyRtB92YpHJpFRJ+pwRcQakU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687172; c=relaxed/simple;
	bh=nj9LxgZBC57IiW6V3OB2LnCPoKyenLNMRBhDBXYYrfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uJqbpst84ESA+HDSaWD4VxtVaIbjZAG/Fa6H9Xv5VoRvwSl5P3SjdkR5iu4/ol4BgHcvT6t7hXRqio1Rm6dXu4IlpJQcyzkU38flXHCGsEACERJ74KhXSkgdJ+cNi5/F0iRIXc5c+IZF5aT98wMHsLP5iZB+0C6IKsCmBTm01eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWtil9Kb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWtil9Kb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12F51F000FF;
	Tue, 29 Sep 2026 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687167;
	bh=7KvEW1cpCrawifUHVvGhAPCae16QwZ3Y3XEnLSUIDsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fWtil9KbX2kQbEJzc6EPFCofSP+dTkIvLulsFuLNeKvbBlIjb1OO+IWH8RtDOT40G
	 rp7ED9TX79dwGLmIwqV8cCCFYz472EvaThYitiDph4MrBYQJbsnMbtV5enB61iBX71
	 ZsI63A4U2dTBc0R70p2wR73ksrUcZAp6opRLPdskThC5iYZxnOjrL2woI29mP/rICr
	 QV+yxmKcS3NhONBwjvX6yWWguXuWrPSTW9ynlid4T1sgX1+eSkPQd14TfmgUTrX77J
	 bCuV3BoWsNaJvhboTP1R3bB5ZSoGdWrU2tp0sH0Re7L4K4JwHseQuiSUwY2ISUH1z8
	 q2tgbGKFMJzaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] rv: Cache timer budget when starting HA timers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260929124908.177676-4-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
 <20260929124908.177676-4-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:06:07 +0000
Message-Id: <20260929130607.C12F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rv: instant invariant failure on initial state for HA monitors
- [High] rv: lockless TOCTOU race on timer expiration budget causes spuriou=
s failures
--

commit ab59c80faa625da1231e21adf0d94a5978fe4a17
Author: Gabriele Monaco <gmonaco@redhat.com>

rv: Cache timer budget when starting HA timers

Commit ab2900ae252b ("rv: Simplify hybrid automata monitors's clock
variables") simplified storage but introduces the assumption that the
expires value passed to ha_check_invariant() is the same used to arm the
timer. This commit caches the armed budget to ensure invariant checks
remain consistent with the timer's duration.

> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 87cf91abdf679..332671f3ce2c2 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h

[ ... ]

> @@ -341,9 +342,13 @@ static inline void ha_reset_clk_ns(struct ha_monitor=
 *ha_mon, enum envs env, u64
>  	WRITE_ONCE(ha_mon->env_store[env], time_ns);
>  }
>  static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon, enum=
 envs env,
> -					 u64 time_ns, u64 expire_ns)
> +					 u64 time_ns)
>  {
> -	return READ_ONCE(ha_mon->env_store[env]) >=3D time_ns - expire_ns;
> +	if (HA_TIMER_TYPE =3D=3D HA_TIMER_WHEEL)
> +		return time_ns - READ_ONCE(ha_mon->env_store[env]) <=3D ha_mon->expire;
> +	if (HA_TIMER_TYPE =3D=3D HA_TIMER_HRTIMER)
> +		return time_ns <=3D ktime_to_ns(hrtimer_get_expires(&ha_mon->hrtimer));

[Severity: High]
What happens to monitors with initial state invariants when they process th=
eir
first event?

When a monitor starts, it is set to the initial state, but
ha_setup_invariants() is not called yet to arm the timer or cache the
expiration budget. When the first event arrives, ha_verify_invariants()
evaluates the invariant against the uninitialized timer budget.

For hrtimers, the expiration is 0, which evaluates time_ns <=3D 0 and trigg=
ers
immediate failure. For timer wheels, ha_mon->expire is ENV_INVALID_VALUE,
which could overflow or evaluate incorrectly.

Could this instantly halt any generated monitor that uses an initial state
invariant upon receiving its first event?

> +	return true;
>  }

[ ... ]

> @@ -420,22 +413,30 @@ static inline void ha_setup_timer(struct ha_monitor=
 *ha_mon)
> =20
>  	if (RV_MON_TYPE =3D=3D RV_MON_PER_CPU)
>  		mode |=3D TIMER_PINNED;
> +	ha_mon->expire =3D ENV_INVALID_VALUE;
>  	timer_setup(&ha_mon->timer, ha_monitor_timer_callback, mode);
>  }
> +static inline void _ha_start_timer(struct ha_monitor *ha_mon, u64 expire,
> +				   u64 time_ns)
> +{
> +	mod_timer(&ha_mon->timer, get_jiffies_64() + expire);
> +}
>  static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum =
envs env,
>  					u64 expire, u64 time_ns)
>  {
>  	u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, time_ns);
> =20
> -	mod_timer(&ha_mon->timer, get_jiffies_64() + expire - passed);
> +	ha_mon->expire =3D expire;
> +	_ha_start_timer(ha_mon, expire - passed, time_ns);
>  }
>  static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum env=
s env,
>  				     u64 expire, u64 time_ns)
>  {
>  	u64 passed =3D ha_invariant_passed_ns(ha_mon, env, time_ns);
> =20
> -	ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
> -			     nsecs_to_jiffies(expire - passed + TICK_NSEC - 1), time_ns);
> +	ha_mon->expire =3D expire;

[Severity: High]
Can a concurrent event on another CPU evaluate the invariant using a stale
timer budget?

The da_event() loop locklessly updates curr_state via try_cmpxchg(), making
the new state globally visible immediately. However, the auxiliary timer bu=
dget
(ha_mon->expire or hrtimer expiration) is updated afterwards here.

If a concurrent event occurs on another CPU and reads the newly updated
curr_state, it could call ha_check_invariant_ns() and read the stale,
un-updated timer budget. Could this race result in a false-positive constra=
int
failure and incorrectly halt the monitor?

> +	_ha_start_timer(ha_mon, nsecs_to_jiffies(expire - passed + TICK_NSEC - =
1),
> +			      time_ns);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929124908.1776=
76-1-gmonaco@redhat.com?part=3D3
