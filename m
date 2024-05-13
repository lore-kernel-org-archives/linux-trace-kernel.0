Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDB146006
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 May 2024 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715578453; cv=none; b=IUaTEfN/TTJ8G8Q1IBfXjGUaUiCI6jiywxgfdM57QlMK/PaSv9L28puc9Lv3iACJcSojZLp2FZYIz4D1ySnVBTWX5nnx/TUXVHCyR1iQjL0yXGCKFJEiOo6EZFChQ/EGrOcM5dossEXujaQ8oflcOHoLJZanLUAdo1bo4wEgEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715578453; c=relaxed/simple;
	bh=3novfxKmuOHtv2/2Uxne6GNAqtrqJ5MvuaL4zalChp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HzR9HpQQV1PNVzuZgf0Fy3K6hkat9yTUFZIoDfDNTO1wj4/bU9iR8IEa9RK1FbqBY5IejfslXq9FZjf89ooGYVqVAmla/buXgHf4PCI1U3cCOdHVJsNc5rqxiHF2X1ZK7aMtaeM6jN8JPQ9wJIIh3tKB3CyxMb5xBbFPGFeevaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bPNF6x/3; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bPNF6x/3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715578448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtkBKlqRVPiYt0KU2gHHEP+MV+jp5EvYQ4ZKCZH6xvs=;
	b=bPNF6x/3D3j3GV79OW8FEMCFENYlL3367JFVNkpvFwAj+4hJh6PsD8ntCa1+sBBnBnlI2V
	EkHkfGP0Osy0bczztTYbcbNGT0iT9/eGfPZwa4BG/I/oYuBP4CQovPJNR1g38DxH7qORLJ
	+TfxTSq2+/maLlJOVvUJwVtuqTzcUj4=
From: hao.ge@linux.dev
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] eventfs: Fix a possible null pointer dereference in eventfs_find_events
Date: Mon, 13 May 2024 13:33:38 +0800
Message-Id: <20240513053338.63017-1-hao.ge@linux.dev>
In-Reply-To: <b574c8d6-c000-8673-74de-a7cc092057ad@linux.dev>
References: <b574c8d6-c000-8673-74de-a7cc092057ad@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

In function eventfs_find_events,there is a potential null pointer
that may be caused by calling update_events_attr which will perform
some operations on the members of the ei struct when ei is NULL.

Hence,When ei->is_freed is set,return NULL directly.

Fixes: 8186fff7ab64 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Hao Ge <gehao@kylinos.cn>

---
v2:
- adjust title and commit message
- omit curly brackets
---
 fs/tracefs/event_inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a878cea70f4c..0256afdd4acf 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -345,10 +345,9 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		 * If the ei is being freed, the ownership of the children
 		 * doesn't matter.
 		 */
-		if (ei->is_freed) {
-			ei = NULL;
-			break;
-		}
+		if (ei->is_freed)
+			return NULL;
+
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
 
-- 
2.25.1

