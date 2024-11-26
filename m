Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E501D4613;
	Tue, 26 Nov 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629416; cv=none; b=D+eQrz55xxfVjIKCLS1C2Eb7xApcdvp+0oVw+Muy0an2XkfwPK+s2C2ifc4pKX5jwSL3SdSojUiKlmn6x5ba48p/eBb74VSVeKkd9aJP5ki86Ft8lFfeIRM6P9Bl9KTqxyZNWFDo9HH2igQsUx1FVkbUlgorX6GQ94hTCt9pqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629416; c=relaxed/simple;
	bh=Pn9iO5fb1Uyq2JUaftRQXEt+EqpdYbktQYXQ1bfxaiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ba2J1UFeCCUPpmRoQalf3skxy5AHBoIFEKsnosihevqybnZcx2uNcLiMaqO0I7rwTZLzPfDyVm2n0Q050j9sU584psK4G9dQdy7N592kOxtrYwWQNxBhmMtO0Sj5WSZt8DELaxgrWf5wsGLSfKEtI6NI4Dw1k6NuhxJoj1XrPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGfOOHts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGfOOHts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3872EC4CED3;
	Tue, 26 Nov 2024 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732629416;
	bh=Pn9iO5fb1Uyq2JUaftRQXEt+EqpdYbktQYXQ1bfxaiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGfOOHtskP+wR5lmWMexanxMyACbyMDT4ogD8E5v3MhKRlhSmirarYNA3yFvZ4xn9
	 O/rTni3yMcjjYFaPC4k9FemSFT5vfW82HdIaY1pJYhfoxHOmHJoyAKIG/+tzQh0j4y
	 uRxs3vEPDY0sDySPWG9uVPxBeXjUSroKxmSx2geTUM/me9/oDLT05ZYi2ueWUb2X6b
	 bCs1BldeUWrvS0Jj/9HkpoNpyXQ57e/9dkrWjh5vQ6BIPMo2ggyXS3U+QEWBQHIk2D
	 HlrdDso2NAlIvOQTVAr7SWbd0oZwSOQgY6Wqe72+WAtys+vG6H4mtAS2JC9284/UOX
	 tBMkOxfjXPr7g==
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
Subject: [PATCH 4/6] tracing/uprobe: Adopt guard() and scoped_guard()
Date: Tue, 26 Nov 2024 22:56:52 +0900
Message-ID: <173262941192.8323.4556929679568313448.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173262937038.8323.5774362855789721936.stgit@devnote2>
References: <173262937038.8323.5774362855789721936.stgit@devnote2>
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
 

