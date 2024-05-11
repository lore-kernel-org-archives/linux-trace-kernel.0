Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98CA125C0
	for <linux-trace-kernel@vger.kernel.org>; Sat, 11 May 2024 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715395389; cv=none; b=orL3RqsKKorJuNhUOl6fNNm9XBmSL/xfDV7FwqkEDFDM6ZH3v3FKfLmdfgONPu8c8k7skggY356N2REs9bLE9048rSfdSJJlWDXNQVrw1MM8sj8HRd1u9ctXX+J6FxCnUjJaat5d2dE5B87M1JMOfdZ5VoraPTLrpjBgRTdWk3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715395389; c=relaxed/simple;
	bh=aVM2BRnQlnNGD4WDElILAHnMRMMEy3roS1X2ykcKQRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JztEi6Fo/v0VquonPZTTEEUCOLpS+9XzEbK4bKMbttIyceMtkzFawtaT+cBGiaymtJoOy3SG4WEGplTpDli4CcxdgcKpmcxiyz/Je4Qhlgk+a2+ayALcT6Ukk9fKnIyL1X/kwDVQt+wVSndvimZCZ5QMmljCtzfJGbCCp1Jjo9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t+IT6lO6; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t+IT6lO6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715395383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wIEjlQgisqNyAdK0Zq/MUd7B7cc7IeoVa5W0hNSvWvg=;
	b=t+IT6lO6wKsDsb8glv3smdyEDEI0zfyuXqpVzjWVoknRcVTE93tlYbj+D13hSGOdN31Eb0
	Z4Db2r3e42SedjaVV1ubdq8yxCrzloM+3/gzwQalRMyv+gK8KvecYP6D9dyMxJG9RE9Um1
	MsQaWrMJIj2fCZ/Jom9/SD1wtHsDE24=
From: hao.ge@linux.dev
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] eventfs: Directly return NULL to avoid null point dereferenced
Date: Sat, 11 May 2024 10:42:55 +0800
Message-Id: <20240511024255.34767-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

When the condition ei->is_free holds,we return NULL directly to
avoid update_events_attr to use NULL point about ei.

Fixes: 8186fff7ab64 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 fs/tracefs/event_inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a878cea70f4c..da2827c6acc2 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -346,8 +346,7 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		 * doesn't matter.
 		 */
 		if (ei->is_freed) {
-			ei = NULL;
-			break;
+			return NULL;
 		}
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
-- 
2.25.1

