Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59C15E90;
	Wed,  5 Jun 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610646; cv=none; b=Vb1hzeHlb1tCk+S/c9CgAK/apZbsTAt/UFvNzhEOrxXxrsaA32CdaIuWuo4M2H6EuNFCdqxyndfJJiJpi4IBeDbtA5iDEUbtKnK8Taw17yskGgyqqdsIDaHT1aBObxFLTUO+KKkKkbWfVkG2vYBL7zaqGUWwzj9X7fXwPxERpl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610646; c=relaxed/simple;
	bh=8b6Nwx0UjbrwVWPwGaSh+tM70eZBD8B/BLULcHoCfEY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UJnVCK7q10snQKehmU9gFKLQQcTy9srFezlgOX5Wrd+I/lIt8oOO3MReDpnI+1DqZ+uYuKhWDU5zZurQYP3k8C3aebxS9MNVa/XVc3vGIpr1K8GLYXvVEXEl27FOTlgYiDEdQmKcQqtpHfIlAGFRnVlGM5y0QaF8YlcMsH1QbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC70C3277B;
	Wed,  5 Jun 2024 18:04:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEuzZ-00000000hYU-0fGU;
	Wed, 05 Jun 2024 14:04:09 -0400
Message-ID: <20240605180409.021080462@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 14:03:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/5] ftrace: Convert "inc" parameter to bool in
 ftrace_hash_rec_update_modify()
References: <20240605180334.090848865@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The parameter "inc" in the function ftrace_hash_rec_update_modify() is
boolean. Change it to be such.

Also add documentation to what the function does.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1a2444199740..83f23f8fc26d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1882,7 +1882,24 @@ static bool ftrace_hash_rec_enable(struct ftrace_ops *ops)
 	return __ftrace_hash_rec_update(ops, true);
 }
 
-static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, int inc)
+/*
+ * This function will update what functions @ops traces when its filter
+ * changes.
+ *
+ * The @inc states if the @ops callbacks are going to be added or removed.
+ * When one of the @ops hashes are updated to a "new_hash" the dyn_ftrace
+ * records are update via:
+ *
+ * ftrace_hash_rec_disable_modify(ops);
+ * ops->hash = new_hash
+ * ftrace_hash_rec_enable_modify(ops);
+ *
+ * Where the @ops is removed from all the records it is tracing using
+ * its old hash. The @ops hash is updated to the new hash, and then
+ * the @ops is added back to the records so that it is tracing all
+ * the new functions.
+ */
+static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, bool inc)
 {
 	struct ftrace_ops *op;
 
@@ -1906,12 +1923,12 @@ static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, int inc)
 
 static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops)
 {
-	ftrace_hash_rec_update_modify(ops, 0);
+	ftrace_hash_rec_update_modify(ops, false);
 }
 
 static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops)
 {
-	ftrace_hash_rec_update_modify(ops, 1);
+	ftrace_hash_rec_update_modify(ops, true);
 }
 
 /*
-- 
2.43.0


