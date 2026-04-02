Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9296396B96
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122021; cv=none; b=jkV0EsqH205HTNOQ2QNygq67PPQ6mRURDbYu2MByBNnXk+HUjHWR2SPKdeLrA608YlRyVXrle5ll6thaWzC6QwOyvhgaREGFskXyZK2rRDdThr65Z7qDe87gUsfujBfRkKh9Q1iU592yOLMv3Zmi0I8uecwEYXiqyBJCk/AHVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122021; c=relaxed/simple;
	bh=8qL3h59juOVKtdfVtW9fmnPkaOy3E2k5IewpcRqOTrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxFIpF9Vf6FvRSSqtLMNSJPF9kDESVi3/IPbtLX+hUwWbhemOD4Pt3ram8u/Fc5F6BZEldjbjLnjLWhmdBagYzqqOAHhLv71CRNqNejuHQaFVo3c3smgRqoZUcXM0yFc5sfewwg+keYbrZeWaIjc2deqEmFLT5SlRpfds9ENBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPTcZuwa; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPTcZuwa"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358ed696623so264112a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Apr 2026 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775122011; x=1775726811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n764rmShOBun+KHnL+n7memFmLpzCXWKwyty1boEneI=;
        b=GPTcZuwaQ9dsujgraAxVwHHCifPXrgGVTQfKWBjvaZNkbaWhkb2Q8HTKPwxUcjbCHG
         HUHKYo7aeWIu07KMMVuNTXX8esTE+wTkZ0Ut/Ur5MGHA1rmeG5E7dINFJ211kcyBpnMr
         kAZ0CLlhS67Fy2lGrWoSQXVd+WWr6N4enueijThYCtZSQTvcbEqU61s7Yb2rc46pyrit
         ySnl8LBYj9kuWCZiRunjmmXguhyFu5BirCL/HDAugPDL2ffgvPz3CEyser0L/bK8hTqE
         Xbl2CslJ2sH31NzuUOrm9o2DKi0q+FiCySkuU6+jqmzZdEmGSresbQcRzN/i1VPyVOoX
         E/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775122011; x=1775726811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n764rmShOBun+KHnL+n7memFmLpzCXWKwyty1boEneI=;
        b=JTQDubpN4jmZ1uSrCoT208QIuyVY4LiOfopbrxo9m41l3HgJudwPmKMWY5iXGTdE4p
         kn0/2tBM8bCsbNO9k2bFkXX467b1sRKmhFrYFsAsvHF2FnQUV9gAPhu2JlY9zVV7AZNJ
         ajug0rWkdzizjtV5Tx1Ilxdr+n3mNMB3bV4KTuSMYVV6R+dpqM1KhPc3EFckkq1u4/Dv
         CNx5/DL/9/ouH3gT0YdVvCwaAKwm4YKobCv0adGSErGocY1X7WihHIT6tFk/PsRnnegB
         U2F1b2cHPnCQKmkA064I4je0cSFqZlD0SPdfoxm9LNz877zgGKT3iw1V7VFWnMXwX1ZX
         Fz/g==
X-Forwarded-Encrypted: i=1; AJvYcCWZCc38o/3YbnKMg/nawydI1b2LfvwaCNKThcJ6RnZoHM854j31Xpak7B9IPCAGutUVZwSUnJ8trpmlsUZMuFRBC2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2L4ENQuCCBsKDynVGnKN8EaXEVxZIvBziYqbhTh/8Ta1TNtyX
	6mt+RQEJHrkMQyWis82vQv0YiLqYPpVRl3Af5yqF+QOrnzkDy3Pb96N5
X-Gm-Gg: AeBDieubEFL1DloHXmq0eYhhSkbjUs+3Q8K9I08DfigzdAJc1ZwKPU7UNNl1S93fSLW
	pcIexmTxHNWtWbjUXkGmM4Rw2jEtz2A5PATABxrwJa2iUdYbLcVIvn5f1TCGyYDxeeyuWYvWjut
	cKQ7SGqe+0Kb3sNAfACQciX01jOOjDxP8+0347l/XZMt6b/0J0hwuthGUPstW030QOM3uyRFihk
	mSI/E2ZFgItH7sVniyFBytr+GjMbBtMZs8tOO0zC6fuWuQwllknRZo5vFXtq9LyTblOiX7MKgPu
	GC7qCBjlQGCXjNix2g+ie2wNYH1GiUdC8anT/c4egbeHZxwG5eU4FR1KeoM0rp7JkVnC59jZ5nj
	MK2GbUiC1TYK4r6lSl7RXo6AihEZvXkJ7/b/RSCurxHJrUMIqwz0sW33BMHucI5zo5OKHaOqgm8
	p9Rz1WtlJhpKmyE1TrSMzT5u9YK4Q6DQboHZyXcYm6hU7X
X-Received: by 2002:a17:90b:5890:b0:35c:1695:24a3 with SMTP id 98e67ed59e1d1-35dc7002648mr6149423a91.23.1775122011254;
        Thu, 02 Apr 2026 02:26:51 -0700 (PDT)
Received: from yafangs-Air ([2409:891f:1aa0:8613:19f3:7bee:2e41:149e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm2227645a91.6.2026.04.02.02.26.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 02:26:50 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 4/4] livepatch: Implement livepatch hybrid mode
Date: Thu,  2 Apr 2026 17:26:07 +0800
Message-ID: <20260402092607.96430-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402092607.96430-1-laoar.shao@gmail.com>
References: <20260402092607.96430-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Livepatching allows for rapid experimentation with new kernel features
without interrupting production workloads. However, static livepatches lack
the flexibility required to tune features based on task-specific attributes,
such as cgroup membership, which is critical in multi-tenant k8s
environments. Furthermore, hardcoding logic into a livepatch prevents
dynamic adjustments based on the runtime environment.

To address this, we propose a hybrid approach using BPF. Our production use
case involves:

1. Deploying a Livepatch function to serve as a stable BPF hook.

2. Utilizing bpf_override_return() to dynamically modify the return value
   of that hook based on the current task's context.

A significant challenge arises when atomic-replace is enabled. In this
mode, deploying a new livepatch changes the target function's address,
forcing a re-attachment of the BPF program. This re-attachment latency is
unacceptable in critical paths, such as those handling networking policies.

To solve this, we introduce a hybrid livepatch mode that allows specific
patches to remain non-replaceable, ensuring the function address remains
stable and the BPF program stays attached.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/livepatch/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 04f9e84f114f..5a44154131c8 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -665,6 +665,8 @@ static int klp_add_nops(struct klp_patch *patch)
 		klp_for_each_object(old_patch, old_obj) {
 			int err;
 
+			if (!old_patch->replaceable)
+				continue;
 			err = klp_add_object_nops(patch, old_obj);
 			if (err)
 				return err;
@@ -837,6 +839,8 @@ void klp_free_replaced_patches_async(struct klp_patch *new_patch)
 	klp_for_each_patch_safe(old_patch, tmp_patch) {
 		if (old_patch == new_patch)
 			return;
+		if (!old_patch->replaceable)
+			continue;
 		klp_free_patch_async(old_patch);
 	}
 }
@@ -1239,6 +1243,8 @@ void klp_unpatch_replaced_patches(struct klp_patch *new_patch)
 		if (old_patch == new_patch)
 			return;
 
+		if (!old_patch->replaceable)
+			continue;
 		old_patch->enabled = false;
 		klp_unpatch_objects(old_patch);
 	}
-- 
2.47.3

