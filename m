Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB32191493;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099539; cv=none; b=jDIH41p8Rn8BBWt9s94ncSsytZRmGIf6reSQ+1Bmd5t6Iz7wnvuvGLz/twR1O7IFt/K9cA19YDBv+M7QbEkhCi/UTflZGn6QOGr2DC4XFZPCh689DEDm+Lj3DKWTqO62Zd8SwWoDnw6sxxs8XxT590hCdknlBx3VqBexmuks2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099539; c=relaxed/simple;
	bh=CrpZfsQvl+o/WpkUnkpWR88txNPc6znh+Atzuyb7wlw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=icU7R4tSwt0s7wNmmv8SB55jkFSKwkvYSLt+kXMWNgxWP/aGWNTCz0i7MvwFMVOSpIPAoIqrxM5hgLv6MLINSYi5if16sUWdEhfKyDrWYh92Yiy3ogxVuKpw6gZe0vt8rHBp2HZWHpFxPqcvchdtqeACgXgtQkHi8FdJzOFzOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37328C4CEE3;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t5Jw4-000000053DY-0HWJ;
	Mon, 28 Oct 2024 03:13:08 -0400
Message-ID: <20241028071307.927146604@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 28 Oct 2024 03:12:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/5] ftrace: Use guard for match_records()
References: <20241028071228.575900713@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_lock is held for most of match_records() until the end of the
function. Use guard to make error paths simpler.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e9fd4fb2769e..44adc34643c9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4829,15 +4829,13 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 		mod_g.len = strlen(mod_g.search);
 	}
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	if (unlikely(ftrace_disabled))
-		goto out_unlock;
+		return 0;
 
-	if (func_g.type == MATCH_INDEX) {
-		found = add_rec_by_index(hash, &func_g, clear_filter);
-		goto out_unlock;
-	}
+	if (func_g.type == MATCH_INDEX)
+		return add_rec_by_index(hash, &func_g, clear_filter);
 
 	do_for_each_ftrace_rec(pg, rec) {
 
@@ -4846,16 +4844,12 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 
 		if (ftrace_match_record(rec, &func_g, mod_match, exclude_mod)) {
 			ret = enter_record(hash, rec, clear_filter);
-			if (ret < 0) {
-				found = ret;
-				goto out_unlock;
-			}
+			if (ret < 0)
+				return ret;
 			found = 1;
 		}
 		cond_resched();
 	} while_for_each_ftrace_rec();
- out_unlock:
-	mutex_unlock(&ftrace_lock);
 
 	return found;
 }
-- 
2.45.2


