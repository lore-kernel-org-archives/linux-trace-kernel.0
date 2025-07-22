Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0B287246;
	Tue, 22 Jul 2025 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221759; cv=none; b=Lgobp3tEMM7FVJ9p+Fx4G2K5YpKtSsS4YIvRh+ANIHrQWz2YVzf/yKmQrF1Nkta2ZkaFfOVhhTOfzemoND6jcGtoOIh+c7CMh/grjupPAEU+yqs/PAKo2u3obNkG+SOgeYqmkWddHFJa4dXRMwui9Kh7JbdGIUOa2BxYKvTIl20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221759; c=relaxed/simple;
	bh=EPde5y9stfjJcaIFZ59a2xBrgJx9wnyVqR7ktHXVogo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CADGdqm4I3u8HBLaU1ORJA/UwC8KEsmqKH/W+5hQRGOA8iFKlwzqVFWRraQS4uLNfLgXHWlxjIel/V2YR61nXlE6jSl1IkcYhBcAYfzTNQeSnfH1xFFuKkpE7VAwGuP5pFY1tI72YOkTnR94Wi40wCbVKi4Y9zbSlecLY36plRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQJpCg6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQJpCg6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD9AC4CEEB;
	Tue, 22 Jul 2025 22:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221759;
	bh=EPde5y9stfjJcaIFZ59a2xBrgJx9wnyVqR7ktHXVogo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQJpCg6AvytfkgaTGtRyuH3K2pj/l/Em5crR1Gy7SZ9iAfU6D8FGatEUKMDz13a3/
	 tzSZjj2PUD2AezrtDfE3OTn9Qacc1GsJowERERspwM2wK1gZjd+9J4ELbG/bGqXqrQ
	 FhjGsDBcEzxIh/WpZct4zGaf313cOIawMaJKj3imldkYF8xYO8VitP0KDpTJI4JHd8
	 GnAdp03m69thJwndwQI1tcS5NO6Bn9MRGtN+NTWhwCoSBQFp1FgleSJPctRzNlQg7a
	 qssT6G/QBza02EGY6GJg2xoYWDBnD8JL7w3nc6+IjaGzq2ZjrWToAhKLQO5MugJhO/
	 64jgMs5Wlpd9Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] tracing: probes: Add a kerneldoc for traceprobe_parse_event_name()
Date: Wed, 23 Jul 2025 07:02:35 +0900
Message-ID: <175322175536.44400.179953626110801411.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175322168606.44400.9155291012158349647.stgit@devnote2>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
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
 kernel/trace/trace_probe.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9d26d901c9e5..7dcc4a548c69 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -247,7 +247,22 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
 	return 0;
 }
 
-/* @buf must has MAX_EVENT_NAME_LEN size */
+/**
+ * traceprobe_parse_event_name - Parse a string into group and event names
+ * @pevent: A pointer to the string to be parsed. On return, this is updated
+ *          to point to the event name part of the string.
+ * @pgroup: A pointer to the group name. This is updated to point to the parsed
+ *          group name, which is stored in @buf.
+ * @buf:    A buffer to store the parsed group name.
+ * @offset: The offset of the string in the original user command, for logging.
+ *
+ * Description: This parses a string with the format `[GROUP/][EVENT]` or
+ *          `[GROUP.][EVENT]` (either GROUP or EVENT or both must be specified).
+ *          The parsed group name is stored in @buf.
+ *          The caller must ensure @buf is at least MAX_EVENT_NAME_LEN bytes.
+ *
+ * Return: 0 on success, or -EINVAL on failure.
+ */
 int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 				char *buf, int offset)
 {

