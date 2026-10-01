Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146736A03F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869338; cv=none; b=K4cvQ9RwxnKqKO+xwMfu+sCXpBBS2yivTLP4xKa9iwKKOSTyS3MbWVaP4FyoVYXIdR1xMBDkViX2DqcTFGq/FqNEHheLNsVs52Lp74RLEESVVYztJjpnMAFMKCzeci+VoFs5m1mzL0T/Mb6tP+9aL0/BpPjJzkowFXJbO3+PCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869338; c=relaxed/simple;
	bh=pro6eBuPwK61fAymgmWVuHiditm1SNrGK/IgYsSy3gA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/mhEOWD9RIIgSjgDHm6kAFV2b2XEakGNWxtGB/3XAUdu9orsepKgjfK7aXfM958VsznU006zT4WifKS0XOAO7G1JbTiwnT3rDXkbSGAPR4AqfX/ZKwzqEGUYfCcguak7c5Hc7R+ZSJtMIsQgNJG4SCi/05rPGE33KZbii88Dq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyFex1jE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyFex1jE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C1A1F000FF;
	Thu,  1 Oct 2026 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869336;
	bh=J7u+ikzyY6XizAcP+I3XsTkHB3Oi2XlKcTZAvDBq58U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KyFex1jEQ0JIgdp++w1ICcJPW8j+hCgJ9CLF51tpRHGmqxy8CeOp0gAs9u1UE+xgU
	 OuP535cWPw13AlbGyF1duoF9j6Qo85+J3L6gnhgquguNIwHJLK7yIuA8urppYb/iJ0
	 mIiDirIZgT75xgDsiaMoo33ucJ9mEVFZ4V+fcFN34Hkwm7gn7BdpQKG23aOK3KhSF/
	 bpbRkEacjNsERxWiGY78MnHqPvq8Ulvof7zRHg+hHX45xUs0ijPwJBRPnxRiihCXou
	 ONDVyPRr2mkbP1m/ARIEBmI6aW1sj9ACBeiWb+/WOo9MDn/IRNYU45vBJi8U3KiiFe
	 6rtmUuT4h5Pdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/compaction: keep compaction deferral state per
 migration mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261001-bug-mm-thp-async-compact-defer-v1-1-0174c7923430@gmail.com>
References: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>
 <20261001-bug-mm-thp-async-compact-defer-v1-1-0174c7923430@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:42:15 +0000
Message-Id: <20261001154216.59C1A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: incomplete tracing of async mode in compaction_defer_reset()
--

commit 0627b5eaa00c60d552c24b2f41326741ce401351
Author: Qiliang Yuan <odys.yuan@gmail.com>

mm/compaction: keep compaction deferral state per migration mode

This commit updates compaction deferral state variables to be arrays
indexed by the sync migration mode. The deferral tracepoints are also
updated to include a sync field to indicate which state they report.

> diff --git a/mm/compaction.c b/mm/compaction.c
> index a049415512c67..7f8845d1990aa 100644
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
> +	int sync;
> +
> +	for (sync =3D 0; sync < ASYNC_AND_SYNC; sync++) {
> +		if (alloc_success) {
> +			zone->compact_considered[sync] =3D 0;
> +			zone->compact_defer_shift[sync] =3D 0;
> +		}
> +		if (order >=3D zone->compact_order_failed[sync])
> +			zone->compact_order_failed[sync] =3D order + 1;
>  	}
> -	if (order >=3D zone->compact_order_failed)
> -		zone->compact_order_failed =3D order + 1;
> =20
> -	trace_mm_compaction_defer_reset(zone, order);
> +	trace_mm_compaction_defer_reset(zone, order, true);

[Severity: Medium]
Does this miss tracing the async state reset?

The code in compaction_defer_reset() updates both the async and sync state
arrays within the loop, but the trace event is emitted outside the loop wit=
h a
hardcoded true argument for the sync parameter.

This seems to silently omit the state transition for async compaction where
sync is false. Userspace tracing tools might miss the deferral reset event
for async compaction and falsely assume it remains deferred after a reset.

Should this trace event be moved inside the loop to emit for both states, or
is there a reason to only trace the sync reset?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-bug-mm-thp=
-async-compact-defer-v1-0-0174c7923430@gmail.com?part=3D1
