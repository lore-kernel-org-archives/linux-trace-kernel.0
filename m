Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBAB3AE18D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983257; cv=none; b=iIp0f0Sp3Zr32ZS9TXCUXFl63WbPO4X1skWh+jz+3sGMw/UgQj/lEsaJCAuf5BC9Il2G6i7L8jCBbfHn7iEGqTSQCjBoNnN/9CTZ9jW7yHQM2Z7PvFI8fDf3ogn3BevZI+x25sS4JH+DjhE1vYnhxCEkE6h0nFXmz/F1ucinm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983257; c=relaxed/simple;
	bh=mWYaaJ95WFSIgwaj7DsE8799Djlnld1MLckIrfE585I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqN2Wk3xbklaF55X6XfJYPsPCN9k5GvROLkwPvlnT8gZDMLR7488BaGDW51ecmIgBrbzcJVxs5aNzM8sKtkexn3c8ku20/5mGwpSkh4fJE5BxofD9rxjmsK/y3ZHRsrvFIep2XtgV2qrL41ELb+CtRiWP/k+iL7ewGvUg7hwPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPb/+Ylt; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPb/+Ylt"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92f03daaa97so99722285a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Aug 2026 19:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785983254; x=1786588054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hysdgtb7wp/8HlGZYxSnsEh9b9oJvSSZRpXBcjKX6ew=;
        b=sPb/+YltBgId2YtErMZpO1BjQeXqOy9tSMLfM1UoXrhKR+TfRxxz1ZFg2kF/rEdYcW
         vNQQT50sSsdwIGbf6UEQW/oAnOy0LB1IrpzKbIF5U1NlfFdcLAmwBfd6xwGEUpHYESfV
         CYFFzpBmixri9Hb4gky2l7xp4AK6KmAjInF9IyRm4lpc4bZmGotrbX/dSvbf5S8hbqZV
         BGywAfGbdp1boikENpvsR5Wk2m2sb9rrQ6hgsl2MQF0/LtMFatvvFRdGVoaKLZhFplEr
         TBxLyu5oAXCsmyPR9eCAGg4FzHI9LpDsNFSwx7IpgR0wI12VtUvhOGjm0hWV65UehK/M
         Goug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785983254; x=1786588054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hysdgtb7wp/8HlGZYxSnsEh9b9oJvSSZRpXBcjKX6ew=;
        b=O4rZYC+LzTKB4DwicmEKGE10hoGLpiOulHuV6ZzQ20psZV2jFJVxYga0+jXjye8z8x
         cm6ungf5qq85O7DajqOmdAF8ozNbCGJD8LnmAtq5+IcPH4fI7GVOzPlQPdGgby5dnjBk
         2tv31kWy0/U4ci/DlFbDEYOEa6ky969Jix9Q59CFpVKUSKqJc297H0PUkDaoZvjSrK36
         kvWw0f2iwJJeNiGW3KKYnxqr0bkXly/tcAm8SbEJdlS0+BjXe5XmYoy08kxQZXVJY/5s
         AHophhfNmxcmQ//tshcvEMS5O7QUZNwXx16l6KmY0ZF5re/hQNlkUPSqDM/our6H6e4R
         0uWA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6TnKUq1VdF+k4/HMZVklbb17znv85RmPKL75AGaVpD7ylLTmUy6UCbPYrAWc4NaaUnk+Bg6lE21pzpbUYGI52Cy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmwlYaYaWxoczdJC+E2N2t5/zTUmZWiplPOnloyX0YFAFqmf/0
	rHVpd4TrZztmLZVkSPGLiWGHCLDc10Ls+QWLdkpjB5gUMEiGQyRYfXCB
X-Gm-Gg: AR+sD13KpmnwsXpEQeuX3wRxoteN2sRCxuUj5xezJkqHJHg8oJPvdmXD/ZM+aXtC+x5
	w4qwBQxOkPhr2Nxi7IZIM2hRp0jeMMQZaRSt9+w56H8MORYdp1aQDj1898FdQ3oHK7I9/jtbFrT
	CxxbF7Zz6VsAHwdwhYX3IIxEZ6E21rmNYxSrHlY8CJIqT4FURmJBc5z6ygg7MlOHTcZX0IRJD51
	uR4uNnBkHMfSlevLNR7oMEPS60Q3Rs5sSSC1GB/IN51GDBDS6w/E9EHlUBu1oi5GLOoKlYXGYwk
	KPG8hD/IRSGeL6dnqxONUqTc5Us6GOHx9TjOoagmX/VItBnTV/3T+8FO7f+ZAvAOZTauH1Jvh23
	cRTlE3a0PeihLTZHjmOXaUoqGuCGZBUMAJK5qJoP87hOz0meSZVD/S3Df/9iKocqhX5t5E9rU8i
	JaUqkYH8Z0tHYoEKg3eLtfy7AMTU6pVQ9x79eTSwcHOtUGg9C/eGgjH709MuIjSFW//R6Z4naJj
	chD/5VuC5evI4i7rQ==
X-Received: by 2002:a05:620a:28cd:b0:925:56bc:b8bb with SMTP id af79cd13be357-93648fafb5bmr1088990485a.9.1785983254432;
        Wed, 05 Aug 2026 19:27:34 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93657630fddsm157474385a.8.2026.08.05.19.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 19:27:33 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] eventfs: Fix use-after-free in eventfs_remove_rec()
Date: Wed,  5 Aug 2026 22:27:19 -0400
Message-ID: <20260806022719.375354-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eventfs_remove_rec() recursively removes the child at the current loop
position. After the recursive call returns, list_for_each_entry() advances
by reading list.next from the removed child.

If free_ei() drops the final reference, release_ei() reuses the list/rcu
union to queue an SRCU callback. The child may be freed before that read.
The eventfs_mutex serializes list updates, but it does not keep the removed
child alive or prevent the SRCU callback from running.

Use list_for_each_entry_safe() to save the next sibling before recursively
removing the current child.

Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 fs/tracefs/event_inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 39c7a34531e8..93bc4f83b73e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -822,7 +822,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
  */
 static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 {
-	struct eventfs_inode *ei_child;
+	struct eventfs_inode *ei_child, *tmp;
 
 	/*
 	 * Check recursion depth. It should never be greater than 3:
@@ -835,7 +835,7 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 		return;
 
 	/* search for nested folders or files */
-	list_for_each_entry(ei_child, &ei->children, list)
+	list_for_each_entry_safe(ei_child, tmp, &ei->children, list)
 		eventfs_remove_rec(ei_child, level + 1);
 
 	list_del_rcu(&ei->list);
-- 
2.43.0

