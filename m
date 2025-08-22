Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB851E5705;
	Fri, 22 Aug 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902171; cv=none; b=QpOJVq9+WO5KXDtTIit3BlXcPeM7apwzFFtBZZLo+5WzJNlIhueoc9eo5x5MamqgG4wO3691BatuHCXLukbYfDQ8eMi908p94XdFHxiF+u5a+Y3vbHLREofLG2K8faJCpuxuhJj27ECi6eBOGSiugwZPeJvQ1novPKyrwpo0LVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902171; c=relaxed/simple;
	bh=Ipf4PtHnqlo2qX/ocDyeGiklut+RT2J+azU0jfIZmxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qZtJIIZnsKyWHWUUc+zIJ9BjgvLANw29vJJPYA8ItHmwvFvYoMg1CrVsh3HAf9BNbJZSB8UfmafamLnJj2bN0htMIVc0q5JN8coo+tVOIFG6u2t31SkXGLXEPpWzS1joL9/eXJMwALSe6EzbTB9wHq0EdD/DnEVp52pSV9Or87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 31316C037C;
	Fri, 22 Aug 2025 22:36:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 5F11B2D;
	Fri, 22 Aug 2025 22:36:05 +0000 (UTC)
Date: Fri, 22 Aug 2025 18:36:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tengda Wu <wutengda@huaweicloud.com>,
 Nathan Chancellor <nathan@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH v2] ftrace: Also allocate and copy hash for reading of
 filter files
Message-ID: <20250822183606.12962cc3@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g4ahir68hhuz96ha3j3etkrun58ojgkz
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5F11B2D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19SOC8s4mzrVc5VaOGJ4F6I9pk4caogj6g=
X-HE-Tag: 1755902165-964812
X-HE-Meta: U2FsdGVkX1+UXTpAxPWCoYB17PTkoRVdZABOHyJjYnowMMdJfCsugcYr3NBipySINUMjU0kXSz6K6joI+N4MNzlYH2m18VDdl+gRpvSkCf4xGal4Ve47/JVwEvAufEdtgKVLQuQ8Di2nWaXH2mwq3O8kaiQTX9qRBSPNjAn3rlSGBgKh0SXwkP0zNB0d6s51XCLXR8yOWHmBh5lx+MFW4q1BCViCsmIJTt9XhoznehFa+gatwtWUrxN8SIUzzLB6HJGeyu/7uG0i+tzTHSNYmD6mGBxCTk+HwBia/RXBeYahoRT6Jpu7yCPVppE+t5S/Ym+USDVWXfLrI3V71nuZ5RTOzC+oz9WGfNBHB3+DlyWiSmguUFGBUR/RG23uky+cT50gxC4HQ67DUrzbd+uDYBCPl1dZF9Qwn2+/1COdZzM=

From: Steven Rostedt <rostedt@goodmis.org>

Currently the reader of set_ftrace_filter and set_ftrace_notrace just adds
the pointer to the global tracer hash to its iterator. Unlike the writer
that allocates a copy of the hash, the reader keeps the pointer to the
filter hashes. This is problematic because this pointer is static across
function calls that release the locks that can update the global tracer
hashes. This can cause UAF and similar bugs.

Allocate and copy the hash for reading the filter files like it is done
for the writers. This not only fixes UAF bugs, but also makes the code a
bit simpler as it doesn't have to differentiate when to free the
iterator's hash between writers and readers.

Cc: stable@vger.kernel.org
Fixes: c20489dad156 ("ftrace: Assign iter->hash to filter or notrace hashes on seq read")
Closes: https://lore.kernel.org/all/20250813023044.2121943-1-wutengda@huaweicloud.com/
Link: https://lore.kernel.org/all/20250822192437.GA458494@ax162/
Reported-by: Tengda Wu <wutengda@huaweicloud.com>
Tested-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250820091913.146b77ea@gandalf.local.home

- Assign iter->hash to EMPTY_HASH if hash is NULL (Nathan Chancellor)


 kernel/trace/ftrace.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 00b76d450a89..a69067367c29 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4661,13 +4661,17 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	        } else {
 			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
 		}
+	} else {
+		if (hash)
+			iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
+		else
+			iter->hash = EMPTY_HASH;
+	}
 
-		if (!iter->hash) {
-			trace_parser_put(&iter->parser);
-			goto out_unlock;
-		}
-	} else
-		iter->hash = hash;
+	if (!iter->hash) {
+		trace_parser_put(&iter->parser);
+		goto out_unlock;
+	}
 
 	ret = 0;
 
@@ -6543,9 +6547,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
-	} else {
-		/* For read only, the hash is the ops hash */
-		iter->hash = NULL;
 	}
 
 	mutex_unlock(&iter->ops->func_hash->regex_lock);
-- 
2.50.1

