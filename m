Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C54457C9
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773396; cv=none; b=o+L3NlPQPEYeiJcQT6Z5KdnmhTvdGkN6/NbT9UeEATY0c0h01nA/i8F0ketRNpii+g4WUYmEHFtA3xzPHeMBWM4482C4LN1M/UWsLrbJE3f7UXnKo5Xp3X2rhHTHhIcQen4AE4U5tuNMJqsCIIaVF2WhhGcnBC5YWvq49oIZ5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773396; c=relaxed/simple;
	bh=Yd1mFkva7OcbJJe61Bzl0dMd4q4gfCTyl4XKjYsc+v8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M3RKqOZFCj1iojMt5TWspXljPuBQHEkSRgdub/146UkXNkUqMW2MLfquLOmo8kESZFNN5l20MrgAF/U52+CCw0cxRcXHpsdDRGFZA+RFB2J1PUp8YmM7moaopQV3jGbZOJciOcB6xsRGubUJ5eJZXfmLblVNDnIVvkq7j9BRvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7+eP5tS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7+eP5tS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3950E1F00A3D;
	Mon,  7 Sep 2026 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788773384;
	bh=IFmlERJClZ2bQSiNGMKTZLUBvDPGO+LlgSOdSN8QtFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z7+eP5tSuobPn4aix5eoCxE3tX14x/2/koTiprXrsZ1KXx0q5ATIj+ZcuXJgAYcyp
	 ldlKJIRsgoDQHX5Kz7YrJKnEfvI/Kt7nBR/8cypTBQ0x6qlbpXWo1ptpyJbVQPN2o3
	 eFofB/VVedQX9o0DwrU5JI23oz8z8m/nSiccgFydwGgUguE0GqRwMApTlkbbCrImMq
	 W+CJbe2Y94byyS1ZTtZVnp5NM2FRAjdrSJmkAB7dDri9NNGt0Utl0lXfUnOn5LKumy
	 p2xckgnJRTtOja84q0h+3AgqhhdXC3lb6o9zsytpnzblXZnceQQha/6RS4Rr2DsX0O
	 /McwFE2ttnXLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: hist: set the trace clock before registering
 the trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260907091415.554535-1-donggeunyoo.kernel@gmail.com>
References: <20260907091415.554535-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 09:29:43 +0000
Message-Id: <20260907092944.3950E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free list corruption if `event_hist_trigger_init` fails =
during named trigger initialization.
- [High] Use-After-Free list corruption because a newly created named trigg=
er remains on the global `named_triggers` list if `hist_trigger_enable()` f=
ails.
--

commit 1e5ea6c77dc8e3a10275a88758d5ef5a8d54be44
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: hist: set the trace clock before registering the trigger

hist_register_trigger() puts the trigger on the global named_triggers
list in cmd_ops->init(), and only then sets the trace clock.
The clock string is not checked anywhere before that call, so a named
trigger using common_timestamp with an unknown clock fails after it has
already become findable.

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 963e0d6b61fdf..6c628415468a6 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6643,12 +6643,6 @@ static int hist_register_trigger(char *glob,
>  		data->cmd_ops =3D cmd_ops;
>  	}
> =20
> -	if (data->cmd_ops->init) {
> -		ret =3D data->cmd_ops->init(data);
> -		if (ret < 0)
> -			goto out;
> -	}
> -

[ ... ]

> @@ -6661,6 +6655,15 @@ static int hist_register_trigger(char *glob,
>  		tracing_set_filter_buffering(file->tr, true);
>  	}
> =20
> +	if (data->cmd_ops->init) {
> +		ret =3D data->cmd_ops->init(data);
> +		if (ret < 0) {
> +			if (hist_data->enable_timestamps)
> +				tracing_set_filter_buffering(file->tr, false);
> +			goto out;
> +		}
> +	}
> +
>  	if (named_data) {
>  		remove_hist_vars(hist_data);
>  		destroy_hist_data(hist_data);

While reviewing this patch, I noticed a couple of pre-existing issues
related to how named triggers are handled during initialization and error=20
paths in this same file.

kernel/trace/trace_events_hist.c:event_hist_trigger_named_init() {
    ...
	save_named_trigger(data->named_data->name, data);

	ret =3D event_hist_trigger_init(data->named_data);
	if (ret < 0) {
		kfree(data->cmd_ops);
		data->cmd_ops =3D &trigger_hist_cmd;
	}

	return ret;
}

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leave=20
the new trigger on the global named_triggers list?=20

If event_hist_trigger_init() fails, the trigger is never removed from the=20
list before the function returns the error. The caller then propagates=20
this error, eventually calling trigger_data_free() which frees the=20
structure. Can this lead to a Use-After-Free list corruption when the=20
global named_triggers list is accessed later?

Also, further down in the file:

kernel/trace/trace_events_hist.c:event_hist_trigger_parse() {
    ...
	ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data);
	if (ret < 0)
		goto out_free;

	ret =3D hist_trigger_enable(trigger_data, file);
	if (ret)
		goto out_unreg;
    ...
 out_unreg:
	event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 out_free:
	remove_hist_vars(hist_data);

	trigger_data_free(trigger_data);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this error path also result in=20
Use-After-Free list corruption?

If hist_trigger_enable() fails, it drops the trigger from the local file=20
list but then we jump to out_unreg. Because the trigger is no longer in=20
file->triggers, event_trigger_unregister() won't find it and skips calling=
=20
cmd_ops->free() (which would normally call del_named_trigger()).=20

The code then falls through to trigger_data_free(). Does this manually=20
free the memory without ever calling del_named_trigger(), leaving a freed=20
node on the global named_triggers list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907091415.5545=
35-1-donggeunyoo.kernel@gmail.com?part=3D1
