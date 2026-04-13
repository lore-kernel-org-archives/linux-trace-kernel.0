Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790A39BFE3;
	Mon, 13 Apr 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119746; cv=none; b=hKFVx4teqZbzaiSUeyZjxLQZWocEWFJTGpc2dKOQze0qjBxc5pUVPTtvTociu6epcjl1XyuJKqjmLTE/jUmTXuhSZa5klOkJnKTBKQ6Hiprswh6oiptldF41gnomBDC0daN936so3nzgzYhZntZP4MeUHC3B0YBvqPs9vw4fivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119746; c=relaxed/simple;
	bh=+ZY82Gc+W2fCMb43D85ngNPsUytjGs5PdcXUsYy/KqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkKNWIv0+W11Ll6cQVbaUyOIfv7fBbgbXwAaI4KJ7avyQcw31obrph0cTu+C4H8BSYx+ys0WdyzGHGzxYip0ie2sPWg2m1WeqcPQbv1wF1l480zViK+PHATsm6YStOu448gEF3AUQFkYieAwavb82lV2EIWejx5j8taKPTXE4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6ys9UP/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6ys9UP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A19C2BCB4;
	Mon, 13 Apr 2026 22:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776119745;
	bh=+ZY82Gc+W2fCMb43D85ngNPsUytjGs5PdcXUsYy/KqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6ys9UP/KqJTWlxJfZRtg01SbjxcTr4cZHwj5OjrTVQWPIW9m/hml2XV60gZQn6IR
	 pepiuBHPKp82tB2mor0kd+EmLfCsJBC06ZgiFxvtj2h8z9idzb7yRPgaPYxf+c6Avi
	 5qmdTcMz9+/bqXIsfJ1o9KJ1DlE0iwMHes4rXdzWKUOEhcuVY+66xulKJbJYBZNXZg
	 m0FLbYvC5qMobjVTcsqo0Fg0Uk4GBaLqCYj5qvAEqzJurSvDSG8+Xk4DSuv6vjhY1t
	 8B1WK+7z1uwpB2aK9Hzw9OmkR/vUY51itKi3PArnXUZjuWnEDU4aTinqrJ3k6ap8z2
	 NCAjE+OOITowg==
From: Tom Zanussi <zanussi@kernel.org>
To: rostedt@goodmis.org
Cc: pengpeng@iscas.ac.cn,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: Fix fully-qualified variable reference printing in histograms
Date: Mon, 13 Apr 2026 17:35:37 -0500
Message-ID: <5dee9a86d062a4dd68c2214f3d90ac93811e1951.1776112478.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776112478.git.zanussi@kernel.org>
References: <cover.1776112478.git.zanussi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syntax for fully-qualified variable references in histograms is
subsys.event.$var, which is parsed correctly, but not displayed
correctly when printing a histogram spec. The current code puts the $
reference at the beginning of the fully-qualified variable name
i.e. $subsys.event.var, which is incorrect.

Before:

trigger info: hist:keys=next_comm:vals=hitcount:wakeup_lat=common_timestamp.usecs-$sched.sched_wakeup.ts0: ...

After:

trigger info: hist:keys=next_comm:vals=hitcount:wakeup_lat=common_timestamp.usecs-sched.sched_wakeup.$ts0: ...

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b2b675c7d663..0dbbf6cca9bc 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1361,9 +1361,12 @@ static const char *hist_field_name(struct hist_field *field,
 		 field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (field->system) {
 			static char full_name[MAX_FILTER_STR_VAL];
+			static char *fmt;
 			int len;
 
-			len = snprintf(full_name, sizeof(full_name), "%s.%s.%s",
+			fmt = field->flags & HIST_FIELD_FL_VAR_REF ? "%s.%s.$%s" : "%s.%s.%s";
+
+			len = snprintf(full_name, sizeof(full_name), fmt,
 				       field->system, field->event_name,
 				       field->name);
 			if (len >= sizeof(full_name))
@@ -1742,9 +1745,10 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 
 static void expr_field_str(struct hist_field *field, char *expr)
 {
-	if (field->flags & HIST_FIELD_FL_VAR_REF)
-		strcat(expr, "$");
-	else if (field->flags & HIST_FIELD_FL_CONST) {
+	if (field->flags & HIST_FIELD_FL_VAR_REF) {
+		if (!field->system)
+			strcat(expr, "$");
+	} else if (field->flags & HIST_FIELD_FL_CONST) {
 		char str[HIST_CONST_DIGITS_MAX];
 
 		snprintf(str, HIST_CONST_DIGITS_MAX, "%llu", field->constant);
@@ -6156,7 +6160,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 	else if (field_name) {
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
 		    hist_field->flags & HIST_FIELD_FL_ALIAS)
-			seq_putc(m, '$');
+			if (!hist_field->system)
+				seq_putc(m, '$');
 		seq_printf(m, "%s", field_name);
 	} else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
 		seq_puts(m, "common_timestamp");
-- 
2.43.0

