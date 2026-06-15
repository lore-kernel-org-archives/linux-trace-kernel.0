Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6302224B1E;
	Mon, 15 Jun 2026 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486051; cv=none; b=jsh+hV0U/+MLpokIqdB97rgsh9V6U2eDTH3KUIbKOw5SJ7mn9ZVwSmUwOKsN7yB/fLPVLDpbeJQPmWN+j0CZox4XGyy3e/K/9LDNA9kGW/pqV+j+JRfWwO1jsiS/zx08mdl4EbFv+SappA7apZ9cBquBa3OTFIWsCFjSGWqWK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486051; c=relaxed/simple;
	bh=MzBTi/tHniuupSgZNNgJV6HTE/0IMN1vtSnLhJYNgEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZuTwAni8XoMGsAlgvXqfdbUzS53E0Ifjjm/JxQii2MGHXo8juWlvMjV1Us3duGOKbUrX2//BRfW2YF2CxJgkS9tTmo9ymdO9L6iBFT8SySndma7qV0PZy2AIXZAaBkm0P+MVGMEQN/ZQV50F2LDy/4S4Fpl4+5GSVXVAzy9wZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkCalxZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkCalxZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE8B1F000E9;
	Mon, 15 Jun 2026 01:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781486050;
	bh=cTmALM5v9MF+mL5ZFkPM1vyGeEUBS3mg7wggTL6NLQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VkCalxZg924mIno0xwbs4wmNqDNn27in62cDl1aT6V2ygcz7v/nJTMWniFewu5Bsy
	 vXC24zmWqYyUhkMEphDD1BI6yTviVXz5WDUfdJB00YHKkC4zrX5Jo53A+f9384NI9E
	 3iK4No99eY7VzukJ3cXN+RRVMZ65Z7UeWOc3ypPb4Cyr9u4MHbt4nkpTAZdgHSrrn0
	 Dv+PE4w19ve94ATrO4EozpLfauaPADGWrU0xxwvWo4t+HptpQi/dUZTYpxPQgn7vqB
	 nLJjoVIODc4/tzxV7tEhFMEDxrTPLjvN+2zWa6VOPUzAOcCidRe7cYQpmuXPMorE92
	 GFGpXubcMx4VQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 1/7] tracing/events: Fix to check the simple_tsk_fn creation
Date: Mon, 15 Jun 2026 10:14:06 +0900
Message-ID: <178148604609.185520.8155504015524406945.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178148603548.185520.3389196102475741865.stgit@devnote2>
References: <178148603548.185520.3389196102475741865.stgit@devnote2>
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

Sashiko pointed that this sample code does not correctly handle the
failure of thread creation because kthread_run() can return -errno.

Check the simple_tsk_fn is correctly initialized (created) or not.

Link: https://sashiko.dev/#/patchset/178092865666.163648.10457567771536160909.stgit%40devnote2

Fixes: 9cfe06f8cd5c ("tracing/events: add trace-events-sample")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
   - Fix to remove decrementing counter in error path, since foo_bar_reg() always returns 0.
   - Add a newline to error message.
 Changes in v3:
   - Recover the usage counter.
---
 samples/trace_events/trace-events-sample.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index ecc7db237f2e..0b7a6efdb247 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -107,6 +107,10 @@ int foo_bar_reg(void)
 	 * for consistency sake, we still take the thread_mutex.
 	 */
 	simple_tsk_fn = kthread_run(simple_thread_fn, NULL, "event-sample-fn");
+	if (IS_ERR_OR_NULL(simple_tsk_fn)) {
+		pr_err("Failed to create simple_thread_fn\n");
+		simple_tsk_fn = NULL;
+	}
  out:
 	mutex_unlock(&thread_mutex);
 	return 0;

