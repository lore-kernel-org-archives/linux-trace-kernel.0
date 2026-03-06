Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9DA30C631
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827504; cv=none; b=D6TlJPYa8jVBmVdnEwz/xZFOTKQGYFx6PbMvVeXVJ+o6j1Ltqa9h/qInRQRW4yAuza+J55KU6KRmdTtFNauH3M61QrWnrB2uAuYr+KQ7h2npJjmC8ym2elaHco5gLmlfXuElMAxSVbSaovGEoXgjG9D6Biavc9ERIBqXgOpk3VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827504; c=relaxed/simple;
	bh=NvN/xy+/VeQeq+W1h8Raav62De9gFC7UBlGgdAxUzwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTPcau/hN6E9xWMd3N98zuyle2tCiNG17ZyF7q5dFtAhBRIVOYR5XWr32tqscY5jKYlQj42MJnKG0zxHoF2Da17C9GQX0bkqFNLDdBQFlD6mSUFIvGRxh0bcmlA6uwRBt1bat1iYui8igkLLqME4Yb0We/3tsdOLoJbw1c33tRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk8OxN7G; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk8OxN7G"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-503347dea84so101481071cf.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 12:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772827502; x=1773432302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLRL/21CZaQDWxEDsVS15El8cmGm+Da0IafrOAmYaGA=;
        b=Uk8OxN7GHiB5czu4U4Zb8zIVfGSF3KA7e0ei8RRn6Bf19Sst5HvmBfoQQ1/N8hi8EK
         uiZ8PfnC5Qy01wgntYveas3zR2Pb1SU2J9u30akc0eWWbWhL4cCNW6TjKRlv6E9KBhCM
         ZhGgCEBhGt09n0l2LcGzDGh5xLh64PByAm38Nwmv4KA4kMRPbnYEWLJ9Scz8AHQ+uQa7
         oNgFSwfvIC6HA1mx2pQz0zsaC98JzWavYwoCJPePoTPdy1ydYFHQ5Gwa7pqlSjNfLZoG
         jVjoWRYg9nX5jlJ4TZD/6WZ0JvpKGUvU3wyMLX8UK25cdDnCuegnaIj243Y/6ARD0nOi
         g69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772827502; x=1773432302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zLRL/21CZaQDWxEDsVS15El8cmGm+Da0IafrOAmYaGA=;
        b=YYZ7SHjAsNfpSHbskZAqQDFZBD3m5FbMsU+W4IoOMtcUxfhmLTL/TnfuUVMbanwXiZ
         U9uyZxEmSlznoNrUb5WZzRZvYWKy3q6gJvCyRKIrtQ3U48HOvUQk1zFWnx6RZ2FdUkkQ
         1tKAm7vxX7ePNKwdXmDlDDK64UGU5olUaCFJ+YR4kgmInZwi7hqpbcvJtX3QtFHY4b9R
         YBZlz8oTdBXpfwhn4fQlhPs+YC4bCs7ZSgc0BnNSSsUh0ofKHHAcRbpqLzxlEq/WylI+
         mTbPwXPQqxuMBWI66L1r10kJSGzXzANnaLplMtr0vh/0lPVG2e/l4OU+LrqtK+CBc/M6
         x6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRVbSJxSDl5+iF8e19jHAh9RT45A1yTsUERkAGXvsczk+xVqvLEzQxygIrtws0/dKyoasxxFBbdl5eBFfCeHNGf/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6mMYVpYbBFYVO3TywyHTTmh6rkSrGhkpFnVigbM4tH8e2Oe4
	j7SlOO1DxgACLdJLR8Iq/5vDx4masxrM7nyLr53V6d9Wx54iR+H0eQ7xDdyvp25n+CI=
X-Gm-Gg: ATEYQzz0ACdE7QkuYOPHPOrjWH2JxWloWYpd41u0iX5DudJFXCj7w4InP6BmIwfT7QX
	UNbd/ICwJMoAZ2LtOmSMsi90MTeMrs1iBv3G78+GTcSxtBRd95lM9kcbkciivikZmjWL7vNvjMF
	oqAfg2oCKdSf1zy2tbQ71RkjGJxbIPwezruAOKBYLDxXV+J/ZiZ3/XiuA9j1S7nHpFdGT3zlfqo
	zaw3WtQwjJMbhKM5/IdpI8zyoQ/W+PjruFlW0W2s1aUud5I/HcgADb6k2QQhKiwH3jCy/WG9tdN
	e/183wnhzoyIcr6vlROqSsAXsWZitf+1K8AzPCDVIvK34p1UC9ZQY5kg6gVKarIhKRJpKFSgUDp
	MRN7fBJI1XJjsOanA8dkdzYoEWDq/k3lCShY0Fd4qSFcMAUyw2bv3n5Q/PxnHIZ0OLk0tWP40W2
	7fmAyBjYNaqlcvSqJUm51MLsVs
X-Received: by 2002:a05:622a:1791:b0:4e8:b446:c01b with SMTP id d75a77b69052e-508f499e32emr45992311cf.61.1772827502002;
        Fri, 06 Mar 2026 12:05:02 -0800 (PST)
Received: from ubuntu ([76.38.17.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ea3fesm20945806d6.37.2026.03.06.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:05:01 -0800 (PST)
From: AnishMulay <anishm7030@gmail.com>
To: rostedt@goodmis.org,
	viro@zeniv.linux.org.uk
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnishMulay <anishm7030@gmail.com>
Subject: [PATCH v3] tracefs: Use dentry name snapshots instead of heap allocation
Date: Fri,  6 Mar 2026 15:04:58 -0500
Message-ID: <20260306200458.2264-1-anishm7030@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305165231.67c2491d@gandalf.local.home>
References: <20260305165231.67c2491d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fs/tracefs/inode.c, tracefs_syscall_mkdir() and tracefs_syscall_rmdir()
previously used a local helper, get_dname(), which allocated a temporary
buffer on the heap via kmalloc() to hold the dentry name. This introduced
unnecessary overhead, an ENOMEM failure path, and required manual memory
cleanup via kfree().

As suggested by Al Viro, replace this heap allocation with the VFS dentry
name snapshot API. By stack-allocating a `struct name_snapshot` and using
take_dentry_name_snapshot() and release_dentry_name_snapshot(), we safely
capture the dentry name locklessly, eliminate the heap allocation entirely,
and remove the now-obsolete error handling paths. The get_dname() helper
is completely removed.

Testing:
Booted a custom kernel natively in virtme-ng (ARM64). Triggered tracefs
inode and dentry allocation by creating and removing a custom directory
under a temporary tracefs mount. Verified that the instance is created
successfully and that no memory errors or warnings are emitted in dmesg.

Signed-off-by: AnishMulay <anishm7030@gmail.com>
---
Changes in v3:
- Rebased into a single clean commit against upstream.

Changes in v2:
- Link to v1: https://lore.kernel.org/linux-trace-kernel/20260227194453.213095-1-anishm7030@gmail.com/
- Use the helper functions take/release_dentry_name_snapshot() instead of allocating the name. (Al Viro)

 fs/tracefs/inode.c | 39 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index d9d8932a7b9c9..ad322e8f9e2ad 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -94,33 +94,14 @@ static struct tracefs_dir_ops {
 	int (*rmdir)(const char *name);
 } tracefs_ops __ro_after_init;
 
-static char *get_dname(struct dentry *dentry)
-{
-	const char *dname;
-	char *name;
-	int len = dentry->d_name.len;
-
-	dname = dentry->d_name.name;
-	name = kmalloc(len + 1, GFP_KERNEL);
-	if (!name)
-		return NULL;
-	memcpy(name, dname, len);
-	name[len] = 0;
-	return name;
-}
-
 static struct dentry *tracefs_syscall_mkdir(struct mnt_idmap *idmap,
 					    struct inode *inode, struct dentry *dentry,
 					    umode_t mode)
 {
 	struct tracefs_inode *ti;
-	char *name;
+	struct name_snapshot name;
 	int ret;
 
-	name = get_dname(dentry);
-	if (!name)
-		return ERR_PTR(-ENOMEM);
-
 	/*
 	 * This is a new directory that does not take the default of
 	 * the rootfs. It becomes the default permissions for all the
@@ -135,24 +116,20 @@ static struct dentry *tracefs_syscall_mkdir(struct mnt_idmap *idmap,
 	 * the files within the tracefs system. It is up to the individual
 	 * mkdir routine to handle races.
 	 */
+	take_dentry_name_snapshot(&name, dentry);
 	inode_unlock(inode);
-	ret = tracefs_ops.mkdir(name);
+	ret = tracefs_ops.mkdir(name.name.name);
 	inode_lock(inode);
-
-	kfree(name);
+	release_dentry_name_snapshot(&name);
 
 	return ERR_PTR(ret);
 }
 
 static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
 {
-	char *name;
+	struct name_snapshot name;
 	int ret;
 
-	name = get_dname(dentry);
-	if (!name)
-		return -ENOMEM;
-
 	/*
 	 * The rmdir call can call the generic functions that create
 	 * the files within the tracefs system. It is up to the individual
@@ -160,15 +137,15 @@ static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
 	 * This time we need to unlock not only the parent (inode) but
 	 * also the directory that is being deleted.
 	 */
+	take_dentry_name_snapshot(&name, dentry);
 	inode_unlock(inode);
 	inode_unlock(d_inode(dentry));
 
-	ret = tracefs_ops.rmdir(name);
+	ret = tracefs_ops.rmdir(name.name.name);
 
 	inode_lock_nested(inode, I_MUTEX_PARENT);
 	inode_lock(d_inode(dentry));
-
-	kfree(name);
+	release_dentry_name_snapshot(&name);
 
 	return ret;
 }
-- 
2.51.0

