Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFF718E29;
	Wed, 11 Dec 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875862; cv=none; b=tF25bQ8lGb5HxaKDkwfcUxIvnBGMpekfflCawMeZj56aVEuBvV+eVmrLoKYTD8oKm1HV5Whfh+hSTU+1x1txGqS4zIqs42Bz3KMj2igIv+o8KQR3oLgfMTBWAZP1XxQnjaeeQYs5yY+yOVx8BWqDW08ir699YbCKuMrwTrbkD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875862; c=relaxed/simple;
	bh=Qb8KY4iC94Z2tzkaJJ6mAeaX1MaxRiU5jicbTfSbGTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O15/DBIKLmW5HDzJ2THlMsPshiiBA4+s15JzJme/sJVcx8auXo7joOPaog4aMCBp7Upp+D4TIEHMTo196oekscQXMKDuTpCQpG48yqYVLjp9Z8MGdrml00w9xIP5I2xqbkCTSPdTvNAuVcfga+j+OT3laEpnMHhMZOrl1zZuDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg8dYZE+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg8dYZE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A68CC4CED6;
	Wed, 11 Dec 2024 00:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733875861;
	bh=Qb8KY4iC94Z2tzkaJJ6mAeaX1MaxRiU5jicbTfSbGTw=;
	h=From:To:Cc:Subject:Date:From;
	b=eg8dYZE+mOrtLHAxRnHbxz14dJcri2BEHiNxet0Vgc/FlGCatxduDJ22u8ibhK4dw
	 sER4vM31A57bsSmekDuUIVJ8tWpryA4Ci+PVsasWD1iGTNmIXEEkyEVp8DQmpZYDnM
	 NNoogjCaZTYKz6un4IiI2m20CvzaCpyfEgJjmopStfguSu3i5Z+nnAOf6MPPlar4Dg
	 LRpFW09TrrxvdbMVtCBW45L6brVjrOStuk5VU4LhJ7/0e0SI7YrJOO6lJAZFZ4miXf
	 CGSp6plAd3QX1WNLf8mqNNy0c113AUBtHlx2fBw32GKGh6sf02HUpO6t9UyzrJHuZ/
	 tm9ccMnI3IzIQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/kprobe: Make trace_kprobe's module callback called after jump_label update
Date: Wed, 11 Dec 2024 09:10:55 +0900
Message-ID: <173387585556.995044.3157941002975446119.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Make sure the trace_kprobe's module notifer callback function is called
after jump_label's callback is called. Since the trace_kprobe's callback
eventually checks jump_label address during registering new kprobe on
the loading module, jump_label must be updated before this registration
happens.

Fixes: 614243181050 ("tracing/kprobes: Support module init function probing")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index bae26eb14449..52ddb694ddee 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -720,7 +720,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 
 static struct notifier_block trace_kprobe_module_nb = {
 	.notifier_call = trace_kprobe_module_callback,
-	.priority = 1	/* Invoked after kprobe module callback */
+	.priority = 2	/* Invoked after kprobe and jump_label module callback */
 };
 static int trace_kprobe_register_module_notifier(void)
 {

