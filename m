Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C233D6C0;
	Tue, 10 Feb 2026 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713034; cv=none; b=azHwM1l1LXh4J6/8TTEAUV5Ky1K6is0jnMusZFKsNPXlfQbhfA4/CKnZ7prl6/Ww/Rh/y3TDigA6HPh4Xf8wvrSPesGGXrqgnag2JZ+CeFvR99r+lITCJTUPrTzWJ6g9CDUpOty9qwKSuZSC92AQEJL7IA+XXSmzS6wLsMpIpB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713034; c=relaxed/simple;
	bh=o+JbqEddB46Pca6G/AQxYO2jKXbhvqyLXGy3aKB0n4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpckjGSGRMdgQEzacFQs3zH+Ud2OaseRG5xmfuHrYSJAdf9mXqxuGlgqC+PPTtd26tPrNBraNHInRayONcKJFobuWbsX688nlQAOmVvZHuz9/HB62Sgn/zftQeNsx7Eu1t7hd1wPPC0uULoAVFq+nWzqFiZQHnFBsn9Jfc/OZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXWJ1stI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXWJ1stI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06924C19423;
	Tue, 10 Feb 2026 08:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770713033;
	bh=o+JbqEddB46Pca6G/AQxYO2jKXbhvqyLXGy3aKB0n4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXWJ1stImWP4mZclA8/IdvFWoGXXQjxxsR2xaHvOkvzhRmk4JY/XmFi8VT18/rhGb
	 2nW1aiOT6hhPR93a9I9tEYUNnu98vZJxDRUjqQDagbIh34u7rVu8h5i/+PrmSBZNnt
	 QJNhydTRBycIQ8HXXahVA8eXGTY9zmwnFJG9C4LxIApymjJ41ZH00+v8p9gH7D/tgy
	 vgRUiRySjkNk5eIfJNl/ythxBNSUtco3xFObsF+/sGiGctFkfOjbE9Z4qAxYk2koxO
	 +54N9bOX7cTxX72R9o7LaBDF+aimO39nmI11BbMUDRPABEQFYOIxuYO2POqMy1ENbJ
	 +8MQMK9sbRp7A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 3/6] tracefs: Check file permission even if user has CAP_DAC_OVERRIDE
Date: Tue, 10 Feb 2026 17:43:51 +0900
Message-ID:  <177071303130.2293046.2400906233143699263.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
References:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Strictly checking the file read/write permission even if the owner has
CAP_DAC_OVERRIDE on tracefs as same as sysfs.
Tracefs is a pseudo filesystem, just like sysfs, so any file that the
system defines as unwritable should actually be unwritable by anyone.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 fs/tracefs/event_inode.c |    2 ++
 fs/tracefs/inode.c       |   36 +++++++++++++++++++++++++++++++++---
 fs/tracefs/internal.h    |    3 +++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 61cbdafa2411..65e8be761e79 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -233,10 +233,12 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 static const struct inode_operations eventfs_dir_inode_operations = {
 	.lookup		= eventfs_root_lookup,
 	.setattr	= eventfs_set_attr,
+	.permission	= tracefs_permission,
 };
 
 static const struct inode_operations eventfs_file_inode_operations = {
 	.setattr	= eventfs_set_attr,
+	.permission	= tracefs_permission,
 };
 
 static const struct file_operations eventfs_file_operations = {
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index d9d8932a7b9c..eb1ddc0cc13a 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -212,10 +212,40 @@ static void set_tracefs_inode_owner(struct inode *inode)
 		inode->i_gid = gid;
 }
 
-static int tracefs_permission(struct mnt_idmap *idmap,
-			      struct inode *inode, int mask)
+int tracefs_permission(struct mnt_idmap *idmap,
+		       struct inode *inode, int mask)
 {
-	set_tracefs_inode_owner(inode);
+	struct tracefs_inode *ti = get_tracefs(inode);
+	const struct file_operations *fops;
+
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		set_tracefs_inode_owner(inode);
+
+	/*
+	 * Like sysfs, file permission checks are performed even for superuser
+	 * with CAP_DAC_OVERRIDE. See the KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK
+	 * definition in linux/kernfs.h.
+	 */
+	if (mask & MAY_OPEN) {
+		fops = inode->i_fop;
+
+		if (mask & MAY_WRITE) {
+			if (!(inode->i_mode & 0222))
+				return -EACCES;
+			if (!fops || (!fops->write && !fops->write_iter &&
+				      !fops->mmap))
+				return -EACCES;
+		}
+
+		if (mask & MAY_READ) {
+			if (!(inode->i_mode & 0444))
+				return -EACCES;
+			if (!fops || (!fops->read && !fops->read_iter &&
+				      !fops->mmap && !fops->splice_read))
+				return -EACCES;
+		}
+	}
+
 	return generic_permission(idmap, inode, mask);
 }
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index d83c2a25f288..1e49ba445ba3 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -76,4 +76,7 @@ struct inode *tracefs_get_inode(struct super_block *sb);
 void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
 void eventfs_d_release(struct dentry *dentry);
 
+int tracefs_permission(struct mnt_idmap *idmap,
+		       struct inode *inode, int mask);
+
 #endif /* _TRACEFS_INTERNAL_H */

