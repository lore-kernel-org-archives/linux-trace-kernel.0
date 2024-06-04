Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07A14C59C;
	Tue,  4 Jun 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536534; cv=none; b=mMerd3EdSvw/nhsKJLyjrwWWsMk3uSjkZNOqS5K76fMfl1eL880bFFywc9Sh49MHKO7KwecKzQNFzePzxMV6AVNH9c0Al3iup/Jw+9kIu8TI85zW2GZ8ibTre2q6T1Gr/+VyDbc/LeLB8aydhVMLucbyaqii3CvieRPrfx2bB80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536534; c=relaxed/simple;
	bh=VP452e+SSltPUNQ60WPUoVTjGYlGi4NsAMEX2G4U0oQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sdcSazpmHIG29QKu81dJekjtoMmh2C5ED4q9/E6HRzB/nmXTujVAlIxfy9eR6GrlBOUny22WOmA3qW2p0OW2kqUDTFW05GYICmJLDLrizR07pbVJOakz0Yy1dbSbuecBGoqscZd7NLodmX0C6CFTH0/jKrWubK5GrXw0Ot21vh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B391C4AF0E;
	Tue,  4 Jun 2024 21:28:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEbiB-00000000bEo-0nHJ;
	Tue, 04 Jun 2024 17:28:55 -0400
Message-ID: <20240604212855.046127611@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 17:28:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/5] ftrace: Convert "filter_hash" and "inc" to bool in
 ftrace_hash_rec_update_modify()
References: <20240604212817.384103202@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The parameters "filter_hash" and "inc" in the function
ftrace_hash_rec_update_modify() are boolean. Change them to be such.

Also add documentation to what the function does.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index de652201c86c..021024164938 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1915,8 +1915,31 @@ static bool ftrace_hash_rec_enable(struct ftrace_ops *ops)
 	return __ftrace_hash_rec_update(ops, true, 1);
 }
 
+/*
+ * This function will update what functions @ops traces when its filter
+ * changes. @filter_hash is set to true when modifying the filter_hash
+ * and set to false when modifying the notrace_hash.
+ *
+ * For example, if the user does: echo schedule > set_ftrace_filter
+ * that would call: ftrace_hash_rec_update_modify(ops, true, true);
+ *
+ * For: echo schedule >> set_ftrace_notrace
+ * That would call: ftrace_hash_rec_enable(ops, false, true);
+ *
+ * The @inc states if the @ops callbacks are going to be added or removed.
+ * The dyn_ftrace records are update via:
+ *
+ * ftrace_hash_rec_disable_modify(ops, filter_hash);
+ * ops->hash = new_hash
+ * ftrace_hash_rec_enable_modify(ops, filter_hash);
+ *
+ * Where the @ops is removed from all the records it is tracing using
+ * its old hash. The @ops hash is updated to the new hash, and then
+ * the @ops is added back to the records so that it is tracing all
+ * the new functions.
+ */
 static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops,
-					  int filter_hash, int inc)
+					  bool filter_hash, bool inc)
 {
 	struct ftrace_ops *op;
 
@@ -1939,15 +1962,15 @@ static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops,
 }
 
 static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops,
-					   int filter_hash)
+					   bool filter_hash)
 {
-	ftrace_hash_rec_update_modify(ops, filter_hash, 0);
+	ftrace_hash_rec_update_modify(ops, filter_hash, false);
 }
 
 static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
-					  int filter_hash)
+					  bool filter_hash)
 {
-	ftrace_hash_rec_update_modify(ops, filter_hash, 1);
+	ftrace_hash_rec_update_modify(ops, filter_hash, true);
 }
 
 /*
-- 
2.43.0


