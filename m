Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D6EACD;
	Wed, 20 Aug 2025 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651943; cv=none; b=g0H/X8VEbd7XPdJKvRNqEPLVi7PYxJTDyc9Rc8kN6MBGrbugfrDEzMDGVmwY6LIDP3Mjz4I4lOHTtZulxr2rVjLiwK+uaKh0Xj9eH16LBM9gxL342DRBp0VPzgu8uw7dmiZ8/Nab+czfvMv4jAQn759pHqr8TKceH9tO3SJw7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651943; c=relaxed/simple;
	bh=XhlmI8i+KqUK5uZkc2v9r1gmC5W7iW4f0P6CkJxGuoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZTfn+wgXXz2frQE88uWIRIDRVbas0C0kPK0iNIyM1tPkiur3OLgbZL5wk3490ZRyL7blhEI7nizwQ92YV8mv38xrAVgcjCt27qrAx6J6ybGk815Hobbo8LuuRkKlQ/Cja9QxjHtI7BSKQft6uwk8cZ+wzjlvoKoVeRvUh/rC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id E0CA282E7C;
	Wed, 20 Aug 2025 01:05:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id D175E40;
	Wed, 20 Aug 2025 01:05:37 +0000 (UTC)
Date: Tue, 19 Aug 2025 21:05:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] ftrace: Fix potential use-after-free for
 set_ftrace_{notrace,filter} files
Message-ID: <20250819210538.29ae29cb@gandalf.local.home>
In-Reply-To: <20250813023044.2121943-3-wutengda@huaweicloud.com>
References: <20250813023044.2121943-1-wutengda@huaweicloud.com>
	<20250813023044.2121943-3-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tknhr8xd9kmhfrtd4qpq8wgr5njp6phq
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: D175E40
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19lPzznN9BqkSLbKjRzTc1GmmBmEI/30QY=
X-HE-Tag: 1755651937-782463
X-HE-Meta: U2FsdGVkX19bTUORDxUnSTsZJ1dAnyRqe0JsY1IHA3u5lgf2VivYtch8t27OpslgaN8whTDXN/QU2cR68Jw9TeF8M16V1qMbkzBzYRvUdXE/UJ8etxt7CrubtJCl878LjlrxXQUG1b7hKJTVKSRoD092tGRqJee3pWDR7sH4v7GQCONALfAxTiN2yZV9szYr5hvBVmPBApDnH8zm7kNZoxx+iWoVpkFbKug/EhriJpR+yXtyVaEG/mqF+hdS+Wjxwasxa04hd5u10gtZcpzOH0Csb1alyqPZoNWShZIjyXG2eHEsluU8mliAyj4QFjgw7iOs6++q4/yd7mk///mRywI4qF4B6bqRK548AsNoDyZHtoLsWWWRY1vpkTmWMg7H58nloV4wKtw96hpHaq1XVBpUvvsniUpHUByXqeMsok0=

On Wed, 13 Aug 2025 02:30:44 +0000
Tengda Wu <wutengda@huaweicloud.com> wrote:


> Since the reader's hash is always tied to its file descriptor (fd),
> the writer cannot directly manage the reader's hash. To fix this,
> introduce a refcount for ftrace_hash, initialized to 1. The count
> is incremented only when a reader opens it, and decremented when
> either a reader or writer releases it, thereby controlling the timing
> of ftrace_hash deallocation.

Hmm, I think the code that the first patch touches is the issue here too.

Instead of doing all these extra hacks, we should simply copy the hash for
read too.

That is, the real fix for both patches is this:

-- Steve

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] ftrace: Also allocate hash for reading of filter files

Currently the reader of set_ftrace_filter and set_ftrace_notrace just adds
the pointer to the global tracer hash to its iterator. Unlike the writer
that allocates a copy of the hash, the reader keeps the pointer to the
filter hashes. This is problematic because this pointer is static across
function calls that release the locks that can update the global tracer
hashes. This can cause UAF and similar bugs.

Allocate the hash for reading the filter files like it is done for the
writers. This not only fixes UAF bugs, but also makes the code a bit
simpler as it doesn't have to differentiate when to free the iterator's
hash between writers and readers.

Cc: stable@vger.kernel.org
Fixes: c20489dad156 ("ftrace: Assign iter->hash to filter or notrace hashes on seq read")
Closes: https://lore.kernel.org/all/20250813023044.2121943-1-wutengda@huaweicloud.com/
Reported-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 00b76d450a89..f992a5eb878e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4661,13 +4661,14 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	        } else {
 			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
 		}
+	} else {
+		iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
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
 
@@ -6543,9 +6544,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
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

