Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567D270037;
	Thu, 27 Feb 2025 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617154; cv=none; b=TCOhT50Y/jg7pycFuQUl0bo7VTackpsd83ViEhXbc8Xb9cr5FSZgY9M/1u2Vetoq1/u/IsUNb6I48JuUm7ZeT/IDi9XJ8LoU4o2nd3Q/HwBsuFxBOUM1J5Pw1K9BciW3QeOnqazfG1dz6QrxQNHyaKe6mxi5yQhpaCLStCvkxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617154; c=relaxed/simple;
	bh=bmjGIsxoJW9MtYDnAf/zAnbbN3cgJxABDX6H5mj1kNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A3p2KsnsrthfmqiqsPuP1MrriFINgzo/DnZ/CBRmiaRthlz6q0L2N73kzcRuD590BucdwUnEXPtK428x7/MFf1xJz/0GzYx7osQdTjYFU7Mjuue3kgyhdxM995zqrDUKXI5BSBygQyqPJXliIHU9af+H1dn+dQk4ixYsadSiAbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTSjhBkp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTSjhBkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68025C4CED6;
	Thu, 27 Feb 2025 00:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740617153;
	bh=bmjGIsxoJW9MtYDnAf/zAnbbN3cgJxABDX6H5mj1kNs=;
	h=From:To:Cc:Subject:Date:From;
	b=KTSjhBkp4dI4PahCStErGNnjoU/xFYZCNllz6mP8fV4FVhqcaqUW+BtjIaUrX16cd
	 DMOkJwL6SodjbQ7JQa+CAX8P47lTukwDXcp3Spu3XLQ9GR1hzausWcxPBeIFJO3I2/
	 K5T8zkhK6rOe817iT06gWyHrzii8h+F1kwH9FoBUagOw+RWcPxS5Tp1RFxN42YTANV
	 /zc45XYyjckj+JSRUEQyYLKtGGt4Zjaue8x1eYRAqgwFzS+lJvEV+jgHfnLjARpDmO
	 mMmpi2AqUwiP4txi650pqNEDJVYSyIv2foVYrb3cvplf92oEOx9w81/ajp0O4jBaxN
	 M9hTikH4y5H8Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: probe-events: Add comments about entry data storing code
Date: Thu, 27 Feb 2025 09:45:50 +0900
Message-ID: <174061715004.501424.333819546601401102.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

Add comments about entry data storing code to __store_entry_arg() and
traceprobe_get_entry_data_size(). These are a bit complicated because of
building the entry data storing code and scanning it.

This just add comments, no behavior change.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/20250226102223.586d7119@gandalf.local.home/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 8f58ee1e8858..2eeecb6c95ee 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -770,6 +770,10 @@ static int check_prepare_btf_string_fetch(char *typename,
 
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 
+/*
+ * Add the entry code to store the 'argnum'th parameter and return the offset
+ * in the entry data buffer where the data will be stored.
+ */
 static int __store_entry_arg(struct trace_probe *tp, int argnum)
 {
 	struct probe_entry_arg *earg = tp->entry_arg;
@@ -793,6 +797,20 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
 		tp->entry_arg = earg;
 	}
 
+	/*
+	 * The entry code array is repeating the pair of
+	 * [FETCH_OP_ARG(argnum)][FETCH_OP_ST_EDATA(offset of entry data buffer)]
+	 * and the rest of entries are filled with [FETCH_OP_END].
+	 *
+	 * To reduce the redundant function parameter fetching, we scan the entry
+	 * code array to find the FETCH_OP_ARG which already fetches the 'argnum'
+	 * parameter. If it doesn't match, update 'offset' to find the last
+	 * offset.
+	 * If we find the FETCH_OP_END without matching FETCH_OP_ARG entry, we
+	 * will save the entry with FETCH_OP_ARG and FETCH_OP_ST_EDATA, and
+	 * return data offset so that caller can find the data offset in the entry
+	 * data buffer.
+	 */
 	offset = 0;
 	for (i = 0; i < earg->size - 1; i++) {
 		switch (earg->code[i].op) {
@@ -826,6 +844,16 @@ int traceprobe_get_entry_data_size(struct trace_probe *tp)
 	if (!earg)
 		return 0;
 
+	/*
+	 * earg->code[] array has an operation sequence which is run in
+	 * the entry handler.
+	 * The sequence stopped by FETCH_OP_END and each data stored in
+	 * the entry data buffer by FETCH_OP_ST_EDATA. The FETCH_OP_ST_EDATA
+	 * stores the data at the data buffer + its offset, and all data are
+	 * "unsigned long" size. The offset must be increased when a data is
+	 * stored. Thus we need to find the last FETCH_OP_ST_EDATA in the
+	 * code array.
+	 */
 	for (i = 0; i < earg->size; i++) {
 		switch (earg->code[i].op) {
 		case FETCH_OP_END:

