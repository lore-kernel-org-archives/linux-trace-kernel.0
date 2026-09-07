Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B1488DBA
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785981; cv=none; b=Qrt39khV27h1lT2Y3+8fSPGQxSn9kEI/XjmRX7ST/IVa1p7u0h0odD8nlw3om89DnSUCFWX5mvNAl06EhFTdoiq46A35RR57QT8HuPP2LWb2DRLMHmQNjI4Se33Yny0p7sc8JwPrC6Yjx3ZPGS6I/+WVJ78A6wXYlvXfMs9yVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785981; c=relaxed/simple;
	bh=JM+RZIKDwFmAvoyCyS5C4EdBFwyhcNrhWNRat0X0Z9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NYPkqAZF0rfhJtaaNm7aWCm6UvDoePrGBSX8dI5Vo0lSAVV+01KV9NfM3YqWGT67NtMinSkkqQHJEHE94t7BVkEoR+LpSyGXVjv6L0P49EVH/2Vwu8qRcVwfoNL9Oz6jgaM6KfORdPGAKVGqPC5HlD+awljnhdQbObxOeY2Fawk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXZCYkku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXZCYkku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6261F00A3E;
	Mon,  7 Sep 2026 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788785974;
	bh=BUKvrvpPBk4PqrtLQTprSd5gXjwA62RXJzn3DtWQc+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EXZCYkkujv0xtalhIIUulDPN92OgXOnk6E9h8UVP5/PCdoODSsXLbDBp86pK555jS
	 Ztd4Q9/T7dBrDWv5Ccsm/WD68Cf4dEg26CBA7Pa1w/tRJ8uWhz9uMn9lBuh+YYEDDR
	 L488qx4U2ofE3QrZhRPLAdKxR21hm7UHrH9xjMhY/4lcaXRaP8BACwO4G3kK8MRGbG
	 ncllZEWwq3Q/inWzLvO0bqNt23bogEFc/Y/kqNYTHl5iB6+n9DHBvnFhHpufS80qol
	 7UtLqJ9COiXUR6HIGfxwId5xHzzo/sfG1kVdkNaJExBn3jfJORkiM9kEWzXxCWWGUo
	 EMRH7Ndcxfgpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tracing: hist: take the reference before publishing
 the named trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260907124420.607097-2-donggeunyoo.kernel@gmail.com>
References: <20260907124420.607097-1-donggeunyoo.kernel@gmail.com>
 <20260907124420.607097-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 12:59:33 +0000
Message-Id: <20260907125934.5C6261F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch leaves an identical Use-After-Free and memory leak if tr=
igger registration fails after `.init()` succeeds.
- [Medium] Ignored return value from `save_named_trigger()` causes silent f=
ailure and breaks histogram sharing.
--

commit 540a72d9b730e99f5331add357da7f87a7bcb997
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: hist: take the reference before publishing the named trigger

This commit delays the publication of a named trigger to the global list
until after its initialization succeeds. This prevents a failed
initialization from leaving a dangling pointer in the named_triggers list
and fixes a use-after-free bug.

Link: https://lore.kernel.org/linux-trace-kernel/20260907092944.3950E1F00A3=
D@smtp.kernel.org/

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 963e0d6b61fdf..c6c04926bdf0c 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6383,17 +6383,18 @@ static int event_hist_trigger_named_init(struct e=
vent_trigger_data *data)
>  {
>  	int ret;
> =20
> -	data->ref++;
> -
> -	save_named_trigger(data->named_data->name, data);
> -
>  	ret =3D event_hist_trigger_init(data->named_data);
>  	if (ret < 0) {
>  		kfree(data->cmd_ops);
>  		data->cmd_ops =3D &trigger_hist_cmd;
> +		return ret;
>  	}
> =20
> -	return ret;
> +	data->ref++;
> +
> +	save_named_trigger(data->named_data->name, data);

[Severity: Medium]
This is a pre-existing issue, but does ignoring the return value of
save_named_trigger() break histogram sharing?

save_named_trigger() uses kstrdup() to allocate the name string, which can
fail and return -ENOMEM. If this happens, the trigger is not added to the
named_triggers list, but the function continues as if it succeeded.

Could this lead to a state where the trigger exists but cannot be found by
functions like pause_named_trigger()? Does this silently break histogram
sharing semantics (causing subsequent triggers with the same name to create
independent maps instead of sharing them) and group pause/unpause logic?

This same return value is also ignored in event_hist_trigger_init():

kernel/trace/trace_events_hist.c:event_hist_trigger_init() {
    ...
    if (!data->ref && hist_data->attrs->name)
        save_named_trigger(hist_data->attrs->name, data);
    ...
}

> +
> +	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but does this fix leave another
identical use-after-free and memory leak reachable from tracefs?

If trigger registration fails in hist_register_trigger() after this .init()
function succeeds, the error propagates up without undoing it:

kernel/trace/trace_events_hist.c:hist_register_trigger() {
    ...
    ret =3D tracing_set_clock(file->tr, hist_data->attrs->clock);
    if (ret) {
        hist_err(tr, HIST_ERR_SET_CLOCK_FAIL, errpos(clock));
        goto out;
    }
    ...
}

The caller event_hist_trigger_parse() then catches this error and blindly
frees the trigger data:

kernel/trace/trace_events_hist.c:event_hist_trigger_parse() {
    ...
 out_free:
    remove_hist_vars(hist_data);
    trigger_data_free(trigger_data);
    ...
}

Because trigger_data_free() does not invoke cmd_ops->free(), does this leave
the newly freed trigger linked in the global named_triggers list and leak
data->cmd_ops, leading to the exact same KASAN slab-use-after-free this pat=
ch
was intended to fix?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907124420.6070=
97-1-donggeunyoo.kernel@gmail.com?part=3D1
