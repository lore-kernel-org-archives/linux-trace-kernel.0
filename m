Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472937;
	b=Mv1sBjKx9B5MQXqj5NViC9MyYEo4sgfLMy58bdCxHvfjPM5RNdpfQeGYJ5d7W93GjaPJ
	 t2u4ilpP9SUQ8KFK27GUpGAk6xfnV2kZEnEy4SsDrlgorM6BhWZqCjyUASm4iWwhfS95L
	 S3WPSWQ3dD4aDb2uSARAsR6sIuAbJyQjpU2x4bE9NSCsYUdtUFY/1sZIMkfOlnhJeA4vo
	 F8UTj78WBxDak4AYCgkDyDbY84KchARFPxiUyJ5Wvb91ExsD2+xvgx527rb6yhrzxUZx9
	 I806z/t7dqyaGoiAV2zkD3V2tLWReomPSGs2sbQFQPsPPG7DPSyz9icOZKFtfyjlP9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472937;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ial8iAsSa5eOrYsCj4SMZLA9EuKpEQEbZW4C+PxDTJA=;
	b=pntWsXsfuMxghEe+msoXFSRktFi/o+glqb8t9adfgQs4q+5HC9KaOdK0aL12UqGfVhP1
	 7jEn2wgK7xtkBIOq8nW57TJTzYNgWQ4VLqFUSAporn6wg/taK6NdNLXRJ1K3oZ1XHyMpl
	 K8n3Vh0/Xfziz+5LscOyplBRc+1VBoCj/k4R0fc3EdjqBWg++XP0NhTX6cQdSGekNrJ2G
	 9lJVksd1eiuJ/5b5o+DsjHsH205SMngk9+O722zXWhYcF+6zIb/nbeVWuM1hfT4eqI50/
	 ZBlDlWw+pla5JiphposE3o79d+FbLPgaG3ruuCJFv3FfRWgONIOmeqfD2NPTR+wqogg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O/G0E/GO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74819606C82D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O/G0E/GO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7D31F00A05;
	Thu, 12 Nov 2026 08:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472937;
	bh=ial8iAsSa5eOrYsCj4SMZLA9EuKpEQEbZW4C+PxDTJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/G0E/GOhzhWvj3+aPjuf/R81zEodFSmOd/3hcJXfsGxzBO9PPKa9mlTwPJcax3iB
	 OdVCU1tSe9ntSNCMaNVqhAKbp00jbrwhPiLDlraF8pCZsdU08OTlvBi2e/a1g26EZb
	 959/ReDHNObr+I8FCl+MWYtz9BJ+FZIllaNxscVo9Z/V3p8sLQx+aaN9ITpw347yhS
	 qPSC7uFh8akjso25gvhq3e10LYYf3z4Vlcq2hPhORVs68vxkSyaGUhwfD+kbHW2fSO
	 rFnl+8q2KMWAH5ZzLblj2XKbL3h7faSTarrZrWPG1dLixZjTGLEgdnnvgpAVgTMt0u
	 Xn0VDYHJDiHBw==
Message-ID: <sashiko-outbox-210762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/compaction: Mark concurrent compact_considered
 accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>, akpm@linux-foundation.org
Cc: vbabka@kernel.org, hannes@cmpxchg.org, ziy@nvidia.com, rostedt@goodmis.org, mhiramat@kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, syzbot+212c2d1f47994035cf7f@syzkaller.appspotmail.com
In-Reply-To: <20261111084205.80997-1-zhujun2@cmss.chinamobile.com>
References: <20261111084205.80997-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:42:16 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] mm: data race in compaction_deferred() [1]
--

commit 065fba640e4d4df80527a642f4adcbe5f31c8683
Author: Zhu Jun <zhujun2@cmss.chinamobile.com>

mm/compaction: Mark concurrent compact_considered accesses

This commit marks concurrent reads and writes to zone->compact_considered
with READ_ONCE() and WRITE_ONCE() to avoid KCSAN data race reports.

> diff --git a/mm/compaction.c b/mm/compaction.c
> index a049415512c67..2ac6af7c1ee59 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -126,7 +126,7 @@ static unsigned long release_free_list(struct list_he=
ad *freepages)
>   */
>  static void defer_compaction(struct zone *zone, int order)
>  {
> -	zone->compact_considered =3D 0;
> +	WRITE_ONCE(zone->compact_considered, 0);
>  	zone->compact_defer_shift++;
> =20
>  	if (order < zone->compact_order_failed)
> @@ -142,15 +142,16 @@ static void defer_compaction(struct zone *zone, int=
 order)
>  static bool compaction_deferred(struct zone *zone, int order)
>  {
>  	unsigned long defer_limit =3D 1UL << zone->compact_defer_shift;

[Severity: Medium]
This problem wasn't introduced by this patch, but should concurrent
accesses to zone->compact_defer_shift also be marked to avoid a data race
[1]?

Multiple CPUs performing page allocations under memory pressure call
defer_compaction(), compaction_deferred(), compaction_defer_reset(), and
compaction_restarting() concurrently without a common lock, reading and
updating zone->compact_defer_shift via plain C accesses.  This causes KCSAN
warnings and can corrupt compaction deferral limits.

[1] https://sashiko.dev/#/bug/linux-b61fd78e-8874-42f5-bbe1-bcd3914879cc

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111084205.8099=
7-1-zhujun2@cmss.chinamobile.com?part=3D1
