Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F017BEBF;
	Wed, 20 Aug 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695956; cv=none; b=t8isyBIsF0H0GDLVOY+BxJ4g+LiDCQVlFRWk1HvfwQBIM5w5mfQ+d1qMGFXIT2ZQlvPnygT/3DdAY1iZ7x/WO5f5vKi8a8tlLt9342tyR2X2Js+s1TmVqWRSzEmH3XjDOmRUdUlPxQGA5bxur9eBzugaW/ceH3Xf1/inLaJ7NFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695956; c=relaxed/simple;
	bh=dfzDTv8oEKCetBlFcR94doiE/batysYuRwZOX+17Q5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nVrexmHh0d9NCAC66QQb0G27rKYtAvyEKjAeOpuSdCuu97e4o3QQPu9/TkCSBrSc6dPG9pV4uSCJEiAEsixkD2M/OXuRjQpOFBREUhA0oDgWsm0Sg/e5kpa+R9BIRMhfJMrJLjMoGjLvQwExsVqxQlGwEu/XNuJRT0tv+88sJtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 3C6C5140487;
	Wed, 20 Aug 2025 13:19:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 9B4FC31;
	Wed, 20 Aug 2025 13:19:11 +0000 (UTC)
Date: Wed, 20 Aug 2025 09:19:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH] ftrace: Also allocate and copy hash for reading of filter
 files
Message-ID: <20250820091913.146b77ea@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: s76bgtiotga8our5impfewimqikqqh5w
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 9B4FC31
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/UPIdFSIrzdxQAXDSFXnKIVexJaJ/8nus=
X-HE-Tag: 1755695951-379636
X-HE-Meta: U2FsdGVkX1+2yvrsJ42/FUxcZJiIC59X7Js69TfH+ECb7sbf+ZKmaf3HEZRpjPSgo73byNe251sY6Y4Bb0X91gtnkH7coHsWWmIwdNgi9/3TcClfkO3sMfmXT8rAbSV23p2yPL2gMNhjyD8GWdVqZLQBJsPQQZMqKQPF2K03SIgHEmKKrsxnwb0otmJNDZHarpfJAVWw/GtLD/hiItpeb6h4zjWUGOAKcHfVbUQiqw9q8ROiQ+LssHALjSkAOTE/7kP6rR24NaeJVzn0dFfwsBFsetib+8cYLvxGJfRAhgHZ1RdU54jDXZ5GwQJSF0AAUXEIHqi7vcNaxY7242zQMPgj5ewHjTy1NOWeNxTP8Ve5D3LTl+j9AmMoqOLbcVhXRhUdYqbpi/ImHCOaMIkaEFLAT17wTZhI0HB7cysyYMg=

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
Reported-by: Tengda Wu <wutengda@huaweicloud.com>
Tested-by: Tengda Wu <wutengda@huaweicloud.com>
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

