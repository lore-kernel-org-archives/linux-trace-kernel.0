Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184D25B082;
	Mon,  7 Sep 2026 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814872; cv=none; b=PoBSPrbmDCbX8QX+n6UhJDP68k8FcOFBxYPNl3SoSvruGH8CZ/01Fdr0ecr3lya0JwcBLgan7B65G3oatlBxheySem06cW9ZnopfPE8mX57SvznfPUNF81QadKyozt5b4FE2cV+ifsEiOWVAQfX0M/CPVkfZ0hlriiBkUlYcvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814872; c=relaxed/simple;
	bh=mrYhEaR9IK2yeyG/ryNn5tLLDTUhEhyf1+dAvbhMTY8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VSwquCb4vZnF1XmKqSxDoQg1Tm76RCM+HzQiFu+LUXlWHhPe2W16iTvt18PuJMiM+K3VAoKxccwd+iLuWTc5avIOhFbQ5uDEnf55wjKH0hk2X7BwOHIB3H1XBf01AP0eFhYgmG7hhVGF8sz/kgSwDp4G2Lmi4od3J095tGaMwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqH16lWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqH16lWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE5B1F00A3E;
	Mon,  7 Sep 2026 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788814870;
	bh=n1wZ7r4xayWp9nNQN29FZBPntyP6nacsynwTW8yABMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MqH16lWxY9rAj2RAKZcgaJ0bRqsUtkedUcprRyQQHHiKIU4kLqQ4depqjYj9XD1k/
	 fY46WbEkCdTzjWPOtXamgWAu7EDr/jWsN4us+NKMdikWKRjhRG7b982Vi0cNQH/uSI
	 lodBsazUSH/rBfznGsG6XC1UMIVyDwXU5xh57egIwylCemyipzo28hS8bh8Wf2ouSJ
	 AtFebYUon7PhgZRq0n6/NDg1OhzJn28TB0iYo0Ah52EdnYePj9YR7Fj74OCjYuCJkh
	 wy6e8+Gv/oqhJtvhLzpXYrgvbWoSFRCwK2is+n0biwzloQhPNv6EB3lm/M/kJuFcHc
	 HaeTypu3XmEtg==
Message-ID: <c64ce430a9c5ba3b7c36acaf8b5befe84bdd6f50.camel@kernel.org>
Subject: Re: [PATCH 1/2] tracing: hist: take the reference before publishing
 the named trigger
From: Tom Zanussi <zanussi@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 07 Sep 2026 16:01:09 -0500
In-Reply-To: <20260907124420.607097-2-donggeunyoo.kernel@gmail.com>
References: <20260907124420.607097-1-donggeunyoo.kernel@gmail.com>
	 <20260907124420.607097-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-07 at 21:44 +0900, Donggeun Yoo wrote:
> event_hist_trigger_named_init() puts the trigger on the global
> named_triggers list and only then takes the reference on the trigger it
> shares its histogram with:
>=20
> 	data->ref++;
>=20
> 	save_named_trigger(data->named_data->name, data);
>=20
> 	ret =3D event_hist_trigger_init(data->named_data);
> 	if (ret < 0) {
> 		kfree(data->cmd_ops);
> 		data->cmd_ops =3D &trigger_hist_cmd;
> 	}
>=20
> 	return ret;
>=20
> event_hist_trigger_init() fails when alloc_hist_pad() cannot allocate, an=
d
> nothing takes the trigger back off the list on the way out.
> event_hist_trigger_parse() frees it, and the next lookup by name reads th=
e
> freed object:
>=20
> =C2=A0BUG: KASAN: slab-use-after-free in find_named_trigger+0xac/0xc0
> =C2=A0Read of size 8 at addr ffff888009346860 by task init/1
> =C2=A0 find_named_trigger+0xac/0xc0
> =C2=A0 hist_register_trigger+0xc1/0xa00
> =C2=A0 event_hist_trigger_parse+0x3146/0x6af0
> =C2=A0 event_trigger_write+0xce/0x160
> =C2=A0Freed by task 67:
> =C2=A0 kfree+0x154/0x420
> =C2=A0 trigger_kthread_fn+0xfd/0x160
>=20
> Do the reference first and publish once it has succeeded, so that nothing
> which can fail runs after the trigger becomes findable.
>=20
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-trace-kernel/20260907092944.3950E1F=
00A3D@smtp.kernel.org/
> Fixes: 7ab0fc61ce73 ("tracing: Move histogram trigger variables from stac=
k to per CPU structure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> =C2=A0kernel/trace/trace_events_hist.c | 11 ++++++-----
> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 963e0d6b61fd..c6c04926bdf0 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6383,17 +6383,18 @@ static int event_hist_trigger_named_init(struct e=
vent_trigger_data *data)
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	data->ref++;
> -
> -	save_named_trigger(data->named_data->name, data);
> -
> =C2=A0	ret =3D event_hist_trigger_init(data->named_data);
> =C2=A0	if (ret < 0) {
> =C2=A0		kfree(data->cmd_ops);
> =C2=A0		data->cmd_ops =3D &trigger_hist_cmd;
> +		return ret;
> =C2=A0	}
> =C2=A0
> -	return ret;
> +	data->ref++;
> +
> +	save_named_trigger(data->named_data->name, data);
> +
> +	return 0;
> =C2=A0}
> =C2=A0

Makes sense. Note that save_named_trigger() can also fail with -ENOMEM,
but maybe that's a separate patch..

Acked-by: Tom Zanussi <zanussi@kernel.org>


> =C2=A0static void event_hist_trigger_named_free(struct event_trigger_data=
 *data)
>=20
> base-commit: df2908090cda368b01ff43709f51890076c56157

