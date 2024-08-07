Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85F1E4EE5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031525; cv=none; b=SKWr2ayvJ/AtUakP2kVgyIB3LIXJ4we7GFFIotGWelYcutET6s/V5+hARC/vKG9dk4n8VpBVio/yIUuGdBf1fLILaa214HiUkeHbOXwVTTGeKUicM6cQ9Tn19NqCTIyiHDepYDBKnU2QgdkeO4otnPDbOmOPwSnvsJKblOQeYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031525; c=relaxed/simple;
	bh=IGFlB68INDcQ8sKrUZofoAD3z1NjB/zmJ8yA1Y+vowM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISxVJoGsZUP2arce/Mq5J4natTb9ybSy9JJGhupnn/CsovYDd2P3hlLg8aHpGEGWu6T+kXEjmoG4qw1nANfLozNBBmXo2V741L9liu1t8fdYMqjibkC2n0nEtSoth/XOGYsNuKO0+I6eE/kLv1cyBUGtlJbPFQhYTehSvQwZpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=KdDrrX+x; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="KdDrrX+x"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso2475950a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1723031521; x=1723636321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5733r8MkNcdcarsQAxONBjSXJjRkkEqIUJQucklfAjI=;
        b=KdDrrX+xmcL6RjpsZ7RjGbzZ+tnn7hLcopf69N9xOamTq+19Qc/nXi0E45R5pouaLz
         QEZsxf8m3i7Pu3T76M9hCozJzS0TndzS9Lpc4QcEB3qSrN12rTfRMXS4VkHZYr63GDDa
         I5Ua+OWi0dXbYzl9FRpbVF0ieBWAE8AQqOdy1CLFAVO4NmE4ENUzFEHFB0SZFtgTTtfI
         I0ai7bGpDHOib4004IJNZZqf6t5GQreBD1BKOs6Xe7SilTs8gVExYMHPYmXhS8dlh0Qm
         CF2lxgF7uLIbxxwMYeJiKAFjT4vEs/KcbwF7SNXxjUUG/fIbP80EldKM8rEDMY7Z7CjU
         ATqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031521; x=1723636321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5733r8MkNcdcarsQAxONBjSXJjRkkEqIUJQucklfAjI=;
        b=HwbaDkwYp7NLyvbHTFo+8ngFenlHgRZSk/TeU3xRL2cUf/fIuDf1rmJit5ucALOvPm
         dQtWT5o3XPz0m0+VbziGFnbZApbLpqKrE5yT6bj5mBCb8xP5E8bC8sTt/oCuNdNyC1bb
         Odz88L3TH078UFEYjP1vGSgO0kxpPCefZutafl6TAt20o0v5/Pr1mSwF2FIaLg/GUPRE
         HqCzr6FVu7o1WnhKFttQH8E6KjYMUT/AuhkuNdlV8b6dQDLVixaNz11L/w4w6zpGqte4
         L3k9FP8O+3oWXN1xiweLwGljV4jDES9727BMEQccpyuEZFe23E84jyFIhBJ/7RgL1nwP
         dmqg==
X-Forwarded-Encrypted: i=1; AJvYcCVX1QkPIzfh1NTdnzbluqpmp8kjWSP0KKZSODq+iS1EUDnPuR9RfUhOOxoxDUkn098gwOVJXDTGtrNQyPL3qiXr+3+KRS3LK8qbZ//phjK5h19I
X-Gm-Message-State: AOJu0YwqzyNcaVUs6nkwDpEuiZEYtQdY4STZUtSy6yJfoKPYGolD2cZe
	XVmmlGSkRi/SDMI5d86Unh+lLskreJ2X5IZQmeBtuBlYVl8I7UIvorNhWBWMywbmlM2WrtysCPU
	n
X-Google-Smtp-Source: AGHT+IG072hvtVXEAG8bATDH9oftvsuC6XgrrvmWhDdJcJRKEph+45ZjwZZwPMYSkUif6Ip38iEkZA==
X-Received: by 2002:aa7:ccd3:0:b0:5ba:cb82:a776 with SMTP id 4fb4d7f45d1cf-5bacb91e9eemr7858125a12.9.1723031521608;
        Wed, 07 Aug 2024 04:52:01 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6af119b00710ea47398d5cfcf.dip0.t-ipconnect.de. [2003:f6:af11:9b00:710e:a473:98d5:cfcf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba3acc257asm5207141a12.51.2024.08.07.04.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:52:01 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathias Krause <minipli@grsecurity.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/2] tracefs: Fix inode allocation
Date: Wed,  7 Aug 2024 13:51:38 +0200
Message-ID: <20240807115143.45927-2-minipli@grsecurity.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807115143.45927-1-minipli@grsecurity.net>
References: <20240807115143.45927-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leading comment above alloc_inode_sb() is pretty explicit about it:

  /*
   * This must be used for allocating filesystems specific inodes to set
   * up the inode reclaim context correctly.
   */

Switch tracefs over to alloc_inode_sb() to make sure inodes are properly
linked.

Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: ba37ff75e04b ("eventfs: Implement tracefs_inode_cache")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7c29f4afc23d..a9279810158c 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -42,7 +42,7 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	struct tracefs_inode *ti;
 	unsigned long flags;
 
-	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
+	ti = alloc_inode_sb(sb, tracefs_inode_cachep, GFP_KERNEL);
 	if (!ti)
 		return NULL;
 
-- 
2.43.0

