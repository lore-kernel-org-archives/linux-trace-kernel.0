Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6B27A93C;
	Wed, 19 Nov 2025 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541133; cv=none; b=QfRT+0clTNusQEij4+/GyczD47ciVlUrYoB8W33pGhJsCEsrbRFeZZQFPzAmWd8hLjZUwmrb539AvTXV+/KRcNKPup6o7xtj/jtrL+tYtFfXXQ2iluYtFphhOpY/ObcZ0IpRnVrNq9fjT1Li7R7hj0laNcOSUBELHx011ymnBVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541133; c=relaxed/simple;
	bh=oI+2+D/mjeBsiUpPHEL3d5hEm58HvaE+OyQhKgyPiJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n15AqUGeRh+Vwp7Uxv3RdgS6eH8ZyoORYOrvymdPGsFfu8dvXrG5EloJpWvCV+iO3zhDSPKDBVssdGM1t5NlnSQw9W0d5He9HWH3MJofQyr1UZjwFYgKJ4mVq0ApdM+RVLSYJ9rX3L0Ckq7wF62GNH8Pc9z6leg/L58zMWdrKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk9vhdSx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk9vhdSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC78C116B1;
	Wed, 19 Nov 2025 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763541132;
	bh=oI+2+D/mjeBsiUpPHEL3d5hEm58HvaE+OyQhKgyPiJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=kk9vhdSxPZ7zwV9sBqkqfbjw7cgNgC7M7/Y16oor33xKD9NkJ9J1ahBKzdO9JDKb2
	 9cUqQ8qHFO2j7pKh/kx6iVaIPS8tOJEYrhpMpap0Lg27ABApXQUR4+R2HxCRUEdJ1R
	 6R2ZTPd3V/dNNk1OXi2l1oZfnDX/d3SDSHYk7GJUZbrbMuyJclNMuKUYAChVZurE2U
	 Xy03Yv2d+Zvodjq6tTqX5+2b0WQyqcTTSZPRwTP8WzjcbHTfMOI5gQ/adx/z/Vpzum
	 U5u9vPfFEzMBWRohx+cbJGt3RO0IJFhcXcvG2HyKJFG15NyYiQR6eTS7ViplagBaFR
	 jLFsEoKv5/+xA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] tracing: Show the tracer options in boot-time created instance
Date: Wed, 19 Nov 2025 17:32:05 +0900
Message-ID:  <176354112555.2356172.3989277078358802353.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
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

Since tracer_init_tracefs_work_func() only updates the tracer options
for the global_trace, the instances created by the kernel cmdline
do not have those options.

Fix to update tracer options for those boot-time created instances
to show those options.

Fixes: 428add559b69 ("tracing: Have tracer option be instance specific")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
  Changes in v3:
   - Fix to update tracer_options_updated before update.
  Changes in v2:
   - Fix update_tracer_options() to update all instances.
   - Update tracer_options_updated after update all instances.
---
 kernel/trace/trace.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ae95800592d..33fcde91924c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10231,11 +10231,14 @@ static __init int __update_tracer_options(struct trace_array *tr)
 	return ret;
 }
 
-static __init void update_tracer_options(struct trace_array *tr)
+static __init void update_tracer_options(void)
 {
+	struct trace_array *tr;
+
 	guard(mutex)(&trace_types_lock);
 	tracer_options_updated = true;
-	__update_tracer_options(tr);
+	list_for_each_entry(tr, &ftrace_trace_arrays, list)
+		__update_tracer_options(tr);
 }
 
 /* Must have trace_types_lock held */
@@ -10937,7 +10940,7 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 
 	create_trace_instances(NULL);
 
-	update_tracer_options(&global_trace);
+	update_tracer_options();
 }
 
 static __init int tracer_init_tracefs(void)

