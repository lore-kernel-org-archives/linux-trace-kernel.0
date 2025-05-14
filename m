Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BD1DB363;
	Wed, 14 May 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206262; cv=none; b=nRfVJj7BQE0pfZcNDa+QVM2trAQ+Uy2aI9rUzsEdpdcCMAqmfgVPT184LSEia4+p3AO5Ipiv06nWKAAbd8icXlCzg65HyhB2FmAVnxm4AEYMNZZiqr1qic+s/chXClo7TtQTc3EgkoBjiHJGAvQJRyNLKjRyQDH6KyR0uj2SJX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206262; c=relaxed/simple;
	bh=JrCt+r+RqHKIYDpTXrLwU7/OFpnQPQqybe9N6BMUzcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o8Upy0HSQCBX/xSDle0bAsRnfaD8Qb1bVuKG8LmJeo9jNboCEDoP2Tx4J1sQBtQSucyr1oz35ouFw2SLIEosPEtZpi3Opcft/Q0WyialXxrhtA+cykDyyFAUzBfbiVT5R10Ap6Cun5FNqcfdNEG4w3vs0oGIGl7TYouZ9M5kBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJkmEZ9x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJkmEZ9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9D3C4CEE9;
	Wed, 14 May 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747206261;
	bh=JrCt+r+RqHKIYDpTXrLwU7/OFpnQPQqybe9N6BMUzcs=;
	h=From:To:Cc:Subject:Date:From;
	b=TJkmEZ9x6vfxipyn8hku7dqjgn4haWIKA9yn8XQ1ke6VzK2Dzux6XaWyzQlKkEZdG
	 xSC/mRg8bSOjcFdgqhFNSeGeMRcqbM65c8GxzvWPX4pDHiCnBbncvKLFksroLMDVj4
	 NTHcuVi/1EqEId198KGQuURjpRkVGiBpHKS+i4JM/zPIJP8U7q9NzvMEE4QTOZXUv1
	 QlgNOYm9XZZDGSPmjfC1Xf+PKpj1oPGr255f5/XokqQ9f6czUmJpsqVNLEKYPrjVi+
	 DNo2rACAOybzKhyhhlKvIK1XexaT1TK2geSSWErhk9wbOVcOWqU+37wG49Z/wJdsw3
	 eDmx8EK8JCyeQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4] tracing: Record trace_clock and recover when reboot
Date: Wed, 14 May 2025 16:04:18 +0900
Message-ID:  <174720625803.1925039.1815089037443798944.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v4:
   - Use unsigned int instead of int for clock_id.
   - Check trace_scratch::clock_id is sane.
 Changes in v3:
   - Save clock_id instead of its name.
 Changes in v2:
   - instead of exposing it via last_boot_info, set the current
     trace_clock as the same clock we used in the last boot.
---
 kernel/trace/trace.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index cf51c30b137f..2c1764ed87b0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6066,6 +6066,7 @@ struct trace_mod_entry {
 };
 
 struct trace_scratch {
+	unsigned int		clock_id;
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
@@ -9628,6 +9636,15 @@ static void setup_trace_scratch(struct trace_array *tr,
 
 	/* Scan modules to make text delta for modules. */
 	module_for_each_mod(make_mod_delta, tr);
+
+	/* Set trace_clock as the same of the previous boot. */
+	if (tscratch->clock_id != tr->clock_id) {
+		if (tscratch->clock_id >= ARRAY_SIZE(trace_clocks) ||
+		    tracing_set_clock(tr, trace_clocks[tscratch->clock_id].name) < 0) {
+			pr_info("the previous trace_clock info is not valid.");
+			goto reset;
+		}
+	}
 	return;
  reset:
 	/* Invalid trace modules */

