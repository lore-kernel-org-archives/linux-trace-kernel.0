Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CC2F7EF5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695069; cv=none; b=RuL+PN9dwwqZSEjlk+a6eRXcmvNlNTtt7N9gVC6jSch/4y0Sj9gshMrpGym7TE3t4tX06+2PoGYr5vvh/PFbRJIwhvzVc/8LhNjRYgf8+FOd78C4u/wMllOQNMGAPgxCfaL1yoB4GlWRUCmYvXlChrtW1NNAKcTsY0pNjPlYyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695069; c=relaxed/simple;
	bh=JfEx9R90DbtsDady/cwL0vwAaFNOuM16zMYkRtcsrSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XipB+q4DtNkgSc2wQX59XZVUn20XkXeVbJ7wriXgN4R6D2ud6gl7IhgNjJsFj98SHiDowmolmXGhwo9gVcgzAbJ6d7xDE6fSzAiplGihaXgUvNE+xIfHPDriulrKuZPA8Xv+P9JsXgH2z1SjV4JRbzyYFIaYtpFmJPpGgz7ZpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsaclQTh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsaclQTh"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so1549355e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787695066; x=1788299866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8SetAdNEzl5Es+rjASEVAa0Ps4/t5B2aWVxxD5JLYZU=;
        b=YsaclQThIDZiRmcS0juy1/h5Z6FFuX3DRB/EPqQAjhpAicWTBvzUpJSOL38NmcXKUf
         QIcxFEk0YiNITBnyV60bPMltwhOwLMwt/0ou1nwUNlSt0ly2oCJTTIDKr9s91U1n0GlM
         3DzQ7gqM4qlHIAWkJq71QiJf4/y8M1cjE4Bakxdikl4mPWn2FhX2NkPEfWy/cJ6QK92w
         08W9Qnt+TAfsRC63zgiUReOtXCp6LBvfkHf3GXbMCevV7d8n3KrBW95couplJtX+/gzs
         OfsD2Rr2CFb2ohNZSzRxme217cGPBJf3bRax9j1jDWA/fjHsGFPXfOinj0ITAOrRuAIm
         INrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695066; x=1788299866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SetAdNEzl5Es+rjASEVAa0Ps4/t5B2aWVxxD5JLYZU=;
        b=roNmFqBktXKhgqa3u35t435WeXDToGq/P5tYLazqYJY8A85pegAZNpntdJOCK8HgFb
         ucVHaLhvWpPvgYvYnxlK6w7Z3igaLsbeW+LkxjEACob0yYAaWfYBsMpM9tvm5SA2trhV
         bDemKwNytB5u/C2OwFAx0f09lRWLY7VbegPA7FHEHUbDwZM20tgs9zvgssJuZwP8mhq4
         Pov0o04j7/rEYQnAYWxi9WzyCApPTcZaxEn1N/WZWv+gG8eK1eviZ7bmuB3hH9nJcJ2F
         gWGU5n8CYe8umq5tJWw3yQiee8QV6R4Ur56ScZcMEEPHCrx4oQkIMKYbqQtQy9Co6Eka
         SgZA==
X-Forwarded-Encrypted: i=1; AHgh+RrCLViIGGmr8isQV155bNsLMPz8kDM54Nf4L6gSg+E4FT8VytyWJ8QnSh3pTv8HH/miEGftvm84sIyg7h65cCnlruM=@vger.kernel.org
X-Gm-Message-State: AFuF++llotN1bMocX3D4SDxP7moE75WYPRJQiNan/GU+6ZwOYD7HuoEg
	8rktE4ggzMJClIGM9zYhzbRXaqhTHZo7IAaVP3T94/qCSjhAqxDfUVAb
X-Gm-Gg: AR+sD12rLZbMxj3Ri/HVcf6U9KH840d0FN4jZKbdJSJ044qNo/lCZg37FggykQLVO3f
	XOF4cfKYDnPentJTPVKT6fu4bMbdcw2NjMpGIBiBPIelqNF/VNTARmaZbKof+ifdRxfPnlppCJp
	iHKVYY0XpAngDlFI5KRka7onZBt6Q5oNPKY3kD43aejfj63xeL8PkEmmUJUPcs391ir+rovjlGt
	IDb6mhGtWB6N/6vpM4JMI7sEkoKfLqbsSceToaTNJpOYgBQPMvEF5AXk6i6CRNylbcuG/ivOI9g
	/gYkZl9asmDsfEBPoAvwYzURH18o0R6L+KiBGwEmRZSuZQuuAOeQaG9wVYRpYcGH0pS2Sghhflp
	1de7sDT+JayEdCP+RASVfTxx9vPAGcFz3p93IUGVFaGSY6X03861cudlCK70tk1xsO6tAS/pPfh
	jNiANJLAvufLQCrr13wSkP2NzVkjzlgYZFl0q00RLD+93ufGRNX1vSYUVPl/92CeKV0oQMkbJWf
	mJOr6/xR0oC1N7RQDzYU+mHqkefGhNWXgs5a6FyMKop9KO7
X-Received: by 2002:a05:600c:8b85:b0:497:ff73:68d5 with SMTP id 5b1f17b1804b1-499dc6a2cbfmr17069205e9.0.1787695066192;
        Tue, 25 Aug 2026 14:57:46 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dca8c75csm5989185e9.2.2026.08.25.14.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:57:29 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] eventfs: Initialise ei->children before it can be freed
Date: Tue, 25 Aug 2026 22:57:18 +0100
Message-ID: <20260825215727.200803-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eventfs_create_events_dir() runs INIT_LIST_HEAD(&ei->children) only after
tracefs_get_inode() succeeds, but that call's failure path jumps to "fail",
which calls cleanup_ei() and then free_ei(). free_ei() reads the list with
WARN_ON_ONCE(!list_empty(&ei->children)), and alloc_root_ei() uses
kzalloc(), so children.next is NULL there and the WARN fires.

The path is reachable at runtime: mkdir /sys/kernel/tracing/instances/foo
ends up in create_event_toplevel_files() and eventfs_create_events_dir().

Move both INIT_LIST_HEAD() calls up to right after the allocation.

Fixes: f0ece16ffca7 ("eventfs: Use children field for rcu head and add memory barriers")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 fs/tracefs/event_inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 604ba3e841d2..1d9edc99ff3f 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -779,6 +779,9 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	if (!ei)
 		goto fail;
 
+	INIT_LIST_HEAD(&ei->children);
+	INIT_LIST_HEAD(&ei->list);
+
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
 		goto fail;
@@ -802,9 +805,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	ei->attr.uid = uid;
 	ei->attr.gid = gid;
 
-	INIT_LIST_HEAD(&ei->children);
-	INIT_LIST_HEAD(&ei->list);
-
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
 	ti->private = ei;
-- 
2.55.0

