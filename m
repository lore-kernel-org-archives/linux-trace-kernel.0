Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046E3BFAEB
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869589; cv=none; b=jPzo5UdblWbRyoB3B9gp+6eXd6Q4XHvZnnBbrUb/kWNBGyDBm44TX4YPpdZS8cwzGRlspFhESnK/A4Aqr3HpkYEbehUm+t4KZSmyEtxg9I/fd77usXBNA4QrkNQmYmwTczgiLv2GO30FFBfnSksSulw83/RXW7tPivyDPmGdaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869589; c=relaxed/simple;
	bh=lW/bUiUMKiFrhpbuINZo04gXWFf6enhSpBJ2D+ZHgEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S8s+waIKThJBXfNV53lXfmxQWknxok9zXeTHhnskb/1PQ4tjR6wJCLmrJ9K9Lw+I9kvm8Qwz3D4ibLRjTL+v51cg657CWRUvtYnpraw/ZBi/lxpAe3DZlUamuOZY5v74hmUhBV8gr8gLZEUyerhXLmCEyvElojwiWzJwl3DsAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqnl1Mwr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqnl1Mwr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8221F000FF;
	Thu,  1 Oct 2026 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869587;
	bh=25kPO99t0wfTQB2dIBHu7ms+Lba38OV51bFx4L6S7Rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jqnl1Mwr3xMtt8sgc0zgHOF7NNFC+DjZjSsMbvN7o219EKNKXrugxB9N3qqnhbC8G
	 mC+OHltNmWLyK8rx2vnmUfd0knR0nZA+goOz2dPJxs9Vvl/Z4cBuuGf6WsZ6GhJc1H
	 fT8NjBuCOhFp4Tdt7Kow6oYef8zrVHAGAZ4t2JVV0HAu0b2nIAFJPMUwP6P167tcqq
	 sBOOi8uxZBuO0MqZrijcPZL2otKvpTmZ96t6YrBANHOp/xXy1aX+QIBp9s7R/Pxn4d
	 D0TOH3k6QaBs88+7+rFEMUEyzKFY6EyoCQfRKe/ZgCiG9BnSsXg/8g51lE+vaTJiUV
	 3WB1GFklBDl2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/compaction: defer failed async direct compaction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261001-bug-mm-thp-async-compact-defer-v1-2-0174c7923430@gmail.com>
References: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>
 <20261001-bug-mm-thp-async-compact-defer-v1-2-0174c7923430@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:46:27 +0000
Message-Id: <20261001154627.9B8221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: async compaction clears skip hints causing full zone rescans
- [Low] mm: missing tracepoint for async compaction deferral reset
--

commit 2e6082a2f3b4a8dcf4b7cf16ef03d8f061912e07
Author: Qiliang Yuan <odys.yuan@gmail.com>
Date:   Thu Oct 1 15:33:49 2026 +0000

    mm/compaction: defer failed async direct compaction

This patch splits the compaction deferral state into sync and async, allowi=
ng
async compaction to be deferred independently of sync compaction. It aims to
prevent unnecessary zone rescans during THP allocations by keeping async
deferral state.

> diff --git a/mm/compaction.c b/mm/compaction.c
> index a049415512c67..25f758bc54f06 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
[ ... ]
> @@ -165,24 +165,28 @@ static bool compaction_deferred(struct zone *zone, =
int order)
>  void compaction_defer_reset(struct zone *zone, int order,
>  		bool alloc_success)
>  {
> -	if (alloc_success) {
> -		zone->compact_considered =3D 0;
> -		zone->compact_defer_shift =3D 0;
> -	}
> -	if (order >=3D zone->compact_order_failed)
> -		zone->compact_order_failed =3D order + 1;
> +	int sync;
> =20
> -	trace_mm_compaction_defer_reset(zone, order);
> +	for (sync =3D 0; sync < ASYNC_AND_SYNC; sync++) {
> +		if (alloc_success) {
> +			zone->compact_considered[sync] =3D 0;
> +			zone->compact_defer_shift[sync] =3D 0;
> +		}
> +		if (order >=3D zone->compact_order_failed[sync])
> +			zone->compact_order_failed[sync] =3D order + 1;
> +	}
> +
> +	trace_mm_compaction_defer_reset(zone, order, true);

[Severity: Low]
Does this tracepoint unintentionally omit the async state? The tracepoint
unconditionally reports a reset for sync compaction (true), but entirely
omits the corresponding event for the async state that was also modified
in the loop.

>  }
> =20
> -/* Returns true if restarting compaction after many failures */
> +/* Returns true if restarting sync compaction after many failures */
>  static bool compaction_restarting(struct zone *zone, int order)
>  {
> -	if (order < zone->compact_order_failed)
> +	if (order < zone->compact_order_failed[true])
>  		return false;
> =20
> -	return zone->compact_defer_shift =3D=3D COMPACT_MAX_DEFER_SHIFT &&
> -		zone->compact_considered >=3D 1UL << zone->compact_defer_shift;
> +	return zone->compact_defer_shift[true] =3D=3D COMPACT_MAX_DEFER_SHIFT &&
> +		zone->compact_considered[true] >=3D 1UL << zone->compact_defer_shift[t=
rue];
>  }
[ ... ]
> @@ -2596,7 +2600,9 @@ compact_zone(struct compact_control *cc, struct cap=
ture_control *capc)
> =20
>  	/*
>  	 * Clear pageblock skip if there were failures recently and compaction
> -	 * is about to be retried after being deferred.
> +	 * is about to be retried after being deferred. Only do it when sync
> +	 * compaction restarts: async compaction relies on the skip hints, and
> +	 * clearing them on every async retry would rescan the whole zone.
>  	 */
>  	if (compaction_restarting(cc->zone, cc->order))
>  		__reset_isolation_suitable(cc->zone);

[Severity: High]
Does this code clear skip hints during async compaction, causing full zone
rescans?

The comment explicitly states: "Only do it when sync compaction restarts".
However, compaction_restarting() only evaluates the sync deferral state. If
sync compaction has been fully deferred (compact_defer_shift[true] =3D=3D
COMPACT_MAX_DEFER_SHIFT), this will return true for all callers.

Without checking if the current compaction is actually synchronous (e.g.,
via cc->mode !=3D MIGRATE_ASYNC), wouldn't this cause async compaction to
continuously clear skip hints and rescan the entire zone on every failed
THP fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-bug-mm-thp=
-async-compact-defer-v1-0-0174c7923430@gmail.com?part=3D2
