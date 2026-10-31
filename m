Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481700;
	b=g8guXj/R5i3khrK0jpwCxNECsx+HzU+bMapls4yQF2vorH7nuDGMwRlYGjwexCy9/7wf
	 a9eL2ePCdqVf2mGPPOvqBF5bEG8Uie7sCzs3nbJM8gCL0lLui4b+F9+X1AaTbOZQDUE55
	 k9U5GFnTDSuprawV7ItJ8X36kEwBFvi/IEwlp7s78Fi5igpkJPMfauugt5+1DrdB89Hot
	 RqKSeUt/+a8vXmhppXXO20UclcuXX0ud373YpkRbHcwVr2aBzXWO6mD7BKoIcj0S41SFH
	 buLpbn30rHm1hDgDCysQY9OerWLqGiEqgq7yRdvqHIqh6SIxi9Ul5zMtMZq4axCg9Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481700;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ty94gSbhmDD5BIMgrsH4AK83dBi7LvnXvW0bmqOEn6Q=;
	b=4rAXijPiyMP5hXdC1NG8sZVEqrVs6TaeyaWpbTRv8YVnYr7i47zO9yHA4cclk788ncvy
	 Xth3B/KHHLGIDdWVVCe/X5tQFP8BJVa50z+7ZX4qbbZ2h3xfWKukO9hz9eU/7Ul5o1dft
	 1BumtMfzGfJoPhlJfKXcC9E0MM9DGgUT3u1L5A4VpPMadFWSHC3WJkzo8XjggJUE3IdXL
	 xzU+iqxgDAIYkvsE5dj7Q0uvewFA0gw4AErnfwQ7FE1T02W7+lQhy+AJ9Ohs5/FmDb0TE
	 4v9vX4ErRofel35OyGVHB1fNt5N2rL+/TMrNCFS5N3UCTrB0HULEHteUsvFcAlJlvFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgOEpBpX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D4606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgOEpBpX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE19B1F00A27
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793481700;
	bh=ty94gSbhmDD5BIMgrsH4AK83dBi7LvnXvW0bmqOEn6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kgOEpBpX1LsYBAVB6hT/TEvjRTxXkDHPdjkVsNZjGEc1DltRtW/mCjPpIVTO6pZCP
	 eVEzWE+mFjHaf4VLcrYnv/4L2gBn3zffsLPlnaXBV2w6Z57NJ4+NtY4C/rKib1edHH
	 flRKy+1HtQOHla7hFeJph4xAmXwtuLDYXTuFlw5Bh81HckwTbSVE5gz1OYRZmLAMHU
	 mHqf7cV/rHCchcNWnBvsZQx0zOg9kDMZE5enYtyFgHDOTtZMLYZ01jAUWBGaLdNafn
	 KpaQ0AJCs5VCh05mmrlgwy22ms8I+8LbgmOlTSX1NsUYCj4rt5HjEial2+f/mzC2Ta
	 wRtRI9G4Xa8Fg==
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5361e313e63so20622361cf.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 14:21:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwsf61oJmymSHkk4aqOGb1JvTOh7DRFcq9hTHFFNbfYwfDcVsMv46LYCGp1HjNfxOg7NmZKD6i1tTqlNxP2/7Mbl08=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIz87HmUBa4s+iaMMQ8uv1vmQAnTUeJnq5M3N8MHXhbhVfeq77
	d40pNzVX4xe00s1BQjoqQa2kkBmIr7aoH4yFky7WrHHfcC1XpH2tjzWm8UqWyhuD/7f3Jh8OPWI
	XhpxNaFh+ASuDUD7VmvOx/f5jvlYGTSU=
X-Received: by 2002:a05:620a:1a04:b0:93e:7939:acd0 with SMTP id
 af79cd13be357-944216bd289mr1066244785a.37.1793481699158; Sat, 31 Oct 2026
 14:21:39 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031090041.58574-1-ridong.chen@linux.dev> <20261031090041.58574-7-ridong.chen@linux.dev>
In-Reply-To: <20261031090041.58574-7-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Sun, 1 Nov 2026 05:21:27 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zUbkFXBhAesVV74-Ndga5f6xEbestK7Qinqddip8xBrw@mail.gmail.com>
X-Gm-Features: AclHuK9WNH9aLICSgSeVZV5too_5MSDmgtyvPVk6Q01fvL_ZF8MPvPlJAdKgm4w
Message-ID: <CAGsJ_4zUbkFXBhAesVV74-Ndga5f6xEbestK7Qinqddip8xBrw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm/mglru: add tracepoint for inc_max_seq()
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>, Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 5:02=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev>=
 wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> Aging in MGLRU advances max_seq via inc_max_seq(), creating a new
> youngest generation. There is currently no tracepoint on this path, so
> the moment a new generation is created, and how the min_seq of each type
> trails behind it, cannot be observed as it happens.
>
> Add mm_mglru_inc_max_seq, emitted right after max_seq is bumped while
> the lruvec lock is still held, with the node id, memcg id, the new
> max_seq, the anon and file min_seq, and the number of pages in each
> generation for both types, summed over zones and clamped to >=3D 0 the
> same way the debugfs lru_gen file reports them. The nr_anon/nr_file
> arrays are indexed by generation slot, so the emitted max_seq/min_seq
> say which slot holds which seq. They are printed with __print_array(),
> so the output is hex and its length follows MAX_NR_GENS automatically.
>
> Only the lruvec is passed in; all of the above is collected in
> TP_fast_assign(), so inc_max_seq() does no extra work when the event is
> disabled. Paired with mm_mglru_scan_folios it makes the full
> aging-to-eviction window observable per memcg.
>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---
>  mm/trace_vmscan.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  mm/vmscan.c       |  2 ++
>  2 files changed, 49 insertions(+)
>
> diff --git a/mm/trace_vmscan.h b/mm/trace_vmscan.h
> index 8148b8224422..cddf42b5849a 100644
> --- a/mm/trace_vmscan.h
> +++ b/mm/trace_vmscan.h
> @@ -456,6 +456,53 @@ TRACE_EVENT(mm_mglru_scan_folios,
>                 __entry->min_seq)
>  );
>
> +TRACE_EVENT(mm_mglru_inc_max_seq,
> +
> +       TP_PROTO(struct lruvec *lruvec),
> +
> +       TP_ARGS(lruvec),
> +
> +       TP_STRUCT__entry(
> +               __field(u64, memcg_id)
> +               __field(unsigned long, max_seq)
> +               __field(unsigned long, anon_min_seq)
> +               __field(unsigned long, file_min_seq)
> +               __array(unsigned long, nr_anon, MAX_NR_GENS)
> +               __array(unsigned long, nr_file, MAX_NR_GENS)
> +               __field(int, nid)
> +       ),
> +
> +       TP_fast_assign(
> +               struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
> +               int gen, zone;
> +
> +               __entry->memcg_id =3D mem_cgroup_id(lruvec_memcg(lruvec))=
;
> +               __entry->max_seq =3D lrugen->max_seq;
> +               __entry->anon_min_seq =3D lrugen->min_seq[LRU_GEN_ANON];
> +               __entry->file_min_seq =3D lrugen->min_seq[LRU_GEN_FILE];
> +               /* summed over zones and clamped to >=3D 0, as debugfs lr=
u_gen does */
> +               for (gen =3D 0; gen < MAX_NR_GENS; gen++) {
> +                       __entry->nr_anon[gen] =3D 0;
> +                       __entry->nr_file[gen] =3D 0;
> +                       for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
> +                               __entry->nr_anon[gen] +=3D
> +                                       max(lrugen->nr_pages[gen][LRU_GEN=
_ANON][zone], 0L);
> +                               __entry->nr_file[gen] +=3D
> +                                       max(lrugen->nr_pages[gen][LRU_GEN=
_FILE][zone], 0L);
> +                       }
> +               }

I feel this is wrong. Can we calculate the newest and
oldest generations from seq, then print them in order
from newest to oldest?

The nr_pages[] array isn't ordered from newest to
oldest or vice versa, as we have:

static inline int lru_gen_from_seq(unsigned long seq)
{
        return seq % MAX_NR_GENS;
}

And I added a helper here:
https://lore.kernel.org/linux-mm/20261022220203.91911-11-baohua@kernel.org/

+static inline unsigned long lruvec_gen_size(struct lru_gen_folio *lrugen,
+ int type, unsigned long seq)
+{
+     int gen =3D lru_gen_from_seq(seq);
+     unsigned long size =3D 0;
+
+     for (int zone =3D 0; zone < MAX_NR_ZONES; zone++)
+          size +=3D max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+     return size;
+}

Maybe you could port it here as a separate patch so it
can land earlier as part of your tracepoints series. We
could then use it in the next version of the swappiness
series.

Best,
Barry
