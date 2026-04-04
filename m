Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D972571DD
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Apr 2026 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775310474; cv=none; b=WPAMsNwcEVYxDM2sXPDyZpszrKq+rDn+FqLOo7jLF14ijgBmmNIIvPWSSfhWHKwCsghm9cefLZ0fH20QiZjYn9ft6xZC6vyhQ8kvtY21KTbcot1FjWvaADx9gymZmM8TKlHoWFiGb1lT1V1i9K7LG7xHS9Qfd7YMI9GNRiStxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775310474; c=relaxed/simple;
	bh=uq0ekskcm1LLoYGE+0NzPOrNZYjEyHzQo7kQCHFrxeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3kjdBChHvYm/JldwmVo1/P/aJRPgd3pAKXVMNpMyp2DWOvN+DRv/NKQXdBxhaiDrbe71dThSgkzszDWLD2VRPxyzINO8Df/geYFwSAw13LhTPcL2MIaIcK6fVki7ao+b9/ksvrCxQy5/jTztYNeYocrMgb7xFsKDioLrX1yayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/V+D/OU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/V+D/OU"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso22451665e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 04 Apr 2026 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775310471; x=1775915271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKsbChh/VnKTH+OmKvRes4T+gJ5uz/EkfVx8lzU6MpQ=;
        b=M/V+D/OU//6VDzZOaakxu4VylIsXYP1VEDtKxXxOl6x6XcLfPYuSKJQK1e/RWN7GTM
         bCWnDOVIJ3ohI+CUuwxxmDZnXUl/zLqHDEaSP4ptV0wbRXYww2v1qFLj8+D5R+vSYTcn
         6ifWgaNIig55fmCCHDFw/ohpJlmLSTRkkGpjDf2Ys8prl2AE6NRWA1FLT7dvbrR7mr0L
         z5TFj+lXbUi/Oo7UdPkdovwAnyEmv9WKagjZCH/Eae23JZQwrI+/0Hm+R5it9HvafP67
         LE5d5VXsM+u6YhpwmuKBXmsAL8txQg8z4ToqD71iidf2nWf+gInZJO70OK5ta9dBKmRm
         zKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775310471; x=1775915271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKsbChh/VnKTH+OmKvRes4T+gJ5uz/EkfVx8lzU6MpQ=;
        b=d6F26bkGv0XKq8qahd1XUxAguJI7JgJRKwfzZ2aBcBc4YGgwEf1hDCl5++cHVr0Z5L
         pnekdUZRdH1diW6x2OAhRlRhxK5vzhVC5AQWPassCD8mMAAa8g4Ruw6XDUA9ESXFKLJZ
         AQcCLwJ5g9OeMla00dh93Tx6DFWNRHrObZXi7QG1fcExvY3FoeU67PeFZVORWAKxXUB+
         nnwnZotjg9OenrBlZgvhsBGXSZMI7CbxsVu8rnMkpOlxsAxv2kKwjYErSqE+PxngqS7M
         T64i7pFS3PFO9l0ZIl4lfGzFf2rn+GG86BJismWJyR3EpTW9bk003bMzP1vR80SvL2dI
         s8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWzIxMoNQ0q3r9R+w7oAYUez9Y6cXeO3Tz2H5/nrGkzEGO0pmcjfVOyK9UaVw4c/Kxi1yHBc9Ti5fWn354li1O45aE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws42beZgaJrnulNLCKVIZNqXpv3B+r9bWjjaltWbhYfYRGIazv
	yErvYUKlQHDIrdkMalikm3CehL5f9Z5RJrugd/gD+9gcJgtg7iSSXlgu
X-Gm-Gg: AeBDievPyk1EQHkGtHOBkdvZEWS4K3SPRNMYoRvG2UWl6oWKV58x85V3ejokyW3xh/7
	xpas9FIp4bu9bo7RrVjjxGvSOUlZb7eEks3eat8zfus1HdHscTk1bN6Le3C/EbUzu3zHRGml0pW
	z5ZU75YRwIPS1aAY1QwoAPqZ6KqUT4u1bzOR8QIW2pCa9ZlWDJRamuldA53KMpKExIa5A0r16Mb
	Zz+KFxJuBKTYh/A6YJPvWuukqGmKwk7iOnx9Pa/WQtNw6L62oclYG9EKPogEkCL00AzamUM79tU
	FL7L5kKgzYViJbkUCBhT+sfBdZY8o/QRcQD4A4DEG3vzCJnxsHqaZjqwTIh5yPv/FyPdDAOFrRi
	NkTmePuY4ktvGOS/+UWQlVLZs1gZtrGx37grf1d9luCiamoOvakZP7FUU7QgoTak7Bl7wwrtCdW
	U+aiQvzk4r9G8hVqEO1lQU6hS3rBH14/04XoZKjyQxaIoLRC4ZDS8DsarZLBkwDVIl139bP3FVl
	Qu+MwXhfdQT
X-Received: by 2002:a05:600c:4e0b:b0:488:869c:eda6 with SMTP id 5b1f17b1804b1-488997d6b8dmr109572865e9.29.1775310470482;
        Sat, 04 Apr 2026 06:47:50 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a8d6e27csm24056165e9.6.2026.04.04.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 06:47:50 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	kaleshsingh@google.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] tracefs: fix default permissions not being applied on initial mount
Date: Sat,  4 Apr 2026 14:47:47 +0100
Message-ID: <20260404134747.98867-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e4d32142d1de ("tracing: Fix tracefs mount options") moved the
option application from tracefs_fill_super() to tracefs_reconfigure()
called from tracefs_get_tree(). This fixed mount options being ignored
on user-space mounts when the superblock already exists, but introduced
a regression for the initial kernel-internal mount.

On the first mount (via simple_pin_fs during init), sget_fc() transfers
fc->s_fs_info to sb->s_fs_info and sets fc->s_fs_info to NULL. When
tracefs_get_tree() then calls tracefs_reconfigure(), it sees a NULL
fc->s_fs_info and returns early without applying any options. The root
inode keeps mode 0755 from simple_fill_super() instead of the intended
TRACEFS_DEFAULT_MODE (0700).

Furthermore, even on subsequent user-space mounts without an explicit
mode= option, tracefs_apply_options(sb, true) gates the mode behind
fsi->opts & BIT(Opt_mode), which is unset for the defaults. So the
mode is never corrected unless the user explicitly passes mode=0700.

Restore the tracefs_apply_options(sb, false) call in tracefs_fill_super()
to apply default permissions on initial superblock creation, matching
what debugfs does in debugfs_fill_super().

Fixes: e4d32142d1de ("tracing: Fix tracefs mount options")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 fs/tracefs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index edfdf139cb02..36058ba5ee48 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -491,6 +491,7 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return err;
 
 	sb->s_op = &tracefs_super_operations;
+	tracefs_apply_options(sb, false);
 	set_default_d_op(sb, &tracefs_dentry_operations);
 
 	return 0;
-- 
2.53.0

