Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61230C357;
	Fri, 21 Nov 2025 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763548; cv=none; b=Kl0zFZNilRh0JrDDvRhhv4tUT4p0mMo18lMLsn7BBDevkTeMFfkmZU3ucImonz3IjBOy8zdVesMqb6E7BoBmsIi+GbMukIgzpR3JmzBjvjpZLPkX813Y6uA+hwlCrNZjPg3MyKgb876NpgqPnlVJLEL0kd+n1wJ/qewRWy+RGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763548; c=relaxed/simple;
	bh=PwGhjD+jAErSMotYXM4CXF+ImjbsyFVWLH84I6xPZbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jj+tGgIPNMr9FzrWvgBo3ZwkFJ0XB46EkmWuMkThhjwyOGYrlgMO+bHxKmK1D4dJ/RkyIImeMQbRN2PYLVvGmPsFa7+zJKFx7dZlgm5q4/zJ2CjiVV3iF0CSC5N1tvlzNl8JeOXrWEuCq/hpp4ArDrO0wnlA0Y9syHQI0mdWGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LWGQbmCE; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LWGQbmCE; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LWGQbmCE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LWGQbmCE"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dCqPg4KMwz9tws;
	Fri, 21 Nov 2025 23:19:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrO+ixwAjzSJj0cD1LibWkTSwLbGzI8j+tZPJSV5pcs=;
	b=LWGQbmCEUC36NAODl+UEImuyKZeGEdAaIRHp7HBQxndYeuZ7nsHpK3je2T9ESr8DVRLS92
	sxP+NxI5+rSdSmi14kApys8Y1pxrhbZyDLcm7N9ECeHn2/3JpzV8DeV2O5BNBgj5FAF0qS
	RvwjvwneiffNmpmRywajFh6Wx5MZkHHYt8Evy1tT9v/WJcrEvlqdgD+1cG9TPK7abN0EeV
	zJZqlvu+tghPKpIY22PS94ZIaLHWJrstyxSw7mIL+QEAEfvkLdw8BtjnQqT1kmyI7cOl3a
	/vIVkZfGm3PdR4gKiL10iJBfxStPTB/iSWHWP4r78wtZQDZte4mI1gVbapG0zw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LWGQbmCE;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrO+ixwAjzSJj0cD1LibWkTSwLbGzI8j+tZPJSV5pcs=;
	b=LWGQbmCEUC36NAODl+UEImuyKZeGEdAaIRHp7HBQxndYeuZ7nsHpK3je2T9ESr8DVRLS92
	sxP+NxI5+rSdSmi14kApys8Y1pxrhbZyDLcm7N9ECeHn2/3JpzV8DeV2O5BNBgj5FAF0qS
	RvwjvwneiffNmpmRywajFh6Wx5MZkHHYt8Evy1tT9v/WJcrEvlqdgD+1cG9TPK7abN0EeV
	zJZqlvu+tghPKpIY22PS94ZIaLHWJrstyxSw7mIL+QEAEfvkLdw8BtjnQqT1kmyI7cOl3a
	/vIVkZfGm3PdR4gKiL10iJBfxStPTB/iSWHWP4r78wtZQDZte4mI1gVbapG0zw==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 03/13] tracing: Fix multiple typos in ring_buffer.c
Date: Fri, 21 Nov 2025 23:18:25 +0100
Message-ID: <20251121221835.28032-5-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dc9e780f46ed757ff7a
X-MBO-RS-META: yx684nikdjscenq4ahqnqq5xi7guaiby
X-Rspamd-Queue-Id: 4dCqPg4KMwz9tws

Fix multiple typos in comments:
"ording" -> "ordering"
"scatch" -> "scratch"
"wont" -> "won't"

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/ring_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index afcd3747264d..9139a020ece4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1735,7 +1735,7 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
 	bmeta->total_size = total_size;
 	bmeta->buffers_offset = (void *)ptr - (void *)bmeta;
 
-	/* Zero out the scatch pad */
+	/* Zero out the scratch pad */
 	memset((void *)bmeta + sizeof(*bmeta), 0, bmeta->buffers_offset - sizeof(*bmeta));
 
 	return false;
@@ -6073,7 +6073,7 @@ static void rb_clear_buffer_page(struct buffer_page *page)
  * id field, and updated via this function.
  *
  * But for a fixed memory mapped buffer, the id is already assigned for
- * fixed memory ording in the memory layout and can not be used. Instead
+ * fixed memory ordering in the memory layout and can not be used. Instead
  * the index of where the page lies in the memory layout is used.
  *
  * For the normal pages, set the buffer page id with the passed in @id
@@ -7660,7 +7660,7 @@ static __init int test_ringbuffer(void)
 	/*
 	 * Show buffer is enabled before setting rb_test_started.
 	 * Yes there's a small race window where events could be
-	 * dropped and the thread wont catch it. But when a ring
+	 * dropped and the thread won't catch it. But when a ring
 	 * buffer gets enabled, there will always be some kind of
 	 * delay before other CPUs see it. Thus, we don't care about
 	 * those dropped events. We care about events dropped after
-- 
2.50.1

