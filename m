Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1363D331C;
	Tue,  3 Feb 2026 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135620; cv=none; b=M7GZkZ0E/Cm34luuvDPaWAZ9KuU32Rv22fAvpJ2U+8Yi8fLP1+fGXC7kmxq1RE8MFe332Uzv6HQosdNiNW12hZVTDu4YpB4Hmsyfycjanl3NYFy7LRdxCJQ+hxtH6sGFRrtgq8LxBGQsi25uTWBV35vxrNnjEgauH71myl/jAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135620; c=relaxed/simple;
	bh=yuL+6Sbc5lFx0zb3DLHZHkwLxr6ZnwQXx5POgp0/D9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAJkEP2FN1LgQp/Ipi8OlErz/lOlffmSZqFPfRxesT+tEvhWgOUX951NDWyy+XZHlBmJMnNMKE9+jECXAQCH8v/T55wo5iXpnSyCuab2ZaIZIltGpY+BVgrbCNojMgjmE7o55AZbt3t/N/fP/QxpjgW9SLZmklcIH6LHI1Gw4cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id C8A751402FA;
	Tue,  3 Feb 2026 16:20:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id DB86B20;
	Tue,  3 Feb 2026 16:20:14 +0000 (UTC)
Date: Tue, 3 Feb 2026 11:20:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "jempty.liang" <imntjempty@163.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset
 for 32-bit ARM
Message-ID: <20260203112040.01bbb8e9@gandalf.local.home>
In-Reply-To: <20260203093018.66c3b3b2@gandalf.local.home>
References: <20260202123342.2544795-1-imntjempty@163.com>
	<20260202103804.40cbaa27@gandalf.local.home>
	<20260202110828.440c8d44@gandalf.local.home>
	<19eab264.7fae.19c22f5d17c.Coremail.imntjempty@163.com>
	<20260203093018.66c3b3b2@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DB86B20
X-Stat-Signature: u7ksmy8hpunseeauwg7mznw7rwwahtz7
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/bH0oIrJ+5Jbm7qNfFx4SfGQeE09BBnEc=
X-HE-Tag: 1770135614-998761
X-HE-Meta: U2FsdGVkX18etqHfERoXlH9Cguv2VeO2Wj12MUlcHPuNcrVLbvgQ0Q5NCPRp6/DaLlMh2fsQo9GqVwIGHtqg4IicgxPNdzmLUbdsqZqq8BocEcrbnkwN505JNK0V5sXQZjyEvZp/E4wiCudZ4k2cpU2nn0UwY16pzwFiZK1uGtfhXRW7OIcoliXFLm6UZ3QD5UNiuu1rJ7/pscvgevp98SaXsEiQShsz5Iah8vaFZ1xMjebmhPpbiMSxVpMcEwWkc0RbmCOFt21GH077Gb2YC78FPwVJAH5qxEM1z92wyorIG4QAeMp0wj/vm48W7ouYgeUfTSpMEBJUB0aoO1ZfpOHwQ7IpoIJZwmMMj+MZQKrPeNl5CIjzriWnkMfHGnQk

On Tue, 3 Feb 2026 09:30:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > On the 32-bit ARM platform, when _type is unsigned long long, the resulting align value is 8 instead of the expected 4.  
> > >     
> 
> Are you saying this still doesn't work?
> 
> That would be an issue because then it would have the same bugs with
> generic trace events which uses the same solution.

OK, so talking with others that know more about arm32 than I do, it can
indeed still produce an 8 byte alignment.

Anyway, I still want to fix it properly. Does this patch work for you?

-- Steve

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b6d42fe06115..c11edec5d8f5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -68,14 +68,17 @@ enum trace_type {
 #undef __field_fn
 #define __field_fn(type, item)		type	item;
 
+#undef __field_packed
+#define __field_packed(type, item)	type	item;
+
 #undef __field_struct
 #define __field_struct(type, item)	__field(type, item)
 
 #undef __field_desc
 #define __field_desc(type, container, item)
 
-#undef __field_packed
-#define __field_packed(type, container, item)
+#undef __field_desc_packed
+#define __field_desc_packed(type, container, item)
 
 #undef __array
 #define __array(type, item, size)	type	item[size];
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index f6a8d29c0d76..54417468fdeb 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -79,8 +79,8 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
-		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	unsigned long,	graph_ent,	depth		)
+		__field_desc_packed(unsigned long,	graph_ent,	func	)
+		__field_desc_packed(unsigned long,	graph_ent,	depth	)
 		__dynamic_array(unsigned long,	args				)
 	),
 
@@ -96,9 +96,9 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
 
 	F_STRUCT(
 		__field_struct(	struct fgraph_retaddr_ent,	graph_rent	)
-		__field_packed(	unsigned long,	graph_rent.ent,	func		)
-		__field_packed(	unsigned long,	graph_rent.ent,	depth		)
-		__field_packed(	unsigned long,	graph_rent,	retaddr		)
+		__field_desc_packed(	unsigned long,	graph_rent.ent,	func	)
+		__field_desc_packed(	unsigned long,	graph_rent.ent,	depth	)
+		__field_desc_packed(	unsigned long,	graph_rent,	retaddr	)
 		__dynamic_array(unsigned long,	args				)
 	),
 
@@ -123,12 +123,12 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ret,	ret	)
-		__field_packed(	unsigned long,	ret,		func	)
-		__field_packed(	unsigned long,	ret,		retval	)
-		__field_packed(	unsigned int,	ret,		depth	)
-		__field_packed(	unsigned int,	ret,		overrun	)
-		__field(unsigned long long,	calltime		)
-		__field(unsigned long long,	rettime			)
+		__field_desc_packed(	unsigned long,	ret,	func	)
+		__field_desc_packed(	unsigned long,	ret,	retval	)
+		__field_desc_packed(	unsigned int,	ret,	depth	)
+		__field_desc_packed(	unsigned int,	ret,	overrun	)
+		__field_packed(unsigned long long,	calltime)
+		__field_packed(unsigned long long,	rettime	)
 	),
 
 	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u retval: %lx",
@@ -146,11 +146,11 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ret,	ret	)
-		__field_packed(	unsigned long,	ret,		func	)
-		__field_packed(	unsigned int,	ret,		depth	)
-		__field_packed(	unsigned int,	ret,		overrun	)
-		__field(unsigned long long,	calltime		)
-		__field(unsigned long long,	rettime			)
+		__field_desc_packed(	unsigned long,	ret,	func	)
+		__field_desc_packed(	unsigned int,	ret,	depth	)
+		__field_desc_packed(	unsigned int,	ret,	overrun	)
+		__field_packed(unsigned long long,	calltime	)
+		__field_packed(unsigned long long,	rettime		)
 	),
 
 	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u",
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 1698fc22afa0..32a42ef31855 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -42,11 +42,14 @@ static int ftrace_event_register(struct trace_event_call *call,
 #undef __field_fn
 #define __field_fn(type, item)				type item;
 
+#undef __field_packed
+#define __field_packed(type, item)			type item;
+
 #undef __field_desc
 #define __field_desc(type, container, item)		type item;
 
-#undef __field_packed
-#define __field_packed(type, container, item)		type item;
+#undef __field_desc_packed
+#define __field_desc_packed(type, container, item)	type item;
 
 #undef __array
 #define __array(type, item, size)			type item[size];
@@ -104,11 +107,14 @@ static void __always_unused ____ftrace_check_##name(void)		\
 #undef __field_fn
 #define __field_fn(_type, _item) __field_ext(_type, _item, FILTER_TRACE_FN)
 
+#undef __field_packed
+#define __field_packed(_type, _item) __field_ext_packed(_type, _item, FILTER_OTHER)
+
 #undef __field_desc
 #define __field_desc(_type, _container, _item) __field_ext(_type, _item, FILTER_OTHER)
 
-#undef __field_packed
-#define __field_packed(_type, _container, _item) __field_ext_packed(_type, _item, FILTER_OTHER)
+#undef __field_desc_packed
+#define __field_desc_packed(_type, _container, _item) __field_ext_packed(_type, _item, FILTER_OTHER)
 
 #undef __array
 #define __array(_type, _item, _len) {					\
@@ -146,11 +152,14 @@ static struct trace_event_fields ftrace_event_fields_##name[] = {	\
 #undef __field_fn
 #define __field_fn(type, item)
 
+#undef __field_packed
+#define __field_packed(type, item)
+
 #undef __field_desc
 #define __field_desc(type, container, item)
 
-#undef __field_packed
-#define __field_packed(type, container, item)
+#undef __field_desc_packed
+#define __field_desc_packed(type, container, item)
 
 #undef __array
 #define __array(type, item, len)
