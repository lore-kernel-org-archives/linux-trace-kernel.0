Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C054B1D4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955929; cv=none; b=Xn7+FIw5o7Y7KNKAmW8sNxjyLvbMQfkNRWARap3JugxcshwNkZB0iHh+wBzEuw2SYS7/ldQNU04DbNxxlj30Z3S2BfylXoDiFPeueGATzjh4wXPh03S+Ta+P03NiTmSZoUnvSE8KTEph1eyQyssuKyXy58WXLit/1FsNy2rwcLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955929; c=relaxed/simple;
	bh=VEfNxTBF0yKDcirUsmnQrY84ZgUIpVi6XyMaVo/bUX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adeIEAdiva0DfBZUdy2+EFNdJV7y/wmcT34aKNMQgDjLj+Fzl17DLWeS9j2R/zanMsM2dZ/nhw6EeLe6khQDwX/XbFPe0jspryNDdwGUpYYxvk1lSV+bC+PUmopsgnlPUrV/DxsjGDc7fYQD6EW7zE9xkgK5ewd6hQWnZPNRdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6oBRNue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6oBRNue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0616C1F00A3A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955928;
	bh=FD1gsvGRC7hkDhQUoluFrtoGkFlmUbPoFR3CsiEk3K8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T6oBRNueMixlB9U/xFkN2puYBkY3OzQ7loF/gsggucoe2FH9ww8Rwh+bpvtPGkc9d
	 ccxtKG+EvKTigS9BcX+WZCkd+T0odFJHTgidMiNbEmTYVXgS367thaQvMFSsDVY2pY
	 5IsekUbgakPOf/Et22zbdIW4DH3fXwnw8ry1J+eeT3BwxTYzxXlGma83UOFx6ymGvJ
	 AgMFcjjmC/HkX2l0vRifZQLcDauHgDzZ6GbjCGUQUHhA/vgcloXdojnjdWwzZ25udS
	 Mp/Oa4ZccFJj4kxH17R8oYLo9e31BWkcj0WUYBSYHa1YkcIBhQVD1ZazRPrZXhxx+K
	 Ud6ZAK/xApJOg==
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66c70f69d3fso5445534d50.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 05:12:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy6Y9kNef3THF5Bq7GYyU/Qyc5SO5AuIXyd6GkPkHUnT3TDjnAjNy/SGj7a4oFmRziTyeDVyrF3Lc9zrBlSK/rsIK8=@vger.kernel.org
X-Gm-Message-State: AFuF++k72V7lWuN5Z6Ov+rha0vAsxCrQftuL9WI3sDNHQYMfYi0ooRM+
	+dchJC79VLepBnZBzIHAyKsyd2I6BsEXurwE6SGao+BEtwNyfuwSqjzg+1TScFVFXWvNxAPiLO9
	L8LOaIUtt7BF5XAfnUnL1OS/CftwkMBQ=
X-Received: by 2002:a05:690c:d8a:b0:873:5ddf:d862 with SMTP id
 00721157ae682-8735ddfd9abmr109509577b3.45.1788955927429; Wed, 09 Sep 2026
 05:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907042447.2450663-1-ridong.chen@linux.dev>
 <20260907042447.2450663-2-ridong.chen@linux.dev> <CAGsJ_4zT0HcbkQjdPFPBeaqbGcYp4WE6sghDzz=0evhhupCs3g@mail.gmail.com>
 <102f6ff6-46f9-4734-a056-694eb2c0129b@linux.dev>
In-Reply-To: <102f6ff6-46f9-4734-a056-694eb2c0129b@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Wed, 9 Sep 2026 20:11:55 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wxZ0pc0UMAXe3xKW0=PTzYv31ieoJa1v01SoLczPVOCA@mail.gmail.com>
X-Gm-Features: AcwNN1USPJswSmWSzvVf7WcWGE35FXyfN8FIwgGMrmaqVfupZIYniCIbPs_AXiQ
Message-ID: <CAGsJ_4wxZ0pc0UMAXe3xKW0=PTzYv31ieoJa1v01SoLczPVOCA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm/mglru: add tracepoint for folio isolation
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Hildenbrand <david@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:00=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev> =
wrote:
>
>
>
> On 9/9/2026 2:40 PM, Barry Song wrote:
> > On Mon, Sep 7, 2026 at 12:25=E2=80=AFPM Ridong Chen <ridong.chen@linux.=
dev> wrote:
> >>
> >> From: Ridong Chen <chenridong@xiaomi.com>
> >>
> >> MGLRU's scan_folios() and evict_folios() emit the classic-LRU
> >> tracepoints trace_mm_vmscan_lru_isolate() and
> >> trace_mm_vmscan_lru_shrink_inactive(). Those predate MGLRU and are
> >> indistinguishable from the classic-LRU path: they carry no generation,
> >> sequence, memcg or swappiness context, so a trace of an MGLRU run cann=
ot
> >> tell which memcg a given scan/evict belongs to, nor how far reclaim ha=
s
> >> progressed through the generations.
> >>
> >> Add mm_mglru_isolate_folios, emitted once per isolate_folios() call wi=
th
> >> the memcg id, the type actually scanned, the effective swappiness, the
> >> scanned/isolated counts, and the anon/file min_seq and max_seq. The
> >> min_seq/max_seq triplet ties each isolation to the generation layout i=
t
> >> ran against, which the classic-LRU tracepoints cannot express.
> >>
> >> This is emitted at the isolate_folios() layer, which is MGLRU-specific
> >> and has no classic-LRU counterpart, so it neither changes nor duplicat=
es
> >> the existing scan/evict tracepoints.
> >>
> >
> > I have no objection to MGLRU having some tracepoints. However, one
> > major concern is that the code is changing rapidly, so the tracepoints
> > may not be stable. We would need to maintain them as the code evolves.
> >
>
> Indeed. GEN-LRU has been available for several years now, and many vendor=
s are
> already using it, so adding tracepoints is a necessary step.
>
> >> Assisted-by: Claude:claude-opus-4-8
> >> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> >> ---
> >>   include/trace/events/vmscan.h | 47 +++++++++++++++++++++++++++++++++=
++
> >>   mm/vmscan.c                   |  9 ++++++-
> >>   2 files changed, 55 insertions(+), 1 deletion(-)
> >>
> > [...]
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 8409ea4bbf37..771fe6827939 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> > [...]
> >> @@ -4876,6 +4877,12 @@ static int isolate_folios(unsigned long nr_to_s=
can, struct lruvec *lruvec,
> >>                  goto retry;
> >>          }
> >>
> >> +done:
> >> +       trace_mm_mglru_isolate_folios(mem_cgroup_id(lruvec_memcg(lruve=
c)),
> >> +                                     type, swappiness, total_scanned,=
 *isolated,
> >> +                                     lrugen->min_seq[LRU_GEN_ANON],
> >> +                                     lrugen->min_seq[LRU_GEN_FILE],
> >> +                                     lrugen->max_seq);
> >
> > Maybe `scan_folios()` would be a better place for this, as it can more
> > directly reflect what we're doing for each type.
> >
>
> scan_folios() already contains the trace_mm_vmscan_lru_isolate
> tracepoint(traditional tracepoint), but it lacks any GEN-LRU-specific
> information. Adding another tracepoint there would be redundant. Therefor=
e, I
> placed the new tracepoint in isolate_folios(), where it can capture GEN-L=
RU's
> specific details. Additionally, it can indicate whether a fallback to the=
 other
> type has occurred.

if `trace_mm_vmscan_lru_isolate` is located in `scan_folios()`, that
would be strong evidence that `scan_folios()` is a better place for
adding a new tracepoint for LRU gen.

There is no need to avoid this location just because we already have a
tracepoint here. In fact, I think this is evidence that it is a better
place, not the opposite.

BTW, `isolate_folios()` might be deleted soon, depending on how we
improve MGLRU and on some ongoing work from Kairui. But `scan_folios()`
should be long-lived, as we need to scan folios in any case. Therefore,
adding tracepoints to `isolate_folios()` doesn't seem to be related to
the stable ABI concern mentioned in your cover letter.

Best Regards
Barry
