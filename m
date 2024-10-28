Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3703191F7F;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099539; cv=none; b=tBiyVIn9AZIu0QbLM9ELwSMpKnYvr1gv0hNZ2w6WXm++XSyFLo+k4M1nivXnobxbrH+9iEqvLxueQOlJ7x9cCoifyALjOiLuqok/lZjOGhobfE8nyhEAMiS5EHIQ428S9gLkQCt7YKf7i6G5wu5E+qKDimJ4fn3UEpj5mLUys9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099539; c=relaxed/simple;
	bh=OZ76P+x20FJGM1mhnK21A4nkaPxTbLlBClKvkWtTMVg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=V1WIPk1PFtt5NdfLWt9gcpqyEIFM9/mQiNtYHfNeG45SjcqaWainGrCrRldx9G/1ZKGghRNkXx/QQ20oljL1RME8QH0OSd29Nc6Plk2bvpVrd+Fl2iy8W3i1uD3p02mgv2vyfTUc5dZt9M4LTP7AqkEKi79h2YLsc7GaBoL/FuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A53C4CEC7;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t5Jw4-000000053F0-2HvF;
	Mon, 28 Oct 2024 03:13:08 -0400
Message-ID: <20241028071308.406073025@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 28 Oct 2024 03:12:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5/5] ftrace: Use guard to take ftrace_lock in ftrace_graph_set_hash()
References: <20241028071228.575900713@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_lock is taken for most of the ftrace_graph_set_hash() function
throughout the end. Use guard to take the ftrace_lock to simplify the exit
paths.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c0fabd7da5b2..b4ef469f4fd2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6816,12 +6816,10 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 
 	func_g.len = strlen(func_g.search);
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
-	if (unlikely(ftrace_disabled)) {
-		mutex_unlock(&ftrace_lock);
+	if (unlikely(ftrace_disabled))
 		return -ENODEV;
-	}
 
 	do_for_each_ftrace_rec(pg, rec) {
 
@@ -6837,7 +6835,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 				if (entry)
 					continue;
 				if (add_hash_entry(hash, rec->ip) == NULL)
-					goto out;
+					return 0;
 			} else {
 				if (entry) {
 					free_hash_entry(hash, entry);
@@ -6846,13 +6844,8 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 			}
 		}
 	} while_for_each_ftrace_rec();
-out:
-	mutex_unlock(&ftrace_lock);
 
-	if (fail)
-		return -EINVAL;
-
-	return 0;
+	return fail ? -EINVAL : 0;
 }
 
 static ssize_t
-- 
2.45.2


