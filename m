Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443932853E0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954755; cv=none; b=syQGVCUAJZx/pCKm1CR/T+hHDETPpEXYuVQpY95xbsrjuLP5Uda2XgNCGuNTmhCvpi73two9D3ezfCVQwWGb800G64KxEfcnBVdNwz0+CP71ertWhYnVBTtTWQICiOCUWAUQqaKXd3+/YSBj0iWe1KHuNZxqrgAEkpTdccGPRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954755; c=relaxed/simple;
	bh=vPqrFhzsoS56yk34gogqjEXAKiAKcL51MnvFt/0vTxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FEDg9hZvT5Psjsjtme/9jS7Sy5W1gFrLT8kO+/F0cN93Yf+L8dFh432qsZkE8ltXISiyA40V7xcS7xSOoUVY6Cigua4zvqxBzHsC7CPtbpBEwyI0wKS90Ymacut4SlLHHWZ7/w32RRYgQrk052oKeNvzYqbZ0YMPO7nm7lijd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zV/k/JN+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zV/k/JN+"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26472a98ab8so11352595ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757954752; x=1758559552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dh1IS3JVHOf86RTcG+zb9g2w/Ys+63vuY/qru+PreQ=;
        b=zV/k/JN+MEs5mTleaLd/vdGTldfkvMs9MFHiB7jKUhkcINpmK79TDVqdPin9BNv2o9
         VmNHWv406Dj7sIufglyt8C8zDiLy6lRB1+z8X869/5iTJjhJzWOfVuWbS6XBK4sgews8
         9u8DrFyTcvo6UUdgtRbWBQ26Mv6zghSrdvgX/pP/eGJnD6rObeFKl22e3foOx3Y+9LMI
         k2kwvqw+ODGe0A4rAoQ80qoiSJFar4+n+1vByHVOeso+429EXL//YmjNqu79XREIRQ9+
         bgAq4lqrkPTv8udsm19RkT16QSMiF+UZ7wUDgdnBMrOD+7rjvVUBridRM4Ef9TB4Idya
         t6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954752; x=1758559552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dh1IS3JVHOf86RTcG+zb9g2w/Ys+63vuY/qru+PreQ=;
        b=YvmALwN+uXakSRW0iIsEETbsCnq+bOlTQMDXrLV8mLBE/5UPjVq+kRqNuCF6Z3RK4y
         P1t3mBEgbgbLHNYVkv+1Catl/Qw5IxC18j38rcAIH0I3rkVcWZdzv3YjWByQHQ4LzfhB
         Ld/PWt/uZHabGAfOv1GV167JWikyQ2zmWZWTBWR1UUtZMwKBveB247oVa+8ynQkjHdAD
         OxnMMVpca1N88LDqqRbH9rHYSYVKloW7tOIBJOVrOfrbT5ZCIrg5kfYWMMSE/b65jd9h
         JfDJW/CzS1x7wc78k6+tsga23jpNmqMJ5nqyB4giL/xcGzDnWcno0BiuU6AM7V0kmBbu
         jdTA==
X-Forwarded-Encrypted: i=1; AJvYcCXh31omQLqLrhBf1WalHkSk7v+bRTFK5MoR4uf7K/bejGk5owQEpOg5kvS0xlKI0BdgpgEGhRE9hS4q49e1fQxwcIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwbWyEmy+j4/hNKy8B9Mb505uZDdokDWY/Ce7OKRmFyRQDqFxa
	JtatqDgbVUq98tB3Gh1B9iwutbA1NGAcdslcBZ8v7q+pZq1eIQf9Wb/pQi1Uk9CgsSKWH0xRQws
	Y+q9wsBYOajcOVxROWN7BhL+wkw==
X-Google-Smtp-Source: AGHT+IETeFsnzxOgNLMCiDHUaYpnu2vRB/Fb66R7+b7xgDA1s+PPQqB4+bTMKY9LvQ479LuxEWFmKDI75ZPJsp8Xlg==
X-Received: from plkb5.prod.google.com ([2002:a17:903:fa5:b0:264:7b3c:4fe4])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dac2:b0:24b:1585:6350 with SMTP id d9443c01a7336-25d2ac3c545mr185756655ad.11.1757954752355;
 Mon, 15 Sep 2025 09:45:52 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:36:32 -0700
In-Reply-To: <20250915163838.631445-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915163838.631445-2-kaleshsingh@google.com>
Subject: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit checks
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The VMA count limit check in do_mmap() and do_brk_flags() uses a
strict inequality (>), which allows a process's VMA count to exceed
the configured sysctl_max_map_count limit by one.

A process with mm->map_count == sysctl_max_map_count will incorrectly
pass this check and then exceed the limit upon allocation of a new VMA
when its map_count is incremented.

Other VMA allocation paths, such as split_vma(), already use the
correct, inclusive (>=) comparison.

Fix this bug by changing the comparison to be inclusive in do_mmap()
and do_brk_flags(), bringing them in line with the correct behavior
of other allocation paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Chnages in v2:
 - Fix mmap check, per Pedro

 mm/mmap.c | 2 +-
 mm/vma.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7306253cc3b5..e5370e7fcd8f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		return -EOVERFLOW;
 
 	/* Too many mappings? */
-	if (mm->map_count > sysctl_max_map_count)
+	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
 	/*
diff --git a/mm/vma.c b/mm/vma.c
index 3b12c7579831..033a388bc4b1 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2772,7 +2772,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	if (mm->map_count > sysctl_max_map_count)
+	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
-- 
2.51.0.384.g4c02a37b29-goog

