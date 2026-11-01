Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499250;
	b=ZHtZU6CRBN5y4chLGvVeKXD+Ov/BJCXzfo+uOVRZVFQdi8IkGbkNob5qzH/dBzM/zTv9
	 W/N3JiTihfvQvL6mDGhmPhNII6SFlytY9W0GclecZh87KtIzX8Cu9fOJdgx5nn6SfIh7H
	 X6IzFejzcFQ095HrkjsTRnm7D42R0NVNGjYwQizHkG90TH+xh7+iRWcGgCOoGuvNUwAUu
	 xrQ1uBXP+So5n/3VTu6e9IpjKb/kYXkCyT/DiQYgocOrzZs6Z8jwbuelSo0h68rSIR2/k
	 MoBHM3L8pRJOEi0joYVxJS8igkkhYg2s2N2ZHywrVtgtNipDdYfFSIYGKUNmo6YlMiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OD9fGDG1XeSV5EuZqC2PA5d9y5CBw/VD1h9p8X7G8nY=;
	b=KpTnLZzlKVjXvom4biHjsO8hfzoKq9DWrnNaCeIjmFEFdPXLDVsxz7WHznIMDN9HLk0B
	 ISnmcVYvkvnCV1shiQxkN34cFVVK+9/0Me4EQwExUnXGnBuXl4ywjDdmIoQbkm6Ao/RXm
	 qNTqlBKIJ/G6r8XyJb+Agd3X77algRPyFcehOmNORtAZsqamNs82rozmjnzfCx3QYScsD
	 LEjrKeVCa25ZnSXx5JaBscQHGiIfT/qQoFlT8x3qQcB8mKs5mx37JgR3wIT1xe9uBUNDD
	 iPqeDmRvM+IWUpVVGaGADPtJQXbAj55/JREiouAxwnZdeCBkHOqH32+n+7MuE4SDx7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=AzOaBy+w;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26C60A2621
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Nov 2026 02:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D26C60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=AzOaBy+w
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917aca1aee5so24170816d6.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 19:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499244; x=1794104044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OD9fGDG1XeSV5EuZqC2PA5d9y5CBw/VD1h9p8X7G8nY=;
        b=AzOaBy+wXqRr8uIup48uh0Vv3TO8Fm5iXAP9snRlRlGmnu+TAArLNbKPlr5gpbEBFQ
         rrCEkejGfBRUxhtLmAmLYeFW8Q/EqO53nWjzD4VQZ89n8QR5S0VJPHQborLwEMHL6vQh
         clbfasTLXFUx665vSN7Jsa7abyRuPAj0ELIcsB1e3M1I+/uR3YkclI2UISYfcj/4nuCT
         uLtGlIKZzR6Bbmz347AwTaSHAwhHp174M6jwe2j7kBRV0WIq00cmBKOTWyTLz3MZqcLN
         WZr8gz9h2JDLi+P2DmgIyMDSGtKgVQikRmFgs6onTlGAiw/MaZ7PlZAnuejz26DSjoY8
         vGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499244; x=1794104044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OD9fGDG1XeSV5EuZqC2PA5d9y5CBw/VD1h9p8X7G8nY=;
        b=j9YSILP/GLv9Jac5zDwXkh7FuIjNkxtzOvhf5kVnXDxg9UveyZOG5n40GrER6brybq
         7/1KSoBJchDdEPaTHf4hjE/CxyfOWXFCTc5AA9ra4aqH5nSSQNmBkKpmyfyo/1NGcFHk
         5J8MR9XxZBaiaX9hm2YO1upi57qJBEQjbdCFszrteHa3dkd2JD3kUS90UR2Y8Dz3uebN
         7H/30kYGeKVu0MnVZptnrGRzICu+0yaDidDd4iGdWlZ+FPdZEqFMVZVCihj1AHYU0HUV
         uPpW5zqgMYpH6+imC/CClbSZqEwqhKgX5eohVmtQ9x4FWBa6EHDnI7/eiLl80VgcElrx
         t7ww==
X-Gm-Message-State: AFq9FYLdnY0sYGIzbLhmxNbhDlwj45eNmTO/xlWuzK13JZvaG0dHh3ZC
	2LxrDN52UcyHaKCmmeTNiFHLnKJMATIJTx8vuuErf0z1dCjUTRT7dOLtH93gU4l5eg4=
X-Gm-Gg: AYBFou2lKlQQO25aPVA/lm7S1qqTFu0DdZshuiwYZZpBQyKMtRaxzmoWRPvjvEpAd6G
	7mBVIVqS6UiwTZ0l1tYOL5JuhNEu1q772IJ3eooOz85DDY3+hJ0xK8yLhtiDmlhyFusw1pdkwWV
	FeW2aHNDGJqgfe6RzYHNmkL7bJeYIescl95xYRIdtdZV+tQU6EMOv9L0UNgI2JU2i0R3wEE53+s
	BqXreDzD6K2cLkhrJLdigI92JYbP6Ie3PmnikYPW60SfDrpMszblZ/95eTcpoq+tq8QPW23NG7e
	V3yaMEKJVslG38PRTjjIRplOHoDEi/mgR28JttzvU4TFV15hO36sow9Kdpl7Puyb2yOZRjf+hYL
	i+Inv7EjxzpqOo3nVEOVwpmrxQm6S1RBCTqTB5+4YIB/MkpS8MHSJ0pHN9eWNnDajzdx3WOdHc6
	ozqSsoE+CeRxXkehIPTQqmrJEhjw0dVRCi3BfSSBx6XM3LbTgSWdUpYDMkSF1ILvdY8/bSqTAcw
	hkxotUUMrJBjcol5iYwpJf7GXzDHQaJcE3d2fVZvaS2baJW/M4q0R/WyJybIntH5INz5Y2NTH+f
	Kphg+tgbktNu1qGC/U7BlsWukvImtrwSTLUbLB8hxmXPaNw4VTaUr8zG6spjW/21AI/dH66e/cv
	U2BtS6bYjwg==
X-Received: by 2002:a05:620a:1712:b0:93e:fa30:f1dc with SMTP id af79cd13be357-944217ebd9fmr1124363485a.72.1793499244292;
        Sat, 31 Oct 2026 19:14:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:14:03 -0700 (PDT)
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
Subject: [PATCH v5 11/12] mm/mempolicy: read the zoneref slot once in mempolicy_slab_node()
Date: Sat, 31 Oct 2026 22:13:39 -0400
Message-ID: <20261101021340.2251928-12-gourry@gourry.net>
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

For a bind or preferred-many policy, mempolicy_slab_node() tests the
first matching slot's zone for NULL, then reads the slot again to look
up the zone's node. Offlining a zone's last block rebuilds the
zonelists in place, so the second read can return the terminator:

  CPU 0                             CPU 1
  mempolicy_slab_node()
    zonelist_zone(slot 4)
      = node 2 NORMAL
                                    offline_pages()
                                      build_all_zonelists()
                                        slot 4 = NULL
    zonelist_node_idx(slot 4)
      zone_to_nid(NULL)

Current GCC merges the two reads, but nothing requires it. With
mm/mempolicy.o built with -fno-inline -fno-ipa-sra, holding a bound
task's slab_strict_numa allocation between the reads while a movable
block earlier in the zonelist goes offline oopses every time:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:zone_to_nid+0x0/0x10
  Call Trace:
   kmem_cache_alloc_noprof+0x294/0x610
   do_getname+0x34/0x230

mempolicy_slab_node() and zonelist_node_idx() are tail calls here, so
neither appears in the trace.

Read the slot once and use that zone.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/mempolicy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0884c629670d..cd63c3e2c029 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2176,6 +2176,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_PREFERRED_MANY:
 	{
 		struct zoneref *z;
+		struct zone *zone;
 
 		/*
 		 * Follow bind policy behavior and start allocation at the
@@ -2186,7 +2187,8 @@ unsigned int mempolicy_slab_node(void)
 		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
 		z = first_zones_zonelist(zonelist, highest_zoneidx,
 							&policy->nodes);
-		return zonelist_zone(z) ? zonelist_node_idx(z) : node;
+		zone = zonelist_zone(z);
+		return zone ? zone_to_nid(zone) : node;
 	}
 	case MPOL_LOCAL:
 		return node;
-- 
2.56.0

