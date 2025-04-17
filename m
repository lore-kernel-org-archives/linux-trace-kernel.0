Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC972571DC;
	Thu, 17 Apr 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912681; cv=none; b=GjeKVUm9Uo1V8xV8c7g8vbCW3E9ox1mRuq7yXWfNy/gp1KdCD0UOB+BigQExeZVJfk4JHTfezq5GrJS9qxBaJHKGslWjdu3HAgQcQMWipoZ+UgwdOJOL52rkK5QOUefgZqx0alvTW3uFtlmBuTMxnsTK/i7Rt6Dt+P5ZMSQnoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912681; c=relaxed/simple;
	bh=obmBouT+OPn9WusyTQWX756/PQVLb3x6dmC8Wnrv21Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CuwB/PucFIgxmzUBIxjtRUolzdBr2qM4+xulYhkizOXW0ZaRvb92GAveCscMqzbO3qU0YJrSdtTbOI9QVLYawy/Ok3grB7I2BFEa18t06BX29ak/5dpEr4eUkwjbdRLbkaMefsekT3blNz4OH8qNCNE+Yc3Fe6KHy8LvlpLJG18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBA6C4CEE7;
	Thu, 17 Apr 2025 17:58:00 +0000 (UTC)
Date: Thu, 17 Apr 2025 13:59:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ftrace: Free ftrace hashes after they are replaced in the
 subops code
Message-ID: <20250417135939.245b128d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The subops processing creates new hashes when adding and removing subops.
There were some places that the old hashes that were replaced were not
freed and this caused some memory leaks.

Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 39ccbb3b9693..d3e8b801ccc1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3609,6 +3609,9 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
 			}
 		}
 
+		free_ftrace_hash(temp_hash.filter_hash);
+		free_ftrace_hash(temp_hash.notrace_hash);
+
 		temp_hash.filter_hash = *filter_hash;
 		temp_hash.notrace_hash = *notrace_hash;
 	}
@@ -3703,8 +3706,11 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
 	}
 
 	ret = rebuild_hashes(&filter_hash, &notrace_hash, ops);
-	if (!ret)
+	if (!ret) {
 		ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
+		free_ftrace_hash(filter_hash);
+		free_ftrace_hash(notrace_hash);
+	}
 
 	if (ret) {
 		/* Put back the original hash */
-- 
2.47.2

