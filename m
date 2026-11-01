Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499239;
	b=1Y1ZWzwNuB2qJSzc6w5/vLiYOvLcuD474hkxcgkyXmd9HSYI5dUS8/fvbviedDjWA2fG
	 OwhizU0qXRZ1/16KVj8QvLxf0g0xN3wSqWOvk90brEUWV42YpmrS3Nt+SYVd+9AzJZ51E
	 kmr6Cjaqjmqpj3jdHOEwgb2OVnqvpohlmATzjzONRFI5/TqpTmWQBKm76VdjmuJQ/gisO
	 WFIP23wynklWGVNEXnbrkjpBIs/72X/7SHZrHwc4ugYgb85TdsUF5My9Wmp7u9kXqQeUL
	 ufrePSpxa7zWi7X3QWdt52caqzO3FIrDwWRsb2pxcevEgyEBCw+sstt3z+N6D/aqQ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PsOknrkq/nzec9hQG23km3v2sM//hYMRVRxTHFDDb+s=;
	b=sIsz9g11u13iztVLGjwuTON5EhZ3hg5P202s+llkEAQgKLHYZTAQ9wJzT5YBIwWDmHn4
	 oQbKXcW68iaaJrZo6l0FDT2H6qo1yqeA6eyEPSq2rP8wF336H+KRd57KpQcjMf3Gbmb7p
	 WjynfNZ96JNbdvCW9QPFWn7JJfVrGqbYVVW0wJm/Xamm7moy95oD7rapW4a3eVenIiVM4
	 +2m3/OhjcTkuKVE2K5aPt7jmYqUfoWw4F069K2U3yNlyL4Y5i3NmzrA7PLXWl3yf8s8ni
	 n/hEOTJAvxkTGp3l7qpsKGRoyegmQpSy32IY9Eihe9QWucvQtaNbZf0nUdxHxft+bHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="H/L+nA9j";
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE0606A338
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CAE0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=H/L+nA9j
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-945ae2daa3eso39846585a.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499238; x=1794104038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PsOknrkq/nzec9hQG23km3v2sM//hYMRVRxTHFDDb+s=;
        b=H/L+nA9jNizIm/iixoLRh1fmKt4I7O+jnIUupPKcZ/0xeRQEkk9svkGxMoN6A+8+Eo
         F8N34TrsvjwnymM2DpnGBCCWXp7hpqDpb4Af+Nj2BQRyOx3PbIAXiYrJ+yzKE7C3rRwj
         gIvMYNIBFusvovNyfROiuFl3AQG2m6xvwikiJdU1F4ZG5DoXZmqINu2F8DHiok5GTU6S
         1Jnm45OspMEHCl2fFapGV7BT9v8L5lw5MnIbM9jKybmAwuAwB5SRr0yOEhD7O8OgBbYN
         awMKxVAL6++0JEY5JinhPTKHctCI0LPTbyEavcuwa3NdazWQRTgVqiit/991KsZr6pQE
         7/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499238; x=1794104038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PsOknrkq/nzec9hQG23km3v2sM//hYMRVRxTHFDDb+s=;
        b=z3S+perruohk3sLNg1uFD241fCFEp3v8ZMHJEsdtREGFQWKdAXI69jz1rIW3r4xolP
         BcOjUVEquYJhpceFJupuVR47Ju2jkGbhasBdnyHRdoY3YX6s7KGczDA9ldcv0KuwtXIO
         RcOmg+kL8GHSuO07V13rNrK1ushwTStekpGHRCmKDEUm4+3wyy26EuZZMhSfTzYqNUFx
         OYnDVt0524KGVAgnawVFEOJUbkC/nR72j47N936UBfTiUTncuzmSqANfj5cq9q3OThzR
         KLH9oPpCVcrETrxVtHq7q+AYvhFhGRRWn6MGBy0RBEEBANyepoYk94SdWIQP8f88OMYR
         ShAg==
X-Gm-Message-State: AFq9FYJD39mqY3a+HnxV7YwRy4+sLwA6IPE3MLXc7cQztNFbNdUlMsvk
	zhzkahSG4kUbm2uj8xGSJRgyhzbYofyK1qtFLxE2v+Q+OPvpeASJKkyFqkWqK7cy6E8=
X-Gm-Gg: AYBFou371rTq3DkYdr5fzS8HFtbGgPaSwDTFLPKikBVjrzwYmM5qTC7pcH68Wu/1DH7
	f9bR4pDP3mRLSdhjhJpGseLpXAqugY/WCFR7e2iP+IKh6V2ojCMlwdLDVW6+CU/f80d5eVcxIW8
	DjljY9lSrBt9g4PoKCeIeA3xuPEFPJqeHXojDjmVGZNbWqah1AfUV3O18bBmIIcf89fRzWicWAw
	bvWWbaNwgE9XlequBpVUv+V9bvCxT+Phc+boqTAc68YCTbOmZt5JyUTrbTTXBy4Qqposv5/xPOb
	xSetWOrWvl9YCz0AbgfQL1PytaazgQHCWxqeveGmxyG8ZViTs0HeoBT8MwZhaYT3au6ypminM6b
	zHQTvZEAvpKFUN4lzIIdbbRMBKai7nsuUzxJYMENUeI9oxSlEnZLTpTV31XD2o3wrapD4qRSZFr
	1744DbIqQR5Z6/pc9sAR+y+eF4D1wHS7llCr4DROHb1D9yLtcl0wXguVOrqW0bI4M2nfz1RIrVm
	stdcOGYNR0P8RkXwWTlDnXrEY4EYIF8K7SpRkPJ8yVZ/RUcdw41A9mF5tcUB2lTBLB8n3A/it+L
	3XR4H3bFo6YSXlGa5lQGsWjmmTPhn50bUn32I2nFJA8c8i9+YZArEgAT2sSG7GtICHNwAwBVh9Q
	JyBJU++yIRw==
X-Received: by 2002:a05:620a:45a5:b0:93e:e175:ee92 with SMTP id af79cd13be357-9442175ae0emr1102271485a.39.1793499238054;
        Sat, 31 Oct 2026 19:13:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:57 -0700 (PDT)
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
Subject: [PATCH v5 07/12] mm/mmzone: read each zoneref slot once when filtering by nodemask
Date: Sat, 31 Oct 2026 22:13:35 -0400
Message-ID: <20261101021340.2251928-8-gourry@gourry.net>
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

__next_zones_zonelist() tests a slot's zone for NULL, then reads the
slot again to look up the zone's node. Offlining a zone's last block
rebuilds the zonelists in place, so the second read can return the
terminator:

  CPU 0                             CPU 1
  __next_zones_zonelist(nodemask)
    zonelist_zone(slot 1) = NORMAL
                                    offline_pages()
                                      build_all_zonelists()
                                        [MOVABLE, NORMAL, NULL]
                                        -> [NORMAL, NULL]
    zref_in_nodemask(slot 1)
      zone_to_nid(NULL)

Current GCC and clang merge the two reads, but nothing requires it.
With mm/mmzone.o built with -fno-inline -fno-ipa-sra, holding a
nodemask allocation between the reads while the node's last movable
block goes offline oopses every time:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:zone_to_nid+0x0/0x10
  Call Trace:
   zref_in_nodemask+0x9/0x20
   __next_zones_zonelist+0x23/0x70
   prepare_alloc_pages.constprop.0+0x16c/0x190
   __alloc_frozen_pages_noprof+0xaf/0x330

Read the slot once and test that zone. A NULL zone still ends the walk.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/mmzone.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index 9cc9ef588580..65880396f104 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,13 +43,14 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref,
-				   const nodemask_t *nodes)
+/* A NULL zone terminates the zonelist, so it ends the search. */
+static inline bool zone_in_nodemask(const struct zone *zone,
+				    const nodemask_t *nodes)
 {
 #ifdef CONFIG_NUMA
-	return node_isset(zonelist_node_idx(zref), *nodes);
+	return !zone || node_isset(zone_to_nid(zone), *nodes);
 #else
-	return 1;
+	return true;
 #endif /* CONFIG_NUMA */
 }
 
@@ -67,7 +68,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 			z++;
 	else
 		while (zonelist_zone_idx(z) > highest_zoneidx ||
-				(zonelist_zone(z) && !zref_in_nodemask(z, nodes)))
+		       !zone_in_nodemask(zonelist_zone(z), nodes))
 			z++;
 
 	return z;
-- 
2.56.0

