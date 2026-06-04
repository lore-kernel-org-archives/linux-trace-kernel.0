Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2A284B25
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540720; cv=none; b=Gx0l1jWv2526HvOvfflPnW8eWbAYvws0GoGcE4cu7BxOdzSLyrXUqg7HhxXizMDnm/N8lvSPuHWMNby2aZeAfzvxx5kUv+Pj9tgkhts9/8RGbDyYOeXX6TvmqbGsRqzyvpVSc7XPWKjHB5B1f5jppOF2RQcNbmeozmzeDzfjpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540720; c=relaxed/simple;
	bh=IgUc5Qe80z/jUGLWABaGxvs/O/OI5c8g7nLD+Ltw+/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bN0eCZHjI+lKoYgyqZCSw8pR1vnPpFRZzNbAccO8/dTONFbcoaezLdxqQTZVxhP2/ZM9AY+cBmw+Me5Auvq8B0WTLufODHpGVcxRxARZPnJteNjhgUpfYbcsiIGrZLoxbgs/Mw98GrDrrUVphD4bdlOtj5podqsDK7Yx8Y3dC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV5ez7xZ; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV5ez7xZ"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36bcbd7821fso74342a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 19:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780540718; x=1781145518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jg2muu/RqGJ6FJ6mWO/tENjNo0VfGXgaATf3xERkFo=;
        b=OV5ez7xZ4+pLtfbIY+9Sh4ZZrvgdl6KMl/hoiGyTgODYeshxlm5um63dAu8W8k++Hq
         ZKQjGNITXWaYVZ6V/svj88VYIO8xeSr4peH+YJUYVfss4Xksvy2ZdLaIcsoQvsgSf+tL
         q1pGx99x2RbWhRAmb1PBOGfAwMhfLTDs4n5NwLwG7vqIHC7+tTKoPjltAHkegByffj3L
         MwPU6HUkeS7fcUg+pneFcbCSr+xIR/NVttl6nSGH0nyTqgUsyf1VYMfXXk4GVecLMhOa
         iFPHN0ISO0EcwV07V5LJSUodQDRWHrIuBytNeS+goyYX6FAlj9PbVCSwVUYrRiOYTbEE
         K7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780540718; x=1781145518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Jg2muu/RqGJ6FJ6mWO/tENjNo0VfGXgaATf3xERkFo=;
        b=Vf+Utfg7H073op/gMWAYxyPjDxOmld3vHA8s7hs+MUBCAIGErC8zMpcriwTJn6uHtr
         v3nsjl4bHuI8sbu7KRoVbMHsXb8KbvrQLA53CEBucQPiSjdXqP52j/BOQUznqXWh9saQ
         b1zsasqJh2w0vlcJkpwCyWvSMpWS8XofljC45XM7pR6C/94Q96nz4OTvORS/bOxH/oFr
         l6V1tRJp4Iujxaa2/N4/zEEmBWk4zXSpu1mtvdLbslFeVd/7auytzAUvtHR+7Q/vRArg
         J1ZZQ0qareFyETdzDsUo3urlhpZQ/ucFCmCbTTFQCyEX0Ees+c7FybpjxUmbbUXl8oNa
         BpCg==
X-Forwarded-Encrypted: i=1; AFNElJ+9voIxawthrvxRQOSfvTbTrXOB/LgvlhnC2ADgmO1aaMSEdCeS37cnSBdalOIvH832sPH1eD4bt6QEp6R0m64qucM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk29z/ifLF3mSxVf0dlKs4kGtiB0pnGwF3EQiS3M0ASmnOnT2I
	byCk+o5t5LsDuIoxphxRRwbxzErebLiQx6ltkTxvDO/7Qck9vIa8F9dj
X-Gm-Gg: Acq92OFan79f8pXJ3jwK0Qc/z9MC+vT9XA5ZKgA+5zFGNSmUVba9fW/sscfZYCHAT57
	BbXADN3iYHgVtSjHx88Iuwb5pdiQJofCF3Vu/hWDyfvDGQxLdu/e3eGWWcGM3aC7XMgf3SQxf4V
	n65GE++X3PoLz69m9uZTx+Ccb02xthVLnhOppaX0jm/tcUuGRFak4UsTVxTh7PhBq2EJlP1uayY
	k0oS2LeAV61M0rbn013I2mvtz3hhjJ+ZYAew/3yvwV6blzBUMcaeD0/UBVedmaJ+iigC5bg4cv6
	Lcnx9ucPWN3updJTyAT761iWK6+f60qr1QujTRMQtV4K59YwOTPf9ZEwUOwPzhfnMAaYzmL0ob5
	TtyWYoPJVGJy181/UKvqhP8miZhX+YpaM1IvxZ+Fiia6ata1zR+2ttZ0LKNpfyigixhGNYS2QVE
	LxZbIm8YzkaMXEtoVzorGo7TrtTM0YNGujm6KXpaL6CLKei4OdEXBL23fRdQ==
X-Received: by 2002:a17:90a:c2c5:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-36e335db4fbmr6149440a91.24.1780540718488;
        Wed, 03 Jun 2026 19:38:38 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6dba8573sm1253072a91.14.2026.06.03.19.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 19:38:38 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	Alexander.Krabler@kuka.com
Subject: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when compact_unevictable_allowed=0
Date: Thu,  4 Jun 2026 10:38:10 +0800
Message-ID: <20260604023812.3700316-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604023812.3700316-1-chenwandun1@gmail.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

compact_unevictable_allowed is default 0 under PREEMPT_RT,
isolate_migratepages_block() skips folios with PG_unevictable set.
However, mlock_folio() sets PG_mlocked immediately but defers
PG_unevictable to mlock_folio_batch(), result in a folio with
PG_mlocked=1 but PG_unevictable=0. Compaction will isolate such a
folio.

Fix by checking folio_test_mlocked() together with the existing
folio_test_unevictable() check.

A similar issue has been reported by Alexander Krabler on a 6.12-rt
aarch64 system. Vlastimil suggested to check the mlocked flag [1].

Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/all/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/ [1]
---
 mm/compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b776f35ad020..7e07b792bcb5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1116,7 +1116,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		is_unevictable = folio_test_unevictable(folio);
 
 		/* Compaction might skip unevictable pages but CMA takes them */
-		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
+		if (!(mode & ISOLATE_UNEVICTABLE) &&
+		    (is_unevictable || folio_test_mlocked(folio)))
 			goto isolate_fail_put;
 
 		/*
-- 
2.43.0

