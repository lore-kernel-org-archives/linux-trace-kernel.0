Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763641A285
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768791874; cv=none; b=egGw39XBjkmIYZw8WFoFNo+1IUi8Bsqe2Cmx/IIUpSIxay1//l6rzHDACz6SzA6XUo7u8z+SojkpsUND5elJYtnlnkaJQzYqVI0k6iu4+6X1qgC09dsUdu5j6AHOBOD89apLtcD5GyTB0k4KtGDi9slvM2xP6PHnOFS1SFB1ag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768791874; c=relaxed/simple;
	bh=+TI6sBxOJKsv8MhTy33Y548WnrgXy/hVxgoHBysWXsU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=eVggpzcsVM9BjJDSpYnRpQQAYf5D/OR+kWawmFIq9OdkJ3+XMJ8L8tgm5uJKbZUx6PJ5Nl4FPMQysCymKPqYJvMzyxliRCfz5p+NKxynadvhL17VAJIDCWexHmE+LwkxutmsDCqLc2lRc9aJ6+yOrMstL59P/7L+DDnf3uVnL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rq/ykZcg; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rq/ykZcg"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768791860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nD9B2kYFWIUGWewoKq7H29ys6yJUvy9QvdM6wh6FK64=;
	b=rq/ykZcgTNXXpeCZNRhMD97B1NzxYWBX7+pY5JhDMpfhrm7H/C/BL/Rpf6ZhczarhbX+HL
	2ja55dd2CLPC3GtqFevZ2gSfKbMNzj7HNIR0+tMRjGoCEqcjk4lF3Q2hMEO7OB/Tq+zoS+
	0yy1L6URaPr39QXYqBSrhjXA8bRL6TE=
Date: Mon, 19 Jan 2026 03:04:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <562a3b0db8bed7a1f13c3e1b8ccc846181226b5b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3 1/2] mm/vmscan: mitigate spurious kswapd_failures
 reset from direct reclaim
To: "Johannes Weiner" <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, shakeel.butt@linux.dev, "Jiayuan Chen"
 <jiayuan.chen@shopee.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "David Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Axel Rasmussen"
 <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>, "Wei Xu"
 <weixugc@google.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Brendan Jackman"
 <jackmanb@google.com>, "Zi Yan" <ziy@nvidia.com>, "Qi Zheng"
 <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <aWpukFnKRoeSrcEZ@cmpxchg.org>
References: <20260114074049.229935-1-jiayuan.chen@linux.dev>
 <20260114074049.229935-2-jiayuan.chen@linux.dev>
 <aWpukFnKRoeSrcEZ@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

2026/1/17 01:00, "Johannes Weiner" <hannes@cmpxchg.org mailto:hannes@cmpx=
chg.org?to=3D%22Johannes%20Weiner%22%20%3Channes%40cmpxchg.org%3E > wrote=
:

[...]
> >=20
>=20Great analysis, and I agree with both the fix and adding tracepoints.
>=20
>=20Two minor nits:
>=20
>=20>=20
>=20> @@ -2650,6 +2650,25 @@ static bool can_age_anon_pages(struct lruvec=
 *lruvec,
> >  lruvec_memcg(lruvec));
> >  }
> >=20=20
>=20>  +static void pgdat_reset_kswapd_failures(pg_data_t *pgdat)
> >  +{
> >  + atomic_set(&pgdat->kswapd_failures, 0);
> >  +/*
> >  + * Reset kswapd_failures only when the node is balanced. Without th=
is
> >  + * check, successful direct reclaim (e.g., from cgroup memory.high
> >  + * throttling) can keep resetting kswapd_failures even when the nod=
e
> >  + * cannot be balanced, causing kswapd to run endlessly.
> >  + */
> >  +static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest=
_zoneidx);
> >  +static inline void pgdat_try_reset_kswapd_failures(struct pglist_da=
ta *pgdat,
> >=20
>=20Please remove the inline, the compiler will figure it out.
>=20
>=20>=20
>=20> + struct scan_control *sc)
> >  +{
> >  + if (pgdat_balanced(pgdat, sc->order, sc->reclaim_idx))
> >  + pgdat_reset_kswapd_failures(pgdat);
> >  +}
> >=20
>=20As this is kswapd API, please move these down to after wakeup_kswapd(=
).
>=20
>=20I think we can streamline the names a bit. We already use "hopeless"
> for that state in the comments; can you please rename the functions
> kswapd_clear_hopeless() and kswapd_try_clear_hopeless()?
>=20
>=20We should then also replace the open-coded kswapd_failure checks with
> kswapd_test_hopeless(). But I can send a follow-up patch if you don't
> want to, just let me know.
>

Thanks, Johannes and Shakeel. I'll send an updated version with these fix=
es.
