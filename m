Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9122D636
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NU7pgaOd"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ED6129
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:31:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c87a85332bso45268905ad.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698211903; x=1698816703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ktOpyXH4xJvQjTjiv4myd5jeNbk19v5L3mPK+5WZ6SE=;
        b=NU7pgaOdmQtFzDcIrlAIpOrOJoOsBrWSARf6YtfdENDvS7C4ZK7Y2f487st1NvLZDZ
         8DifvchcrofAMOJYA0GIQf1Ve4gF/jGVRBj75oE641NdFxJYK/iPCpMgBz2aHu5200QD
         Y3gD1n9kakT92wbc04GZ04o1I7iDLsUczJrCBUV/4Gv/Iv+eW6wB/reJZ4Ln2q+e4g4r
         rgIfegf6/PYCVUvkFAXSyaVfQsBzpfvFgqbTvlUmPLCWwg6bBLFHylyfNfKsNo+Hy8L4
         Mg/h2vMG6VEeZDJbjGb/1fZw+i22RqEYL+QiPjkEPNBLi5BMyLA1eedvaLJ+8grzf0sj
         Upjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698211903; x=1698816703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktOpyXH4xJvQjTjiv4myd5jeNbk19v5L3mPK+5WZ6SE=;
        b=b9Bl3W4HjqCTgYN8tl49BXHYDeQE61xZKVih2+xdTKjZd5ITQhK47DEzolLE+glrVg
         Vc+wFKZUeFyEMNrE6wLgIqIAyMez0hVRP9NyIkpHdLXsJauhsrFPvy+mzpeYRlWJ+6B9
         X5v+H8nz03+Yk2ytuzgX5XMlEE3j3aNPT+l3F50zTrrl+qYfhmuh7eSUCIx6f6FSbio8
         JTcbukxYRwGp217OXB1szwDqUDgBRjdL5xq1WmwcozlJXOGAJVrn6g7hf7KOVYNLCxL4
         qi6m0PyF5IMoUDkwSyd2FtK4gKoNMgl/wIMNOzOu6gaaMJcOXhB7YFcm7bt5yad2fE2O
         Rvvg==
X-Gm-Message-State: AOJu0YwcLKeeLDvP0Q7Xi9zLrATtLLdBOxFY8W38y3bkqqPvTri7vVb6
	fRDN9PklFiZbRRlXeP2hlDQ3+wRnbf/ZRR/7lKY=
X-Google-Smtp-Source: AGHT+IFBNwIwfANneov1NrawUxvJ/9EtUDvFvK9xFRIKuWtX2JAggywQQ3wA2YrUCMumS8dfPYnqsA==
X-Received: by 2002:a17:902:e5d0:b0:1bd:d911:2a85 with SMTP id u16-20020a170902e5d000b001bdd9112a85mr16244605plf.12.1698211903253;
        Tue, 24 Oct 2023 22:31:43 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001bc2831e1a9sm8278906plg.90.2023.10.24.22.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:31:42 -0700 (PDT)
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
To: linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	davem@davemloft.net,
	anil.s.keshavamurthy@intel.com,
	naveen.n.rao@linux.ibm.com,
	rostedt@goodmis.org,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	sander@svanheule.net,
	ebiggers@google.com,
	dan.j.williams@intel.com,
	jpoimboe@kernel.org
Cc: linux-kernel@vger.kernel.org,
	lkp@intel.com,
	mattwu@163.com,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH] lib,kprobes: objpool_try_add_slot merged into objpool_push
Date: Wed, 25 Oct 2023 13:31:33 +0800
Message-Id: <20231025053133.343923-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After several rounds of objpool improvements the existence
of inline function objpool_try_add_slot is not appropriate
any more:
1) push can only happen on local cpu node, the cpu param of
   objpool_try_add_slot is misleading
2) objpool_push is only a wrapper of objpool_try_add_slot,
   with the original loop of all cpu nodes removed

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 lib/objpool.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/lib/objpool.c b/lib/objpool.c
index a032701beccb..7474a3a60cad 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -152,13 +152,17 @@ int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
 }
 EXPORT_SYMBOL_GPL(objpool_init);
 
-/* adding object to slot, abort if the slot was already full */
-static inline int
-objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
+/* reclaim an object to object pool */
+int objpool_push(void *obj, struct objpool_head *pool)
 {
-	struct objpool_slot *slot = pool->cpu_slots[cpu];
+	struct objpool_slot *slot;
 	uint32_t head, tail;
+	unsigned long flags;
+
+	/* disable local irq to avoid preemption & interruption */
+	raw_local_irq_save(flags);
 
+	slot = pool->cpu_slots[raw_smp_processor_id()];
 	/* loading tail and head as a local snapshot, tail first */
 	tail = READ_ONCE(slot->tail);
 
@@ -173,21 +177,9 @@ objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
 	/* update sequence to make this obj available for pop() */
 	smp_store_release(&slot->last, tail + 1);
 
-	return 0;
-}
-
-/* reclaim an object to object pool */
-int objpool_push(void *obj, struct objpool_head *pool)
-{
-	unsigned long flags;
-	int rc;
-
-	/* disable local irq to avoid preemption & interruption */
-	raw_local_irq_save(flags);
-	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
 	raw_local_irq_restore(flags);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(objpool_push);
 
-- 
2.40.1

