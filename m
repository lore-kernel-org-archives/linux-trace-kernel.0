Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951D3D9E;
	Wed,  5 Jun 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610646; cv=none; b=Hx7i+Sp0Gb7f6Fw5q300Sp71Fuj5hG/CYggeQ6gF/Sud805Ww2MWVGTrk1//TPZTJsPRUwo420gyBVNvfZLs7BMv/CCOex6WQlpSYmG/ewsidlCiYZEV26STUCvvKZ/fP3uihcibGCEN+XH6k5cguGnyE+M0EARqdVHCpmqDGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610646; c=relaxed/simple;
	bh=Ldbg+sdfEohAnkSLIhjaFK1vi72Igfk+qnGb+F/ERbE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QOt8axdhiOAXyZUrB3rKdZXIZWkBSX12oF8wM1Q6CBwxB4es8BJcCmB+rl2mJ2CfxgBOsTtDtE889DYyg3UFZWq4xTncJ1OgbRvj5c6ZD3WcHm4SKciAKp1pM0XdMRJMpjpqtiLN249LHLCflgUEkSpwHkhZlW9t89pAo7UDQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF55C2BD11;
	Wed,  5 Jun 2024 18:04:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEuzY-00000000hX1-2oUS;
	Wed, 05 Jun 2024 14:04:08 -0400
Message-ID: <20240605180408.537723591@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 14:03:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/5] ftrace: Rename dup_hash() and comment it
References: <20240605180334.090848865@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The name "dup_hash()" is a misnomer as it does not duplicate the hash that
is passed in, but instead moves its entities from that hash to a newly
allocated one. Rename it to "__move_hash()" (using starting underscores as
it is an internal function), and add some comments about what it does.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da7e6abf48b4..9dcdefe9d1aa 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1391,7 +1391,11 @@ ftrace_hash_rec_enable_modify(struct ftrace_ops *ops, int filter_hash);
 static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 				       struct ftrace_hash *new_hash);
 
-static struct ftrace_hash *dup_hash(struct ftrace_hash *src, int size)
+/*
+ * Allocate a new hash and remove entries from @src and move them to the new hash.
+ * On success, the @src hash will be empty and should be freed.
+ */
+static struct ftrace_hash *__move_hash(struct ftrace_hash *src, int size)
 {
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *new_hash;
@@ -1438,7 +1442,7 @@ __ftrace_hash_move(struct ftrace_hash *src)
 	if (ftrace_hash_empty(src))
 		return EMPTY_HASH;
 
-	return dup_hash(src, size);
+	return __move_hash(src, size);
 }
 
 static int
-- 
2.43.0


