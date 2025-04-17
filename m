Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0DA94A;
	Thu, 17 Apr 2025 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744867053; cv=none; b=JB5HbDTEk6mzI+xMue2xHUWEhM+vYIvrO4Kxg3xm534cwkUmKFkZRvNIexoGetprqKR7xrj5nXuChQW6ZlHCKqNdUgBlKvXuBBNAWsTRS1aUigoWfcJdKZJKh687Mg0jBOxwk37kRr1YfosJIeAPWhu0hj1Jbow91YQTxw07rOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744867053; c=relaxed/simple;
	bh=6EgLG4gGOWWwoixoJY8+Na03ZmFU57CDaO0m9BfGgV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=czvXSUi1qNO5DEzJ8Cw4jLLgN7HqXSH743+lL6VvzQ5EJtB/t2IZf2O5E/Z+qBQs7Xx86NfSWkReZzPAPTPVtkRf32GE1dzGOTWzzclzYU9KKo8OlHeAFEOzphwOLZq9Vw6wBwdFco6aoYN1c1m46H6kACMkEwxaEs7qxxQ5t68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXjS/Tsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXjS/Tsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA7CC4CEE7;
	Thu, 17 Apr 2025 05:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744867053;
	bh=6EgLG4gGOWWwoixoJY8+Na03ZmFU57CDaO0m9BfGgV0=;
	h=From:To:Cc:Subject:Date:From;
	b=hXjS/Tsu1IvtdZEHvu8TmVrAsXFEuQVk4fMFoefDfUD/nzpO3lPdbnsNnCKFJlxdF
	 1w40F759jSMvC58vkprQcGOy6tZLKmqL2Su/1XPNiFXEGoRMflm6ypGrmiYRMAc2Cv
	 LZAPAnkD+5Niv8Xmitvym96CtJgVXZEWLzHyTwXlipm0h+G1FfmuEubzDQufAI7L+R
	 5AFna/DFZbJ23eDwKbZd2sAkqrv8oP7VzVAQYP8wp3sp7ls4AZTTu58ps7UbikReri
	 uM+jyVUXTsIO/OHF9d5qalRVwabOq+DevdY0Ox0yxh1BwqDbWGAcT7J2oh9EOMFgQ5
	 3fMl09dZu45NQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Record trace_clock and recover when reboot
Date: Thu, 17 Apr 2025 14:17:29 +0900
Message-ID:  <174486704950.3973933.810283141514120282.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
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
 Changes in v2:
   - instead of exposing it via last_boot_info, set the current
     trace_clock as the same clock we used in the last boot.
---
 include/linux/trace_clock.h |    2 ++
 kernel/trace/trace.c        |   17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/trace_clock.h b/include/linux/trace_clock.h
index 00e8f98c940f..2245848270d2 100644
--- a/include/linux/trace_clock.h
+++ b/include/linux/trace_clock.h
@@ -15,6 +15,8 @@
 
 #include <asm/trace_clock.h>
 
+#define TRACE_CLOCK_NAME_MAX 16
+
 extern u64 notrace trace_clock_local(void);
 extern u64 notrace trace_clock(void);
 extern u64 notrace trace_clock_jiffies(void);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ddf6b17215c..6ce5d05ec64d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6004,6 +6004,7 @@ struct trace_mod_entry {
 };
 
 struct trace_scratch {
+	char			clock[TRACE_CLOCK_NAME_MAX];
 	unsigned long		text_addr;
 	unsigned long		nr_entries;
 	struct trace_mod_entry	entries[];
@@ -6114,6 +6115,8 @@ static void update_last_data(struct trace_array *tr)
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
 
+		strscpy(tscratch->clock, trace_clocks[tr->clock_id].name,
+			TRACE_CLOCK_NAME_MAX);
 		memset(tscratch->entries, 0,
 		       flex_array_size(tscratch, entries, tscratch->nr_entries));
 		tscratch->nr_entries = 0;
@@ -7289,6 +7292,12 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
 
+	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
+		struct trace_scratch *tscratch = tr->scratch;
+
+		strscpy(tscratch->clock, trace_clocks[i].name, TRACE_CLOCK_NAME_MAX);
+	}
+
 	mutex_unlock(&trace_types_lock);
 
 	return 0;
@@ -9514,6 +9523,14 @@ static void setup_trace_scratch(struct trace_array *tr,
 
 	/* Scan modules to make text delta for modules. */
 	module_for_each_mod(make_mod_delta, tr);
+
+	/* Set trace_clock as the same of the previous boot. */
+	if (tscratch->clock[0]) {
+		if (tracing_set_clock(tr, tscratch->clock) < 0) {
+			pr_info("the previous trace_clock info is not valid.");
+			goto reset;
+		}
+	}
 	return;
  reset:
 	/* Invalid trace modules */

