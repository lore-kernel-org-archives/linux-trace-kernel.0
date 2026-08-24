Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67EF447813
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582828; cv=none; b=U8qESPeuVEpAGRfLMjWhHwW3tiJjjXecMkEjvgiWmgAzdPqxcyuFXeQ58dbdTkPkzE1+OV0DNuW+Zkp2LFRjqVPlMk53pv6AoDW4CY2T8etiJdJddCC9Vzu8Cz+bDWmpGqRx42U3wMEdKclCkK2KgAsLVMBbKKBPkG6i5PCH7ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582828; c=relaxed/simple;
	bh=NXG7bE790VEEAyF28aLFVFci8yXbRztC6StC9DoElGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQRER1sLbt0581HDbnMueG96P6woxaiAxoQh0tWWLPS3m8SAeNGHsJucCZTjy7/5bPlA4FVWHsHis2MVQeu77h51CLM5y16b8B1mFIEFDdxcgtIY88/rxtRjc6Uqr+oLxd5vHdBILg/kS/FTzGLXVcRCWc1hws4edhTaV5DG9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KawySjtM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KawySjtM"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so4095833a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787582825; x=1788187625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbTvMJOA5pAnK3dUzCcI4B1WpzStHPSu12W55oNjXVo=;
        b=KawySjtMyaKjpiaTzAegy+9sFaXa9f+QcH53evqIh6Eai+w+efb+S4fJ5WTZY851vR
         qwSITmHO6w/HydKbTUTRKeR3G+2fdegdqJPEy9OQNJcuq2JPqqco4/clcTQ7rn4LbgDP
         TOdX1wN3re/qmKUJUwYFR2KmgJEdtik/Fvu3RblSbujkY/G9SJaVCBehNwnqHE4h5P9J
         V/PMqa5t5KahtDp4/yLsSQGicbt2SgVVqBrrtgSgrncxA0QdFwp7lre4KL9TCnOW4wzY
         i6WcLo7T9PipZX7GplPH+TP5s/wBdyxwmZRpxWXgNfdgPxeYEBw0A641CfSf17PbNkZW
         sK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582825; x=1788187625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbTvMJOA5pAnK3dUzCcI4B1WpzStHPSu12W55oNjXVo=;
        b=qACi6jFOf+ikGoJUDhEe9BT/kmoMnt/+VfRtT8fCIK4TtMY8S+WLiirN3kW5w8LH6s
         KT7zkqBqC5I17C1V5W60x9lDpxK2AkmWIq/EAT4P71FMW9FY+q2kXVwIAyiD0ID/M3xZ
         4Trlnyl2r3jDLhm0DpDZU3G9efNLox+kherekJBf+n0PNG7DiKg/VKO1UnV+dQauidCF
         eS15i9v8KZL9AprKYjrPRDqb18XJt7shKonTWMmxSBQ75ukomKs7LgRGfgb3GHzbd+tg
         jfrA3dJjTK02r/Ri2cdUQK5PTevKe8oj7uhRt2382zfOHtZGgVabXsmOeuzKqM7I0sEL
         w0mQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzrZqpLZHIbdfSkQBvt3qvfLHFdmiKssYRawDC87jxAXVOl9z2pVhs/w3oHCcj+EJ9tNmKa8VTWgvKfGnlC6Lomos=@vger.kernel.org
X-Gm-Message-State: AFuF++l+OftzGzfxgpkuptrAlRYlnew+vL9QMDduZGl0B6fr3kJX6axO
	goo9R1lpxLqn1kPXYpgjmWDNvM7zmzbPJM5SUl5OSNSkOBDi6QBiHQ9z
X-Gm-Gg: AR+sD13IFxjKmS8xgU2GVn0XLEk4+R+ei3CZKO8/Mkyz0zOlhP+SYjMkM27MizVqGfR
	fAHrLJaD8cDNdGY9FwqbM380FmquptnTo80Vgv1FGI9TFLfFbB06T/NQElTvWRPMnRBeyFV8CDN
	W2a4XigbhEBdKz6EjiITKivTAhfwic+C5dzm9wRpObL7fPIfBPFRc9cdcy2QGrFoolHVZhNzISM
	CREWJGmxM1GYsRloLEr9SoaKUioD6UafSO4HVydL7/1er/UgBtd7f5Pm1Uy/OcJSUYAeMDPutVI
	MUYrPO3ZfYW0NwgL8rHNN4MUTxZ2LW5XLwnJGypVP7LTbptRqphVkCHUCBSysPN5ajNxAf176AM
	jbUE8WEnqij2wS/NdubZJRvv1EfHSocHtny7Z3zIhHqGSe73mXa5XHAPjB1bbKLFiXZ+ZDRXHI6
	kQ1X5TRG86nWMys9OK1k0vPst4lmbspFd9ScyobNZqcqgWTtfl0S40wikHRYohK7Vnq66ZrM9wx
	ZP1OvZ/33DZijXaeZMxoFA=
X-Received: by 2002:a17:90a:100f:b0:396:40e6:f631 with SMTP id 98e67ed59e1d1-39640e6f6d9mr1017779a91.3.1787582824587;
        Mon, 24 Aug 2026 07:47:04 -0700 (PDT)
Received: from deepanshu.. ([2405:201:682f:383f:4cf4:9e7a:69d:2900])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm25774770c88.10.2026.08.24.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:47:01 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] eventfs: Initialize ei->children and ei->list in init_ei()
Date: Mon, 24 Aug 2026 20:16:53 +0530
Message-Id: <20260824144653.54044-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eventfs_create_events_dir() allocates the eventfs_inode via
alloc_root_ei(), but only calls INIT_LIST_HEAD() on ei->children
and ei->list after the tracefs_get_inode() check. If that check
fails, the code jumps to the fail label and calls cleanup_ei(),
which calls free_ei():

	WARN_ON_ONCE(!list_empty(&ei->children));

Since ei was allocated with kzalloc(), ei->children.next is NULL
at this point, not a self-referencing pointer. list_empty() checks
head->next == head, so it returns false on an uninitialized list
head, triggering a false-positive WARN_ON_ONCE() even though the
list was never used.

eventfs_create_dir() has the same latent issue: alloc_ei() is
called before INIT_LIST_HEAD(), leaving a window where an early
failure path could hit cleanup_ei() on an uninitialized list head.

Move the INIT_LIST_HEAD() calls into init_ei(), which is called
by both alloc_ei() and alloc_root_ei() immediately after
allocation. This guarantees every eventfs_inode has a valid,
self-linked, empty children/list the moment it is allocated,
regardless of which failure path runs afterward.

Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ef80b4ed02226d04a06
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/tracefs/event_inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 604ba3e841d2..6e3513b13cfa 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -438,6 +438,8 @@ static inline struct eventfs_inode *init_ei(struct eventfs_inode *ei, const char
 	if (!ei->name)
 		return NULL;
 	kref_init(&ei->kref);
+	INIT_LIST_HEAD(&ei->children);
+	INIT_LIST_HEAD(&ei->list);
 	return ei;
 }
 
@@ -729,8 +731,6 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	ei->entries = entries;
 	ei->nr_entries = size;
 	ei->data = data;
-	INIT_LIST_HEAD(&ei->children);
-	INIT_LIST_HEAD(&ei->list);
 
 	scoped_guard(mutex, &eventfs_mutex) {
 		if (!parent->is_freed)
@@ -802,9 +802,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	ei->attr.uid = uid;
 	ei->attr.gid = gid;
 
-	INIT_LIST_HEAD(&ei->children);
-	INIT_LIST_HEAD(&ei->list);
-
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
 	ti->private = ei;
-- 
2.34.1

