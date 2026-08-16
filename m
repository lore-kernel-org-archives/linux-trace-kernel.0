Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082842931F1
	for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Aug 2026 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786876335; cv=none; b=DhB6AhKQnPAGiHoPsW42/Mb1OMBOqXOKDC8mxP5tlf1Qd3/fUTRCADsfKsiSW9M7jc2ohL3Ll/wRP6jkLHPQqHFFLCM6Gu+uk6LaFbNmRdQRLPTTGRyyM+rDm/oYGBt64a4JCf5dgHlr+Q7W8nd2U2ZEwa4X7HRwDTpPehiJzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786876335; c=relaxed/simple;
	bh=z8tmrrugPakLz5kNJPKVg+IxT5wehCn74J4LqJkddcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OPfitIgGYtLJPjWw41rzO1mYZP7UoqXh1ZD6eOIUXh1q5SDSaPmgjzRuKDuN3K85HSpS+1xX0xYt25FkIa/A5g80Pnuo6TZUydEh2KG65MXLqGDdnGC6kG1+uN4LUyu1j7qPcChog5yV7ZInuYScbbV4Boau9ldQa9dqLCCMx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtAuV8om; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtAuV8om"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBED1F000E9;
	Sun, 16 Aug 2026 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786876333;
	bh=OkYr8e9+IkJayw0jJC1ilTNkCjAAd/folhZ83tWZVV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BtAuV8omEbnpHYTeUQyD3D+0KHFXJdkK4Eq8m7L4u5CCg59510x5EfUSv9Zmvv/21
	 lEfLWai+VarUYgbnzIigs8AcLAs1ob1Ft3b4iu6dZyMeOptz0ww8DH2C/rF+Qn4KJB
	 6miZGF0EkLWjp3y573oPIagDR7GVcTVzTC4kRU3lb58ih7oKUOAjRjuZANFCiuhBTj
	 hj0Hp1qOm0EDUlnCopgK4jPGkhO51IRO1MXG58MkZouodZrJR30xMCV/VhMvmyBiNj
	 Wyrna/1Q/wxPVDtJa8taF8sgODqYuYqc5aOkUKiK8bRiuMUMl8309OXCVsYMtF/mg1
	 OBeV4v5i6F82A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing/histograms: Fix use-after-free with same-name
 named triggers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260816100427.33642-3-sh_def@163.com>
References: <20260816100427.33642-3-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 10:32:13 +0000
Message-Id: <20260816103213.6EBED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing rollback of data->ops->init() when tracing_set_clock()=
 fails, leading to a use-after-free in the global named_triggers list.
- [Critical] Double-free and use-after-free of `hist_data` and global list =
corruption of `trigger_data` when a reused named trigger successfully regis=
ters but fails to enable.
--

--- Patch [1]: [PATCH] tracing/histograms: Fix use-after-free with same-nam=
e named triggers ---
commit 5aedb1f49e82add364d36e7e38374f9abcb9b2b9
Author: Hui Su <sh_def@163.com>

tracing/histograms: Fix use-after-free with same-name named triggers

When two hist triggers on different events are registered with the same
name=3D, the second one reuses the first as named_data. Both are added to
tr->hist_vars by save_hist_vars() during event_hist_trigger_parse(),
but the named reuse is only detected later. This commit fixes a dangling
pointer issue by properly removing the hist_data from tr->hist_vars before
freeing it.

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index fdf784620c283..50e86f81ea32a 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6044,8 +6044,10 @@ static int hist_register_trigger(char *glob,
>  		tracing_set_filter_buffering(file->tr, true);
>  	}
> =20

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential problem in the error
handling right above this block when tracing_set_clock() fails.

If tracing_set_clock() fails, the code executes goto out, returning without
rolling back the data->ops->init() call that added the trigger to the global
list.

Would this result in event_hist_trigger_parse() executing kfree(trigger_dat=
a)
via its out_free path while trigger_data->named_list is still linked in the
global named_triggers list? Could this lead to a slab-use-after-free during
global list traversal?

> -	if (named_data)
> +	if (named_data) {
> +		remove_hist_vars(hist_data);
>  		destroy_hist_data(hist_data);

[Severity: Critical]
This is another pre-existing issue, but might freeing hist_data here cause a
double-free if registration ultimately fails?

When reusing a named trigger, hist_data is freed here. However, it appears
event_hist_trigger_parse() does not update its local hist_data pointer. If
a subsequent operation like hist_trigger_enable() fails, will the out_free
path in event_hist_trigger_parse() execute remove_hist_vars() and
destroy_hist_data() on the already-freed hist_data pointer?

Additionally, it seems kfree(trigger_data) would be called in that same
error path without unlinking it from the global named_triggers list. Can th=
is
corrupt the global list?

> +	}
>   out:
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816100427.3364=
2-3-sh_def@163.com?part=3D1
