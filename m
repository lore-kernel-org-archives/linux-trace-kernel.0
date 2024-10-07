Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B71DA26;
	Mon,  7 Oct 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312467; cv=none; b=mYd85WoUzzSnHy7916iH1iVKzXmT8NJ8rN0Wx6TeIqsg83sK0QwJqIOt0VjNt5ZsghhXG7+KShiX4TR2opXFBXSI1DYM3u4SXRNCQKvXHKqVtEP68VxKVOVzJSJHJ6JR2k7Wsp0IOrs8Eo9HRcg8+Q7MukhyaDXytJj/b28s6cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312467; c=relaxed/simple;
	bh=CqukBupSC+VDEdKCHf7l/4TyHuACvRb0VK8/+tzSNis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JgpyK9sapyx4wW63VHoMa/vNhDDCsQcRWogzEn40SinYlziUSqFq4SNjQ2W7NWHHFWn8qd5KEWMXdVsoqnkY9JBjTGGuMJDyz5vz1Dk59x8sgykqWX1UZsbxl0ZUMgeGYUXIfoXhIqv/gsmGoZbaPQD83UxxrCZEaSh28Qt/JPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07EFFDA7;
	Mon,  7 Oct 2024 07:48:15 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AAB03F64C;
	Mon,  7 Oct 2024 07:47:44 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dave.Martin@arm.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2] tracing: Consider the NULL character when validating the event length
Date: Mon,  7 Oct 2024 15:47:24 +0100
Message-Id: <20241007144724.920954-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strlen() returns a string length excluding the null byte. If the string
length equals to the maximum buffer length, the buffer will have no
space for the NULL terminating character.

This commit checks this condition and returns failure for it.

Fixes: dec65d79fd26 ("tracing/probe: Check event name length correctly")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---

Changes from v1:
Refined for condition checking (Steve).

 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 39877c80d6cb..16a5e368e7b7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -276,7 +276,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 		}
 		trace_probe_log_err(offset, NO_EVENT_NAME);
 		return -EINVAL;
-	} else if (len > MAX_EVENT_NAME_LEN) {
+	} else if (len >= MAX_EVENT_NAME_LEN) {
 		trace_probe_log_err(offset, EVENT_TOO_LONG);
 		return -EINVAL;
 	}
-- 
2.34.1

