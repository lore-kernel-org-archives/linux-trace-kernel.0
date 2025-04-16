Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914B1C7013;
	Wed, 16 Apr 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814802; cv=none; b=K5N5riDExAIIPBZHc98jMgE+nkauLzrdCAK689U0XEii+x8NMj8P/HBSeoG7sxi3a0LV8omLm/vgjI1IyNd6HIcLmgjjHxeDfX7tVEpkr1hDQtd60I377EY5TllP7yo8OyKjA6Q1hYBeCDRS9T0Bh2KgkGsF6olnbvMDiulh7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814802; c=relaxed/simple;
	bh=XQhJCYea51/Ij9z+SrGCJlW4RYjtXZv2oRK2Iig+0pI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GHUMtO4aK4mweP9cRHQE0+FbFxc4xvsvwNwduNsuAu23TgGVHrXOq3EYol92c0epV3D2UjkQjAdkxpRjs980+hmAZXOgi0318grtyR68LStrLi1gqC2x1jtaOY9/F5UTd7paMGUzL7Wo2aLQDehRpnZdZa3+qg2tZJpPPQ3iPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1YL4PBW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1YL4PBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FF7C4CEE2;
	Wed, 16 Apr 2025 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744814801;
	bh=XQhJCYea51/Ij9z+SrGCJlW4RYjtXZv2oRK2Iig+0pI=;
	h=From:To:Cc:Subject:Date:From;
	b=s1YL4PBW65rfe4XSXGzeUP2OVT007Utw2GHx3jgjRdiSUcsNlmKRGzk5BhBirR9C3
	 IG3DSTE1pDqsRBL2Re4MeUXZLXrlYQZ2gnDK9/ZTDNCiOYlrKJLIooabpnYnveeYTm
	 66uqc8PG3ZsrXYYWmDJcRQk/tWPE7YUHLRPSb6wmuvkEV5n7IypLKN+7CN1F3w00b2
	 dl1q1T4OpujFFWdvPD4dJLNy5CrAzI5LL1oFB8+5nFi5TUJN/7WOT2r65dFqOlSfWq
	 4F4UaYduW/BlaWn8PaSaN3G7vPww/jXhrnMiOQ3KB2YwP0Hq8Iu2TXIYrcWS6SerFf
	 YYl6Xsmi+Q7fA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Record trace_clock in last_boot_info
Date: Wed, 16 Apr 2025 23:46:38 +0900
Message-ID:  <174481479787.2426861.10924329074660376176.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
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

Record trace_clock information in the trace_scratch area and show
it via `last_boot_info` so that reader can docode the timestamp
correctly.
With this change, the first line of the last_boot_info becomes
trace_clock which is used when the trace was recorded. E.g.

/sys/kernel/tracing/instances/boot_mapped # cat last_boot_info
trace_clock: mono
ffffffff81000000        [kernel]

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/trace_clock.h |    2 ++
 kernel/trace/trace.c        |   14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

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
index 8ddf6b17215c..e59826fa4cb3 100644
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
@@ -7000,9 +7003,10 @@ static void show_last_boot_header(struct seq_file *m, struct trace_array *tr)
 	 * Otherwise it shows the KASLR address from the previous boot which
 	 * should not be the same as the current boot.
 	 */
-	if (tscratch && (tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+	if (tscratch && (tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
+		seq_printf(m, "trace_clock: %s\n", tscratch->clock);
 		seq_printf(m, "%lx\t[kernel]\n", tscratch->text_addr);
-	else
+	} else
 		seq_puts(m, "# Current\n");
 }
 
@@ -7289,6 +7293,12 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
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

