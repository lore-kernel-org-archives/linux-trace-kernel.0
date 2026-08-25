Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C149362C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787656342; cv=none; b=G+r1+TjMKAT9uRCO30u18ocxO9yTTcMOydgIJoauMp19gv/GL7Ev/i96zpjfzEDEYu43CtyGM544R4G8ss33FoGfmoveIPCgL4jjLTkCJJ/iMpDg+fuuafcBnL6/uFCB4LrZTAdtvO8ZSQokgsiggUTVU0sf8oe9YS43a228rXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787656342; c=relaxed/simple;
	bh=R7SiTOh0PFe0DzLthNlxryytuOFiGP1U7I1PBAXV4JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlFrleJ8+Cup1t4MDLFq+Yvd4LhX8jtSs3OnxNnr21213Y4BITJt/SA8ncoAiYIJqU5fmBRw86M4FdTf2IequkrRnqNUWNXKwV/Z4RQzzhk3Lf1zZKZXNFYPkcn/QbsARtHZ0jko6mWyQXApH9OuvTPkfvZNTaXFO//hPcJ5xcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgd3WGnw; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgd3WGnw"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-4483c9986ceso346982fac.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787656340; x=1788261140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3zIxXood4PVZFu1Qa5yvNtX5OE3SRSdZd1BmUJW9SHE=;
        b=mgd3WGnwiF5iZPRMgbdphvd5HgKDGvMKxIZoBGjnIW54oW9fNm+8yCkcMhcDg06ZMH
         mrRZkFq5wuPOjtzRYUvTjDoCithKiHFsDj4zPkIr3eFaDsyyV+sALzy3HxTPfUb3CqcR
         R5k/Qpzi+plj85aty4k2bNV+GzNg63Td0IInScOAO7PSH2q5YuWottVoGS2iygs0YP5M
         NF3lmD2UOwN3W6A3fTZOEGaSBhW0b7ZhqrIBfwMjQmr6Oy8mQw25wJ0loms3FGsXR4mN
         5tPHU8tT5HIK1Zv7/EJlnBhKonPobNLmDsG9Gs3iiKXHNr4dFx41aI4AzS6ESWO8Dx50
         gHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787656340; x=1788261140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3zIxXood4PVZFu1Qa5yvNtX5OE3SRSdZd1BmUJW9SHE=;
        b=saT+Gm5Rja+26miMnrhINNHI7CK/Thm/z7QvtqriR5SphMx9fB/NIjmITRbETT+EWo
         CvQ9cpKx3SnrlYl5Jh/ErHGC0fWIQsd3EvsbdF9sLyl6UrrQIJEgpjFthm3lW0T8exX/
         kipc2TiAQW0cgGh8lT1wEgM3mYu218jsfgytqgOqN55jM8pTdeSspOGrfYvW8S2+Eomp
         885SPxqzLnuKokVK0Iqe0aM1zzXH7UAraHijbhjum+eTC5yrro32G3lSzE6J+u4E1OLQ
         I0+wRui8m8o01Isp8N9+pS/jeBK+07N8BDGG55nEm3dJqQuDGA0HmTZQfCgJV35xaw1b
         94eA==
X-Forwarded-Encrypted: i=1; AHgh+RpVAAAoLw4VUB71xqnSY7fNOC7lwSleVQWm+RKrg3zSUJyLWOwD4F+T27/AV4Ir8wFI+qcjEVmOIt0htNj1wScaCzs=@vger.kernel.org
X-Gm-Message-State: AFuF++kOg5+b0iDnSqic3H54S8OeKMyGPk/yWOSOuhDK6iidBPKjihMd
	OXvkRVgHF0B893hWrHeuvQBQn3w+Y0366GQe7CAHFUA9b7qKpqunFEnc
X-Gm-Gg: AR+sD114Ks68kAvoPdgAfsl6b54b4KqeTVRaQufbOv+OZXgXwbDumdUfANz6wbUuc3D
	ZXXWUyVeq9M5/uoUbXKYBGR8jySSj/V0rOFvGJ33mVsBdPDA9La/lgsu8ymc87uBCWjXdw23Q9P
	a9fJcNL1ulZP+ZFvp7X4LSUZ+qw8a0Qq5LSPkH5cs6QUYc1oTV5iNWL+/WzEfaD+cSdSzZGpx5q
	sF1Sjb3M6deftqiwTx4KW5KiQbGUg6Y+CHNw15Ma8906kCYnNe9YBAHXZomWYUQCGTth8F2ov5g
	EfQicIDWcvcdDDlBmI9sytfJjSna4UeJKNY5F3recYmz00+DZ9xTghSCIBh+yLn93uXSsy3iFX3
	XSrZEwY8v1eBfSE0Fpkj569kyvYqBlEmQ4EXR1zd1vE1HoiuU8hDjeVx4S0igbkd0OxgFrk/N7t
	63cGU/aIbMwG0VqVzTRbm9KjzHpaaX1vHnePWBaY6Eya7yULjPJ9NhS9RSjLeiYUqY6Ud18fGna
	5FYSAoIcFNPDDryOYriSxUx2w==
X-Received: by 2002:a05:6820:1c82:b0:6b1:2a4a:ca8f with SMTP id 006d021491bc7-6b18fb23267mr3914986eaf.10.1787656340006;
        Tue, 25 Aug 2026 04:12:20 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc4e6f3sm6666893a34.14.2026.08.25.04.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 04:12:19 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v3] tracing/probes: Fix use-after-free on field name/type of multi-probe events
Date: Tue, 25 Aug 2026 19:12:10 +0800
Message-ID: <20260825111210.3271443-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260824144356.1f61aea2@gandalf.local.home>
References: <20260824144356.1f61aea2@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fields of a probe-based dynamic event (kprobe, uprobe, eprobe and
fprobe events) are created in traceprobe_define_arg_fields() by handing
the probe_arg name/type strings to trace_define_field(), which only
stores the pointers without copying. Those strings are owned by the
trace_probe and are freed when that probe is removed.

An event can hold several probes ("multi-probe per event", added by the
Fixes: commit below). The field list is defined only once, by the first
probe that registers the event, but it is kept alive by any surviving
sibling probe. Deleting just that first probe by symbol -

  # primary A: fields are defined from A's args
  echo 'p:kprobes/ev vfs_read  a1=$arg1' >  kprobe_events
  # append B: shares A's event call
  echo 'p:kprobes/ev vfs_write a1=$arg1' >> kprobe_events
  # delete only A (matched by symbol), B survives
  echo '-:kprobes/ev vfs_read'           >> kprobe_events

frees A's args (trace_probe_cleanup() -> traceprobe_free_probe_arg()),
but trace_probe_unlink() keeps the trace_probe_event because the probe
list is not empty. The event call stays registered via B while its
fields now reference freed memory. Any field lookup then reads it, e.g.

  echo 'a1 == 1' > events/kprobes/ev/filter

  BUG: KASAN: slab-use-after-free in strcmp+0xa7/0xb0
  Call Trace:
   strcmp
   trace_find_event_field
   parse_pred
   process_preds
   create_filter
   apply_event_filter
   event_filter_write

field->name references parg->name (kstrdup'd, freed with the probe) and,
for array arguments, field->type references parg->fmt (kmalloc'd, freed
with the probe) - the scalar type otherwise points at the static
fmttype rodata, which is safe.

Fix it in the probe layer, which is where the borrowing happens, so that
trace_define_field() and static trace events are left untouched. Make
traceprobe_define_arg_fields() duplicate the name and type strings and
have the trace_probe_event - which embeds the event call and outlives
every individual probe - own the copies, releasing them in
trace_probe_event_free().

The reproducer above triggers reliably; the field lookup and the delete
both run under event_mutex, so this is a dangling reference after
removal rather than a race.

The issue was found by the autokbug dynamic kernel fuzzer at Tencent
Yunding Lab.

Fixes: ca89bc071d5e4 ("tracing/kprobe: Add multi-probe per event support")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v3:
 - Steve: wrong fix / wrong file. Move the fix out of trace_events.c
   into the probe layer (traceprobe_define_arg_fields() /
   trace_probe_event_free()) so trace_define_field() and static events
   are untouched. Ownership now lives on trace_probe_event, whose
   lifetime matches the event call and its field list.
 - Clarify in the changelog that this is kprobe multi-probe-per-event
   (append_trace_kprobe), not eprobes, and add a shell reproducer.
v2:
 - Reworded the module-rodata note (dropped, superseded by v3).

 kernel/trace/trace_probe.c | 36 +++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h |  2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index c4163904ba747..26a9fb3533bde 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2552,19 +2552,48 @@ int traceprobe_set_print_fmt(struct trace_probe *tp, enum probe_print_type ptype
 int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 				 size_t offset, struct trace_probe *tp)
 {
+	struct trace_probe_event *tpe = trace_probe_event_from_call(event_call);
 	int ret, i;
 
+	/*
+	 * A field created by trace_define_field() only stores the name and
+	 * type pointers, it does not copy the strings. Here they point into
+	 * the probe_arg of @tp, which is freed when @tp is removed. For a
+	 * multi-probe event the field list is defined once by the first probe
+	 * but kept alive by the surviving siblings, so removing that first
+	 * probe would leave the fields referencing freed memory. Make the
+	 * event own duplicates that live as long as the event call itself.
+	 */
+	if (tp->nr_args) {
+		tpe->field_strings = kcalloc(tp->nr_args * 2, sizeof(char *),
+					     GFP_KERNEL);
+		if (!tpe->field_strings)
+			return -ENOMEM;
+	}
+
 	/* Set argument names as fields */
 	for (i = 0; i < tp->nr_args; i++) {
 		struct probe_arg *parg = &tp->args[i];
 		const char *fmt = parg->type->fmttype;
 		int size = parg->type->size;
+		char *name, *type;
 
 		if (parg->fmt)
 			fmt = parg->fmt;
 		if (parg->count)
 			size *= parg->count;
-		ret = trace_define_field(event_call, fmt, parg->name,
+
+		name = kstrdup(parg->name, GFP_KERNEL);
+		type = kstrdup(fmt, GFP_KERNEL);
+		if (!name || !type) {
+			kfree(name);
+			kfree(type);
+			return -ENOMEM;
+		}
+		tpe->field_strings[tpe->nr_field_strings++] = name;
+		tpe->field_strings[tpe->nr_field_strings++] = type;
+
+		ret = trace_define_field(event_call, type, name,
 					 offset + parg->offset, size,
 					 parg->type->is_signed,
 					 FILTER_OTHER);
@@ -2576,6 +2605,11 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 
 static void trace_probe_event_free(struct trace_probe_event *tpe)
 {
+	int i;
+
+	for (i = 0; i < tpe->nr_field_strings; i++)
+		kfree(tpe->field_strings[i]);
+	kfree(tpe->field_strings);
 	kfree(tpe->class.system);
 	kfree(tpe->call.name);
 	kfree(tpe->call.print_fmt);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index fba1af092a9bd..d1fb3520700fb 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -264,6 +264,8 @@ struct trace_probe_event {
 	struct trace_event_call		call;
 	struct list_head 		files;
 	struct list_head		probes;
+	char				**field_strings;
+	int				nr_field_strings;
 	struct trace_uprobe_filter	filter[];
 };
 
-- 
2.43.0
