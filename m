Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6C1CEAC3;
	Tue, 28 Jan 2025 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078631; cv=none; b=spKxj/irf/v3Wrh23GUzwo6PvlZmdQkivd9KSyDvYYjdwxh3hlARcn58GvpVJhiMrpZYkodXkL2sHKDbiaKrbRTInvnHHQE2PaArTdJcPwtYrKjuDGyj3zV7UOynP+6Tt2o936DEl3LuJ3Tb9A20rhVvkp9KB6CdTF4QjXWJd8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078631; c=relaxed/simple;
	bh=gBCuCf3DrjmvjehQDKAvnh/dqTCGqU4f0+ykGJSM5Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWCAaoYPh1/wHcfaNzTEQ/Blse594M5htQgtdKDtN0v+pxC8DTWzgrpTeWmUEcjvvkaZEI4w2jLY5HYKbVxtANHcpV+nB9qurrNfg9xdCtWrDGD5NdFLspLOCrLdvROcuhaHTSJFu862Rfuu2mVHfGTbzrZX1x/i0feXDIVx8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzPbybVO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzPbybVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54655C4CEDF;
	Tue, 28 Jan 2025 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738078630;
	bh=gBCuCf3DrjmvjehQDKAvnh/dqTCGqU4f0+ykGJSM5Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzPbybVOjTrmOiaVYAog9dNQf7mq/btHKHNeEVi5/Tg8iuqkQT8AHRgQX/ariMydD
	 UFiGAxHOyIbOPEYZ9MizQNg909q+1HVCgWz+hQgBdVNZeNv8T7UsFcOmp+6ueZx+fI
	 D0LJH5a422KYPsUQj64ihfwGJTpuv37esajqSyL3Sn0tKGXrLlPd0DfoswunLFrRS3
	 4Y1eX987Q/L04AI6ge+C4LKhBmZMunRhgCpiTiIMs9VC2OG1axsG6a/Bu/3R3wQjJB
	 mZaGgUu0CWZn/ydlpkmn4INC6mAnKt5DqRfRuct5exiwckPiloeHsKTlnjk+qALy/G
	 CaKjmFUFDFCWQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [RFC PATCH 1/3] tracing: Record stacktrace as the offset from _stext
Date: Wed, 29 Jan 2025 00:37:06 +0900
Message-ID:  <173807862643.1525539.5494079998018402469.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
In-Reply-To:  <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
References:  <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
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

Record kernel stacktrace as the offset from _stext so that it does
not affected by KASLR.

For the persistent ring buffer, decoding the stacktrace entries
requires kallsyms in the previous boot because the kernel symbols
will have random offset for each boot by KASLR. But this is not
useful because we always need to save the kallsyms. Alternatively,
we can record the stacktrace entries as the offset value from
_stext. In this case, we can use System.map or nm for the vmlinux
to decode the entries.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c        |    6 ++++++
 kernel/trace/trace_output.c |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1496a5ac33ae..8e86a43b368c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2973,8 +2973,14 @@ static void __ftrace_trace_stack(struct trace_array *tr,
 		for (int i = 0; i < nr_entries; i++) {
 			if (calls[i] >= tramp_start && calls[i] < tramp_end)
 				calls[i] = FTRACE_TRAMPOLINE_MARKER;
+			else
+				calls[i] -= (unsigned long)_stext;
 		}
 	}
+#else
+	/* Adjsut entries as the offset from _stext, instead of raw address. */
+	for (int i = 0; i < nr_entries; i++)
+		fstack->calls[i] -= (unsigned long)_stext;
 #endif
 
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 03d56f711ad1..497872df48f6 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1248,7 +1248,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	unsigned long *p;
 	unsigned long *end;
-	long delta = iter->tr->text_delta;
+	long delta = (unsigned long)_stext + iter->tr->text_delta;
 
 	trace_assign_type(field, iter->ent);
 	end = (unsigned long *)((long)iter->ent + iter->ent_size);

