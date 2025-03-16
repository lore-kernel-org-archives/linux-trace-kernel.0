Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390318B47C;
	Sun, 16 Mar 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742127688; cv=none; b=s7mSPpv0xGtxRIx/wvo7YRXu1TeES3kA76v8Qb3eQJBOjhwj7j9T2KOGBC/50knfh7dKwIp2RY5Z+FMa415XHJCrssrAojajwWqd35zJ9wvSqt+LQO/wnbxZEsG1uNG6GgdSHRFTOywZmqM6Hv8AYcj1ZRqluQsOTRZjId5BVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742127688; c=relaxed/simple;
	bh=gjmV4gbAkAhF5mQ6J/09/rRmSzsdFAZegE7iBok4gYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYTr3Qr6RRP6qy+14Swvr42TODnu6WwCEs6oPoWl6r7eTGQrSGeCXZBBXA+6io2ae9YG7IiWhUiP6jZM+LOPJD2WfWlJ/Z/HEiR7bST4AfI9LkHV6wIUjJ4O7ibRuhYqes94wSltzHleb6Q1vm1naBReXWu0aosrqy+ivIeGCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoC+FfGX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoC+FfGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4E4C4CEDD;
	Sun, 16 Mar 2025 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742127687;
	bh=gjmV4gbAkAhF5mQ6J/09/rRmSzsdFAZegE7iBok4gYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OoC+FfGXp+HTSN2a6ctff0Zp27I1tB0ukHqVXNPo6CZD0UjEE5GU9iiCAirrN9mXR
	 0X88AzygOEx60oRAemOzkc7dXVUh5BXj+REySR8UFPVXqbn7K2ylXKN/O2vnwAPVSr
	 Mx0tWnUnJAkz5yHX24m1HNDaeYUWEUIw08cTz7p4yJCy7SFaf3JFgC/X/M2uiCaTCN
	 ElGe3HEORFCpmYPWDMJuuduKS47Nv2WG62LEChg49VlQert878r3+eO5Knqg1VnCK9
	 wglqVU2+LIspduzOa6vwvKU7zvTHmLBcZbWvcYZ7uwJmtVph96DxLcigQ+1da2UYYL
	 /J6cj+uutWcBQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/4] tracing: tprobe-events: Remove mod field from tprobe-event
Date: Sun, 16 Mar 2025 21:21:21 +0900
Message-ID: <174212768121.348872.11676145343580139357.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <174212767109.348872.18231451508464729427.stgit@devnote2>
References: <174212767109.348872.18231451508464729427.stgit@devnote2>
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

Remove unneeded 'mod' struct module pointer field from trace_fprobe
because we don't need to save this info.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 5d7ca80173ea..08def94f9ca6 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -46,7 +46,6 @@ struct trace_fprobe {
 	struct fprobe		fp;
 	const char		*symbol;
 	struct tracepoint	*tpoint;
-	struct module		*mod;
 	struct trace_probe	tp;
 };
 
@@ -426,7 +425,6 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 					       const char *event,
 					       const char *symbol,
 					       struct tracepoint *tpoint,
-					       struct module *mod,
 					       int nargs, bool is_return)
 {
 	struct trace_fprobe *tf __free(free_trace_fprobe) = NULL;
@@ -446,7 +444,6 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 		tf->fp.entry_handler = fentry_dispatcher;
 
 	tf->tpoint = tpoint;
-	tf->mod = mod;
 
 	ret = trace_probe_init(&tf->tp, event, group, false, nargs);
 	if (ret < 0)
@@ -776,7 +773,6 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
 			tracepoint_probe_unregister(tf->tpoint,
 					tf->tpoint->probestub, NULL);
 			tf->tpoint = NULL;
-			tf->mod = NULL;
 		}
 	}
 }
@@ -992,7 +988,6 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 			tpoint = find_tracepoint_in_module(tp_mod->mod, tf->symbol);
 			if (tpoint) {
 				tf->tpoint = tpoint;
-				tf->mod = tp_mod->mod;
 				if (!WARN_ON_ONCE(__regsiter_tracepoint_fprobe(tf)) &&
 				    trace_probe_is_enabled(&tf->tp))
 					reenable_trace_fprobe(tf);
@@ -1003,7 +998,6 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 				tracepoint_probe_unregister(tf->tpoint,
 					tf->tpoint->probestub, NULL);
 				tf->tpoint = TRACEPOINT_STUB;
-				tf->mod = NULL;
 			}
 		}
 	}
@@ -1210,8 +1204,7 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 		return ret;
 
 	/* setup a probe */
-	tf = alloc_trace_fprobe(group, event, symbol, tpoint, tp_mod,
-				argc, is_return);
+	tf = alloc_trace_fprobe(group, event, symbol, tpoint, argc, is_return);
 	if (IS_ERR(tf)) {
 		ret = PTR_ERR(tf);
 		/* This must return -ENOMEM, else there is a bug */

