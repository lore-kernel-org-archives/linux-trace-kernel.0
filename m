Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F624B8280
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596708; cv=none; b=ru2CummMdBBgITLs+RVnVbwm86Mkmu7Wzq3f1fxm2KJMTwkSorJnI6Om6urYPTrCBglkGEgEWUrQ2EpSUUAXXB5caNvidAayHAi9RZpRjtaDvE3vIQKfgY/xXFntXSWdxjhM1u5EoJlpbBz8PAZqt4xkSQcKPMIgagw1TwLL7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596708; c=relaxed/simple;
	bh=E7W6OJqrArXZwdvGEx7J3Iy0KtBFzD++01Q5349IKX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vFv+n7yNW5cwRmQWrwsw6BNoE/OStxDLfdiQpPXg7wEf6jqPovyNd7ACA9Y6UXr9v54aMFGsirAkfyRpvnLpXkY6FyeYZMoci2DVsLOt4ekz8OYW5duNSDhniHLA4Xl3u3fQAq8yTA8Xo0BbU8TpzwebWcq7pUTBPknCAu90fpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNdaacVP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNdaacVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B291F00893;
	Mon, 28 Sep 2026 11:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790596707;
	bh=AJsffS0MEBK8gh7T/d5kNFzV3w+EQT2pZ0V14SA6fVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BNdaacVPQ2qgmwtpHr8Ed2Ir7WiueycKo0KQlnZolBP+D2DfVXF9PXHlPUa6dCANT
	 B7evcr8CAg8QQJyNtAXTK5rSJEN7pi1rUNDdpCwz0fjfNCC17cI3O7LjsU4/5sFEh/
	 sf6GGELmdwQNXjH0JbAdHoIYVItjSo6MRtCp1E8hm3u++eA4SDW7IXchfRz5qwYoES
	 6xaoHCoHypa2eiaNHwn6fGjqcMJia5JRZOb7e4nDKbz38xUCcEtYvbOZa9mDp1uGWZ
	 WPwK+RVggORhmkKRoqRp4Tpr9tfk1VTnI6hioVbIsDZ5rxuCosKaEN/Z5hbvtTf3YN
	 GyS+PJLhAhgDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 7/7] mm/vmscan: pass scan_control to
 mm_vmscan_balance_pgdat_end
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ridong Chen" <ridong.chen@linux.dev>
Cc: hannes@cmpxchg.org, linux-trace-kernel@vger.kernel.org, tj@kernel.org, mkoutny@suse.com
In-Reply-To: <20260928114625.3609130-8-ridong.chen@linux.dev>
References: <20260928114625.3609130-1-ridong.chen@linux.dev>
 <20260928114625.3609130-8-ridong.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 11:58:26 +0000
Message-Id: <20260928115827.18B291F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: BPF raw tracepoint ABI breakage and commit message mismatch =
in mm_vmscan_balance_pgdat_end
--

commit eb8bc6091aab714af4b68f316fecfc08d43c39dc
Author: Ridong Chen <chenridong@xiaomi.com>

mm/vmscan: pass scan_control to mm_vmscan_balance_pgdat_end

This commit updates the mm_vmscan_balance_pgdat_end tracepoint to receive
a struct scan_control pointer rather than passing individual struct fields.
It updates the TP_PROTO and TP_ARGS while leaving the exported event format
unchanged.

>     balance_pgdat() passes sc.order and sc.nr_reclaimed to
>     mm_vmscan_balance_pgdat_end as bare arguments. Pass the enclosing
>     struct scan_control instead and read the fields out in TP_fast_assign,
>     mirroring mm_vmscan_balance_pgdat_begin. highest_zoneidx stays a

[Severity: Medium]
The commit message states this change is "mirroring
mm_vmscan_balance_pgdat_begin." Is this description accurate?

Looking at mm_vmscan_balance_pgdat_begin in mm/trace_vmscan.h, it still tak=
es
individual arguments and was not updated to take struct scan_control *sc:

TRACE_EVENT(mm_vmscan_balance_pgdat_begin,
        TP_PROTO(int nid, int order, int highest_zoneidx),

Could the commit message be more precise about the rationale?

> diff --git a/mm/trace_vmscan.h b/mm/trace_vmscan.h
> index 04f285e776596..c27bc7cc60630 100644
> --- a/mm/trace_vmscan.h
> +++ b/mm/trace_vmscan.h
[ ... ]
> @@ -124,10 +124,9 @@ TRACE_EVENT(mm_vmscan_balance_pgdat_begin,
> =20
>  TRACE_EVENT(mm_vmscan_balance_pgdat_end,
> =20
> -	TP_PROTO(int nid, int order, int highest_zoneidx,
> -		 unsigned long nr_reclaimed),
> +	TP_PROTO(int nid, struct scan_control *sc, int highest_zoneidx),
> =20
> -	TP_ARGS(nid, order, highest_zoneidx, nr_reclaimed),
> +	TP_ARGS(nid, sc, highest_zoneidx),

[Severity: Medium]
The commit message mentions there is "No functional change", but could this
modification break existing BPF programs hooked to this tracepoint?

While standard trace events parse the formatted output, BPF raw tracepoints
consume the TP_PROTO arguments directly via ctx->args. Changing the number
and type of arguments alters the BPF raw tracepoint ABI for this event.

Does this inadvertently break user space tools that attach to this raw
tracepoint and expect the 4 original arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928114625.3609=
130-1-ridong.chen@linux.dev?part=3D7
