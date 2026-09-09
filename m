Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD513BB138
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936316; cv=none; b=nMxppXfrgnY6GbmVga1sOa7CRKPDxEQnFuLcKOBWrN1CGa452+52tPB5I3zOuj9jfPdp44hmKj1ik/TXEzrZFZu3/yo18xtbNYNFNxW+3xXXRsK29cvgr0UqFiFKQCmGKW0yApVBAUp1ZPLmgdJVjdmiLH5t/Qgeh0XA5jZr65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936316; c=relaxed/simple;
	bh=Dbe73Tvs5EYLnu1vtoP1R/+TyEnhBF1khl9WMFgf1ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOzQZMXv2rwJNP4UKmx0hGS0gS1DAXLSKcNxK7j6QnH1hqzicXcGG3dJn+6H1W8/MgeBBEVTaddIAUX6wPRHLgca4u4hEWDMWtYlnLBOHY5/DVTvOs1KZyV7f10kq1CBonJEwgbVq+vGd8bVWOgM9uelZDTFp7LBPSiqeOuXT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhLgczlC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhLgczlC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8696A1F0155B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 06:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936314;
	bh=oXtI965ppSTiwbT7ipKM86YtHUyLj5gqRIWr+nTAhBA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IhLgczlCdWxFSegmkDizxcGCljjux3VJc/i0FEoY8gH2PXRUq4Ssn7Y30byvlShQN
	 gFCDQfZx7fm+duVZJvytrkcjU5b3C1wT8mzuIhcBd5/MFvOZQyvXERSN9mv0tAiSgL
	 5WRfo91cKBLXK0RSm9JXUt+1ypLzXGa+Hxid0r3sBUmNRgra8ny+lsL65oS3vB3jxA
	 uEJYCwVriFGytJVB5DZHLBxlxTvbZghw6a4Bnz3Pvg7GkJJXLdhx07aTck1sFxDWZw
	 4LFA6J5OxT6k7ridJrBHWXdlH9Ah/Ag33l3q6SpLU9s+DxJEMH8jlYgovnNHbGED7H
	 D9MjCaVN42fpA==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-939adff838bso207263685a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 23:45:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz9avaC8H+pCGIVYn1F7IgPtFtUBwa6+Zsgwj22dAVxO4hLs1Xy/1Fptf5qmk65kYLQ4IMKkxilWaMu+ybT/0KdrRQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lsKvGuO8kTjjOk4qvkWCzcPN1aTjvwHqsaoHBQM8OOz2AHL+/Y
	sAEmIj47T28otrg1ncYVX0W32EWJZvIQfIqQRDGO9r6n0cfgVFyON6rLALKhrS8G92+WnYlbPJu
	ctd/4N6QZtdkVwp/LK0clw6MS4iauGF0=
X-Received: by 2002:a05:620a:811f:b0:939:6dea:374b with SMTP id
 af79cd13be357-939804f7c81mr2852075085a.47.1788936313658; Tue, 08 Sep 2026
 23:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907042447.2450663-1-ridong.chen@linux.dev> <20260907042447.2450663-3-ridong.chen@linux.dev>
In-Reply-To: <20260907042447.2450663-3-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Wed, 9 Sep 2026 14:45:02 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zvJmdiicZAefUyjn4RjP=hBxE95fjpR9HM+SFJ8S_aCQ@mail.gmail.com>
X-Gm-Features: AcwNN1VgWoJtkBN10FObnIaNeshFsBlYP68mFG3ghCEpyRhlhxvLD1TMEuEii5k
Message-ID: <CAGsJ_4zvJmdiicZAefUyjn4RjP=hBxE95fjpR9HM+SFJ8S_aCQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] mm/mglru: add tracepoint for inc_max_seq
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

On Mon, Sep 7, 2026 at 12:25=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev>=
 wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> Aging in MGLRU advances max_seq via inc_max_seq(), creating a new
> youngest generation. There is currently no tracepoint on this path, so
> the moment a new generation is created, and how the min_seq of each type
> trails behind it, cannot be observed as it happens.
>
> Add mm_mglru_inc_max_seq, emitted right after max_seq is bumped, with
> the memcg id and the new max_seq alongside the anon and file min_seq.
> Paired with the mm_mglru_isolate_folios tracepoint it makes the full
> aging-to-eviction window observable per memcg.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---
>  include/trace/events/vmscan.h | 30 ++++++++++++++++++++++++++++++
>  mm/vmscan.c                   |  4 ++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.=
h
> index a0e3cf75294b..ab93c2f4b318 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -439,6 +439,36 @@ TRACE_EVENT(mm_mglru_isolate_folios,
>                 __entry->max_seq)
>  );
>
> +TRACE_EVENT(mm_mglru_inc_max_seq,
> +
> +       TP_PROTO(u64 memcg_id,
> +               unsigned long max_seq,
> +               unsigned long anon_min_seq,
> +               unsigned long file_min_seq),
> +
> +       TP_ARGS(memcg_id, max_seq, anon_min_seq, file_min_seq),
> +
> +       TP_STRUCT__entry(
> +               __field(u64, memcg_id)
> +               __field(unsigned long, max_seq)
> +               __field(unsigned long, anon_min_seq)
> +               __field(unsigned long, file_min_seq)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->memcg_id =3D memcg_id;
> +               __entry->max_seq =3D max_seq;
> +               __entry->anon_min_seq =3D anon_min_seq;
> +               __entry->file_min_seq =3D file_min_seq;
> +       ),
> +
> +       TP_printk("memcg_id=3D%llu max_seq=3D%lu anon_min_seq=3D%lu file_=
min_seq=3D%lu",
> +               __entry->memcg_id,
> +               __entry->max_seq,
> +               __entry->anon_min_seq,
> +               __entry->file_min_seq)
> +);
> +
>  TRACE_EVENT(mm_vmscan_write_folio,
>
>         TP_PROTO(struct folio *folio),
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 771fe6827939..3c806a57d113 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4065,6 +4065,10 @@ static bool inc_max_seq(struct lruvec *lruvec, uns=
igned long seq, int swappiness
>         WRITE_ONCE(lrugen->timestamps[next], jiffies);
>         /* make sure preceding modifications appear */
>         smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
> +       trace_mm_mglru_inc_max_seq(mem_cgroup_id(lruvec_memcg(lruvec)),
> +                                  lrugen->max_seq,
> +                                  lrugen->min_seq[LRU_GEN_ANON],
> +                                  lrugen->min_seq[LRU_GEN_FILE]);

I suspect we also want to know the number of pages in each generation,
similar to:

/sys/kernel/debug # cat lru_gen
memcg 1 /
 node     0
          0      25672          0          85
          1      25672          0        4249
          2      25672         21           0
          3      25672          0           0
memcg 19 /A
 node     0
          0      23036          0           0
          1      23036          0           0
          2      23036          0           0
          3      23036          0           0

Best Regards
Barry
