Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4111E87B;
	Mon, 31 Mar 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435340; cv=none; b=r+vMl6xzri5+Afz4eVLhLMHJqpVjl7rNpFtpgnBvLprS5FukKYu/pBkk1IbkIbRVIUBL5KKrn7pSW/0jJtODup/sOh5/DqYTFGyiKbHNpKRILiZwl1LaoSeLXIqpVBvCyrce6mA1vFNAIxazYv8YkeN+3cOGrONWhNLk3YXg0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435340; c=relaxed/simple;
	bh=XfxUmWlDoXAenKpS0CquwXTLrNbsbqfRSmcog6/7CvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAZvPK/CC6MTYEea7Bk8fOSw1EAB3x4J1mY7hybwO6UxLtfnfDoNgnrkG7O8VvCnSlB2FU6jiIYlphvUEZ1WFsRu6muW3oouk7xcX8deNNS5+KluuIYQTIKDPyHULf+h5Be1mQSjrNGwDZS9GVKMtYNJQM/peCBgVBoM4QljgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbBFnhx7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbBFnhx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD07C4CEE3;
	Mon, 31 Mar 2025 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743435339;
	bh=XfxUmWlDoXAenKpS0CquwXTLrNbsbqfRSmcog6/7CvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbBFnhx7RU1dsjDDTXm6RfyBot0/Tl0E+NcECfT+04AArRxNETUcyzCOhhebhkySN
	 FGMePSypqVb2U3dGIP06TACMS3wWR9eNK4ZVXio+BgwyAvRkSBdKz9QVBD/Kkic3Kv
	 BzOL+0rhxnGDTbMhlMEQOx+V0Blkdnt1Y+8pxaclFpW+3a6Tq9AiJ+j5HvVCIYxTFZ
	 N2/ZPuKulKvL9Hb2ZvsA9n891YzIb6CpzSnnVecbcmYSK3kodMeEoaKanw36QWMGzw
	 Yln1Sw6UW1uW5r2hE9ep2NT3QIfcd72H2oxaUpwJkrL7yN3HjxhvxBf06PFvDIfJeN
	 FTlgCHGwvFTvA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] tracing: fprobe events: Fix possible UAF on modules
Date: Tue,  1 Apr 2025 00:35:36 +0900
Message-ID: <174343533593.843280.8788277038071990492.stgit@devnote2>
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

Commit ac91052f0ae5 ("tracing: tprobe-events: Fix leakage of module
refcount") moved try_module_get() from __find_tracepoint_module_cb()
to find_tracepoint() caller, but that introduced a possible UAF
because the module can be unloaded before try_module_get(). In this
case, the module object should be freed too. Thus, try_module_get()
does not only fail but may access to the freed object.

To avoid that, try_module_get() in __find_tracepoint_module_cb()
again.

Fixes: ac91052f0ae5 ("tracing: tprobe-events: Fix leakage of module refcount")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 985ff98272da..2cd9ff1049f1 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -919,9 +919,15 @@ static void __find_tracepoint_module_cb(struct tracepoint *tp, struct module *mo
 	struct __find_tracepoint_cb_data *data = priv;
 
 	if (!data->tpoint && !strcmp(data->tp_name, tp->name)) {
-		data->tpoint = tp;
-		if (!data->mod)
+		/* If module is not specified, try getting module refcount. */
+		if (!data->mod && mod) {
+			/* If failed to get refcount, ignore this tracepoint. */
+			if (!try_module_get(mod))
+				return;
+
 			data->mod = mod;
+		}
+		data->tpoint = tp;
 	}
 }
 
@@ -933,7 +939,11 @@ static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
 		data->tpoint = tp;
 }
 
-/* Find a tracepoint from kernel and module. */
+/*
+ * Find a tracepoint from kernel and module. If the tracepoint is on the module,
+ * the module's refcount is incremented and returned as *@tp_mod. Thus, if it is
+ * not NULL, caller must call module_put(*tp_mod) after used the tracepoint.
+ */
 static struct tracepoint *find_tracepoint(const char *tp_name,
 					  struct module **tp_mod)
 {
@@ -962,7 +972,10 @@ static void reenable_trace_fprobe(struct trace_fprobe *tf)
 	}
 }
 
-/* Find a tracepoint from specified module. */
+/*
+ * Find a tracepoint from specified module. In this case, this does not get the
+ * module's refcount. The caller must ensure the module is not freed.
+ */
 static struct tracepoint *find_tracepoint_in_module(struct module *mod,
 						    const char *tp_name)
 {
@@ -1169,11 +1182,6 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	if (is_tracepoint) {
 		ctx->flags |= TPARG_FL_TPOINT;
 		tpoint = find_tracepoint(symbol, &tp_mod);
-		/* lock module until register this tprobe. */
-		if (tp_mod && !try_module_get(tp_mod)) {
-			tpoint = NULL;
-			tp_mod = NULL;
-		}
 		if (tpoint) {
 			ctx->funcname = kallsyms_lookup(
 				(unsigned long)tpoint->probestub,

