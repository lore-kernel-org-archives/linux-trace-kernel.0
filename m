Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3CF1D5CE5;
	Wed, 23 Jul 2025 01:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234310; cv=none; b=hmXrStma4e2E85pA3exvajdBg0Wcuv4mXOuVwdyUXpgt+nMGEL6tAuZJ13U53OU/hk25YpEqSlG/ma8JhxyhTQvayU/c28cwVcLctPI4f8bok0bTF25Hmybs+kwL7qLba6qweg4cDh46X6e4q2DRgLVh1BXTFWqGEXMKmJI2uUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234310; c=relaxed/simple;
	bh=0o/Q+PhjU0nIVPGyd9F9Kvrv+SnISOZztWOthtpvPKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSNrjj3Gkvd+EwwfYbI8gBV3QSgdiYcJlCAPJx5PFEHDRSZ+A5s4/LZtCXuUtovaeQwte8Mt4Lm8R+/OrQOkuGmrnAOztyJ2AAA0Css/4ecpsUW/utw2kr2OpWRWw3igm8GKporO1pCiuGlStskpQA07imidVpE2JlaKDzLQGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTf8CxtS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTf8CxtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92291C4CEEB;
	Wed, 23 Jul 2025 01:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234309;
	bh=0o/Q+PhjU0nIVPGyd9F9Kvrv+SnISOZztWOthtpvPKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTf8CxtS47okcbY/yLD9+wNh8Z1ckezFsqxYXoAl+KVL+PRTPx5qnnFyFc1Biv0JA
	 2Rg6MUGgEkQdMG197e8wf1fRM9RSmZRNV6gQxA2whhB/GvUW+PWeFZifp0612MQgl/
	 CLlVEYjVz99YciI6YvPUnobJ3DyMkvE/JABa8Za2r7yt5OduPioKveKdzNrrEFxVqY
	 GE2DxXLTnY94yDQzZto3u0r53f8BexsPaV+KrFp8I1XGZ5jZNgApE0PLHMGhPOuAfV
	 lBJEvUb3kGb3ng1uGJKJKKC2Cxa5bspDG9a3eJ9xLfX1FhtUwLN9nI4jTmVTSVRdhf
	 mKN4hHEyq2b9w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] tracing: probes: Add a kerneldoc for traceprobe_parse_event_name()
Date: Wed, 23 Jul 2025 10:31:45 +0900
Message-ID: <175323430565.57270.2602609519355112748.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175323423662.57270.14650807176845939538.stgit@devnote2>
References: <175323423662.57270.14650807176845939538.stgit@devnote2>
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

Since traceprobe_parse_event_name() is a bit complicated, add a
kerneldoc for explaining the behavior.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
  - Move longer parameter description into Return section.
  - Rewrite the style according to
    Documentation/doc-guide/kernel-doc.rst
---
 kernel/trace/trace_probe.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9d26d901c9e5..4fb3d98e38ea 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -247,7 +247,25 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
 	return 0;
 }
 
-/* @buf must has MAX_EVENT_NAME_LEN size */
+/**
+ * traceprobe_parse_event_name() - Parse a string into group and event names
+ * @pevent: A pointer to the string to be parsed.
+ * @pgroup: A pointer to the group name.
+ * @buf:    A buffer to store the parsed group name.
+ * @offset: The offset of the string in the original user command, for logging.
+ *
+ * This parses a string with the format `[GROUP/][EVENT]` or `[GROUP.][EVENT]`
+ * (either GROUP or EVENT or both must be specified).
+ * Since the parsed group name is stored in @buf, the caller must ensure @buf
+ * is at least MAX_EVENT_NAME_LEN bytes.
+ *
+ * Return: 0 on success, or -EINVAL on failure.
+ *
+ * If success, *@pevent is updated to point to the event name part of the
+ * original string, or NULL if there is no event name.
+ * Also, *@pgroup is updated to point to the parsed group which is stored
+ * in @buf, or NULL if there is no group name.
+ */
 int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 				char *buf, int offset)
 {

