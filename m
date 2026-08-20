Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B7A476CED
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245126; cv=none; b=ch7m7eW7QgjmcfdXSN+c4kErVOGlw7PHbroyc/AUO+1OCeSo7Wp2nH8atXxCXpD1jtAVIg/M2KNsRdX/PlIc3QVny+C2QvL/D8hPwQaTQXMnSJfCEAOGXP0jDF9X4ra2seCn0BpdOADsfASriOr/chvqI9Plwl2zAC/hDVgzNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245126; c=relaxed/simple;
	bh=zeavYpUgKt91zIzSUPP+/qVt6hWTqvapfwz4BinTQ9I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LfLqeGo1xqwkFZDLNuraMKGbHa6cmIUtGYPNenaOisNsgaEg0kJxXOtHlA/UMEfpMOQFU1mcvvTq1lBc3MQa4np66G6zwUpX3N/yXcvWBoiJZ3hO3SrFN5wsB76GXcWEiO65VzlWsOHVTbKieobw6G4O3XQxlqirgFr+Wgzljt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJBu00pG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJBu00pG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AE71F000E9;
	Thu, 20 Aug 2026 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787245125;
	bh=+iJtI77FV6eKO0b+kIpE4tk1QqLVtNOfhOy252w39J4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bJBu00pGtA7rZ4lxh3KW+P896hwuCDAqIrkrxqS7o0Tj6VTSTEhhWbBG88Lqut7v4
	 mW01yw39MfxJerUAfxd8Y91t4BTsP1praOuGcoUB0pnbjLTugDnk3FJKKCraQgQnou
	 1lw4IIc4Pb86VyswRj+OO3RJv87HuFCKOEkr1WrvixIXDZezP8WZ7v00slg7W3YFQi
	 VLlfzinTiHqov8hwMdQbu+uKf2K6yZjfyJrTuojPH2epuejkKxoiJv61ARFDPXh/wd
	 ub2ghu9ODLaxejI7ltSnl/Xbg8tfEU5yZtu/duEm2XpoxP4zZOVTHeyZOdD6H2QDqN
	 ygHsgBhdnvWxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] rv: Fix ha_invariant_passed_ns silent bypass of
 invariant check
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <b12480afcae971936571d9c0def64d3a8fa0be99.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
 <b12480afcae971936571d9c0def64d3a8fa0be99.1787243842.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 16:58:44 +0000
Message-Id: <20260820165845.21AE71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Check-then-act (TOCTOU) race condition in first-invocation guard r=
eset allows concurrent thread execution to overwrite an initialized invaria=
nt timestamp.

Pre-existing issues:
- [High] `ha_check_invariant_ns` calculates `time_ns - expire_ns`, which ca=
n underflow and cause valid invariants to falsely fail when the system upti=
me is less than `expire_ns`.
- [High] `ha_start_timer_ns` and `ha_start_timer_jiffy` suffer from integer=
 underflow when elapsed time (`passed`) exceeds the timeout (`expire`), cau=
sing monitor timers to be scheduled far into the future (or at a random tim=
e) instead of expiring immediately.
--

--- Patch [4]: [PATCH v6 4/9] rv: Fix ha_invariant_passed_ns silent bypass =
of invariant check ---
commit 1e15107a6865e6fddc264988e2a5c771a535486a
Author: Wen Yang <wen.yang@linux.dev>

rv: Fix ha_invariant_passed_ns silent bypass of invariant check

This patch fixes a silent bypass in ha_invariant_passed_ns() and=20
ha_invariant_passed_jiffy() by initializing env_store to the current clock
on the first invocation. It replaces the early return with a call to
ha_reset_clk_ns() to establish the invariant guard.

> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 6e1c7fe5449a3..e1738d199b289 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -355,7 +355,7 @@ static inline u64 ha_invariant_passed_ns(struct ha_mo=
nitor *ha_mon, enum envs en
>  	if (env < 0 || env >=3D ENV_MAX_STORED)
>  		return 0;
>  	if (ha_monitor_env_invalid(ha_mon, env))
> -		return 0;
> +		ha_reset_clk_ns(ha_mon, env, time_ns);

[Severity: High]
Does this lockless state check and modification allow a check-then-act race?

Looking at ha_invariant_passed_ns() in include/rv/ha_monitor.h, if concurre=
nt
threads execute this path for the same multi-state monitor, could Thread A =
and
Thread B both evaluate ha_monitor_env_invalid() as true?=20

This could lead to one thread blindly overwriting the invariant start time
initialized by the other, inappropriately pushing the epoch forward and mas=
king
violations.

>  	return ha_get_env(ha_mon, env, time_ns);
>  }
> =20
> @@ -375,6 +375,7 @@ static inline bool ha_check_invariant_jiffy(struct ha=
_monitor *ha_mon, enum envs
>  {
>  	return time_after64(READ_ONCE(ha_mon->env_store[env]), get_jiffies_64()=
 - expire_jiffy);
>  }
> +

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of integer
underflow in the related ns check function?

include/rv/ha_monitor.h:ha_check_invariant_ns() {
    return READ_ONCE(ha_mon->env_store[env]) >=3D time_ns - expire_ns;
}

If the system uptime (time_ns) is smaller than expire_ns (e.g. for a monitor
started early during boot with a large timeout budget), could time_ns - exp=
ire_ns
underflow?

This would immediately trigger a false positive invariant violation that co=
uld
cause a kernel panic if the panic reactor is configured.

[Severity: High]
This is a pre-existing issue, but could integer underflow occur in the timer
setup functions when the elapsed time exceeds the timeout?

include/rv/ha_monitor.h:ha_start_timer_ns() {
    u64 passed =3D ha_invariant_passed_ns(ha_mon, env, time_ns);
    ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
                         nsecs_to_jiffies(expire - passed + TICK_NSEC - 1),=
 time_ns);
}

If passed is greater than expire, expire - passed underflows to a massive u=
nsigned
64-bit value.

When passed to nsecs_to_jiffies() (or jiffies_to_nsecs() in ha_start_timer_=
jiffy),
this can result in timers being scheduled far into the future (or at a rand=
om
time) instead of expiring immediately, nullifying the monitor's ability to
enforce latency budgets.

>  /*
>   * ha_invariant_passed_jiffy - prepare the invariant and return the time=
 since reset
>   */
> @@ -383,7 +384,7 @@ static inline u64 ha_invariant_passed_jiffy(struct ha=
_monitor *ha_mon, enum envs
>  	if (env < 0 || env >=3D ENV_MAX_STORED)
>  		return 0;
>  	if (ha_monitor_env_invalid(ha_mon, env))
> -		return 0;
> +		ha_reset_clk_jiffy(ha_mon, env);

[Severity: High]
Can concurrent threads race when resetting the jiffy clock here as well?

Similarly to ha_invariant_passed_ns(), could multiple CPUs evaluating
ha_monitor_env_invalid() at the same time in ha_invariant_passed_jiffy() ca=
use
an initialized invariant timestamp to be silently overwritten?

>  	return ha_get_env(ha_mon, env, time_ns);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787243842.gi=
t.wen.yang@linux.dev?part=3D4
