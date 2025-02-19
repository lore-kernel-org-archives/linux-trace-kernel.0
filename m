Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C21E4AB;
	Wed, 19 Feb 2025 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991017; cv=none; b=mruREsH90u898v9lm5bJVKHBbjf7O9m2gNPJ1uV2Jgie4lY2FuDiJ/NlcLV5CiV5AKLO9ePOuOG6HNax6VYBRPlLHxLT5ZiNdyd3IZplnQ+4UA1nOmkO3FjOcXgGTfZaRQ0lJa+RZbIsZZMVgvMWz9YnQ3/XnP+o/c40zu2onE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991017; c=relaxed/simple;
	bh=3UemN212tYASst3nh3yJ+3WrgzRCvetbd+D36w7vyBo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cGsJM6wLLoanay1yQNRRSwdhEueUJNjCNxAU1/ZZOgbnQW74OB8xCAx41w4jqORBVztcth/2CBQyvrSLi0hJGQahXkEOzzj9UwbHeXANZU3/pnb7n3AUzPNz65knQN+aRs4AHlD1QLMPivgNVRin85NfnYvqmbrSGot0rFYDBWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6069BC4CEE0;
	Wed, 19 Feb 2025 18:50:16 +0000 (UTC)
Date: Wed, 19 Feb 2025 13:50:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ftrace: Have ftrace_free_filter() WARN and exit if ops is
 active
Message-ID: <20250219135040.3a9fbe00@gandalf.local.home>
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

The ftrace_free_filter() is used to reset the ops filters. But it must be
done if the ops is not currently active (tracing). If it is, it will mess
up the ftrace accounting of what functions are attached and what is not.

WARN and exit the ftrace_free_filter() if the ops is active when it is
called.

Currently, it doesn't seem if anything does this, but it may in the
future.

Link: https://lore.kernel.org/all/20250219095330.2e9f171c@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 189eb0a12f4b..4f6cad3b05b2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1296,6 +1296,8 @@ static void free_ftrace_hash_rcu(struct ftrace_hash *hash)
 void ftrace_free_filter(struct ftrace_ops *ops)
 {
 	ftrace_ops_init(ops);
+	if (WARN_ON(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return;
 	free_ftrace_hash(ops->func_hash->filter_hash);
 	free_ftrace_hash(ops->func_hash->notrace_hash);
 }
-- 
2.47.2

