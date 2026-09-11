Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E264534AE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112569; cv=none; b=pDNRj7JFGDSkESKAph/mpFTAZnY+/fFyxx331EsPax/Ed9aTblH9ECnB19ZMbVl2AOqgrIt2BTJDdlN2Cuxx5JERVDXhM6vENr18fgeZaSDfMA83fKT1tytyPcZmG24dnYNpAITOP1GvRqqHmJ5vBFPZzZQPDgVGIMt9wGNfydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112569; c=relaxed/simple;
	bh=AgXohcXYxTOYFDGUisGC8NK1A/jY5U9xvZmpnbRFk/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=djms9y/8ngCBbmlMglMbR/xesHxrXW/U+7H8iZGcKhhAhb2ZzjDBIyP+e9lLnwWL3GvlCf8GfWO6eboTzL+gOCmNBBEEoPbTYvFJRhxNHOGG4amnelavtgYnyIF43bEXqQtTq+v6NILs//v0znoXCbCXXft6S9KdJOMewHJe52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chVAjX7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chVAjX7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CA11F000FF;
	Fri, 11 Sep 2026 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789112566;
	bh=db2tScTkNeCi2YKa2bBBhQKol1ydzSzEyWhDKsdPGdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=chVAjX7naCy8WrzV7VP6ZIBYB16ozJePzD+P3IZB3AeMlkzRPJvdcXOo6EervelxB
	 zMxDYOUNLzvK2CidAnQHGIiQo98oocWqf2lA82Ga7EyqMnu57+5M/Kn8iWbn7o1N6v
	 +Mzz7Oy86LkWUikmxz3EidP7b53yQtiCQahF4/nII7YQkBG0CCDzFoAKNlYeZCs4PF
	 pEjNh75KX4CO8jGJSCY0TI3HE4BH5gQH3fzpQMe5DL7LeNkytf2a6zEfWPUpeuytUO
	 wAWW4Bxbz6KtfE7TJW8SQ6Oz7Kg6F0vg3Ybh+W5eErRM6ctxCsTkf6INJJ5tjY9mDn
	 do97qyFN975rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] mm/mglru: add tracepoint for scan_folios()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ridong Chen" <ridong.chen@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260911072848.2346073-3-ridong.chen@linux.dev>
References: <20260911072848.2346073-1-ridong.chen@linux.dev>
 <20260911072848.2346073-3-ridong.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:42:45 +0000
Message-Id: <20260911074246.03CA11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Evaluating pointer dereferences at the tracepoint call site adds=
 unnecessary overhead when tracing is disabled.
--

commit 3d7b5caa2f51b1f8f623f8379f3a020ee141f537
Author: Ridong Chen <chenridong@xiaomi.com>

mm/mglru: add tracepoint for scan_folios()

This commit introduces a new MGLRU-specific tracepoint,
mm_mglru_scan_folios, to report scan and isolate counts along with
MGLRU-specific context like memcg ID, generation, and tier. The tracepoint
is placed alongside the classic-LRU tracepoint in scan_folios().

> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
[ ... ]
> +TRACE_EVENT(mm_mglru_scan_folios,
> +
> +	TP_PROTO(u64 memcg_id,
> +		int highest_zoneidx,

[Severity: Medium]
Does this prototype incorrectly accept an evaluated u64 instead of a pointe=
r?

Accepting the evaluated value here forces evaluation at the call site.
Could we pass the struct lruvec pointer in the prototype instead, so the
expensive pointer dereferences can happen safely inside TP_fast_assign
where they only execute when tracing is enabled?

> +		int order,
[ ... ]
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
[ ... ]
> @@ -4927,6 +4927,12 @@ static int scan_folios(unsigned long nr_to_scan, s=
truct lruvec *lruvec,
>  	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
>  				scanned, skipped, isolated,
>  				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> +	trace_mm_mglru_scan_folios(mem_cgroup_id(lruvec_memcg(lruvec)),
> +				   sc->reclaim_idx, sc->order, nr_to_scan,

[Severity: Medium]
Can this introduce unnecessary overhead on the memory reclaim hot path?

Because trace_mm_mglru_scan_folios evaluates its arguments before checking
the tracepoint's static key, calling mem_cgroup_id(lruvec_memcg(lruvec))
here forces multiple pointer dereferences to happen unconditionally.

The compiler cannot optimize them into the inactive branch because it cannot
prove the arbitrary pointer accesses won't trap. Placing the dereferences
inside TP_fast_assign avoids this execution when tracing is disabled.

> +				   scanned, sorted, skipped, isolated,
> +				   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON,
> +				   lrugen->max_seq, tier,
> +				   lrugen->min_seq[type]);
> =20
>  	*isolatedp =3D isolated;
>  	return scanned;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911072848.2346=
073-1-ridong.chen@linux.dev?part=3D2
