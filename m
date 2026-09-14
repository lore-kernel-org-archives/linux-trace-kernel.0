Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E983F54D1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371427; cv=none; b=WU7XLgg/BJWeZC7DM9iOmXWGMjEcEtm4p70R2+VtkbvXYLyKoa2PBta48zE7mso7XOGf0yywEoA7J0kOOC3wXURYiI7YPMnpvxvDUYimUEj9jGRoT5KgHaEYXnAzxxqImQxlLYHSjAWS6nWWvRihRv3YdSBvwnXHhgX+nYzN7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371427; c=relaxed/simple;
	bh=lHcM3gDgNbmDT7VeCly2z1lKhlX1+1C8B5OkIWc1+wU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KDlU4pZVa9Ml5VpZqbpzGfuxTaqtB8x/UR5R16+RnO2RWsr5qhPcnd8GAXu+OYMbEPufD+C3pwEogUB++TupY62fwmmEJCXQjAsX3ShXEpWnwEBNUIoYm61oeLqqauIDCxmQVPzc+zVTkqer0uVNkbMI9rjSTrFlTg0x0X3r3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5DU2aIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5DU2aIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604D81F00899;
	Mon, 14 Sep 2026 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789371425;
	bh=zylNCGqqO6ki2dcqtDe6OD8LVkMXDPidvrxhJMgqewg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5DU2aIEXb0jCg/xukau3U4v8kQOHnlvujZVRfKqm8YxM5QfB/uH51nXY0LQZkmm9
	 pxs6udXR0qLvLYIKjNyb+3rT8kuS/btz3xa3t0C4YCzSz/AmD0XtioK4oMIOOP9BHG
	 O8Tvxmq83WRCkkxwkeKY/7aj//JXjk8xCoGwU1767Xo0zCr3bCHjWKws04Uc+fk9V7
	 qEitjp6ckvTMZsMzmnBCYMoqJxLp27lbl0nYk8t9T8I25/x7UmrXtNVV1WpsmrQLfc
	 D0rBPI7yHIeuAAQ+HuyJKgv3Zpbyf/OM/3OTFbeuR54b5wIZyJ7v+6rEL4qhDQ5kpK
	 dx6Tdsm90bEBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm: vmscan: rework lru_shrink and write_folio
 tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?cWl3dS5jaGVuKO+/ve+/ve+/ve+/ve+/ve+/vSk=?= <qiwu.chen@transsion.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260914072433.39636-1-qiwu.chen@transsion.com>
References: <20260914072433.39636-1-qiwu.chen@transsion.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:37:04 +0000
Message-Id: <20260914073705.604D81F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `mm_vmscan_lru_shrink_inactive` tracepoint prints `nr_ref_ke=
ep` twice and omits the newly added `nr_ref_activate` field.
- [Medium] Missing TRACE_DEFINE_ENUM exports for PGSTEAL_* enum values used=
 in trace_reclaim_reason_ops.
- [Medium] The patch breaks the in-tree `trace-vmscan-postprocess.pl` scrip=
t by altering tracepoint arguments without updating the script.
--

commit 415a9b2c51b867b9381070883253c78fbde68aee
Author: qiwu.chen <qiwu.chen@transsion.com>

mm: vmscan: rework lru_shrink and write_folio tracepoints

This commit reworks the lru_shrink and write_folio tracepoints for better
correlation and analysis. It traces each folio LRU type and reclaim reason,
adds activation statistics, and removes some unused reclaim flags.

> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index 8a872990b4bee..db6c6d2d777af 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
[ ... ]
> -#define trace_reclaim_flags(file) ( \
> -	(file ? RECLAIM_WB_FILE : RECLAIM_WB_ANON) | \
> -	(RECLAIM_WB_ASYNC) \
> -	)
> +#define trace_reclaim_reason_ops		\
> +	{PGSTEAL_KSWAPD,	"KSWAPD"},	\
> +	{PGSTEAL_DIRECT,	"DIRECT"},	\
> +	{PGSTEAL_KHUGEPAGED,	"KHUGEPAGED"}, \
> +	{PGSTEAL_PROACTIVE,	"PROACTIVE"}

[Severity: Medium]
Since this macro maps enums to strings for use with __print_symbolic(), do
these enum values need corresponding TRACE_DEFINE_ENUM() exports?

Without them, userspace tools like perf or trace-cmd will not be able to
evaluate the enum values from the trace format file and will fail to parse
the reason field.

[ ... ]
> @@ -495,29 +480,32 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>  		__entry->nr_activate0 =3D stat->nr_activate[0];
>  		__entry->nr_activate1 =3D stat->nr_activate[1];
>  		__entry->nr_ref_keep =3D stat->nr_ref_keep;
> +		__entry->nr_ref_activate =3D stat->nr_ref_activate;
>  		__entry->nr_unmap_fail =3D stat->nr_unmap_fail;
>  		__entry->priority =3D priority;
> -		__entry->reclaim_flags =3D trace_reclaim_flags(file);
> +		__entry->lru =3D lru;
> +		__entry->reason =3D reason;
>  	),
> =20
> -	TP_printk("nid=3D%d nr_scanned=3D%ld nr_reclaimed=3D%ld nr_dirty=3D%ld =
nr_writeback=3D%ld nr_congested=3D%ld nr_immediate=3D%ld nr_activate_anon=
=3D%d nr_activate_file=3D%d nr_ref_keep=3D%ld nr_unmap_fail=3D%ld priority=
=3D%d flags=3D%s",
> +	TP_printk("nid=3D%d nr_scanned=3D%ld nr_reclaimed=3D%ld nr_dirty=3D%ld =
nr_writeback=3D%ld nr_congested=3D%ld nr_immediate=3D%ld nr_activate_anon=
=3D%d nr_activate_file=3D%d nr_ref_keep=3D%ld nr_ref_activate=3D%ld nr_unma=
p_fail=3D%ld priority=3D%d lru=3D%s reason=3D%s",
>  		__entry->nid,
>  		__entry->nr_scanned, __entry->nr_reclaimed,
>  		__entry->nr_dirty, __entry->nr_writeback,
>  		__entry->nr_congested, __entry->nr_immediate,
>  		__entry->nr_activate0, __entry->nr_activate1,
> -		__entry->nr_ref_keep, __entry->nr_unmap_fail,
> -		__entry->priority,
> -		show_reclaim_flags(__entry->reclaim_flags))
> +		__entry->nr_ref_keep, __entry->nr_ref_keep,

[Severity: Medium]
Is the second __entry->nr_ref_keep here a typo?

It looks like it should be __entry->nr_ref_activate to match the format
string. The duplicated nr_ref_keep argument causes the correct
nr_ref_activate field to be ignored in the trace output.

[Severity: Medium]
Does the Documentation/trace/postprocess/trace-vmscan-postprocess.pl
script also need to be updated to handle this new format?

The script contains a hardcoded regular expression for this tracepoint:

$regex_lru_shrink_inactive =3D generate_traceevent_regex(
		"vmscan/mm_vmscan_lru_shrink_inactive",
		$regex_lru_shrink_inactive_default,
		"nid", "nr_scanned", "nr_reclaimed", "nr_dirty", "nr_writeback",
		"nr_congested", "nr_immediate", "nr_activate_anon",
		"nr_activate_file", "nr_ref_keep",
		"nr_unmap_fail", "priority", "flags");

Since flags was renamed to lru, and reason and nr_ref_activate were
added, the parsing logic in the script will fail on traces using this new
format.

> +		__entry->nr_unmap_fail, __entry->priority,
> +		__print_symbolic(__entry->lru, LRU_NAMES),
> +		__print_symbolic(__entry->reason, trace_reclaim_reason_ops))
>  );

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914072433.3963=
6-1-qiwu.chen@transsion.com?part=3D1
