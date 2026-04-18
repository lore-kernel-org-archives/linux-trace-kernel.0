Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C925EF87
	for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Apr 2026 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776539863; cv=none; b=Z1o/prbCszFd3LWlvvRivQ0dvCbrZxrNMBm6S1i3qcFyN17HEjb0prsO+PffkWW2uvEkd7IBayD7WEQ+pbOoulSjINBd8uIH4dFuIFUUvyIN0ZITknddMcKf3LnD67rfN1IbcTYitcvKHp2IFdKsN3j4zA2zi4KcjiYa6qpzJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776539863; c=relaxed/simple;
	bh=GymHzhvKrvD17ZOrxb4Dq9BmOKQK6lNjMoVhIjQSDAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKedYNrh7UKcTeUmbbzihT8QHZMHjqoR9zHz1wiAPhJ+DBhJkgyYWNoLgzCLIe5iK/ru9DsUVTtckG8Dq55I5bsyTaO0UceVrSXuBPASVUK20r7Sx9qGoK3CUMJ9bguKEzCMmNH6eDHdecSzG/nH8Kd0azjHiZqYMB4WoOMPWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaHxRZaR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaHxRZaR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso1125834f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Apr 2026 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776539860; x=1777144660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NrEV29CtMlnaVQCR7QbuyoYiQZBB4+LYKoPg0T6j78k=;
        b=EaHxRZaRhv+D1Djj57nmPrmEsca1Q4hzTeYJeDMzgpWrsPJLDyHIpKa/za3NdwOcvR
         aBjcJ+o2Sd/fR72+Fg4QHkqNE6yeVIkrB+72yN4iLH9iCfMyTXTw9rNPQepVTcXI/X73
         351e7e++jZGRMdnhrLuOokus6IjFK/G9kdyjKVDEC4nvZ0EXzHwOqk+rhU9CRjWu6bw1
         AtQq7Ej5uJF49uR5+Kzds19UXL2vt0WSbxO1vwKLR86oHW+ar2q6L6FozbSOc8ukwZ0d
         0FJr1v4Pk6nnRpZo4sKEpLRh8AbWdObmUv978CFAKQpI7dm2njs22F0FKYhbwCNAadVf
         +crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776539860; x=1777144660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrEV29CtMlnaVQCR7QbuyoYiQZBB4+LYKoPg0T6j78k=;
        b=TTmMpCAkevEoPyXyTH+Q013HfOlAPVug3p39ZntnycOoTvE8x9xADQnCfZDOGZVCBn
         ja05ofM/BE49FMIP+lr6+F8CcRSrV91N6coZT3AE9xzEtHuHV5tgxvtS0U2LCzH8tM5k
         8+DLfY7BeZ7x0qkxSKtsTBX73TkiCoKu8grPBlZ6boertFuG/86z6LpdHPw7AozCNa+F
         TM9F78jX7TmEZax857zY/9uwwL/S2/+aGjjaN/V/O4HTxCOCa6+pAnSsiiPqWxC2JUrc
         AkwxFCYqY7GpB13q1yyJj8TAKUfA92WPZAVZu3gN06f1aRKOZ+bEzQ2+UVuXNF2I8e0b
         MhFg==
X-Forwarded-Encrypted: i=1; AFNElJ/3g+YwR8lSr/FNg68qE4AxtLZKS0LLqq/E60tR88vnqi4pKwkTHd+5H38+DxttdvXYueJX+YhT+p27rEN2eI3ZyDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWcQEgek3Qfszgt1OIsZnNsriIYOSwR9esfN/w5jPZfIMlKBM
	1x0AKO22zsM020rXJ7s7HUXVfNC4VEczE5osQV/RddDoYvrK13lD0c4jXpqcw3wKKFI=
X-Gm-Gg: AeBDietpD0LxkIYXAogNMFIygWRmYTiGDGfIpzDud2344iACx8/ra2hyIdLcuqRBLos
	12ZOmmLMix8s05tUYjp5dufl6090PpdREB95DZ5eMSpG5LhgaGIyFxpEfxo0KgORKcPBXMqtHv2
	nYzLwTuP0fdfmz/ReMGdPAdWiP48PM5Bq3iCBr7cErWp9KjkPKZblT6OvhE6gEJtdgpwz1swZ9r
	HVYGWJMrZ1uS0/umrRzf+yjon0EMtj65MltMpzHCpn1qk4g3LmDVGNwAjbUdSvfJQUg1Z0QTi4K
	AQowCM6Isc8A9rs+/SpAdmJfL33wegpLvqmDPoMP3P1rLYEzBKWDg6PiFtWoGYhfcGo+9n4m0nL
	ZnXoRCnqWQI9bLPCMAm/Zr1VtEgzvqlMaYuy7NI0/zJU5inyDTNNipt1yBk4nkVjcCmUZ2upvG0
	/+ewcIGwWpuapoOaIoeCw/wUCiH3hx5prFSM+y6ySRs4vAsJa+cmzfCLji7JiP+XEin1UfL6Jmi
	e7guX3lDS8nmzeJVOvCTA==
X-Received: by 2002:a05:6000:40de:b0:43d:7946:badc with SMTP id ffacd0b85a97d-43fe3e073dcmr11320272f8f.26.1776539859788;
        Sat, 18 Apr 2026 12:17:39 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm15253423f8f.0.2026.04.18.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 12:17:39 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] eventfs: Hold eventfs_mutex and SRCU when remount walks events
Date: Sat, 18 Apr 2026 20:17:37 +0100
Message-ID: <20260418191737.10289-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 340f0c7067a9 ("eventfs: Update all the eventfs_inodes from the
events descriptor") had eventfs_set_attrs() recurse through ei->children
on remount.  The walk only holds the rcu_read_lock() taken by
tracefs_apply_options() over tracefs_inodes, which is wrong:

  - list_for_each_entry over ei->children races with the list_del_rcu()
    in eventfs_remove_rec() -- LIST_POISON1 deref, same shape as
    d2603279c7d6.
  - eventfs_inodes are freed via call_srcu(&eventfs_srcu, ...).
    rcu_read_lock() does not extend an SRCU grace period, so ti->private
    can be reclaimed under the walk.
  - The writes to ei->attr race with eventfs_set_attr(), which holds
    eventfs_mutex.

Reproducer:

  while :; do mount -o remount,uid=$((RANDOM%1000)) /sys/kernel/tracing; done &
  while :; do
      echo "p:kp submit_bio" > /sys/kernel/tracing/kprobe_events
      echo > /sys/kernel/tracing/kprobe_events
  done

Wrap the events portion of tracefs_apply_options() in
eventfs_remount_lock()/_unlock() that take eventfs_mutex and
srcu_read_lock(&eventfs_srcu).  eventfs_set_attrs() doesn't sleep so the
nested rcu_read_lock() is fine; lockdep_assert_held() pins the contract.

Comment in tracefs_drop_inode() said "RCU cycle" -- it is SRCU.

Fixes: 340f0c7067a9 ("eventfs: Update all the eventfs_inodes from the events descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 fs/tracefs/event_inode.c | 14 ++++++++++++++
 fs/tracefs/inode.c       |  5 ++++-
 fs/tracefs/internal.h    |  3 +++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 81df94038f2e..79193021c6b0 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -244,6 +244,8 @@ static void eventfs_set_attrs(struct eventfs_inode *ei, bool update_uid, kuid_t
 {
 	struct eventfs_inode *ei_child;
 
+	lockdep_assert_held(&eventfs_mutex);
+
 	/* Update events/<system>/<event> */
 	if (WARN_ON_ONCE(level > 3))
 		return;
@@ -886,3 +888,15 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
 	d_invalidate(dentry);
 	d_make_discardable(dentry);
 }
+
+int eventfs_remount_lock(void)
+{
+	mutex_lock(&eventfs_mutex);
+	return srcu_read_lock(&eventfs_srcu);
+}
+
+void eventfs_remount_unlock(int srcu_idx)
+{
+	srcu_read_unlock(&eventfs_srcu, srcu_idx);
+	mutex_unlock(&eventfs_mutex);
+}
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 03f768536fd5..f3d6188a3b7b 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -313,6 +313,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	struct inode *inode = d_inode(sb->s_root);
 	struct tracefs_inode *ti;
 	bool update_uid, update_gid;
+	int srcu_idx;
 	umode_t tmp_mode;
 
 	/*
@@ -337,6 +338,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 		update_uid = fsi->opts & BIT(Opt_uid);
 		update_gid = fsi->opts & BIT(Opt_gid);
 
+		srcu_idx = eventfs_remount_lock();
 		rcu_read_lock();
 		list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
 			if (update_uid) {
@@ -358,6 +360,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 				eventfs_remount(ti, update_uid, update_gid);
 		}
 		rcu_read_unlock();
+		eventfs_remount_unlock(srcu_idx);
 	}
 
 	return 0;
@@ -403,7 +406,7 @@ static int tracefs_drop_inode(struct inode *inode)
 	 * This inode is being freed and cannot be used for
 	 * eventfs. Clear the flag so that it doesn't call into
 	 * eventfs during the remount flag updates. The eventfs_inode
-	 * gets freed after an RCU cycle, so the content will still
+	 * gets freed after an SRCU cycle, so the content will still
 	 * be safe if the iteration is going on now.
 	 */
 	ti->flags &= ~TRACEFS_EVENT_INODE;
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index d83c2a25f288..a4a7f8431aff 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -76,4 +76,7 @@ struct inode *tracefs_get_inode(struct super_block *sb);
 void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
 void eventfs_d_release(struct dentry *dentry);
 
+int eventfs_remount_lock(void);
+void eventfs_remount_unlock(int srcu_idx);
+
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.53.0

