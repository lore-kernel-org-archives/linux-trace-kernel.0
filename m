Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A591C296
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:15:27 +0000 (UTC)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F40CE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:15:23 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230926141521epoutp03c50a3f78e0ce59b528f445ab43fe162d~IeHkNj0yY1186911869epoutp03F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:15:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230926141521epoutp03c50a3f78e0ce59b528f445ab43fe162d~IeHkNj0yY1186911869epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1695737721;
	bh=FBUxH+V46Rt0kdEMw6EgGCObFJfgZ2YOADTq9JkYl08=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=S/zUsUaJ0aEGjL1jQdfaXtpLv2VS9+I5kkMejHE3ZHdfAMqRu2Jtlz2FXoSAtvidS
	 BjBnSyGTwAu3CB6w7hmcot0kMiYen/W/WdIAXvxbz2nEp7EFNKr2fAIIDiahZyXrPh
	 gykxVXK6N6QhXUxmJMdMSboOE6n8MjWcGaJEjJos=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20230926141520epcas1p4c121852cbbd958fedb0f089680824ca6~IeHjmWet43097730977epcas1p4p;
	Tue, 26 Sep 2023 14:15:20 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.242]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Rw1wm08Gvz4x9Pr; Tue, 26 Sep
	2023 14:15:20 +0000 (GMT)
X-AuditID: b6c32a33-749fa700000021d1-45-6512e777c81b
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	48.80.08657.777E2156; Tue, 26 Sep 2023 23:15:19 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v4] vmscan: add trace events for lru_gen
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To: Yu Zhao <yuzhao@google.com>
CC: "rostedt@goodmis.org" <rostedt@goodmis.org>, "tjmercier@google.com"
	<tjmercier@google.com>, "kaleshsingh@google.com" <kaleshsingh@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "sj@kernel.org"
	<sj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230926073333epcms1p14c9798232b395007eb20becb5dbc4b4e@epcms1p1>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230926141519epcms1p5b7808c768df48647516f458529e4e3c8@epcms1p5>
Date: Tue, 26 Sep 2023 23:15:19 +0900
X-CMS-MailID: 20230926141519epcms1p5b7808c768df48647516f458529e4e3c8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmnm75c6FUgw8fjC3mrF/DZrF6k69F
	9+aZjBa9718xWTTtm8lucXnXHDaLe2v+s1ocWX+WxWJfxwMmi8Nf3zBZvFv/hc1idmMfo8W7
	CV9YHXg9Dr95z+yxc9Zddo+WfbfYPRZsKvXYtKqTzWPTp0nsHidm/Gbx6NuyitHjzIIj7B6f
	N8kFcEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA
	3a6kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAr0CtOzC0uzUvXy0stsTI0MDAy
	BSpMyM74+mcqY8EkjYrD3X/YGxibZbsYOTkkBEwkdvzfwtLFyMUhJLCDUeL4/XesXYwcHLwC
	ghJ/dwiD1AgL2EhM7vjMAmILCShJnP1xhR0ibi2xf9EMJhCbTcBSYvvNiYwgtoiAvMSEl8/Y
	QWYyC6xnkfjx/BEjxDJeiRntT1kgbGmJ7cu3gsU5Bfwk/vdfZoaIi0rcXP2WHcZ+f2w+VK+I
	ROu9s1A1ghIPfu5mhJnz5/hzNgi7WGJZ5wMmCLtGYsW5VVBxc4mGtyvBbF4BX4kFs2eBzWER
	UJXYuLuBHeRfCQEXia2bRUDCzED3b387hxkkzCygKbF+lz7EFEWJnb/nMkKU8Em8+9rDCvPV
	jnlPoLaqSbQ8+woVl5H4++8ZlO0hcePpFGZIMF9mkjhw9hvTBEaFWYiQnoVk8yyEzQsYmVcx
	iqUWFOempyYbFhjCIzc5P3cTIzgZaxnvYLw8/5/eIUYmDsZDjBIczEoivA9vC6UK8aYkVlal
	FuXHF5XmpBYfYjQFenkis5Rocj4wH+SVxBuaWBqYmBmZWBhbGpspifMqTpidIiSQnliSmp2a
	WpBaBNPHxMEp1cAkcvqx1AadbWadHo69L1Yw79JVup1pk88s9mHORe71Oy8dWljBv/WG68el
	DQ+Kv/bIbXnYzCRWNf3hcQdn+SnL5buCVH18Z1T6eV+y2/9q9tWYv2vn73FVUJlmxP03ZOuN
	cpdnQre8D7u8abL7eSB4PpuIjdmp01M1pFpn9af8eOX5SOre/eYVnHXTuC8/9/9z2Dly0ixt
	6SsLrtT4/18l1eXdL/quf3mbd6F86PY7MdfsBMRmfv1X1vz/0/eDSYFNGU/VHfKne1ZfZq1P
	C9828+bV2XsEu/IjGPzPT0naaDH1qeoFI8uwPyyxs1VO+Gnvu3YslUX0133BbIu1O84WnWzQ
	N9VeLWFpsaZMcmKTEktxRqKhFnNRcSIAlekjgE8EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c
References: <20230926073333epcms1p14c9798232b395007eb20becb5dbc4b4e@epcms1p1>
	<20230926051035epcms1p312b531bba2c17bb763b6f046a45c86da@epcms1p3>
	<CAOUHufZwLET1E9dQq15LX27v+20HwWstL4XFi+qzVuz1voLW=w@mail.gmail.com>
	<20230926042250.6028-1-jaewon31.kim@samsung.com>
	<CGME20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c@epcms1p5>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>>>On Mon, Sep 25, 2023 at 10:20?PM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>>>>
>>>> As the legacy lru provides, the lru_gen needs some trace events for
>>>> debugging.
>>>>
>>>> This commit introduces 2 trace events.
>>>>   trace_mm_vmscan_lru_gen_scan
>>>>   trace_mm_vmscan_lru_gen_evict
>>>>
>>>> Each event is similar to the following legacy events.
>>>>   trace_mm_vmscan_lru_isolate,
>>>>   trace_mm_vmscan_lru_shrink_[in]active
>>>
>>>We should just reuse trace_mm_vmscan_lru_isolate and
>>>trace_mm_vmscan_lru_shrink_inactive instead of adding new tracepoints.
>>>
>>>To reuse trace_mm_vmscan_lru_isolate, we'd just need to append two new
>>>names to LRU_NAMES.
>>>
>>>The naming of trace_mm_vmscan_lru_shrink_inactive might seem confusing
>>>but it's how MGLRU maintains the compatibility, e.g., the existing
>>>active/inactive counters in /proc/vmstat.
>>
>>
>>Hello
>>
>>Actually I had tried to reuse them. But some value was not that compatible.
>>Let me try that way again.
>>
>>>
>
>Hello Yu Zhao
>
>Could you look into what I tried below? I reused the legacy trace events as you recommened.
>
>For the nr_scanned for trace_mm_vmscan_lru_shrink_inactive, I just used the scanned returned from isolate_folios.
>I thought this is right as scan_folios also uses its isolated.
>  __count_vm_events(PGSCAN_ANON + type, isolated);
>But I guess the scanned in scan_folios is actually the one used in shrink_inactive_list

please ignore nr_scanned thing above I just misread the code.

This is an example, I think it works well.

 mm_vmscan_lru_isolate: isolate_mode=0 classzone=2 order=0 nr_requested=4096 nr_scanned=64 nr_skipped=0 nr_taken=64 lru=inactive_file
 mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=64 nr_reclaimed=63 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=1 nr_ref_keep=0 nr_unmap_fail=0 priority=2 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC

>
>I tested this on both 0 and 7 of /sys/kernel/mm/lru_gen/enabled
>
>
>diff --git a/mm/vmscan.c b/mm/vmscan.c
>index a4e44f1c97c1..b61a0156559c 100644
>--- a/mm/vmscan.c
>+++ b/mm/vmscan.c
>@@ -4328,6 +4328,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>        int sorted = 0;
>        int scanned = 0;
>        int isolated = 0;
>+       int skipped = 0;
>        int remaining = MAX_LRU_BATCH;
>        struct lru_gen_folio *lrugen = &lruvec->lrugen;
>        struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>@@ -4341,7 +4342,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
> 
>        for (i = MAX_NR_ZONES; i > 0; i--) {
>                LIST_HEAD(moved);
>-               int skipped = 0;
>+               int skipped_zone = 0;
>                int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
>                struct list_head *head = &lrugen->folios[gen][type][zone];
> 
>@@ -4363,16 +4364,17 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>                                isolated += delta;
>                        } else {
>                                list_move(&folio->lru, &moved);
>-                               skipped += delta;
>+                               skipped_zone += delta;
>                        }
> 
>-                       if (!--remaining || max(isolated, skipped) >= MIN_LRU_BATCH)
>+                       if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
>                                break;
>                }
> 
>-               if (skipped) {
>+               if (skipped_zone) {
>                        list_splice(&moved, head);
>-                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped);
>+                       __count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
>+                       skipped += skipped_zone;
>                }
> 
>                if (!remaining || isolated >= MIN_LRU_BATCH)
>@@ -4387,6 +4389,9 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>        __count_memcg_events(memcg, item, isolated);
>        __count_memcg_events(memcg, PGREFILL, sorted);
>        __count_vm_events(PGSCAN_ANON + type, isolated);
>+       trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
>+                                   scanned, skipped, isolated,
>+                                   type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> 
>        /*
>         * There might not be eligible folios due to reclaim_idx. Check the
>@@ -4517,6 +4522,9 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
> retry:
>        reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
>        sc->nr_reclaimed += reclaimed;
>+       trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
>+                       scanned, reclaimed, &stat, sc->priority,
>+                       type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> 
>        list_for_each_entry_safe_reverse(folio, next, &list, lru) {
>                if (!folio_evictable(folio)) {
>
