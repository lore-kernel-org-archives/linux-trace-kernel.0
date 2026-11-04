Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784766;
	b=uhMFcg5Qo1HcgG3O6NAzuAEy4BsZ0RzgH/HBpDlbbQcigLpKlTDh8p8dPNhWEuP5sp56
	 /dX17rCVNfmOKbW1i1Ui6YLFQxE2XL3hgecUzi3o56nnov3keyWEnPDl3I+fgTTzRS/q6
	 yT0nlFIGFlNfM+sExs/CLYm4+4gbVsFdV7IDJvss6AK/Ji9fEur1S3Ab++tDZuKKSOZjP
	 +zaruUnEziODtrG1iUzSfjeQRYIfjTOECuK2rrBUROGMxy7KTqBcwAWkRavGJ/wcOSq1N
	 XmlxNG5MMD5EEYNq+7ERkP8gwzxHFz/i8uwrJSrMNKFLwdFo9EbPmag5cKwIZIH2CnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784766;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DKEXbx0T6i5N+6bpPfl9KpeYXuWH8OZQmLYSaN0iNnE=;
	b=bUknK0eqF4Ak7hmVDV8aRf2d12JwH8IoJIDBOtk+auVcoR+wvgQij3xaWJ1Hm0CDmSdf
	 jImMMAf7dxLutqhVeW2M3mAyEDXGm0bafC7N7UYz/g4BW3DkkJVzxyIfK4n/HxIqLlCcH
	 BOL0PQRHARWAvYnEux5LGup/v7soZRtB9aJLkdyl38zEpEzM1hs58B15/HsMQimlSHlnE
	 /MqcXiarXOOZ+QYUIDF3mUAvtjD3Lg2ePZMu0vC6f6KotDWwpdtmDc+WJzWkwpHZW6XEf
	 5BvSZRRIOodUVSAqJ8xQHm3dJ5MXlJK21+krrdGTZY9zOvu7ey1vsXKs3ehIiWKa+sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRtnUSpA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3B606A326
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRtnUSpA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493E61F000C1;
	Wed,  4 Nov 2026 09:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784765;
	bh=DKEXbx0T6i5N+6bpPfl9KpeYXuWH8OZQmLYSaN0iNnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JRtnUSpA8LXX6c/6LzmixOUqhO6hUq/mKG3B2QHFnKylRbKwKLpGSTsJx+7eIWauL
	 VGLW8G6USOtRnkiT9fzRJoO6cRlukUQxVXx8pcQiB07U4rU3H9hwOjWpJOuBo7RYFT
	 royelln/agTBMLWk1qS4QSGNIJdgNSd4xqv0Kkkv8yaniH0+0JJvKrmaCDeE9zeptM
	 vDwThoMvfqxbWj41MWz3RRVWHW2nljGTZdETal2ipFFbeg5n2iOzPWSrqVPuJ+6NnS
	 6TQhbx9AYmtbH00qceWCiJHekfCG6zsmW2sd2aBcAGMYt+5hAQ66OCJCFTYMaEb6eV
	 TgjeJFzSJVpgA==
Message-ID: <sashiko-outbox-196964@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] rv: Update monitors through a quiesce helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Li" <liwei1412@hotmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <CY8PR19MB7009AD3DA7BC39C8D5419B1EB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
 <CY8PR19MB7009AD3DA7BC39C8D5419B1EB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:32:44 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rv: unconditional disable in rv_update_single() resets monitors =
on no-op
- [Medium] rv: partial child update in rv_update_container() and ignored er=
ror return
--

commit 5225ae9ebfb18889b8c1d478e3a3b6a70311b8ec
Author: Wei Li <liwei391@huawei.com>

rv: Update monitors through a quiesce helper

This commit introduces the rv_update_monitor() helper to quiesce, update, a=
nd
re-enable runtime verification monitors via a callback while preserving the
enabled state of container children. It updates monitor_swap_reactors() to =
use
this helper when changing a monitor's reactor.

> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 29f155c6968b7..4e689d4590aee 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -289,6 +289,19 @@ static int rv_enable_single(struct rv_monitor *mon)
>  	return retval;
>  }
> =20
> +static int rv_update_single(struct rv_monitor *mon, rvmon_update_fn_t up=
date, void *data)
> +{
> +	int retval =3D 0;
> +	int enabled;
> +
> +	enabled =3D __rv_disable_monitor(mon, true);
> +	update(mon, data);
> +	if (enabled)
> +		retval =3D rv_enable_single(mon);
> +
> +	return retval;
> +}
> +
>  static void rv_disable_container(struct rv_monitor *mon)
>  {
>  	struct rv_monitor *p =3D mon;
> @@ -321,6 +334,22 @@ static int rv_enable_container(struct rv_monitor *mo=
n)
>  	return retval;
>  }
> =20
> +static int rv_update_container(struct rv_monitor *mon, rvmon_update_fn_t=
 update, void *data)
> +{
> +	struct rv_monitor *p =3D mon;
> +	int retval =3D 0;
> +
> +	list_for_each_entry_continue(p, &rv_monitors_list, list) {
> +		if (retval || p->parent !=3D mon)
> +			break;
> +		retval =3D rv_update_single(p, update, data);
> +	}
> +	if (retval)
> +		rv_disable_container(mon);
> +	update(mon, data);
> +	return retval;
> +}

[Severity: Medium]
When re-enabling an active child monitor fails in rv_update_single() ->
rv_enable_single() -> mon->enable() (for instance, if enable_nomiss() retur=
ns
-ENOMEM when allocating storage), rv_update_container() breaks out of the
loop over rv_monitors_list immediately.

Because update(p, data) has already run for the failing child and all prior
children, breaking out of the loop skips calling update() on the remaining
children of the container, while still calling update(mon, data) on the
parent container itself after rv_disable_container(mon).

When called via monitor_reactors_write() -> monitor_swap_reactors() ->
rv_update_monitor(), doesn't this leave the container and earlier child
monitors pointing to the new reactor while later children still point to the
old reactor?

[ ... ]

> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
> index ea52f50e64532..06f21bcdd6cf8 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -177,45 +177,25 @@ static const struct seq_operations monitor_reactors=
_seq_ops =3D {
>  	.show	=3D monitor_reactor_show
>  };
> =20
> -static void monitor_swap_reactors_single(struct rv_monitor *mon,
> -					 struct rv_reactor *reactor,
> -					 bool nested)
> +static void monitor_update_reactor(struct rv_monitor *mon, void *data)
>  {
> -	bool monitor_enabled;
> +	struct rv_reactor *reactor =3D data;
> =20
> -	/* nothing to do */
> -	if (mon->reactor =3D=3D reactor)
> +	if (mon->reactor =3D=3D data)
>  		return;
> =20
> -	monitor_enabled =3D mon->enabled;
> -	if (monitor_enabled)
> -		rv_disable_monitor(mon);
> -
>  	mon->reactor =3D reactor;
>  	mon->react =3D reactor->react;
> -
> -	/* enable only once if iterating through a container */
> -	if (monitor_enabled && !nested)
> -		rv_enable_monitor(mon);
>  }

[Severity: Medium]
Previously, monitor_swap_reactors_single() checked mon->reactor =3D=3D reac=
tor
before calling rv_disable_monitor(mon), making a redundant reactor write a
no-op:

	if (mon->reactor =3D=3D reactor)
		return;

	monitor_enabled =3D mon->enabled;
	if (monitor_enabled)
		rv_disable_monitor(mon);

With the move to rv_update_monitor() -> rv_update_single(),
__rv_disable_monitor(mon, true) now runs unconditionally before invoking
monitor_update_reactor().

If user space writes the already-active reactor to a monitor's reactors file
(or updates a container monitor where some enabled child monitors already u=
se
that reactor), won't __rv_disable_monitor() still detach tracepoints, wait =
on
tracepoint_synchronize_unregister(), and invoke mon->disable(), resetting a=
ll
in-flight automaton verification state even when mon->reactor =3D=3D data?

> =20
>  static void monitor_swap_reactors(struct rv_monitor *mon, struct rv_reac=
tor *reactor)
>  {
> -	struct rv_monitor *p =3D mon;
> -
> -	if (rv_is_container_monitor(mon))
> -		list_for_each_entry_continue(p, &rv_monitors_list, list) {
> -			if (p->parent !=3D mon)
> -				break;
> -			monitor_swap_reactors_single(p, reactor, true);
> -		}
>  	/*
> -	 * This call enables and disables the monitor if they were active.
> -	 * In case of a container, we already disabled all and will enable all.
> -	 * All nested monitors are enabled also if they were off, we may refine
> -	 * this logic in the future.
> +	 * Update the reactor with the monitor quiesced: enabled monitors are
> +	 * disabled, updated and re-enabled, disabled ones are only updated.
> +	 * Children of a container keep their enabled state.
>  	 */
> -	monitor_swap_reactors_single(mon, reactor, false);
> +	rv_update_monitor(mon, monitor_update_reactor, reactor);
>  }

[Severity: Medium]
rv_update_monitor() returns an error code when re-enabling a monitor fails =
in
rv_enable_single(), but monitor_swap_reactors() ignores the return value and
monitor_reactors_write() unconditionally returns count to user space.

Should monitor_swap_reactors() propagate the error from rv_update_monitor()
back to monitor_reactors_write() so user space is notified when re-enabling
the monitor fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CY8PR19MB70098BF493=
A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com?part=3D2
