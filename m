Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255B3AA9F8;
	Tue, 28 Jul 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243028; cv=none; b=A5Yg9Noy7aOC/F27AAariWo+WqJVpuCsLSgwBsuUklnWjUmqAFpEKBKVdbR+3JAJLOjo9zO/Zm8p+uGWft+nZ+RLFfeONrFKEe7HijpX6KI33JHs8DH/DlONfTT/VFX7qfUGjVqvo3md18JxX6LjBhnnaQuGx7u8SmhuPi/rAa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243028; c=relaxed/simple;
	bh=O379y4zuXFDdurM2AZ+6nkATCcVSpTV+SbbmqtKTCOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/jltS/xrdtAOAUx0zFWV+knmJJLwH0ORu0+1H/km0LFOzRdAuEY3kseeFiMUSTZFUMfpfJPDBG/LIj/kp8WdTcIdslVla45T8ROBChHN0P8EW+i07MTSEvDZyhA6zh8b0Mg09G0P4IJiLa+8wPiUe4IAP4pIbc4vjOoc4MmpoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LemkiApK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LemkiApK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27581F000E9;
	Tue, 28 Jul 2026 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785243023;
	bh=tjW8QunB0TqlXecPQTXyLsyQo5KDdpsYt4sg9qwmSmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LemkiApKfrT0JnkAQ8CTu0dd5grdSK7YQVb5yRF3ZxyrTUeuTzp2tBtcx+44LsFhY
	 YoOVI1XvI30IHe2etaunk6uPl9QxxeWSRl43XPhsFy+Xu95Yt2wdHCDlJ6BZviQZ8D
	 Qo/DJ37jKr0TzwQDuXyKl0v9BtuWv/ubWWiNbzwWylXC0LbT9fILQ6BZCDxr40Ab88
	 pOCxAaE1S4duueil1rerjUErh0GF401LgQs9X724WpA69xPBCOZsNXREu+fXZsHtib
	 6PZYTBzy2IhycLbYgg1+HwDaOxkQMxebAv8kvddACFS8jCeZpNQXd1uQAPBPvdqpFL
	 YaaqsRd0f8KLQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Pekka Paalanen <ppaalanen@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/4] tracing/mmiotrace: Clean up coding style and redundant debug logs
Date: Tue, 28 Jul 2026 21:50:19 +0900
Message-ID: <178524301945.56416.2087305624947649637.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178524298182.56416.7520852015178187644.stgit@devnote2>
References: <178524298182.56416.7520852015178187644.stgit@devnote2>
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

Clean up coding style issues in trace_mmiotrace.c:
- Remove redundant pr_debug() entries in tracer callbacks.
- Fix opening brace placement for mmio_tracer.
- Prefer 'unsigned int' to bare 'unsigned'.
- Add missing blank lines after local variable declarations.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_mmiotrace.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 77120d467e11..ce16e1c53d12 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -36,7 +36,6 @@ static void mmio_reset_data(struct trace_array *tr)
 
 static int mmio_trace_init(struct trace_array *tr)
 {
-	pr_debug("in %s\n", __func__);
 	mmio_trace_array = tr;
 
 	mmio_reset_data(tr);
@@ -46,8 +45,6 @@ static int mmio_trace_init(struct trace_array *tr)
 
 static void mmio_trace_reset(struct trace_array *tr)
 {
-	pr_debug("in %s\n", __func__);
-
 	disable_mmiotrace();
 	mmio_reset_data(tr);
 	mmio_trace_array = NULL;
@@ -55,7 +52,6 @@ static void mmio_trace_reset(struct trace_array *tr)
 
 static void mmio_trace_start(struct trace_array *tr)
 {
-	pr_debug("in %s\n", __func__);
 	mmio_reset_data(tr);
 }
 
@@ -113,6 +109,7 @@ static void mmio_pipe_open(struct trace_iterator *iter)
 static void mmio_close(struct trace_iterator *iter)
 {
 	struct header_iter *hiter = iter->private;
+
 	destroy_header_iter(hiter);
 	iter->private = NULL;
 }
@@ -170,7 +167,7 @@ static enum print_line_t mmio_print_rw(struct trace_iterator *iter)
 	struct trace_seq *s	= &iter->seq;
 	unsigned long long t	= ns2usecs(iter->ts);
 	unsigned long usec_rem	= do_div(t, USEC_PER_SEC);
-	unsigned secs		= (unsigned long)t;
+	unsigned int secs	= (unsigned long)t;
 
 	trace_assign_type(field, entry);
 	rw = &field->rw;
@@ -215,7 +212,7 @@ static enum print_line_t mmio_print_map(struct trace_iterator *iter)
 	struct trace_seq *s	= &iter->seq;
 	unsigned long long t	= ns2usecs(iter->ts);
 	unsigned long usec_rem	= do_div(t, USEC_PER_SEC);
-	unsigned secs		= (unsigned long)t;
+	unsigned int secs	= (unsigned long)t;
 
 	trace_assign_type(field, entry);
 	m = &field->map;
@@ -249,7 +246,7 @@ static enum print_line_t mmio_print_mark(struct trace_iterator *iter)
 	struct trace_seq *s	= &iter->seq;
 	unsigned long long t	= ns2usecs(iter->ts);
 	unsigned long usec_rem	= do_div(t, USEC_PER_SEC);
-	unsigned secs		= (unsigned long)t;
+	unsigned int secs	= (unsigned long)t;
 
 	trace_assign_type(print, entry);
 	msg = print->buf;
@@ -274,8 +271,7 @@ static enum print_line_t mmio_print_line(struct trace_iterator *iter)
 	}
 }
 
-static struct tracer mmio_tracer __read_mostly =
-{
+static struct tracer mmio_tracer __read_mostly = {
 	.name		= "mmiotrace",
 	.init		= mmio_trace_init,
 	.reset		= mmio_trace_reset,
@@ -322,6 +318,7 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 void mmio_trace_rw(struct mmiotrace_rw *rw)
 {
 	struct trace_array *tr = mmio_trace_array;
+
 	__trace_mmiotrace_rw(tr, rw);
 }
 
@@ -353,6 +350,7 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
 void mmio_trace_mapping(struct mmiotrace_map *map)
 {
 	struct trace_array *tr = mmio_trace_array;
+
 	__trace_mmiotrace_map(tr, map);
 }
 

