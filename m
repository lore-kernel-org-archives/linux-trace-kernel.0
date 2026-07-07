Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EFA3955E3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429183; cv=none; b=lX6dXCtbzCycB8UzG5fYSOcEPm8ELedEiAF8RP+TZj8qjYxRUQ5BN8g/fBMbRkZjBVeC6aMiV+J7xVCC1pb4n5j1T+hfhYbWc3XphVmoNoREMbesZaBivjERN7cXwUDFih/jFeJf7D2zs1pEnAhsXwzs0R7ChpMMK+icIiVop+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429183; c=relaxed/simple;
	bh=Byg3OJZRe1xd79dRgn/Udm67f4fCX5ulQy5iFP2kz1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkcgOwNrLE6nApHxV4IAiUxO48XjBFUihoczl92ohHrbMwAnyK3OYoCOdyqtJxpYIHelT71rQvEeJ4sNSo9o11DDKEnfh4nNaKWgnMbQHxojcyfxkYDv4J+dffh3hNInDNtkXZOUweZsOUR9hnqamP5MjxSoaezezttSOZ7MDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNhOG6bt; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNhOG6bt"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca00ea47337so659491a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783429182; x=1784033982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bqawGs/D2kwMuaBURT3A7nHx9bziQ0g0fHDee9Yijoc=;
        b=qNhOG6btEnVV5WsdEiIwgo+aAL+1hfa6WhiDm4ke6TbV3DURfnen3QMEH604nRYYmt
         QLCI7MLvnUs5ntGQ1nmTm/lOVeOuPj1zu0Gc18UgJRee18GFhhYOzA5/LEbrEFThKUSl
         e0/Q8g1rtoEKcAlA8BrAP1nW4L+aTHTd+A9trPNz+/hCa16yQJATbe3l+63scjuaCnIm
         aZpkdsP50ATLDVqq2h9YM2RvMhmT8SzQzp7lql98C6i1fTP76zcPtSkQ5oqcIsvvFq4F
         Ts7Mk0/bvT6dbjg52g2KZnI/98WCvgRtFNTiL3DOlmI3flQOgL+/ji/+Qyv5tb57bmKr
         JmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429182; x=1784033982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqawGs/D2kwMuaBURT3A7nHx9bziQ0g0fHDee9Yijoc=;
        b=e25dlCi1A7RAP/lYfwjYHLG3yjzK65QQLFeya8QzZfCl0puhOTyJce4Bu7pFB6opZ7
         NCrPOb/Mwe90Es2Wj2KKeMnWFqERF+m9PRJuhWYh2CrDTzn2cjZEwhMlISKxwWggpj59
         PAxwJbmO8wYQS47/hwvJH6fGmBQmWVdkYBZBc6IKM38c5QlL6csBJOprd4qgnaeXfEVy
         4xBkwmihzY4G4XpPeE1hdK12eQQg0n75vnPwGHj9p22W2DQate3AcyVpkOy7BoJmlS05
         UX/WgF2Iwe8LQ15xI1Q42gliboRvyb4wqutwD4pVc4XoQ7oYRY5Q7vK41c/mckHxux+J
         Ot3g==
X-Forwarded-Encrypted: i=1; AHgh+RqlFRpGVr+3+A94Jn0Qh1Dt6cOkBTRoI005RhvyiEf3ykEx1hRYIzXi1EhIZGVJZAy0TOvIe7GqBRebzkwKKYmxu8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHdn5lLK0IArmhCYadJAYlPsnU9ZtfrB4GUSssW+AJ8HZLug8k
	wtZCoWc1VYoZyAu7Wcd4rjJChcS0mdb0p6DhioVC4rAt9fju0KWApdt3
X-Gm-Gg: AfdE7cmSlVsW6w6Ql4kZ2y1UrZ9kVOOvlUJIEZZiS0CA/mYoY1hzt7HkCDqFPzq27I4
	erOGLmftMJG6Ivig4s3QZiTFuBUKdmmr3DniRHwCrPci2U7Ut2OygIBsYG7qsFzGMS6tMh53xLP
	C2lXD7y36ipFGjM12GpuQwgTL2R71Q6k08B4VSMYsGK3DMOSYzvbi2hVTHD/ALNlAjCvMF/J4Dj
	CyDx7dDClefJERi72DaLqEumgT+i91fFkxOzmoFECiglVtfWaBkY1kWWcvVOU+Dy5ptQwDmK3Mi
	sWBUqprWue1LJe5QWk5R+hTOtr6mSxK7sdYtgZuZajxf+PUKEs5G+gJq5Ab/2Flvzv4c5LCp25y
	rAh8qkG806KqtUOb7N/sDiqKh/zHySYF61lQY5Ep6Ll3JNE4Z39DUbLIT4RKmU5jnwBICveqtiy
	6HhEBO1WO20zg3PJsfme3xcnMfhw==
X-Received: by 2002:a05:6a00:859b:b0:848:32f5:4999 with SMTP id d2e1a72fcca58-84832f56f1dmr1523190b3a.30.1783429181654;
        Tue, 07 Jul 2026 05:59:41 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm5415983b3a.3.2026.07.07.05.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:59:40 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: vbabka@kernel.org,
	david@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	Alexander.Krabler@kuka.com,
	hughd@google.com,
	fvdl@google.com,
	bigeasy@linutronix.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	pfalcato@suse.de
Subject: [PATCH v2 0/4] mm: honour compact_unevictable_allowed in mlock and CMA paths
Date: Tue,  7 Jul 2026 20:59:21 +0800
Message-ID: <20260707125925.3725177-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

vm.compact_unevictable_allowed=0 (the default on RT) is meant to keep
compaction from touching unevictable folios. Several paths still migrate
folios that are about to become unevictable, or in CMA regions,
installing migration entries that a later access must wait on, then
causing latency spikes on RT kernels.

This series fixes those paths and adds a tracepoint for diagnosis. It is
a rework of the RFC [1] per review feedback, mainly from Vlastimil.

RFC --> v2:
1. On top of the isolate-path filtering, also filter by VM_LOCKED
   during the migration unmap step.

2. Make mlock/mlockall wait for in-flight migration entries, ensuring
   the folio is on the unevictable LRU before mlock[all] returns.

3. Dropped letting CMA migration take unevictable folios; instead
   migrate CMA folios out during mlock[all], avoiding migration at
   cma_alloc time.

4. Moved the tracepoint to the migration unmap path.

[1] https://lore.kernel.org/lkml/20260604023812.3700316-1-chenwandun1@gmail.com/

Wandun Chen (4):
  mm/migrate: do not migrate folios mapped into VM_LOCKED VMAs under
    compaction
  mm/mlock: wait for migration to finish when mlocking a folio
  mm/migrate: add tracepoint for folios unmapped during migration
  mm/mlock: migrate folios out of CMA when mlocking a range

 include/linux/compaction.h     |   6 ++
 include/linux/rmap.h           |   3 +
 include/trace/events/migrate.h |  29 +++++++
 mm/compaction.c                |   8 +-
 mm/migrate.c                   |  23 +++++-
 mm/mlock.c                     | 142 ++++++++++++++++++++++++++++++++-
 mm/rmap.c                      |  16 +++-
 7 files changed, 216 insertions(+), 11 deletions(-)

-- 
2.43.0

