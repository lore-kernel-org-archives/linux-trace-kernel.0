Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC33285C84;
	Sun,  1 Mar 2026 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328508; cv=none; b=p9mNHd77T8cYlXfANnjxD5RFvasSbcZcf+HghnQ9TF+sATm/nRBVLO2lbUwcFGTVsdabZ09UhgaDVLlyJo8CMOssY3xwM1nqZYsmW+aX92djbtRlnQql1BTwF8jXGo37VN640ZUc2C0tPYGOVoTYYbOnWdJHf8GJCXclwd8C3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328508; c=relaxed/simple;
	bh=6BTI1UVeG4tQYlx39XQkCdSzxjetyFCbjbmNcM2R6Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ah6CdAyfvP5MiDgaAI4RanJ0mepZ4YluwRJ05k0XAEWsorgbfCRXNdl2Wlmh+iKseS2U37ESpBNXiZU7+orscuE85heo7gqnPVXWCPLxgf+L4/Z6grPenjmzoAi+xMZiltf/R4Dq+9ey+jA1daT+o2fkM6qaE15WOGIvzRB+VHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHHXZi4+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHHXZi4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A6DC19421;
	Sun,  1 Mar 2026 01:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328508;
	bh=6BTI1UVeG4tQYlx39XQkCdSzxjetyFCbjbmNcM2R6Yw=;
	h=From:To:Cc:Subject:Date:From;
	b=YHHXZi4+7jM42pSi5k6kVn8YsDK1iPG+EHENWiN+JsSNcDrhXGgWpdVmqjHtcwcgQ
	 zFH3b04UyIx1PBpODgnH0tBr1okX92nB3t7f7pyJyCkUjWB/i27kUxvGVGmhzKvlB3
	 eQ8+ocKOIGuI3CNqw9BsVRizcSsxnJWIj4mcGZ66BOU3ofhqMhvMW4JWWyKaDtOV13
	 xdUS9qDPT+O7VkjBVuNeNPzXSztdtPnCbMf/365qjT6jk1HTyQHwVKmFGSOHvXq8qx
	 QxTxCWRIkdL7jKP8fA78EHPShTweDLXg61HZoailB8fuRXqyAKMwv+qJRHoKIafdiT
	 IVLz7cFjoFATw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hu.shengming@zte.com.cn
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "function_graph: Restore direct mode when callbacks drop to one" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:26 -0500
Message-ID: <20260301012827.1686191-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 53b2fae90ff01fede6520ca744ed5e8e366497ba Mon Sep 17 00:00:00 2001
From: Shengming Hu <hu.shengming@zte.com.cn>
Date: Fri, 13 Feb 2026 14:29:32 +0800
Subject: [PATCH] function_graph: Restore direct mode when callbacks drop to
 one

When registering a second fgraph callback, direct path is disabled and
array loop is used instead.  When ftrace_graph_active falls back to one,
we try to re-enable direct mode via ftrace_graph_enable_direct(true, ...).
But ftrace_graph_enable_direct() incorrectly disables the static key
rather than enabling it.  This leaves fgraph_do_direct permanently off
after first multi-callback transition, so direct fast mode is never
restored.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260213142932519cuWSpEXeS4-UnCvNXnK2P@zte.com.cn
Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index cc48d16be43e0..4df766c690f92 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1303,7 +1303,7 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
 	static_call_update(fgraph_func, func);
 	static_call_update(fgraph_retfunc, retfunc);
 	if (enable_branch)
-		static_branch_disable(&fgraph_do_direct);
+		static_branch_enable(&fgraph_do_direct);
 }
 
 static void ftrace_graph_disable_direct(bool disable_branch)
-- 
2.51.0




