Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9917BD3;
	Tue, 13 May 2025 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096291; cv=none; b=HY40r4GlpHsKrOHS+tDltwql9g6d6UbGd7ntaIolXlSiyu+drk365rTLxNva3xO2w7MzhMKeZG86EUguozrOL2RXAj4iAun8CMQMrIAN60vu28dfwlJjJvR2ljs60f5t6TJyIgEbUhYqqzlHATXGeBMESobTBS6qxd8tZzftAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096291; c=relaxed/simple;
	bh=+Hq+ketVyMdmLh+sSRo9Ay4BPKRDvQymZuzWWELLjv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GoRqHyPfTcT09SAf7zgPy+KYraTVpyEZV6JaWw4NJ3UMNEnIeecShsHWnH2qf1vITeedAhQMCJ5NGHoAgakYCLNZBe/mLhTE2TJMqQizGICqQHUNmhwO7QuT0Nr5GolSRxVUsQm8/jawhddexZM9AL1cqR8M3HVGN7HfBfn/RCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHTao9v/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHTao9v/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FABC4CEE7;
	Tue, 13 May 2025 00:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747096291;
	bh=+Hq+ketVyMdmLh+sSRo9Ay4BPKRDvQymZuzWWELLjv0=;
	h=From:To:Cc:Subject:Date:From;
	b=cHTao9v/sBA4EfKApS85CQfK0e4Hd98OtZmXUpQqZUfDwV6d8Fvzjho5XJ6JjJKC4
	 k9jLHgF3Ob92w9Z5l654vWp6PpyurovA4uERrNGsiapRVS5ka2v3PW7qaAYfF6HOgY
	 Do3ruPe2HdnTIYYiXVZ9Lbcs/6vNgd4sGW0sWf2cMlKgwIG2t2nyUvGQqFKTtYFKPA
	 UzqZEfujgF4GAeOKIaT+A/kR8NNXgr8297iIOe/oeJQn/9E+OaJ23kscWOkp7uJR17
	 /VgtKBxLgWKUq3d/pcpI9UhyLyn8Lw/UUEvv5xWZHJQQvllqjcEw2WF+ErokPRQSaJ
	 kxPWuDGtkWTdQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] tracing: Record trace_clock and recover when reboot
Date: Tue, 13 May 2025 09:31:27 +0900
Message-ID:  <174709628747.1945884.11884057542151507891.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
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

Record trace_clock information in the trace_scratch area and recover
the trace_clock when boot, so that reader can docode the timestamp
correctly.
Note that since most trace_clocks records the timestamp in nano-
seconds, this is not a bug. But some trace_clock, like counter and
tsc will record the counter value. Only for those trace_clock user
needs this information.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
   - Save clock_id instead of its name.
 Changes in v2:
   - instead of exposing it via last_boot_info, set the current
     trace_clock as the same clock we used in the last boot.
---
 kernel/trace/trace.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index cf51c30b137f..2a060c62d686 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6066,6 +6066,7 @@ struct trace_mod_entry {
 };
 
 struct trace_scratch {
+	int			clock_id;
 	unsigned long		text_addr;
 	unsigned long		nr_entries;
 	struct trace_mod_entry	entries[];
@@ -6181,6 +6182,7 @@ static void update_last_data(struct trace_array *tr)
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
 
+		tscratch->clock_id = tr->clock_id;
 		memset(tscratch->entries, 0,
 		       flex_array_size(tscratch, entries, tscratch->nr_entries));
 		tscratch->nr_entries = 0;
@@ -7403,6 +7405,12 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
 
+	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
+		struct trace_scratch *tscratch = tr->scratch;
+
+		tscratch->clock_id = i;
+	}
+
 	mutex_unlock(&trace_types_lock);
 
 	return 0;
@@ -9628,6 +9636,14 @@ static void setup_trace_scratch(struct trace_array *tr,
 
 	/* Scan modules to make text delta for modules. */
 	module_for_each_mod(make_mod_delta, tr);
+
+	/* Set trace_clock as the same of the previous boot. */
+	if (tscratch->clock_id != tr->clock_id) {
+		if (tracing_set_clock(tr, trace_clocks[tscratch->clock_id].name) < 0) {
+			pr_info("the previous trace_clock info is not valid.");
+			goto reset;
+		}
+	}
 	return;
  reset:
 	/* Invalid trace modules */

