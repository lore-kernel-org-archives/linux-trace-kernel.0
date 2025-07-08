Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CE02D949B;
	Tue,  8 Jul 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975699; cv=none; b=hRW0vRyUOxtpKtGNO/bKV5IjEdI2s+ZhTBIGKxVBePhm/fRGTO5CcsK9wdIhef79uclh3R8znWAhMP1h2cdY9eyoCNjAxGk9wlRn5DqbrZ8tKJd6Wxtp/C4A9JfkeMDlsG4lMFi/iwAQ/lT2b77v2ZeMukBOQUgDcDa6/EqEJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975699; c=relaxed/simple;
	bh=GqBzklexVMTYQwlMXJxPuLW/c+HeYdqghUOKGpseyGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzJwQTP4wpd4Tlhe7SCN627SmzlPK9+dyPH8dEKJWxrcy5l822fhLR68/G0bAH68Iw3E/gaNVXlxC1RT92tC2GVQ+yb1iSQqpxXj0Ze9hc7jA5AKcXxEMF9bRs0AW9w+Jo8u2X1yjOO6mx9/HHbsqnNkERwpZ0QyIPD9xkk6XzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9OY+GJq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9OY+GJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA47C4CEED;
	Tue,  8 Jul 2025 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751975699;
	bh=GqBzklexVMTYQwlMXJxPuLW/c+HeYdqghUOKGpseyGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9OY+GJqOssuHnPGJTdm/Axdp/gjNMRWdBLhnm5cCpvd2WHiK1oy6w5ofDKPq0VZ/
	 ePnObaqzUAPaLkdE74nXKAnrwDdvPQ7Qh8/eotbA4EYhI+hrrT6+0ITuwydI4zBVbs
	 k8AIlmeLaedygsN4+qrch/YioGsYL+FaoczoSDk6KrPvqJR7K4xi4R8ACxPcnAh5TL
	 9ygwMWFVB/nbou1aBexBdYchgqo82zbUfXX0poBGTOdlEhEl51/dj9KblT7seERrXS
	 HejC8OpLGRdEfxurxtsb/tJoWOvvrXGDHXhD+jo4R6g9V+J1jBm8RRdau6tNsJU5cp
	 6/0XNDQlkI41A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: Allocate field->type only if it needs to be sanitized
Date: Tue,  8 Jul 2025 20:54:57 +0900
Message-ID:  <175197569695.977073.14996860364063727757.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To:  <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
References:  <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
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

__trace_define_field() always allocate field->type for sanitize
the type string, but almost all cases it does not contain the
string to be sanitized. To reduce such memory usage, prevent
to allocate field->type unless it actually has the string which
needs to be sanitized.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.h        |    1 +
 kernel/trace/trace_events.c |   28 ++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd084953a98b..cd7be4ce6ee9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1468,6 +1468,7 @@ struct ftrace_event_field {
 	int			size;
 	unsigned int		is_signed:1;
 	unsigned int		needs_test:1;
+	unsigned int		alloc_type:1;
 	int			len;
 };
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 2f950aceb783..d95f24d61875 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -145,6 +145,11 @@ static void sanitize_field_type(char *type)
 	}
 }
 
+static bool need_sanitize_field_type(const char *type)
+{
+	return !!strstr(type, ATTRIBUTE_STR);
+}
+
 static int __trace_define_field(struct list_head *head, const char *__type,
 				const char *name, int offset, int size,
 				int is_signed, int filter_type, int len,
@@ -159,16 +164,22 @@ static int __trace_define_field(struct list_head *head, const char *__type,
 
 	field->name = name;
 
-	type = kstrdup(__type, GFP_KERNEL);
-	if (!type) {
-		kfree(field);
-		return -ENOMEM;
+	if (need_sanitize_field_type(__type)) {
+		type = kstrdup(__type, GFP_KERNEL);
+		if (!type) {
+			kfree(field);
+			return -ENOMEM;
+		}
+		sanitize_field_type(type);
+		field->type = type;
+		field->alloc_type = 1;
+	} else {
+		field->type = __type;
+		field->alloc_type = 0;
 	}
-	sanitize_field_type(type);
-	field->type = type;
 
 	if (filter_type == FILTER_OTHER)
-		field->filter_type = filter_assign_type(type);
+		field->filter_type = filter_assign_type(field->type);
 	else
 		field->filter_type = filter_type;
 
@@ -266,7 +277,8 @@ static void trace_destroy_fields(struct trace_event_call *call)
 	head = trace_get_fields(call);
 	list_for_each_entry_safe(field, next, head, link) {
 		list_del(&field->link);
-		kfree(field->type);
+		if (field->alloc_type)
+			kfree(field->type);
 		kmem_cache_free(field_cachep, field);
 	}
 }

