Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895444065F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384075; cv=none; b=CKKJsvCo2n5ft1AMyuEnn/cjO/9dxDFef2yp2JtQpD/2IIoJCQgaesbJeobenmMKQ4ojvh+FjEiUVsEGH+tz9Mw4+8UdaKw3mDdt4BvcwCZ2+Lz7hkz6ZvqFmyoeq0IvJySXbPxt8ZdfG81YWQnBrpq/g3sZC2mp9rF9AK62dG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384075; c=relaxed/simple;
	bh=//tubY6Uxov/PLVuvtFFe+7GdEaIT6Xt7rD8WHKagQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cX852hLTty5H6GZmLOJ4s8BvvQmf4d8WDCWKrlnYmzpRs5zHpQwQgIuL/MgivjiNETnQ3rrwmtEZMAniajPqEjoTC40QvYY76p5ldMFN6xCxX34Y3u0u+DP4nOx7j4ranOKM+naXXsARfv/pVcp/goe3UromS31C7SFd56+skB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRX1zYZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRX1zYZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221E61F000FF;
	Mon, 14 Sep 2026 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789384073;
	bh=ruvh5lCK6BTTqiD/TLcwUuAuHUlsCH1ORCNBM+jlSYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KRX1zYZSBYxKSC4meUw4eAU5v7roadKLbYrzD7IesfvWiK6ad73MSVKbK5xSIw0UX
	 pyThBNGXLRbmPlQJVUjh9VdZF1bJ4UpExJ1j3rV7pxyAJZJkoaKf/inUaqe79PCFBS
	 vEk7h1UfvvVVdVwd0S9GBfuJWE2xLIdOiuxW3iZxdz5cZSY5lHz6RNG3Hor0kJWyM2
	 K2OwLGCrMyBwrNJA3KUVVMfX5LfgFxRuKxcaqc11NTlqcyLTuo1MguY6FUidpjoWlE
	 WPlteCpJ8ZfopAJZOhW3i/2ofacMP8PWJaiTZ1pgCFMF5jox4O2XsLdCJkKjoRjSlH
	 YO03gwgpbcXSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Unregister field variable histograms when the
 command fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260914104036.1768529-1-donggeunyoo.kernel@gmail.com>
References: <20260914104036.1768529-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 11:07:52 +0000
Message-Id: <20260914110753.221E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error unwinding in event_hist_trigger_parse() causes Use-After-Fre=
e and Double-Free of hist_data, and leaves dangling trigger_data on the glo=
bal named_triggers list.
- [High] Use-after-free of the compatible hist_data when removing a target =
histogram that uses field variables.
--

commit a635652ad2d37c0cc5b35a037b2c68349bec678b
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: Unregister field variable histograms when the command fails

An action that names a field on another event needs that field as a
variable, so create_field_var_hist() registers a second hist trigger on
that event to provide it, and records it in
target_hist_data->field_var_hists[].

If a later part of the same command fails, create_actions() returns an
error and event_hist_trigger_parse() jumps to out_free.

Closes: https://lore.kernel.org/all/20260913204302.DB2551F000FF@smtp.kernel=
.org/

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 963e0d6b61fdf..8e6c699b75c2a 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3138,20 +3138,18 @@ create_field_var_hist(struct hist_trigger_data *t=
arget_hist_data,
> =20
>  	kfree(cmd);
> =20
> +	n =3D target_hist_data->n_field_var_hists;
> +	target_hist_data->field_var_hists[n] =3D var_hist;
> +	target_hist_data->n_field_var_hists++;
> +
>  	/* If we can't find the variable, something went wrong */
>  	event_var =3D find_synthetic_field_var(target_hist_data, subsys_name,
>  					     event_name, field_name);
>  	if (IS_ERR_OR_NULL(event_var)) {
> -		kfree(var_hist->cmd);
> -		kfree(var_hist);
>  		hist_err(tr, HIST_ERR_SYNTH_VAR_NOT_FOUND, errpos(field_name));
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> -	n =3D target_hist_data->n_field_var_hists;
> -	target_hist_data->field_var_hists[n] =3D var_hist;
> -	target_hist_data->n_field_var_hists++;
> -
>  	return event_var;
>  }

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free of the
compatible histogram?

Earlier in create_field_var_hist(), find_compatible_hist() finds an existing
histogram to copy its keys and filter, and stores it in var_hist->hist_data:

kernel/trace/trace_events_hist.c:create_field_var_hist() {
    ...
	hist_data =3D find_compatible_hist(target_hist_data, file);
    ...
	var_hist->hist_data =3D hist_data;
    ...
}

Since the original compatible histogram has no variables attached to it,
check_var_refs() will return false, allowing a user to safely remove it whi=
le
the target histogram is still active.

When the compatible histogram is removed, its hist_data is freed via
destroy_hist_data().

Later, when the target histogram is removed, unregister_field_var_hists()
is called:

kernel/trace/trace_events_hist.c:unregister_field_var_hists() {
    ...
		file =3D hist_data->field_var_hists[i]->hist_data->event_file;
    ...
}

Would this dereference the freed compatible hist_data, resulting in a
use-after-free?

> @@ -6976,6 +6974,8 @@ static int event_hist_trigger_parse(struct event_co=
mmand *cmd_ops,
> =20
>  	trigger_data_free(trigger_data);
> =20
> +	unregister_field_var_hists(hist_data);
> +
>  	destroy_hist_data(hist_data);
>  	goto out;
>  }

[Severity: High]
This is a pre-existing issue, but can this error path lead to a double-free=
 and
use-after-free if named trigger registration fails?

If a named trigger is successfully linked to existing state in
hist_register_trigger(), save_named_trigger() is called which adds
trigger_data to the global named_triggers list, and the local hist_data
object is freed:

kernel/trace/trace_events_hist.c:hist_register_trigger() {
    ...
	if (named_data) {
		remove_hist_vars(hist_data);
		destroy_hist_data(hist_data);
	}
    ...
}

If a subsequent initialization step fails in hist_register_trigger() (such =
as
tracing_set_clock() failing), it returns an error without unwinding the list
addition.

When this happens, event_hist_trigger_parse() jumps to out_free and calls
trigger_data_free(trigger_data). Does this leave a dangling pointer in the
global named_triggers list?

Additionally, this path unconditionally calls destroy_hist_data(hist_data).=
 If
hist_data was already freed by hist_register_trigger(), could this result i=
n a
double-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914104036.1768=
529-1-donggeunyoo.kernel@gmail.com?part=3D1
