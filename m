Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AF18C008
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787713219; cv=none; b=OWrk1lsStum3TTr3h9eHR9VfEuj1I4+h5n6oXags6mlKxAGCtKVKCAr0ZNUIF6MuOaSSIcFyr97EEOXEfArs7zc76CXiyP1A15Fx3KDQ3otyytCdqRGCd1bifBLExf5N59wk2mhBXe6AS0x8GlBApSLzHJSfOiGTsfKZHgMh/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787713219; c=relaxed/simple;
	bh=D8p7mZ3kg+7smOS1vLA4B5w7bt/8s8UNR2Wlj3uMUXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0v8YRVk7hUORS+3F7kOjdm8AOEoYWA7cSzKPlaA5+BfZJJHdKHAYBtETq+L7vwRB8hy7bY1RqSMlLqvI6tYjwqVoLga1DEq06im3t+2ntxEJE6LuQB/i9+TkTRWzHYiGnZzy7oNUdJUsHwg6N3GfFAZ0JhTc5TpgfWnzzLTCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nORop46p; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nORop46p"
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-451e22b4773so243121fac.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 20:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787713215; x=1788318015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6uGsUcBpwSrDte5NO1KsCbh+Am7aGUcn0OpWMafaL0=;
        b=nORop46piOv6ODSxDbpUSI2foMtDncVlwpyL4SbDnL78p0bnEweeSOJPb0eWV9lZAd
         0WQNUvf4DIwD3grJz4JkoJm7TRYSDD5dB7FqE9fJGLPph2lmdk8NCNSa3/8PB0v0zPsV
         jIAXcqB4w1sxM5OF18Lu1TMesRq7gsfPrCGc7iS0LzwQzR63aqtbgsSztPPFT6ggQbE7
         3SSdu+9+K9OXCYF2euMnJOVDzYjvJUxDT8Qr5Sv5OpixJ1NdNPV/oVoniy6x7wVQbefN
         YwxfJmYJry4+z1zBbqH1jO84kAKmPDrqPtZEc9EcdwrbDEcfcy+nW4OnPzleC9Hv4Tjy
         eH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787713215; x=1788318015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6uGsUcBpwSrDte5NO1KsCbh+Am7aGUcn0OpWMafaL0=;
        b=ft+wVESZJ4Z2e1uyQxwktOyrNNrqT5eXSLDzswK+B8xd55gV/w1ak4hcxf5enezV6X
         p8PikVBs8nqJ3WI3bg7Zk2Mqmp9zKc9KLkVRuZmzUkM0ImpJkzzyln1r0sxLDkQ4QZJC
         gcwN367DwkvZhBHHuU2mkJKlh+BGntqrlx5Ab5JZKOaQd7446PBpziPqAPScFQJwvAOC
         Jxiu9JHyDBZzli3t66NmSi/Dv7EQlbDDf55Q1s5Ieax35bj42F/jlNWVuf+MKxUrJcLm
         XVWV1RpKCcaYcM72omwVYxdAmjcojre/e5neYw7U9HFM1l2gx/+1mc6rE6WzIzdQ7SP2
         Bssg==
X-Forwarded-Encrypted: i=1; AHgh+Rpj+6gUsJJYioJZJQ2y9wtcpyihgb//U3XXFVOggbsy/g5jGUll4FCGmnrv3BWpqapeGnDCu2mh44DTgME99B44eEs=@vger.kernel.org
X-Gm-Message-State: AFuF++mvcBFtchT4sW4S6DwEgSJHj8ysmwPTgiSuLPPUvCpZQTfy1ZIM
	AnJDQPXNl6B8c7fnCdui0cUdxrq8TvuRuLaGfgndIwYBMrxCzTo2KLb7RfesRmLY4Ksz2Q==
X-Gm-Gg: AR+sD11mRXM83IrHtcdwqBVaG4F89UXLGF3fLcMRUgD+XfFM34RG5f20jZFAlnGQhXr
	lNdZSUkSI8lMJKJNCmtE4ILHBphwh4lKXNJy3mU2gCyl0mwR0fJjmfTKZj40ejuAvPDFNHnf3vG
	/jTH+DwqdyfMBNgqwn9Seas8bsZzcFczqLZH63xUocdYfxOuHqtS0Q+rGzeAQ9eGKus4loXAc0f
	uAhvsZxaAwrVV+k4vGTPRlPb/enmWdv34ohsHRK9SfHLHo8XD5OZjb50vQdxaORGeiLvpYSgux/
	d3znZC5Ri8qGwWNooEHLhUSgIaF6lUYTV6eakQTYCwRIKcPDDCNq7/TUvp6i1TiqKUn7R4mG5Lr
	DSL+ybhbp1JL58l2T6izUzvprUMhUNCuiGQJxH8aUG5QewFufrVUPxsEd6ICoibY/2MZN+pYlzV
	JWxNFxRH6bzRyuZkEujxwl1s+zC2Q7R8dy6PIn9N41zzHjJOX1LwLCkoeJoXJ0pTIB/7TePiE61
	NpVNaS+eECYucVyk4vvxJ4aHA==
X-Received: by 2002:a05:6870:c6a7:b0:448:71f4:a28 with SMTP id 586e51a60fabf-46597c51710mr4868190fac.2.1787713215432;
        Tue, 25 Aug 2026 20:00:15 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465adf69375sm1082389fac.7.2026.08.25.20.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 20:00:14 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v4] tracing/probes: Fix use-after-free on field name/type of events with multiple probes
Date: Wed, 26 Aug 2026 11:00:09 +0800
Message-ID: <20260826030009.1855331-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260825102221.79713c98@gandalf.local.home>
References: <20260825102221.79713c98@gandalf.local.home>
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

An event can have several probes attached. The field list is defined
only once, by the first probe that registers the event, but it is kept
alive by any surviving sibling probe. Deleting just that first probe by
symbol -

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

Have traceprobe_define_arg_fields() duplicate the name and type strings
and anchor the copies on the trace_probe_event, which embeds the event
call and outlives every individual probe; trace_probe_event_free()
releases them.

The reproducer above triggers reliably; the field lookup and the delete
both run under event_mutex, so this is a dangling reference after
removal rather than a race.

The issue was found by the autokbug dynamic kernel fuzzer at Tencent
Yunding Lab.

Fixes: ca89bc071d5e4 ("tracing/kprobe: Add multi-probe per event support")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
v4:
 - Drop the redundant "added by the Fixes: commit below" and reword the
   code comment ("an event with multiple probes attached"; clearer last
   sentence), per Steve's review.
 - Steve: drop the sentence explaining the move from the previous
   version from the changelog.
 - sashiko-bot (ack'd by Steve): traceprobe_define_arg_fields() may be
   called again after a failed first attempt, since event_define_fields()
   ignores this hook's return value. Freeing and resetting the leftover
   duplicates at entry avoids leaking the previous array and writing
   past the new one.
v3:
 - Move the fix out of trace_events.c into the probe layer
   (traceprobe_define_arg_fields()/trace_probe_event_free()). Ownership
   lives on trace_probe_event, whose lifetime matches the field list.
 - Clarify this is kprobe multi-probe-per-event, not eprobes, and add a
   shell reproducer.
v2:
 - Changelog wording (superseded by v3).

 kernel/trace/trace_probe.c | 48 ++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h |  2 ++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index c4163904ba747..0dfeb6d5eec07 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2552,19 +2552,60 @@ int traceprobe_set_print_fmt(struct trace_probe *tp, enum probe_print_type ptype
 int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 				 size_t offset, struct trace_probe *tp)
 {
+	struct trace_probe_event *tpe = trace_probe_event_from_call(event_call);
 	int ret, i;
 
+	/*
+	 * A field created by trace_define_field() only stores the name and
+	 * type pointers, it does not copy the strings. Here they point into
+	 * the probe_arg of @tp, which is freed when @tp is removed. For an
+	 * event with multiple probes attached, the field list is defined
+	 * once by the first probe but kept alive by the surviving siblings,
+	 * so removing that first probe would leave the fields referencing
+	 * freed memory. Duplicate the strings and anchor the copies on the
+	 * trace_probe_event, which lives as long as the field list itself.
+	 *
+	 * event_define_fields() ignores the return value of this hook, so
+	 * if a previous attempt failed before creating any field, it may
+	 * call here again. Release duplicates left behind by such an
+	 * attempt before starting over.
+	 */
+	for (i = 0; i < tpe->nr_field_strings; i++)
+		kfree(tpe->field_strings[i]);
+	kfree(tpe->field_strings);
+	tpe->field_strings = NULL;
+	tpe->nr_field_strings = 0;
+
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
@@ -2576,6 +2617,11 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 
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
