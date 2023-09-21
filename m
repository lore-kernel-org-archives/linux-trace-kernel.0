Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919114D8F9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:11:32 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2661019C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:11:12 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bd04558784so749788a34.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695319872; x=1695924672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/nh5+0PZETjSMJy4nh4EngmscUGhpVzLurVdwdj6j0=;
        b=3p19Skb/9J42gy6CAxNTAHnAr91iC9nd8HrZuW3QOZAhn9WG/P6aBwRhp8rWHd7tjv
         xlJFpgk5im6uWCYJzXFsKe3SlsTE1GGpdhNB8FQX3fxLFjrRaw8emZytkGmpe4lH2fk4
         N+cx0IcZkVbpUNAIBSWuUe7sxvBJkgalNHGHemg7mTxHNZ9mFIqr4DTKCsPa2hGU/Lgl
         C7ULHVTum5pI6pc6+2Jh64O9P7CcqxWLLYB+NN2SlN/seA/6K4yiA1fryJbL5AhdhYOn
         JdaUY8sQkjEd914SHKa4foS7HRTsWIt82a4uIogRsLf0OLJMOAmyofq3a7lQaTuMfN3X
         Johg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319872; x=1695924672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/nh5+0PZETjSMJy4nh4EngmscUGhpVzLurVdwdj6j0=;
        b=J74ONrcnb7dFs9VAztIhc/cLSfgxbPPCNlkASg6uhcbi7Vs3xePso0WGE4UvEMiwhB
         1QJMzhBRIaCszgVbj6CQ5DA7nEkYauM+YUNOjdpj2hpWISSvQTUNnPOLsw72tGdjb/KW
         pGHx9tXh4G9yT0Ii0V3dl8Vk/AmW6rU3xp62YNaAcYOpjCoZq6eIV+jphSxibS0f/MrY
         WGOzXrfcOEc1e2VcuShxPXl+TvSjPCdYirGs9buTRYgqSFWuVeEW4DaI4l6IpgpC5gYW
         0MHBTrXSHSUb8iQBlk/8uFeiLX63iJvvvohTxm1LfZHeMzOb3ctXR09uWY8hWlLFDMh2
         UGkg==
X-Gm-Message-State: AOJu0YzW644lnRsWiZ5XqQO25hVs6KlVZiI+UhjCPbaAgBw8ybauUyzH
	LC5nNn9oT0IyHy3Ow/SYCs5zmr09C46Va+dOAuVO39oRhNvzdRJtRzi2BA==
X-Google-Smtp-Source: AGHT+IGYKYW646WETikplKcYFAQrsxX7SCEIo5f6CzP9FAr+rMBHhocm1DBGv3sdWJuyceNTUOP9LEJJdPfpuiCuC1k=
X-Received: by 2002:a25:cf07:0:b0:d15:7402:f7cd with SMTP id
 f7-20020a25cf07000000b00d157402f7cdmr6441885ybg.27.1695312762236; Thu, 21 Sep
 2023 09:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20230921061944epcas1p2f8a022282709da12840b33c0f5898b5f@epcas1p2.samsung.com>
 <20230921062206.14429-1-jaewon31.kim@samsung.com>
In-Reply-To: <20230921062206.14429-1-jaewon31.kim@samsung.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 21 Sep 2023 09:12:30 -0700
Message-ID: <CABdmKX1V-yPF260gORh-0LFkL+bDfPhOJteiwBjg1v6rYgrvgg@mail.gmail.com>
Subject: Re: [PATCH v2] vmscan: add trace events for lru_gen
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: rostedt@goodmis.org, yuzhao@google.com, kaleshsingh@google.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, jaewon31.kim@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 11:19=E2=80=AFPM Jaewon Kim <jaewon31.kim@samsung.c=
om> wrote:
>
> As the legacy lru provides, the lru_gen needs some trace events for
> debugging.
>
Hi Jaewon, thanks for adding this.

> This commit introduces 2 trace events.
>   trace_mm_vmscan_lru_gen_scan
>   trace_mm_vmscan_lru_gen_evict
>
> Each event is similar to the following legacy events.
>   trace_mm_vmscan_lru_isolate,
>   trace_mm_vmscan_lru_shrink_[in]active
>
> Here's an example
>   mm_vmscan_lru_gen_scan: isolate_mode=3D0 classzone=3D1 order=3D9 nr_req=
uested=3D4096 nr_scanned=3D431 nr_skipped=3D0 nr_taken=3D55 lru=3Danon
>   mm_vmscan_lru_gen_evict: nid=3D0 nr_reclaimed=3D42 nr_dirty=3D0 nr_writ=
eback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D13 nr_activa=
te_file=3D0 nr_ref_keep=3D0 nr_unmap_fail=3D0 priority=3D2 flags=3DRECLAIM_=
WB_ANON|RECLAIM_WB_ASYNC
>   mm_vmscan_lru_gen_scan: isolate_mode=3D0 classzone=3D1 order=3D9 nr_req=
uested=3D4096 nr_scanned=3D66 nr_skipped=3D0 nr_taken=3D64 lru=3Dfile
>   mm_vmscan_lru_gen_evict: nid=3D0 nr_reclaimed=3D62 nr_dirty=3D0 nr_writ=
eback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activat=
e_file=3D2 nr_ref_keep=3D0 nr_unmap_fail=3D0 priority=3D2 flags=3DRECLAIM_W=
B_FILE|RECLAIM_WB_ASYNC
>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
> v2: use condition and make it aligned
> v1: introduce trace events
> ---
>  include/trace/events/mmflags.h |  5 ++
>  include/trace/events/vmscan.h  | 98 ++++++++++++++++++++++++++++++++++
>  mm/vmscan.c                    | 17 ++++--
>  3 files changed, 115 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflag=
s.h
> index 1478b9dd05fa..44e9b38f83e7 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -274,6 +274,10 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY, "softdirty"     )=
               \
>                 EM (LRU_ACTIVE_FILE, "active_file") \
>                 EMe(LRU_UNEVICTABLE, "unevictable")
>
> +#define LRU_GEN_NAMES          \
> +               EM (LRU_GEN_ANON, "anon") \
> +               EMe(LRU_GEN_FILE, "file")
> +
>  /*
>   * First define the enums in the above macros to be exported to userspac=
e
>   * via TRACE_DEFINE_ENUM().
> @@ -288,6 +292,7 @@ COMPACTION_PRIORITY
>  /* COMPACTION_FEEDBACK are defines not enums. Not needed here. */
>  ZONE_TYPE
>  LRU_NAMES
> +LRU_GEN_NAMES
>
>  /*
>   * Now redefine the EM() and EMe() macros to map the enums to the string=
s
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.=
h
> index d2123dd960d5..f0c3a4bd72db 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -327,6 +327,57 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>                 __print_symbolic(__entry->lru, LRU_NAMES))
>  );
>
> +TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
> +       TP_PROTO(int highest_zoneidx,
> +               int order,
> +               unsigned long nr_requested,
> +               unsigned long nr_scanned,
> +               unsigned long nr_skipped,
> +               unsigned long nr_taken,
> +               isolate_mode_t isolate_mode,
> +               int lru),
> +
> +       TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skip=
ped, nr_taken, isolate_mode, lru),
> +
> +       TP_CONDITION(nr_scanned),
> +
> +       TP_STRUCT__entry(
> +               __field(int, highest_zoneidx)
> +               __field(int, order)
> +               __field(unsigned long, nr_requested)
> +               __field(unsigned long, nr_scanned)
> +               __field(unsigned long, nr_skipped)
> +               __field(unsigned long, nr_taken)
> +               __field(unsigned int, isolate_mode)
> +               __field(int, lru)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->highest_zoneidx =3D highest_zoneidx;
> +               __entry->order =3D order;
> +               __entry->nr_requested =3D nr_requested;
> +               __entry->nr_scanned =3D nr_scanned;
> +               __entry->nr_skipped =3D nr_skipped;
> +               __entry->nr_taken =3D nr_taken;
> +               __entry->isolate_mode =3D (__force unsigned int)isolate_m=
ode;
> +               __entry->lru =3D lru;
> +       ),
> +
> +       /*
> +        * classzone is previous name of the highest_zoneidx.
> +        * Reason not to change it is the ABI requirement of the tracepoi=
nt.
> +        */
> +       TP_printk("isolate_mode=3D%d classzone=3D%d order=3D%d nr_request=
ed=3D%lu nr_scanned=3D%lu nr_skipped=3D%lu nr_taken=3D%lu lru=3D%s",
> +               __entry->isolate_mode,
> +               __entry->highest_zoneidx,
> +               __entry->order,
> +               __entry->nr_requested,
> +               __entry->nr_scanned,
> +               __entry->nr_skipped,
> +               __entry->nr_taken,
> +               __print_symbolic(__entry->lru, LRU_GEN_NAMES))
> +);
> +
>  TRACE_EVENT(mm_vmscan_write_folio,
>
>         TP_PROTO(struct folio *folio),
> @@ -437,6 +488,53 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
>                 show_reclaim_flags(__entry->reclaim_flags))
>  );
>
> +TRACE_EVENT(mm_vmscan_lru_gen_evict,
> +
> +       TP_PROTO(int nid, unsigned long nr_reclaimed,
> +               struct reclaim_stat *stat, int priority, int file),
> +
> +       TP_ARGS(nid, nr_reclaimed, stat, priority, file),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned long, nr_reclaimed)
> +               __field(unsigned long, nr_dirty)
> +               __field(unsigned long, nr_writeback)
> +               __field(unsigned long, nr_congested)
> +               __field(unsigned long, nr_immediate)
> +               __field(unsigned int, nr_activate0)
> +               __field(unsigned int, nr_activate1)
> +               __field(unsigned long, nr_ref_keep)
> +               __field(unsigned long, nr_unmap_fail)
> +               __field(int, nid)
> +               __field(int, priority)
> +               __field(int, reclaim_flags)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->nid =3D nid;
> +               __entry->nr_reclaimed =3D nr_reclaimed;
> +               __entry->nr_dirty =3D stat->nr_dirty;
> +               __entry->nr_writeback =3D stat->nr_writeback;
> +               __entry->nr_congested =3D stat->nr_congested;
> +               __entry->nr_immediate =3D stat->nr_immediate;
> +               __entry->nr_activate0 =3D stat->nr_activate[0];
> +               __entry->nr_activate1 =3D stat->nr_activate[1];
> +               __entry->nr_ref_keep =3D stat->nr_ref_keep;
> +               __entry->nr_unmap_fail =3D stat->nr_unmap_fail;
> +               __entry->priority =3D priority;
> +               __entry->reclaim_flags =3D trace_reclaim_flags(file);
> +       ),
> +
> +       TP_printk("nid=3D%d nr_reclaimed=3D%ld nr_dirty=3D%ld nr_writebac=
k=3D%ld nr_congested=3D%ld nr_immediate=3D%ld nr_activate_anon=3D%d nr_acti=
vate_file=3D%d nr_ref_keep=3D%ld nr_unmap_fail=3D%ld priority=3D%d flags=3D=
%s",

Many of these values are unsigned so I think many of these format
specifiers should be %lu instead of %ld.

> +               __entry->nid, __entry->nr_reclaimed,
> +               __entry->nr_dirty, __entry->nr_writeback,
> +               __entry->nr_congested, __entry->nr_immediate,
> +               __entry->nr_activate0, __entry->nr_activate1,
> +               __entry->nr_ref_keep, __entry->nr_unmap_fail,
> +               __entry->priority,
> +               show_reclaim_flags(__entry->reclaim_flags))
> +);
> +
>  TRACE_EVENT(mm_vmscan_node_reclaim_begin,
>
>         TP_PROTO(int nid, int order, gfp_t gfp_flags),
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6f13394b112e..f453a0f8ceef 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5005,6 +5005,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>         int sorted =3D 0;
>         int scanned =3D 0;
>         int isolated =3D 0;
> +       int skipped =3D 0;
>         int remaining =3D MAX_LRU_BATCH;
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
> @@ -5018,7 +5019,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>
>         for (i =3D MAX_NR_ZONES; i > 0; i--) {
>                 LIST_HEAD(moved);
> -               int skipped =3D 0;
> +               int skipped_zone =3D 0;
>                 int zone =3D (sc->reclaim_idx + i) % MAX_NR_ZONES;
>                 struct list_head *head =3D &lrugen->folios[gen][type][zon=
e];
>
> @@ -5040,16 +5041,17 @@ static int scan_folios(struct lruvec *lruvec, str=
uct scan_control *sc,
>                                 isolated +=3D delta;
>                         } else {
>                                 list_move(&folio->lru, &moved);
> -                               skipped +=3D delta;
> +                               skipped_zone +=3D delta;
>                         }
>
> -                       if (!--remaining || max(isolated, skipped) >=3D M=
IN_LRU_BATCH)
> +                       if (!--remaining || max(isolated, skipped_zone) >=
=3D MIN_LRU_BATCH)
>                                 break;
>                 }
>
> -               if (skipped) {
> +               if (skipped_zone) {
>                         list_splice(&moved, head);
> -                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped)=
;
> +                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped_=
zone);
> +                       skipped +=3D skipped_zone;
>                 }
>
>                 if (!remaining || isolated >=3D MIN_LRU_BATCH)
> @@ -5065,6 +5067,9 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>         __count_memcg_events(memcg, PGREFILL, sorted);
>         __count_vm_events(PGSCAN_ANON + type, isolated);
>
> +       trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order, MAX_LRU_=
BATCH,
> +                       scanned, skipped, isolated,
> +                       sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);
>         /*
>          * There might not be eligible folios due to reclaim_idx. Check t=
he
>          * remaining to prevent livelock if it's not making progress.
> @@ -5194,6 +5199,8 @@ static int evict_folios(struct lruvec *lruvec, stru=
ct scan_control *sc, int swap
>  retry:
>         reclaimed =3D shrink_folio_list(&list, pgdat, sc, &stat, false);
>         sc->nr_reclaimed +=3D reclaimed;
> +       trace_mm_vmscan_lru_gen_evict(pgdat->node_id, reclaimed, &stat,
> +                                     sc->priority, type);
>
>         list_for_each_entry_safe_reverse(folio, next, &list, lru) {
>                 if (!folio_evictable(folio)) {
> --
> 2.17.1
>
