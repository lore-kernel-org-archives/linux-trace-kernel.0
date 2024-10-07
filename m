Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D1B17B4E9;
	Mon,  7 Oct 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309099; cv=none; b=qDo87AACu9JqZ+m24EPK25I65CUQ8g1hGSuTOV6xnK+7VRNmynvIFTSRyQ0yKFCpQGMLciTYh+uJXiyRwcsaHAgabY00DCV5kEnf9Y0NeabAc89kvvD7NpsmPfSVcbyrPGOKVUx6TDuLlbUXB6tXbGEbT8O3pL+KegQmX7M7ZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309099; c=relaxed/simple;
	bh=YW1TLeRgf3X5WEfXbhRqUOfyZiKkWMAtBU8XW+ig4+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Imjpc1z9Le/JA5UQ4SOKd+PMp9fnQp5cNEvYiQvB9riDlps2gJjQ3GnS4iYtZtFVxCph9m5kwCsqjV5z7lp5VmWJolF+NeoOWOSJo2iXBAsnBd9PQh2olOJbN6f4blBAl3Rl2uq1kwFAsr7xZ6b1KC/5m2JaErfV/9bwr3i2US0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7358DFEC;
	Mon,  7 Oct 2024 06:52:06 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E16103F64C;
	Mon,  7 Oct 2024 06:51:35 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dave.Martin@arm.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] tracing: Consider the NULL character when validating the event length
Date: Mon,  7 Oct 2024 14:51:26 +0100
Message-Id: <20241007135126.873234-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strlen() returns a string length excluding the null byte. This commit
adds 1 to account for the NULL terminating character when checking if an
event string is within the maximum length.

Fixes: dec65d79fd26 ("tracing/probe: Check event name length correctly")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 39877c80d6cb..376ba56c3680 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -276,7 +276,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 		}
 		trace_probe_log_err(offset, NO_EVENT_NAME);
 		return -EINVAL;
-	} else if (len > MAX_EVENT_NAME_LEN) {
+	} else if (len + 1 > MAX_EVENT_NAME_LEN) {
 		trace_probe_log_err(offset, EVENT_TOO_LONG);
 		return -EINVAL;
 	}
-- 
2.34.1

