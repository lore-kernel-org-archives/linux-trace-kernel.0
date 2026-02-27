Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63747A0A7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772226913; cv=none; b=toAQBhh8/tTmOPfU0+ySYtLGauFfBgP8385Jxh7SbsgXeQTSywtYWBsknjYdOOfAdcIQ3OOdVgfscZA4HPlOPZyZ4EI6SwXhSl+i5iCAIctzowYTA+l34H9g+yUmJXhnv/lHwyItf3lm0XnC6baiTUYsz+laGoF3tcWyO0NjIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772226913; c=relaxed/simple;
	bh=LnVjx3sJuLTuMbVOtLUm99eribvNM8AdnMRRtkiN6a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyACn9Ch+nlbCX52KBGRxiR9uOKKebt7D1Xqde8BuJnOEv+Rsi52/e2TDmZNYjO9rTTQ9+tTUToXlKgYdZ+UcTBLuqjTreKpDzS0J2AX1FqZbNA1VknByxRqXfbvGe5Hr8F69T/tmgxgn9Mj9WWCY3n/F+mB/pWVhxr4Ns66l7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+jaBZ/W; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+jaBZ/W"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7986d231b3cso43532997b3.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 13:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772226911; x=1772831711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekna4DOdfEq37ibiDykxyhlVIkUX5bjTHdf7smxfKqI=;
        b=g+jaBZ/WM77+88IJT/OU6QuqEb6+1SqEbsVGH9z7ZubMgCQr461rVzrgaz8C3I8Uoh
         mOXa3NF1G5yvI94JZBDTxGVQ25NFySA48F0c9Tc/vhVQR53Xdxayc3anqagLY+9dgRgT
         7IkBBgX236U2P4Bipv4p3D9by4nQqEis6OwhtCTJR1M0PR3RpkXkZTa0QOKjUiyMVwMc
         Q+d/4y219lNUfGfos3FmK7B9BlKLzZdqB3BRSSNgN6oUpUuV6l/P/ZGcxjCmmdGxRnPk
         wFmkaGhPeNa1FtwEkyNFhS958mgUjCGOaKou1k5+LfUQoLFLdX/f9L5PClb/hQ0UKNsX
         7KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772226911; x=1772831711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekna4DOdfEq37ibiDykxyhlVIkUX5bjTHdf7smxfKqI=;
        b=q6Om0ln8yprWJcN7fhLUKX33HJpQ8dA55IWP4x3hhtWcSB7MtyxyAjK33pjRohQPwo
         CSoejEurlesGx+DbWRm2Ku/A6lVcFsSlNtoru3H9kvSE7TgDJkcCjp+OtNZDGtWM0YsD
         L8WiaVxNAPXpgxZRsMjxGSYDRQzSoMTOzEhH0zLzryxRE2b96JEDTD+03+1u0elSD98x
         s2TUo+ovz3mOdUjF1LdxScTVW48/KSvGjtS+DWKG3mbEBmo2D/UtyEk9vPZljmSG3k9V
         O+M8Wu+ft9bbq7pFR7/jwAgGuGhRZUNp6lD/RA3ySlswr0tsIeE1TRUGGh2ba929Ox24
         64TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB59oupajap5Uz7WL3m202PXnc/SLdB3mBly/tpNcayfTvzZsnolov3nOQPlI97Sc8bTAz0amER7QaRHfbZJPi7sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyhqLAWYEqN4woaFDxzPFwXGIxxL28ifArHnOIdVlmZWiqknn2
	hOkUT1ExkBeOos3wv+/iR930AYI+KyfiCLijiBECzoCdKJly1C9RX8bFQWi24YV7RJg=
X-Gm-Gg: ATEYQzz7Gz/ZcRF5clMNf0eSGBn9hDw0EOnqYBdPY12MmJKVX6CT+cE+7uiPtf2/d1W
	R1c8Po16LNnVz3Sy+sSu6LJk82dMerWpD3dYlqDeMsAHk/FroYFtK3xFgxF4osNcdTMGAWZJpLg
	F0bhp64b7v6bB57xApNUrOd4aQoNn+AyeyzJ2DbpRAjWfX8qW80Npu1oI4ZqBPzqrhCBlebphoX
	jrGQOKOtefAdNNLi/bPAv/XYAH9TcMgQgNG9tbrSQh3yeOyDuma/O82Lwm29dKCmLgOLdRNC7Kz
	DvNNGMP9KSUAZzVRcoZduuc7FczIMWSatB8hL7KM9ZRB3YIE6RqHekuRNOKTehFx4F86rMHWP8w
	eySlEhs+jfnBpeslsJ/uXQ6vgR7C4e8/XRjWYd0PEcWogG1BAEmK7oSqV45BOaNEAS3Efgn3EfA
	+QPgub/QaewV1Pkv3wGHrvzs2gKht7+2v9haI=
X-Received: by 2002:a05:690e:44a5:b0:649:cff9:de4 with SMTP id 956f58d0204a3-64cc3050faamr2315443d50.41.1772226910602;
        Fri, 27 Feb 2026 13:15:10 -0800 (PST)
Received: from ubuntu ([76.38.17.53])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7627432sm2763297d50.12.2026.02.27.13.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:15:10 -0800 (PST)
From: AnishMulay <anishm7030@gmail.com>
To: rostedt@goodmis.org,
	viro@zeniv.linux.org.uk
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnishMulay <anishm7030@gmail.com>
Subject: [PATCH v2] tracefs: Use dentry name snapshots instead of heap allocation
Date: Fri, 27 Feb 2026 16:15:05 -0500
Message-ID: <20260227211505.226643-1-anishm7030@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227154210.5bd19a45@gandalf.local.home>
References: <20260227154210.5bd19a45@gandalf.local.home>
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
 fs/tracefs/inode.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 86ba8dc25aaef..ad322e8f9e2ad 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -94,23 +94,14 @@ static struct tracefs_dir_ops {
 	int (*rmdir)(const char *name);
 } tracefs_ops __ro_after_init;
 
-static char *get_dname(struct dentry *dentry)
-{
-	return kmemdup_nul(dentry->d_name.name, dentry->d_name.len, GFP_KERNEL);
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
@@ -125,24 +116,20 @@ static struct dentry *tracefs_syscall_mkdir(struct mnt_idmap *idmap,
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
@@ -150,15 +137,15 @@ static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
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

