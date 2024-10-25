Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B186AE3;
	Fri, 25 Oct 2024 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823389; cv=none; b=QWF7jhIfUnezUWxXkGw1Kbzc8io/QernuvIhUQcV27wY1yLMfvIBfrGS4W6Zhun71ptvsfeysvmfiGvXo7b3Hj3iRCgtxCzRSucZ9aGdmMxo3GhNAlzgy4mFHXxz2OHW9/A1xbqdazwRh07qO4w3WZr4qVoOu/6SCtnzkznyUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823389; c=relaxed/simple;
	bh=maewG1pabUMM7p9GiBQcQL2cP2/TW16L+uJ1f9eSQM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MI39neiBdJK99TNW3wX2qa6BQt+31zty0JoHM2Ng4jb3JXSknkuplu0/7rEETkKGrV6owJCalp3DKxH1f1Ol/d2nWpS9XJCJWPskZpUFxqyHRbbNDACA3GQMFBR/VuRYug+fcbLoIMYAA3SmpcztELi6XNOkItS8nVV4qqAL9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06C4C4CEC7;
	Fri, 25 Oct 2024 02:29:47 +0000 (UTC)
Date: Thu, 24 Oct 2024 22:29:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] fgraph: Change the name of cpuhp state to "fgraph:online"
Message-ID: <20241024222944.473d88c5@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The cpuhp state name given to cpuhp_setup_state() is "fgraph_idle_init"
which doesn't really conform to the names that are used for cpu hotplug
setups. Instead rename it to "fgraph:online" to be in line with other
states.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 2c02f7375e658 ("fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index cd1c2946018c..69e226a48daa 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1255,7 +1255,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	guard(mutex)(&ftrace_lock);
 
 	if (!fgraph_initialized) {
-		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
+		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph:online",
 					fgraph_cpu_init, NULL);
 		if (ret < 0) {
 			pr_warn("fgraph: Error to init cpu hotplug support\n");
-- 
2.45.2

