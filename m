Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470B28E9;
	Sat,  8 Nov 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762599392; cv=none; b=GBNYF49eTo1kiIJvuMXOh2mwvddJUCkQGpdnAmoKXruS/dvA1cP1pJVMWcnj6T0jRC4IzxMRC/niidQSk7T09GATHkywrG3+bLQLCPlLQFjusuBOo4lyu5cTjuGoQMq6i0zM1LoxngWDnDkJ0moR93MWy1i4WDI4rlgm4THyEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762599392; c=relaxed/simple;
	bh=1/zPj/GOtEGOtvxhfaLOwbvXmNML0Pp716jOkeAfyK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G8/aGT0L9XebCxA+Tw804/ZZ3ACOIu1pZ6XZcCiI1x0AwXNOv75JU6mjImULH00CnAvNc/1wuMxanTLnp6SMksMoHrivTNeZncFPMetSOGHadGSarFKEq1vYBKWZdATa2xYZvsWJdM0RYJqA6gpSGDVFvhxx6QxM+ITNdebBM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMiVNLhy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMiVNLhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5194BC19422;
	Sat,  8 Nov 2025 10:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762599391;
	bh=1/zPj/GOtEGOtvxhfaLOwbvXmNML0Pp716jOkeAfyK0=;
	h=From:To:Cc:Subject:Date:From;
	b=RMiVNLhy1cVf0zyYPggyz+mjVDwnUlbn4QjL2O0XQ5d7EZ+ht/eEXiXx9m5ebdG/X
	 in4GdaNT3fgyuQTzkxBD/Cp1OV2yiBnFHJQMmK2sbtoWya3blTpcHDhs4D05rjiHFq
	 Ximewn8F/GTf7uHIBByhfMwXQ/idDYdYPDIZh9omj0hcPwm9ehFZ6R0hsN2Bghji8P
	 lW4iPbrsZORB+ua4NU/5BH3PdvNPf0NonQfkSz4FDNUgOB4YCrAa4XmbZTP9ynmudI
	 kOwDibqNqQ1wI45rTkWAOUQzSl9Vboqorc+Iq9KO9OgwTRXkDvNXeCUh1sdMSU5GRW
	 W6cwUkk75yerw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Report wrong dynamic event command
Date: Sat,  8 Nov 2025 19:56:27 +0900
Message-ID: <176259938768.261465.10714633393722227911.stgit@devnote2>
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

Report wrong dynamic event command via error_log.
---
 # echo "z hoge" > /sys/kernel/tracing/dynamic_events
 sh: write error: Invalid argument
 # cat /sys/kernel/tracing/error_log
 [   73.371714] dynevent: error: Invalid dynamic event command
  Command: z hoge
           ^
---

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_dynevent.c |   11 +++++++++--
 kernel/trace/trace_probe.h    |    3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index d06854bd32b3..536a7704abfd 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -14,6 +14,7 @@
 
 #include "trace.h"
 #include "trace_output.h"	/* for trace_event_sem */
+#include "trace_probe.h"
 #include "trace_dynevent.h"
 
 DEFINE_MUTEX(dyn_event_ops_mutex);
@@ -144,9 +145,15 @@ static int create_dyn_event(const char *raw_command)
 		if (!ret || ret != -ECANCELED)
 			break;
 	}
-	mutex_unlock(&dyn_event_ops_mutex);
-	if (ret == -ECANCELED)
+	if (ret == -ECANCELED) {
+		/* Wrong dynamic event. Leave an error message. */
+		trace_probe_log_init("dynevent", 1, &raw_command);
+		trace_probe_log_err(0, BAD_DYN_EVENT);
+		trace_probe_log_clear();
 		ret = -EINVAL;
+	}
+
+	mutex_unlock(&dyn_event_ops_mutex);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 591adc9bb1e9..e6e5c884e60a 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -567,7 +567,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_ACCESS_FMT,	"Access memory address requires @"),	\
 	C(BAD_ACCESS_TYPE,	"Bad memory access type"),	\
 	C(BAD_ACCESS_LEN,	"This memory access length is not supported"), \
-	C(BAD_ACCESS_ADDR,	"Invalid access memory address"),
+	C(BAD_ACCESS_ADDR,	"Invalid access memory address"),	\
+	C(BAD_DYN_EVENT,	"Invalid dynamic event command"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

