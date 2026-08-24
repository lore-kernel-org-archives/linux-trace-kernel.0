Received: from mail-oi2-f3.google.com (mail-oi2-f3.google.com [74.125.231.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A764052BC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566839; cv=none; b=a/4nYr6BN7LirHpIMnhj3HYoeTJ2RX/rCJfxLcZyuSEN69i+LGeRZxfe1LFQr6HebIUjmHgOrW8tASdrOKe1qhmCYiFhyXum4viGe41wsL/LbS6ynhpCK/lDWrLBDpUT0aCawcasePvM7hexwsWd90eaZPh16bGOWCgOmKgZ3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566839; c=relaxed/simple;
	bh=lPPVGAstHmikN1GkkMpgs5o8PyqaxuXluMd9NmQb03E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kowm2WGtmCni9F4CgldL9N6qqdrtqJ7EuLVZwvmmXnpQHyEYGVCw0gm7jKv5v4toNUqriwbrkwlQ3P/0cJaraW47OLI39Iy6A+IVDFl89JrofIvc1X+4TAWZJSeNc/+zbh2c+LGe2q0ZVGT9dbLCbSFVj5Wk0GAWpN0suoDqaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBSOT47c; arc=none smtp.client-ip=74.125.231.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBSOT47c"
Received: by mail-oi2-f3.google.com with SMTP id 46e09a7af769-7e9e0d8ee2cso1364359a34.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566837; x=1788171637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z5aZlHmDHOQxmVbZgRFaFqVNVR5nPWlfPpl37pEOfY0=;
        b=PBSOT47cQzpJ5p+SCeaD/fQ+BKMwlXxSzezvvKNBsoPHYIEuikuAdxbrTlDqbphIzP
         ZSnq9HkHv3mpStVONCo/shjMbc1YrMYc43YRLMPIF64uPMqQDpSe79D1gcGABXYWKKvd
         v2wmQeZWot+Uel9yqn0Ivz7PpqG19GyoWLnVYxI8bGx7HkSv2wtgZdUhbD5rQB/TY+t4
         kLni/PlVfrEnwFdUTpZfAUR1V/Fvq0jeccbMvbV/YpARbxItYTasnECRlyARsrwj9tPa
         NoJvaXSu7c38YSIU7h8pZ6jqxdWT8yq0WSKFls+hDQaoiHI0MY8yAKDlQ+x0qLr8KzCd
         pfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566837; x=1788171637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z5aZlHmDHOQxmVbZgRFaFqVNVR5nPWlfPpl37pEOfY0=;
        b=tINT3b5rT9P3gWknPIhX4LA0Qu4+6GneQKNpMKs/nSa7BuUXNpyurA+DtJoNQlEEoY
         OGJ+z/4r7t8Slc3aulVE5EAkK2TFZPiXf+rcAvsbSdMIhyplY+Hxu2D5SkrAoX58BYKR
         cMy63sBaeUZs/A3vOoZ2hQDdKjokTZMaaXpZSVzwrYse1Ha+WqGN1+aHRTm4ax9G3iRf
         lF//2xECM9Izlz4/zDolMsnJ19vuNZciUx1f98Rfgnc+rAWFFMiyjBEC3NDNLxJaUJUW
         r5uVyltEJzoZW4/LWP/ZLImhM/CH2k1t4faFAefbCUq7og//mJsez42tSLftXg7hXvgT
         faYg==
X-Forwarded-Encrypted: i=1; AHgh+RpmMZAdBd5hIL+ZSWOkjfTMNnJhDggQOez+Bmwk0hiA4gbsyCSaLJgISeXFW6KsKvSSkFOu5GOgklv1UblOWn/5YdU=@vger.kernel.org
X-Gm-Message-State: AFuF++kPSLtRg3Du9tapn98FbnVAKOtoB0fnt7gyotvKzLfsH3DFAdnO
	Ve8wqDF7xHg4imhbhecs7wBl0X2f57lFX3C/dP5R/5LDdr4KJ0KmMtVX
X-Gm-Gg: AR+sD11TTA2u5/1d73LS6fr+/PAscDtaTuN7CYcv8V25Nut6bDj9QGZUQnK/H6bkYRO
	Vlk9wJNEc21pnahDhwDcRL8jn26wcyRc+Zc9+qMRN+wl4mYy70Fc0l+5Tb2J2Qy1zHEQxFA1sr8
	ZNlkYgA5betlAYfB7dj3SyVuQXu+P3YVtn2P1NFpbhwgAl6IoMu+1N8l7INfYYYV7NFUAI2a20c
	tKakIAmaXsG7LYy9WDW37L9/PDbNuFRSNjNzxJOKbjXBzgm01gA8hpK7x1+mB0ZaH7Rs4eHPOH6
	5gMgsxokXY1wOK+rCOAyBTenaSotPeTNi/EXnT8j36wJRWD7CYhGgcA/Dj+0bIRsmoQ74MxTQ9a
	kuFAMYXlCj1VDeSy29ZfCDrqaUh6hOvt0eTlNwC7PycD2mO5zabCFPDn+YjsPHwiINj8Lc/3d2R
	f/NA8/wlhGHKX9l2sF2bB9V/sNvzeQuAntZn1vVuPK+nWtBwpXFB1FpyszMUgLXH/T9K19vK1nR
	UazlCNC4FMcDfrSJgyp4fInRSk=
X-Received: by 2002:a05:6820:20e:b0:6aa:de29:651 with SMTP id 006d021491bc7-6b159294dfemr25899528eaf.16.1787566836558;
        Mon, 24 Aug 2026 03:20:36 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b17c703cf8sm3535763eaf.0.2026.08.24.03.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:20:35 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2] tracing: Fix use-after-free on field name/type of dynamic probe events
Date: Mon, 24 Aug 2026 18:20:29 +0800
Message-ID: <20260824102029.4132962-1-bsdhenrymartin@gmail.com>
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
kfree_const() in trace_destroy_fields(). Fields of built-in trace
events still reference their kernel rodata string literals directly,
as kstrdup_const()/kfree_const() only touch memory that was actually
allocated. Module trace events pay one extra copy per string, since
module rodata is outside the core kernel rodata range checked by
is_kernel_rodata(); the copy also makes field strings immune to
module unload edge cases (e.g. forced unload) where the module text
may be freed while its trace event structures are still referenced.

The issue was found by the autokbug dynamic kernel fuzzer at Tencent
Yunding Lab.

Fixes: ca89bc071d5e4 ("tracing/kprobe: Add multi-probe per event support")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v2: Clarify in the commit message that module rodata strings are
duplicated rather than referenced (kstrdup_const() checks only the
core kernel rodata range), and scope the module-unload benefit to
edge cases rather than the normal removal path, which already tears
down module events via the module notifier.

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
