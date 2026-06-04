Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF936F912
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540710; cv=none; b=jzJ/Csg+jZw0KxJIck1F1B4yhzxufzpDZKc0J1IU2tRY+qbi7n51hFQ60d7tj3Of1q9tdMqPo/3qXd09eFDoMH+9pDCYO5pPlNOePamJOLAWFzkav04cjU1egzFlOOZbzmYgwmg2nBctq2h3waU7qECbwZDWwHcLDRseaXiDws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540710; c=relaxed/simple;
	bh=wwCoW7DmfdTZZnPyFRGmgps6+GicUaepEB+MXmFgDxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMIfaFu44MDPtINo8ZEEpL72Jg+yUGfJUULxk/Av9/1ic6x7Mlaid3Fu9LcTlP4nuLkQGDK6nWNBSO7a0RvOIWgpUG23S+h4aksZEeuXhqYd9Zpup2imFMTjPExO6nUBRETn+HSdjRq2SrczCoSsm/Z+Vi6GYwzwblDxcDbkYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPYB7Qey; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPYB7Qey"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso98097a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 19:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780540709; x=1781145509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnVgPGbeod1FIMU1/Hr8h7dHeMhQCz5JwUfAc3OgklU=;
        b=LPYB7QeyH8uWqC7GJ1wvmfiJkLTTNK5NKWeYtnPlts1fXPTv+6d6bX6oxxzkH1ZhzY
         jTmIt6eMnvRtEkisRdwjuUEzb6vSzX7oVDU0LV7AvvGGHvADeSOJha3eDDymTOeBpWEZ
         UeUMQDxCc7tKwhVlySmeblkgRzulvgHgUMIjAyjqMQkko7JoO3WFyE+bwoScUhDrcFPz
         JBncbsDccyuZs8zRlPl1cUF0qFtHBOjLWFxlFlTrprFhse6X8UFmK69z5dQAflCFOHC4
         zfoJc8+MZYdYTIYX0yXyb8GMDvK61+09d4GgYslfzoY8bIGVzYT170Pep2LzddE8tdkq
         lEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780540709; x=1781145509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnVgPGbeod1FIMU1/Hr8h7dHeMhQCz5JwUfAc3OgklU=;
        b=MhU/D3ch1p7ACLP2c5hsGgb+F3Nb4pTUjvy5D3UD08krCuj816o8S9dw4BPH6BqV6U
         jU/fWDZLqW0HxA9A4guarGdfMphIIh2thUGXPXJgIiCLGxqy09aUw9AVT7yYFCjwucXh
         Fdcwa/cgh9hNZsCPwwqM2tl8FFZAgrI6FAKSpcOs6phA35EGQH23Yhja7pvF0emzHmLq
         8HOWrRv9CH1uhqiAB8lylG6czMOJPAI+gyc9AdeS+JE0eZ5vI/vS9M1p4Lgi3tNZ5JN4
         0Ie5ztGApPK8AVghFeDxlo3uFTUGKKvvGkK0wOLi2xZgUZUY/vgUNBEVhaaGVAZRrOS4
         Kkkw==
X-Forwarded-Encrypted: i=1; AFNElJ96Vzj5SCwymYX1wQbPMeBLcOuBsCEyUF8uMPRhtq5iH3Xh35boFugMVXI7GAaotWhkO4gwcr9i6kc3pUOgIJB0rKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfVuLIN4TYLq8nXUKqi5PNK7ZZJjFAkHDKmsG1ZW15lhagXIW
	1dz1s8nW/0po8j9ypWlMjLXMw3cClgOYZ11XJrV6Q4cGwZz41voP6YU48FGEDuE8PazeoQ==
X-Gm-Gg: Acq92OEyaz2RfFacGRKXWnPoAW+V8FQFhI7E4Gbzscjt6tKYyDyockM1Ml8Bou+Qsk1
	WWcQghMGBrEk+RAx/s3q9odKeUL8iXupPh/QyxbQ3+9ZgQUQF4kgsWHlKGa8dw3Cj7CuQhsfnfI
	sCjtWlLmeeqqZZ+zUFocaE31qo6+TXI9W0/lXDM7cd/glQ95Uo8kSMCu8BDGvJ/1mZl3EOpb27j
	vjo4vKxM/E91Aa2Ox7LA+aJTMh0XGdzmwj9X7WMrBDjPnRTsM+Il1Bc4qod4w6QdcXuPk6xn0C7
	mPQgWOs6hqho9sHfYCfMrMijpxS4uRK3DVUgPOaN/mdYcV5gQiFov+u1Mp8v4t7sj5z1UItZ2EF
	V5gfe5ksEx7dvGitaCPzfX5vL6eY2kccXWhTpfi/Oend6nLnGCadqEMDVARrLpoQLFWYHB2yR2L
	AL/BF/cUnjmQutFPYLxis7YF8xEaQSptO+zHgWd8MKB4pQdBo=
X-Received: by 2002:a17:90b:5610:b0:369:7421:b376 with SMTP id 98e67ed59e1d1-36e32949e58mr5612929a91.19.1780540708922;
        Wed, 03 Jun 2026 19:38:28 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6dba8573sm1253072a91.14.2026.06.03.19.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 19:38:28 -0700 (PDT)
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
Subject: [RFC PATCH 0/3] mm/compaction: honour compact_unevictable_allowed in mlock race and alloc_contig path
Date: Thu,  4 Jun 2026 10:38:09 +0800
Message-ID: <20260604023812.3700316-1-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

vm.compact_unevictable_allowed=0 is meant to keep compaction from
touching unevictable folios. In practice there are still two paths
where it does not take effect. This series fixes them and adds a
tracepoint to make such issues easier to diagnose in the future.

Wandun Chen (3):
  mm/compaction: skip isolate mlocked folios when
    compact_unevictable_allowed=0
  mm/compaction: add per-folio isolation tracepoint
  mm/compaction: respect compact_unevictable_allowed in alloc_contig
    path

 include/linux/compaction.h        |  6 ++++++
 include/trace/events/compaction.h | 26 ++++++++++++++++++++++++++
 mm/compaction.c                   | 14 +++++++++++---
 mm/internal.h                     |  1 +
 mm/page_alloc.c                   |  2 ++
 5 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.43.0

