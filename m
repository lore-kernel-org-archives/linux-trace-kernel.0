Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785035;
	b=rRS3Da8caxdavKboYirxpsgeYJHuLa/0jw/j8PWUtLcVe96QpR2AxZS/aypDExPtCFMr
	 Bij0nQBUPPt+yTGHUisQ+wgPLpFdWAYIk035LpWfVZE5s1x/YFLZ5pVGZiu5T25Hw8gtW
	 09Hy+9DlMVrqXpPywRm0VjGqmGTWnB2M+WH+/r0d//gwYUl4LcD2MScy22UgR1pgXXTqu
	 ZQ5hpQIYwd7B2lCySwnmWLyDpBl8biULDJlwhw7WIt2cnF5WW0vroCXAN71FpPvdifI84
	 zZAx6IjPdjCNbifgrjoTgz5YYflpH2wo8a1KasY+6/FegfZ8xdor0vXaZDNS+gGceYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+18W1Qz9UtmKIOIfymdE7GzGzs4tDdcUL8jM0vu2r8Y=;
	b=uDLm356pWCzBlPrOuZvFqF2SXpIJNCBX4LMXydM2SlAVKwJ4pOUZQ8HhBn5+k8T0ze8z
	 bPMbKrY7x8JQkmmgn7DTVOXJM/letQssZUyV8PokKOOo33ZKdHmmAyXcMY1sw4Pn7inUr
	 fM3ewDoC5CxfWopFbZVGvJgGZq/FOuXJNucxRsY79zRYAiyBXJjcrBjvhfi2RjXyRF1Up
	 ZL0ks0N9RBsi8UuRF+2KcjYPbs4RT9b5nkR7l94rhOMSEScmEPn3ZQp8GsWU/bK3LDMwX
	 y7TLoojDXnhPMDf2NOs3MxnnYC6/HD0BpdMMvqmmmcEaitoOPzpiKi6jf/pYoYa4a7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PWbAoY/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CB606A335
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWbAoY/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C831F0093A;
	Wed,  4 Nov 2026 09:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785035;
	bh=+18W1Qz9UtmKIOIfymdE7GzGzs4tDdcUL8jM0vu2r8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PWbAoY/etYxxLZC+jmIuSRdhNTgwDbi4gGvYuvkyQY5+2j5Ig9xEEsGPrAYdK3RII
	 6xnmX2GASl75MTpeB8zrWxIbHgH/fBNMzyu4BALWlPHEMrFade57K+7mAdJVcN/63q
	 bSkMQNW+Ars94sRVIXlcHXE5ry2EPFPmo+EYX/07JZjRQR3YYBgEpso99vJZkccl5U
	 R/UQcCfkud4+1gmztxHgL32DFJudyyKzVEBJMLXlt7/D+/dqoS6WuKyktCXoC8105A
	 zg0TiCdV6/tY5J+vanITZfKY3vXzMLSinur2Iri2YAV7uNF0iFnJd2/jptyvuidW9v
	 JBThO8n/YJj8A==
Message-ID: <sashiko-outbox-196972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] rv: Show the mixed enable state of containers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Li" <liwei1412@hotmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <CY8PR19MB70099F2263C408361053B295B7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
 <CY8PR19MB70099F2263C408361053B295B7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:37:14 +0000
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
- [Medium] rv: stale parent container state on re-enable error in rv_update=
_single()
--

commit 2db3de084bc5c2af773f028e5905ec5c314ba488
Author: Wei Li <liwei391@huawei.com>

rv: Show the mixed enable state of containers

This commit converts struct rv_monitor::enabled into enum rv_monitor_state
so container monitors can report a mixed ("X") enable state when only a
subset of their nested monitors are enabled. It updates rv_enable_single()
and rv_disable_single() to refresh the parent container state.

> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 4e689d4590aee..7846e4092b9c4 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
[ ... ]
> @@ -269,10 +272,22 @@ static int __rv_disable_monitor(struct rv_monitor *=
mon, bool sync)
> =20
>  static void rv_disable_single(struct rv_monitor *mon)
>  {
> +	struct rv_monitor *cntr =3D mon->parent;
> +	struct rv_monitor *p =3D cntr;
> +
>  	__rv_disable_monitor(mon, true);
> +	if (!cntr)
> +		return;
> +	cntr->enabled =3D 0;
> +	list_for_each_entry_continue(p, &rv_monitors_list, list) {
> +		if (p->parent !=3D cntr)
> +			break;
> +		if (p->enabled)
> +			cntr->enabled =3D 2;
> +	}
>  }
> =20
> -static int rv_enable_single(struct rv_monitor *mon)
> +static int __rv_enable_monitor(struct rv_monitor *mon)
>  {
>  	int retval;
> =20
> @@ -289,6 +304,27 @@ static int rv_enable_single(struct rv_monitor *mon)
>  	return retval;
>  }
> =20
> +static int rv_enable_single(struct rv_monitor *mon)
> +{
> +	struct rv_monitor *cntr =3D mon->parent;
> +	struct rv_monitor *p =3D cntr;
> +	int retval;
> +
> +	retval =3D __rv_enable_monitor(mon);
> +
> +	if (!retval && cntr) {
> +		cntr->enabled =3D 1;
> +		list_for_each_entry_continue(p, &rv_monitors_list, list) {
> +			if (p->parent !=3D cntr)
> +				break;
> +			if (!p->enabled)
> +				cntr->enabled =3D 2;
> +		}
> +	}
> +
> +	return retval;
> +}
> +
>  static int rv_update_single(struct rv_monitor *mon, rvmon_update_fn_t up=
date, void *data)
>  {
>  	int retval =3D 0;
> @@ -297,7 +333,7 @@ static int rv_update_single(struct rv_monitor *mon, r=
vmon_update_fn_t update, vo
>  	enabled =3D __rv_disable_monitor(mon, true);
>  	update(mon, data);
>  	if (enabled)
> -		retval =3D rv_enable_single(mon);
> +		retval =3D __rv_enable_monitor(mon);

[Severity: Medium]
Can this leave mon->parent->enabled stale if re-enabling a nested monitor
fails in rv_update_single()?

When updating a single nested monitor (for example via
monitor_reactors_write() -> monitor_swap_reactors() -> rv_update_monitor() =
->
rv_update_single()), __rv_disable_monitor() sets mon->enabled =3D 0 without
updating mon->parent->enabled.

If the subsequent __rv_enable_monitor(mon) call fails (such as
enable_nomiss() failing in init_storage(false)), mon remains disabled while
mon->parent->enabled still holds its previous enabled or mixed state.

Also, this isn't a bug, but would it be cleaner to use a shared helper with
the enum rv_monitor_state constants instead of open-coding the parent state
loops with raw 0, 1, and 2 literals in rv_disable_single() and
rv_enable_single()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CY8PR19MB70098BF493=
A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com?part=3D3
