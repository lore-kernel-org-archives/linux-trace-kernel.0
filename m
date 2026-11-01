Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499234;
	b=2TtCwo0pIlhJf2cDPXHujLD2pxuOBUpe0/ekMPVtF58A+ApwrdQ7Kt+8bUM8apFpd8PF
	 qs6+DDvVppLxiTL5nHwHXOxCQ0+RnZC3c3kzyEAR0W/XimOJnJbmWpW0P1ZadZxjQqYYE
	 ERZWkSBU5UXzUfobVqyuzEBaBmBkxEe/DpWxYG0OJ1ZC7pueREABLHTsvsRm0F42IUhc3
	 u9GTsrBN6M4ZsQXP+Lk6/Nj9E7HSeBreGkf/+iqulrpvosss+LsdJHcO1m10tHibF+cNq
	 Hkm5NMocWp2iWyjGJ7IZ6h7OPGsq1AMYYJachKZ27ciiykxD4doUsQU8Vp7mHCyTvWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IX83IRV13zUjxpE8+UB16/ReS4it9bdD0etB9Kv5xx4=;
	b=4LZVZD3vkpNZaGOaxKwM3hMuyZJfXcia93Qe4dP+dHjcc/KKC/vL/kmtsw71zbnNYbtQ
	 KboeDTbPBzRsRhsX8d4D2vWJnYjv+k09AM5z526PJqHGAsOKFgA/7rmuA0VrHKFuGAC8Y
	 jBCKqTNWa8GaLeGXZSnHVNF9tWEwW7/oTqtMO35xuGoVuazJ9bl+AfAcJkLKEZQ/YOIAo
	 sG8NxuCoroQdpX2E1SfWaWBLTqkP1fYxbk5DL5fhFm4XSPXSTU1GoPTfMDkmDInQ849i4
	 U4eYRXFxbkmnNYoqauIOdRY+Hn7o5ZkCuGqjaOiqwZsFvdwnmICHZz3BAuqiBaCoHAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=O23ACsgn;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE12606A32F
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE12606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=O23ACsgn
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f20c3aaa5so205262585a.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499233; x=1794104033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IX83IRV13zUjxpE8+UB16/ReS4it9bdD0etB9Kv5xx4=;
        b=O23ACsgndry4YA9wKXjSwIMGPt9b/CC2wNGJAACC21fdenDx6Kjve0LIwwU2MweSGw
         T10decsrXvUbsgheMEPjL+/2u7BqU/zmPGtoFdLviCMTbeAEqNMAxOfAMSyrbQuGYrOU
         d4MC05i940M0JmuSFgmFI4KSuPXDlOxKi8D2VFi8AERvbUBEw3MXbv+ngrggbUugxR+J
         QNMMIQ9Si8K02YQRunNiV2TmUEOyQ4qI/sMlJurICLWYABWcJ2dtJnHdBYFy0jhqxX+j
         6VlXStC9zGUsXkyyZdpbwL7e+YuT8MpyIsEcK4IFr5O5Yu6Wttm/7dvmIRD2StEfk8W5
         5ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499233; x=1794104033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IX83IRV13zUjxpE8+UB16/ReS4it9bdD0etB9Kv5xx4=;
        b=A1cIF1xIigTEzEIcxy4Ia9akDE3ziUqDk7LUIwVRRY2ZglU4haREALIDXQ0kQVablx
         gBSZPc7r7+CtT8j1vBN7xqH8JC1WaEbCFMnSS9/dsdZkf3S1dem2GHDpTYhqPDG3tl0G
         uhFz/c/mtMyBNg/k/AZgIiM0g2RrVH3SP3IHmUQIrtDUMW0rbQhM7Kp0c2c7rD8jguH/
         4pMZO083d1g+WiN+dHVYDbeRr/2F8ppGQXKvSBsAhraF2HXaZzx42qbjTfI7XJ9X5Iht
         TNVSxJDreBomxnfvKFt1O7Fat16R8CknlzZVUbpQIlc/V+Xy4xYQeK40EDoOzeDNLllr
         xDoQ==
X-Gm-Message-State: AFq9FYJ0qroRBNwktnURmPGqpNsBrYl2YhIAzmjEMFPEtamyMlkq/7HU
	nRuXIuHY095ThhsFITXc80hYOzJCYyNtBb3ke505XIAdBg8CxVOgfHS5UtBLoXERQiM=
X-Gm-Gg: AYBFou2p5a61ADBfNNZMuPzSeTrZwdm12ptoSxA514HSLMKjxT5OeEiBJuuXlqjeyvH
	bYcR0/Ydm9/G3PHbLejFvNm3xHsbFCXiGBlb2KKdWz2t+iI1xCArDcMQFymHTZhgK57qzglbKo1
	Y0zj1fakHsdTRBCf4+IkOSD3OAw8gweDAtWBAiYcwUs2H6zyM3mTMiVP+yLhkxnaB+3O4Yhxbm6
	kQuDdGyNcRZdUTIXuJw+odOHILJDEqToRffrVSD6CLyGN0hgudqcp3D4Rd8fdyhQrwOqGKJjTYm
	slgAeWVZ8HNLYO4AswK+r4NW1rvrxIzAYYsCtwKdXZHafUJJouOWm8jl2PVfHPiQpEFFOPzCe1C
	8Vu8VC8BmOVSiVJI5osuNRREb6Qf5fp0Frsv6GDeyY9idO8qrPPS9kcxwXwXegQxVi5X8/cTgIf
	sJ4RT9i52DYIW50stbZxffV9tFDQ4ZGFge7pss93ivR50V8iW/L+mFAEXzCIXAzn+zx/KohSSYy
	oAPG28qj5zFxOJKL2gCxWTYe2GXMAMBbZUnUXi89byok1KzWBni0xgJIP+gYuR6EqVq6sxu3UpT
	K1xD7U4zcAuR9eBfCBr7Vw6LjjUB/4s6VEKXevtsLisU3g2MQcVWGhOi/V4oSwoTa7zhzkekZby
	iKr1mwfT6EA==
X-Received: by 2002:a05:620a:3703:b0:93f:3120:6c84 with SMTP id af79cd13be357-9442173fc02mr1051691885a.36.1793499233173;
        Sat, 31 Oct 2026 19:13:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:52 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v5 04/12] mm/page_alloc: detect zonelist rebuilds from memory hot-add
Date: Sat, 31 Oct 2026 22:13:32 -0400
Message-ID: <20261101021340.2251928-5-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zonelist_update_seq retry was limited to CONFIG_MEMORY_HOTREMOVE,
presumably because only hot-remove takes zones out of a zonelist.

However, build_zonerefs_node() rewrites the zonelists in place, so
onlining the first block of a zone shifts the entries that follow it
in every zonelist containing that zone.  This can cause a spurious
allocation failure for a __GFP_THISNODE caller.

For a node with only ZONE_NORMAL, onlining its first ZONE_MOVABLE block
rewrites the node's ZONELIST_NOFALLBACK list as:

  [NORMAL, NULL] -> [MOVABLE, NULL] -> [MOVABLE, NORMAL, NULL]

A concurrent GFP_KERNEL | __GFP_THISNODE allocation can observe the
intermediate list, skip ZONE_MOVABLE, and find no eligible zone. With
CONFIG_MEMORY_HOTREMOVE=n, check_retry_zonelist() returns 0 and the
allocation fails even though the node has free ZONE_NORMAL memory.

Gate the sequence checks on CONFIG_MEMORY_HOTPLUG, which covers every
configuration that rebuilds zonelists after boot.

Fixes: 3d36424b3b58 ("mm/page_alloc: fix race condition between build_all_zonelists and page allocation")
Cc: stable@vger.kernel.org
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e14d550d4128..11be12b443ad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4404,7 +4404,7 @@ static DEFINE_SEQLOCK(zonelist_update_seq);
 
 static unsigned int zonelist_iter_begin(void)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqbegin(&zonelist_update_seq);
 
 	return 0;
@@ -4412,7 +4412,7 @@ static unsigned int zonelist_iter_begin(void)
 
 static unsigned int check_retry_zonelist(unsigned int seq)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
 
 	return seq;
-- 
2.56.0

