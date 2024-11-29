Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2D19C54D;
	Fri, 29 Nov 2024 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898905; cv=none; b=MEG/QiKprpylwVnFXD+Ld3z/z207BR32lurZDEypADu2N00w+o65e0IeWaZiIwt1TPOZSiThfFSIMhrJy5qftgUwlQLGa95MfBfWYIyaimiX5YZZlzQyMb4mqtI6ITlx9XUgh8ltcmFpqydB+jy4CsnDLExu4mQH5eIaoQimj/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898905; c=relaxed/simple;
	bh=Pn9iO5fb1Uyq2JUaftRQXEt+EqpdYbktQYXQ1bfxaiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxO6xjeYqbPYHJmG0oGx8WAI4NMuyB9kTiKlpCXF0WJ4qZhKF6Vd0OtSTAPAblMdOIjCI0Y09yJ1ghtcLmrz+x3DSLbEkXP4sp8kKMey2g+NaYZRKO7xeIVk3yBAkD+PLrHj2Q14QAE3SdG/+HeTi8R/c2WJUTz78AgldAWsOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0UDwCI9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0UDwCI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D55DC4CECF;
	Fri, 29 Nov 2024 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732898904;
	bh=Pn9iO5fb1Uyq2JUaftRQXEt+EqpdYbktQYXQ1bfxaiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0UDwCI9VqCr+CNIHvT6qT0Un3AUy7No8wzmF+b4fRipRYCEoKYG8jLxBKwke52Hu
	 0MPzdteR2npBaN0zdKjXAnCr8xRwPCT6ryO6W6HpIcPnEfNjgW1WSuAclkke7rMIaw
	 cIpA1a8tE1Tf+/NHCWobJC0hfStyur/g7OSxMeMoZMFLfI9Zw/hojrLM6hOexgm5pp
	 nBnC945fowFfK19moYbVIV5mmaOPtBxq4/owXYLK7H0+Ql2dfcWumEPECnjb3o3ekw
	 bPZyc0B1DPAhxXO5RJXv3vK9DMekw47+CGwe8mslPWFPz8DcXvWQ0BIEP1saAowS/y
	 r8D/vqbWeFUOA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] tracing/uprobe: Adopt guard() and scoped_guard()
Date: Sat, 30 Nov 2024 01:48:19 +0900
Message-ID: <173289889911.73724.12457932738419630525.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173289885627.73724.13632317993038475335.stgit@devnote2>
References: <173289885627.73724.13632317993038475335.stgit@devnote2>
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

Use guard() or scoped_guard() in uprobe events for critical sections
rather than discrete lock/unlock pairs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_uprobe.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index b30fc8fcd095..4150ab1d835e 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -496,11 +496,11 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	struct trace_uprobe *old_tu;
 	int ret;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	ret = validate_ref_ctr_offset(tu);
 	if (ret)
-		goto end;
+		return ret;
 
 	/* register as an event */
 	old_tu = find_probe_event(trace_probe_name(&tu->tp),
@@ -509,11 +509,9 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 		if (is_ret_probe(tu) != is_ret_probe(old_tu)) {
 			trace_probe_log_set_index(0);
 			trace_probe_log_err(0, DIFF_PROBE_TYPE);
-			ret = -EEXIST;
-		} else {
-			ret = append_trace_uprobe(tu, old_tu);
+			return -EEXIST;
 		}
-		goto end;
+		return append_trace_uprobe(tu, old_tu);
 	}
 
 	ret = register_uprobe_event(tu);
@@ -523,14 +521,11 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 			trace_probe_log_err(0, EVENT_EXIST);
 		} else
 			pr_warn("Failed to register probe event(%d)\n", ret);
-		goto end;
+		return ret;
 	}
 
 	dyn_event_add(&tu->devent, trace_probe_event_call(&tu->tp));
 
-end:
-	mutex_unlock(&event_mutex);
-
 	return ret;
 }
 

