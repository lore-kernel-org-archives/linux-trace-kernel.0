Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6497225A642
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555427; cv=none; b=ANzA36lJi2TSQhd3zGcCH881affiPOw6mNtUedhNG1pF6yFFg/LBpD1LLvt6aANyTHeWAntDVD6DmnMZWYJuepvcWvzQgpK3wVvbIHqtnXROQgEfPaDNIeZWGpisUyVWlnFsHNqUwJO5GZMi6E9DcrBsmoTL4OXPJbVJ5E6FngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555427; c=relaxed/simple;
	bh=YhspMydTY1oA24IJ6JLVdGCBzKlQDhp++E1WO+31lMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZO3wSkcCzGuTcdVvW84CvSnzC/Tx65sRnOvHygENBtCmMf50RMBVkhDWTM2qaV+eqNqDy70gKSMPXeyl/8NKkPbj2mgzVuEx1S0lvvCwQSX3zaZiDwTnvdHOhA3Xo2mVwpvJuCIQvIaRzC+/zmSsjMnDIYDfb9Jrwh9lql2X50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YebJa11I; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YebJa11I"
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-45958a0c7c4so961939fac.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 00:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787555425; x=1788160225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O3IzVHIXrBFOM86OhJWc9RtLmRZBPf8cDlCfPztlzHM=;
        b=YebJa11INEo+P/O0cIfylr7FUxEu6gyhwFS2AqjtgSaVbeipSRCln5hF/0qvV2WnmO
         LOYZ3C88A7HmA35WW1Na8bpNCrr81S5SNxpN2PrzwZroh8LW75xFn5brB4aOpWC3mlVl
         0YJ2d7JTLjoLgzvxcdHTjn5imehbn70TwQ6GDm4foYReHnUQ+ZdVMhwoRe0VHU+lZ+ks
         P9c2Z7s40ONGcgTyOdo8XqAR+Cwiwe+dTaom02iiX5LSPcmwoewgOnIBELrVwqW1Ng1A
         2nEtK/q1hE+TvArWFolggzdqBqrvEclnZXEE5L1WIxOxoJh2tTgJCf5WTq+OqHEs6i/e
         VH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787555425; x=1788160225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3IzVHIXrBFOM86OhJWc9RtLmRZBPf8cDlCfPztlzHM=;
        b=BYKf8DNzzbge4BSLCrYsgnIVSR7mxDAJAiAbT0x+c0qiLW3aQaq6tNpBIiqoY7CcXs
         NfEJxXqYgJSvqfn34S60OkUYcuiCbVS49f4IO6N9WHA/InchlQclwApvIQHZr75+AcdK
         aj2iW395aIwwAFuW88mAX/83iWhwAfqzw59/u/YQ04rPBgasegnTqMmNkAKDcBYBOiXT
         kZoEmq8pJsJ83qlVkH6vNPjOBqu3UfY7BCkD/5BKkFM/WYzrA9hz4lBtqFyc5H1oPfOa
         dgwBTQS8YRdcQXsZXGEaQXaVT6EFaW0aqFru7bXGko29jf4GhZL3YVDP6n+BfbjJKZ4n
         2wzw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0f82BbIKq0CviK64Jys8+gAtS1VvCSDGXOM+cH8i5KMbXgZehqueINnuNUPlxQFMy4f4FKD+DKOAf00C/p9DwW6I=@vger.kernel.org
X-Gm-Message-State: AFuF++mp6Z5vpHo/pK0/+Bz0RIiQ0ygbBQoBGX5B8AObL/JMCB6DKVpm
	Gv1BzLaMzyoCoe6JE5UPmjT8ZklTRoawn6d2Fl51BwJYBeC2JOA3m/5l
X-Gm-Gg: AR+sD13Mn5xtOMrLtuzGzCgBW/ruPREKzDTNJIAKh03yfZS2xYpG5B00v5ySnfr2tDx
	aIJgq2b9oQMNb+ScUab5D20qBYbqGdv4R1ov2LI7AU0pthWGMQ/q01JBaYndR0SZRcapPqT7E3J
	Ey02sGNohU/Zahz1IfBLRZmkBX4OcA8zQqNCxRHnBrXdtM8SKZLNs73FHeciBdDzpXNSmoFyCwn
	vl5sYH4WFsL2YFU53eqcDGs7+gmRhqAkLsyLdmsqVHGl50WRZ5emM7ruNBNgT29Z26A2dl0DspV
	+aXvMG8N+JBC78LU8a2mqgdSvo56v7uFEHMVwHyRFjSnlM1VPUL+TUfSF/TrrY3nf9gK67erOes
	rnvLSWZ62EO3jVLbLIw3vF41fkOL2WJ7ymCIxdOsrNYbDD10sxZGQDumBw2hGfX4434GXaAmThH
	1MZlYA1Cy9uIR1/fg4Bee1WnTeWEgF8qyciC/m/XNlCcT7TMDKyz0K2A6XCj7/g1MNyM5Prygd0
	NuUMeTMfKd7MlUXrD+82uvX6EaNDUreZenv
X-Received: by 2002:a05:6870:f290:b0:456:f700:dd75 with SMTP id 586e51a60fabf-4637fa674admr15809304fac.7.1787555425264;
        Mon, 24 Aug 2026 00:10:25 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.164])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46383499862sm5024219fac.9.2026.08.24.00.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 00:10:24 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] tracing: Fix use-after-free on field name/type of dynamic probe events
Date: Mon, 24 Aug 2026 15:10:11 +0800
Message-ID: <20260824071011.3507735-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fields of a probe-based dynamic event (kprobe, uprobe and eprobe
events) are created from the argument name and type strings of the
trace_probe that first registers the event, as plain pointer
references without copying.

When several probes are appended to the same event, they share the
trace_event_call and its field list, which stays the one defined by
the primary probe. Deleting just the primary probe with
"-:group/event symbol" frees the trace_probe and its argument
strings, while the event call is kept registered by the remaining
sibling probes. field->name and field->type are left dangling, and
any field lookup - e.g. writing to events/<grp>/<ev>/filter - reads
freed memory:

  BUG: KASAN: slab-use-after-free in strcmp+0xa7/0xb0
  Call trace:
   trace_find_event_field+0xd6/0x220
   parse_pred
   process_preds
   create_filter
   apply_event_filter
   event_filter_write

Make the field own its strings: duplicate name and type with
kstrdup_const() in __trace_define_field() and release them with
kfree_const() in trace_destroy_fields(). Fields of static trace
events still reference their kernel/module rodata string literals
directly, as kstrdup_const()/kfree_const() only touch memory that
was actually allocated.

The issue was found by the autokbug dynamic kernel fuzzer at Tencent
Yunding Lab.

Fixes: ca89bc071d5e4 ("tracing/kprobe: Add multi-probe per event support")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 kernel/trace/trace_events.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c01b10b99f67e..ee3b93fa09ee8 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -123,8 +123,18 @@ static int __trace_define_field(struct list_head *head, const char *type,
 	if (!field)
 		return -ENOMEM;
 
-	field->name = name;
-	field->type = type;
+	field->name = kstrdup_const(name, GFP_TRACE);
+	if (!field->name) {
+		kmem_cache_free(field_cachep, field);
+		return -ENOMEM;
+	}
+
+	field->type = kstrdup_const(type, GFP_TRACE);
+	if (!field->type) {
+		kfree_const(field->name);
+		kmem_cache_free(field_cachep, field);
+		return -ENOMEM;
+	}
 
 	if (filter_type == FILTER_OTHER)
 		field->filter_type = filter_assign_type(type);
@@ -225,6 +235,8 @@ static void trace_destroy_fields(struct trace_event_call *call)
 	head = trace_get_fields(call);
 	list_for_each_entry_safe(field, next, head, link) {
 		list_del(&field->link);
+		kfree_const(field->name);
+		kfree_const(field->type);
 		kmem_cache_free(field_cachep, field);
 	}
 }
-- 
2.43.0
