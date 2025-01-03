Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC71C1738;
	Fri,  3 Jan 2025 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735945324; cv=none; b=u7adaXwBO+xoRh20XehFYAC4obCltyD8YW+08+egxb5Wjwpmi2A8FceP8hOc4SqXb7XMrghnZqIxYvr1edvhFr34B1jX0w7aV5VH2/4So84ctLUch1fR+KjrB1mb4+Ost2yy22+S2GRHexCNvgVKrXzAqVRI57fcSW1m98qZoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735945324; c=relaxed/simple;
	bh=etnA2SO279t5hWq6UUbJo8a9gsTJwE59MSfhjDJAKQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWfjN1eoNsG5sYTYOwkl0IDyJFJzAyNyFlbwW4KbCP1ofqx6fo2INTiq9Ok5obyqZQ5nZj7QJgXfcSYTjZMjlT9U/CQ7N1H8GUiz/rYYcxHZIwDpj8hOqZhgtCz1FLC5sOuqAhs8MFFNIG2z6Cg3svLEGwdsDclE1r6jIhPieC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMwDDDKF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMwDDDKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6DDC4CEDD;
	Fri,  3 Jan 2025 23:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735945324;
	bh=etnA2SO279t5hWq6UUbJo8a9gsTJwE59MSfhjDJAKQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gMwDDDKFUiHyiUXPVzIFrYU4ITY6vzLvqXzGcyy2lHpQrRgNC8KZ57f+QR+5LIO08
	 4ZClUdA+128T10v049QHrWmzM4gYxtBICDxnm1g9gue9CshiZienp0/JJ/AULyEoh1
	 cOfFS1+q698gDWIJy2RpKvn7i6y77FmucH52KUt31m0smlqFCz+CwCvsW1CS9rUGkS
	 YGoiOQAK1Ne9WmRFvWX8KuCJiRoaAMY0Cft+UeaRAay23bnnhpQIlLpPkkLAnFXUDn
	 CFS12h7O0SXM6+ADzeFu7QwjqDLgTe2r1siPbSHwjGrS6u503F64ohBvZ6wpiyJ00G
	 S5dHPUFpfodZQ==
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
Subject: [PATCH 3/6] tracing: Use __free() for argv in dynevent
Date: Sat,  4 Jan 2025 08:01:58 +0900
Message-ID: <173594531843.1055889.15079784465215693664.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173594528527.1055889.2175884987203674189.stgit@devnote2>
References: <173594528527.1055889.2175884987203674189.stgit@devnote2>
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

Use __free() for the args allocated by argv_split() in dynevent.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_dynevent.c |   47 +++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index eb8f669c15e1..ec8fa7b143e2 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -73,24 +73,20 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	struct dyn_event *pos, *n;
 	char *system = NULL, *event, *p;
 	int argc, ret = -ENOENT;
-	char **argv;
+	char **argv __free(argv) = NULL;
 
 	argv = argv_split(GFP_KERNEL, raw_command, &argc);
 	if (!argv)
 		return -ENOMEM;
 
 	if (argv[0][0] == '-') {
-		if (argv[0][1] != ':') {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (argv[0][1] != ':')
+			return -EINVAL;
 		event = &argv[0][2];
 	} else {
 		event = strchr(argv[0], ':');
-		if (!event) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!event)
+			return -EINVAL;
 		event++;
 	}
 
@@ -100,27 +96,22 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		event = p + 1;
 		*p = '\0';
 	}
-	if (!system && event[0] == '\0') {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!system && event[0] == '\0')
+		return -EINVAL;
 
-	scoped_guard(mutex, &event_mutex) {
-		for_each_dyn_event_safe(pos, n) {
-			if (type && type != pos->ops)
-				continue;
-			if (!pos->ops->match(system, event,
-					argc - 1, (const char **)argv + 1, pos))
-				continue;
-
-			ret = pos->ops->free(pos);
-			if (ret)
-				break;
-		}
-		tracing_reset_all_online_cpus();
+	guard(mutex)(&event_mutex);
+	for_each_dyn_event_safe(pos, n) {
+		if (type && type != pos->ops)
+			continue;
+		if (!pos->ops->match(system, event,
+				argc - 1, (const char **)argv + 1, pos))
+			continue;
+
+		ret = pos->ops->free(pos);
+		if (ret)
+			break;
 	}
-out:
-	argv_free(argv);
+	tracing_reset_all_online_cpus();
 	return ret;
 }
 

