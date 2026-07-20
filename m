Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092B3DBD47;
	Mon, 20 Jul 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544241; cv=none; b=jt32TNabSzppiOnGd1H7XA4zA40VRwoJJ4cVMsygA2Or90buJLkQd+1LOynndahrR4iQmp724QC8UXpGPyaO4IH7jhyR6J0CF/ySyBP5BZ5uBZac8z48wPw/zUJLcP9bqyx8S3J76zU7SMPpzOdxydeF3BmRStlqkg1q2Nzdqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544241; c=relaxed/simple;
	bh=7iwhT+OMjeqlBnHKCtI3TLdB7erI40oggHs3AYxmGNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8n5rQVL0GEJMQxZ9DJEUD6UNagSjJ/rMTc4AnkT9Ez4uI1pCZqOzASObex25GbhtEPkOjyq67QUt25Vp0pSP95QWXPPYoXg+1Qf5ZTkAj3cMhvgsWHej7uQLaaime7VK/ySmaVxzh4mPfYblYXegM9QkOAIZhpcSLKji0eG2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWhjOrCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWhjOrCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDDA1F000E9;
	Mon, 20 Jul 2026 10:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544232;
	bh=r54JjzfEk9czsuC0MJryDnII5W8oRT9GKoRXZth4XIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kWhjOrCEyXZHKrqN1a5C2G/c0EgUL4T1hNiiumxcpdkUKMhNu5fxnfl/rTgS6pZEQ
	 brQsUL99Kx48b6bWhJKLZNkfzoWbRJtr31iPwWh6PJr9fQ+v9iOEQ78EF8GdJeb5V/
	 o1tFU9c4KllytmYJLUZC1Yf8tbq4t2S4OABjEZsNsuZbmcEt6VZUlXAKPa9V27tite
	 LYBQ6IDBR60LcJ319CLdlbSGa1B9lXdQV+HiL1O1Rwrkvlq6hv4/Vr7y4bCHzH3VTT
	 YCuOYFLqMPq2ifNvNlFicsxsGTt331ljzlPCD3uQ2BWiLasd1tQ1DAUPNCuJ21QQZ6
	 +wtbOg9qpbzGQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 02/10] tracing/probes: Remove redundant boolean conversion in trace_probe_has_single_file()
Date: Mon, 20 Jul 2026 19:43:48 +0900
Message-ID: <178454422826.296567.4382363406595169533.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454420994.296567.10239174745865301350.stgit@devnote2>
References: <178454420994.296567.10239174745865301350.stgit@devnote2>
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

list_is_singular() returns a boolean value, so the double negation (!!)
in trace_probe_has_single_file() is redundant. Remove it.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index b3571c85abb1..c0f05763811c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -360,7 +360,7 @@ static inline int trace_probe_unregister_event_call(struct trace_probe *tp)
 
 static inline bool trace_probe_has_single_file(struct trace_probe *tp)
 {
-	return !!list_is_singular(&tp->event->files);
+	return list_is_singular(&tp->event->files);
 }
 
 int trace_probe_init(struct trace_probe *tp, const char *event,

