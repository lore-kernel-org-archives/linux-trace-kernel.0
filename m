Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1F1219A86;
	Mon, 31 Mar 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435357; cv=none; b=t2gZilGbcpb8UXuH9HkKVvEU4gdXtIM4BNMwdga+btopWw+qWtt34+Bas2AlH9U6FDI+RGFq8VUDyrVDrO7EE0krnCfj8raYBBSbpubQMH0KNu4P5Dc5o8D0ZpuYgvqGCzuK1TAKph4vxDVmIkbqhMnk78zR4rpF2PNf3xbjhxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435357; c=relaxed/simple;
	bh=pDTF0MKZB1iayRn9ON00BlXlbWN00/eEqjP/+2646z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhyjBA+YKuE/Nw9tqAopFON2gmB6PqahT7wxDToLNoB+2Qriw7HyowsnIoDpj8KX7ddzSAG0HoFDNhjjqtI1IAsCz+/yFYf9cUoidj0ncoSnE8td8eAVW+Pa2z5BBQjHo5Itb+vT3VBO/qGZEqhE1SvBKMlcMxR3JRFtLObWTts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGL/Ngj6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGL/Ngj6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C274CC4CEE3;
	Mon, 31 Mar 2025 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743435357;
	bh=pDTF0MKZB1iayRn9ON00BlXlbWN00/eEqjP/+2646z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGL/Ngj6XsH8gFjHZeAkrVTP9klUSJTn4XNJyjmpWP+0FdrZFRxHMm0fOkgy04WCF
	 8dlJVLzAc8rp5UcFr6Pb4/Z/01dwFFRTW/vCE4RDkTnbvBSVR+kMsjLUWqQBVwLfYy
	 PiMw1xOtcmJcHx13pA1DIk+h8VSXeSq97tlJhXy6yQnv6jG90ZgpmtGHDkR//MISJC
	 dAnKW+rE4KSmzQUhsDRQFhzRQ++IQ+lbkcx7+0HcZusW4g6dQDLDUCP9O0vy9MLY3U
	 +OW9aVJeLDzXQ6aJ3b0997kkruS50ZCbr1JpsK8G/qa2vITkCmePNfIwWWFVcZ0OQv
	 dj3E4olMRzHAw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] tracing: tprobe-events: Remove mod field from tprobe-event
Date: Tue,  1 Apr 2025 00:35:53 +0900
Message-ID: <174343535351.843280.5868426549023332120.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <174343532655.843280.15317319860632975273.stgit@devnote2>
References: <174343532655.843280.15317319860632975273.stgit@devnote2>
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
 kernel/trace/trace_fprobe.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 2cd9ff1049f1..14a1e4f07002 100644
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
@@ -1001,23 +997,23 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 
 	mutex_lock(&event_mutex);
 	for_each_trace_fprobe(tf, pos) {
+		if (!trace_fprobe_is_tracepoint(tf))
+			continue;
 		if (val == MODULE_STATE_COMING && tf->tpoint == TRACEPOINT_STUB) {
 			tpoint = find_tracepoint_in_module(tp_mod->mod, tf->symbol);
 			if (tpoint) {
 				tf->tpoint = tpoint;
-				tf->mod = tp_mod->mod;
 				if (!WARN_ON_ONCE(__regsiter_tracepoint_fprobe(tf)) &&
 				    trace_probe_is_enabled(&tf->tp))
 					reenable_trace_fprobe(tf);
 			}
-		} else if (val == MODULE_STATE_GOING && tp_mod->mod == tf->mod) {
+		} else if (val == MODULE_STATE_GOING &&
+			   tf->tpoint != TRACEPOINT_STUB &&
+			   within_module((unsigned long)tf->tpoint->probestub, tp_mod->mod)) {
 			unregister_fprobe(&tf->fp);
-			if (trace_fprobe_is_tracepoint(tf)) {
-				tracepoint_probe_unregister(tf->tpoint,
-					tf->tpoint->probestub, NULL);
-				tf->tpoint = TRACEPOINT_STUB;
-				tf->mod = NULL;
-			}
+			tracepoint_probe_unregister(tf->tpoint,
+				tf->tpoint->probestub, NULL);
+			tf->tpoint = TRACEPOINT_STUB;
 		}
 	}
 	mutex_unlock(&event_mutex);
@@ -1215,8 +1211,7 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 		return ret;
 
 	/* setup a probe */
-	tf = alloc_trace_fprobe(group, event, symbol, tpoint, tp_mod,
-				argc, is_return);
+	tf = alloc_trace_fprobe(group, event, symbol, tpoint, argc, is_return);
 	if (IS_ERR(tf)) {
 		ret = PTR_ERR(tf);
 		/* This must return -ENOMEM, else there is a bug */

