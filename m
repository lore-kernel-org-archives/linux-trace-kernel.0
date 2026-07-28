Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE53F0A96;
	Tue, 28 Jul 2026 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243002; cv=none; b=XrC86fXzyIbjnkP2EUau8kmrRF3mdGpmpjtqActZyXiqVVoJbupZNuKJFI/1NsBxJ1Pz+cNEz/zdxBC20H+d25PXiROxK6LH4jdS1sOFIjf/eni/XRBLJdcRawPcpHvoiTDWrVnVPy/Nhw20CuoMRZLoerSwW00wT4en5hpgbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243002; c=relaxed/simple;
	bh=2SwRgdQ0V1SjrXbSJJ6Dqk/2FBtQZ75F8VZePlgbyyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNBlk+Kp25ThNi/IAikNFZdz0YEaS5sdGITmvFmqEpO90+jCdIn9BS6BhRGCYwADWLqWyojqNAtsUxb2l0xiIdqxJ8Yecb6zT1hMbxHnPVnoMMgWSJLdN1StEXfHd+pNu2s7oT5x11jDgvK4IYFJOAt7SO1TJsbxdgHNvMnN8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNxlql1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNxlql1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EE91F00A3A;
	Tue, 28 Jul 2026 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785242995;
	bh=B+SkAkO+DZpWHcOFED85ZibUv6VMCkE6Esgv84zpzV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNxlql1ELMjCLY4whD2NKFfCbGuDKemzT62mPnVi5XEqXNas5wz1utgRcGawRGH9f
	 IS67grzadIMGA8QGyHR5vbgGOJ0ABa8HHBUUQ66T4DdyK/66RZ0BhRd6vbDiPlJiNk
	 6B0UTXgPTpyhojhJdyp1bY2eESwIxRx5nu5TLz8sTYOXo3KUlrk1W9wPsubn+XIQKc
	 RXHKKUzJ5ZxqPkenxNO4SnLrd48GN/pdExaasXADgCl+LdKTXfW/8YESvt18nuMO7g
	 goi64TgtY8KiTnBqRYDWG29PbLfapmW19LM8jn76veAr/5TsRtxLL4PjN042wrZEJ/
	 whkFYOpgUx1Rw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Pekka Paalanen <ppaalanen@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/4] tracing/mmiotrace: Reset dropped_count in mmio_reset_data()
Date: Tue, 28 Jul 2026 21:49:51 +0900
Message-ID: <178524299122.56416.16277704230639425172.stgit@devnote2>
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

mmio_reset_data() is called during tracer initialization, reset, and
start. While it resets overrun_detected and prev_overruns, it neglects
to reset dropped_count. Consequently, dropped event counts from prior
tracing sessions persist in dropped_count and corrupt overrun reports
in subsequent runs.

Fix this by explicitly calling atomic_set(&dropped_count, 0) in
mmio_reset_data().

Fixes: 173ed24ee2d6 ("mmiotrace: count events lost due to not recording")
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_mmiotrace.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index b88b8d9923ad..e064ba3f28cb 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -29,6 +29,7 @@ static void mmio_reset_data(struct trace_array *tr)
 {
 	overrun_detected = false;
 	prev_overruns = 0;
+	atomic_set(&dropped_count, 0);
 
 	tracing_reset_online_cpus(&tr->array_buffer);
 }

