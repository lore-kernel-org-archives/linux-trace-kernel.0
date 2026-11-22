Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307725;
	b=zrV7AGhWJeKbRgUAltQAEPzbmheRTmuTTDcrsrmEeeoWSEQHZp4mop7N9gMYGSlATg3l
	 ZLHBKsYJPANPGix3KOsrGpOoBO3Zrt3FlReY34i9yqmJg+jKa+PbNUuDwM7cjhH97cm73
	 T3+5OtUsF5/Uu3euBU+NGTinxwRCYJTTAST1KIpI1hwtW4tz9HM41RMJy/M81jhaWQmGz
	 q50KLgT93Lj+BLbxFooLXmXgfmpdZ4GOByDj3zfhVdFXdN7tMBZPSNyC6OXcMh+oJXzvF
	 LhVzs6NUuvGBmPgG9KKPLWYDSt1lc4EBpVUDToC5KTL1NuC+PoQCP9iPz5IKgEasc6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vxj37Hr5O+kDPLZxiNuhBV6UtfZk88fpDy0o/vxTN+c=;
	b=l8OaU9gVA/bF8rkFGtcVO8fLse6htr4mXvYMn6QdmyYeZTV4C8yLqDAgbjynlbeeof8k
	 4tBpuO9DMwXEOR50SOXX35GtrsZJbmqMnMxvCUdkpYoNQ6gYt+2nvR5u7KSHocsMynh3H
	 KLEtRl/ajgyiXB6BGQ0du/39Plg7/ygrWAJ7hLrMnUdeRYPOab3+nViFeSOmaBE7vHsnb
	 G7i3ozrT3l+tv8JvYeGpmFSzt6Syj9lb8jYa+CEyZwQbpErsJ5PP96Qj+3wqBM0+/dyun
	 cU8Et30f+DBzP7EA89tmHwTxkv4cfrru4gWmewX/mId3iZ6xxtOxRIZjVrGfTCr6+Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fdPu4qdO;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4685606A320
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 00:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4685606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fdPu4qdO
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so18892025e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 16:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795307723; x=1795912523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vxj37Hr5O+kDPLZxiNuhBV6UtfZk88fpDy0o/vxTN+c=;
        b=fdPu4qdO30qiivSx5Rj+zo0EF57i8QoJJ+6qC4p87IBxoIIY0w3HMmkr/R5iW95SCL
         1wvzqzDZxUPrmbIkMg8kpMR5WqD1OCx38a9GRbJN0+Wq0aewIYrA1e9DIbEEBU88eBEn
         +0Lq3qOoN/7PuHocdqMarDfvPrx9Di13lMiKOaV5T2kpPlOt0ZBgcW67jpGsWwBgDDBW
         6hLS4fZqC3cNC1x/0aMNBkmfJHo0jJmRhaGO2GaSYlBBosUuo9IAGHVkKXBv/fcc7zUS
         cYu4eJmCH00ZD3pCPwC1rrHs9kGWJrvDY420e9Fjh8i6UFeoTZiujBTz5JqaE+DNl/8R
         zT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795307723; x=1795912523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vxj37Hr5O+kDPLZxiNuhBV6UtfZk88fpDy0o/vxTN+c=;
        b=oquHQadA6KGlISPB6GGN+pZefunZAwu0gh3KSgCgf501KqHXywIu6LHu0/DHl8up45
         o7Ea5m64ao4+9ffUeCrUxkyKDyE8IkzRXJEEeMbzy1cZ0xtCIUzumf/G/soW5qkbrlT3
         Agza324iM0aynPkUxjQIYDd3OdaDr5l8K61IpgkU9tMReWt5Kc0dkCj3IWGNKVrINzdm
         /aHtDRyKPB8k9tiKjBZfAuFOQ/rJbhLd2VhD7sSPDjcoJwEoifc670XPJIYBLbS9zA9q
         pKNCnnxtsL3E1t7y0SchmM0J4kSPtLbLqZ6FI1fDuri33MckrbNYN2dOEKcPx6QOwcpm
         C7tQ==
X-Forwarded-Encrypted: i=1; AL+hErE0mLOPJK80za8BRHJQfxoM+C3br9WgDYyTT+rSVdMpMsQuGyrhFGmcGOQwseNh6mydWbQ9LxkGRI4hVxrzFJbLWQY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vrciv3/VB/UYf4JnpqpUKg+t+sHJvYfjwmKOCMV63ghE2vG0M
	j1/TagMAMjEOj7B45FUPRvRyD7NwSrOwbsE+uxVwylcGHSX98LtIaJmS958Wsw==
X-Gm-Gg: AZFdTZftTAnuEjj1959KP1PjRs6jUdbf8XrSRXQvOXeqP8kut6gI6L5iF2tQ8a63axj
	neQpf07QOBsBo3vPG2oAUF5IySc+lM4ozcDp6DjUdTf/L1OTa/2DmPDHguXg5tz5UZ0OrClBcif
	H2n2x7qBPDjVkkJ9UjKgm7QF8q8jsZ37PGuToZ9czVzOg5NrcV2fdsQFgk8JrNtt0rbtLmghBfH
	qm43DYD9/Ym6otiJeMYv6J1lqk+6apw3lV6quccSZsnXNeLoJAYcfdEllonpWmlZccUGYCisHNQ
	x6RAD4omFmENgWYlLdq5nOvtSdBxhkh8TLKzAqYnv78moH0cofAToNHNvtm/7oU/aQuNj85C51v
	Ck7HxbxdeGEnlWLkr09ClPwsyaLJ7D2mt0VAgADOKkE9jx4p02EZZqRN49n211SywvKg5ZE/EHd
	ngTbItpy2V7Vcay3KGbpra6KcUazpk4hW8IySDlTpzpOKL3bmKjI4KxlxkYD6qWhU/mHAeEOReW
	lfWeL70uGtJPIF4qLVCb3G/Af5z03jXvP1bXG+JrqIHgU7rWqcOvmkCo8QaHrtRvoFRXSyLxxbk
	lT8i3kaLxbqDm5p4abYj00xNGgGNl4R56K9rBsUPGM8nSB+NpDjLpAQGTnKrHPEMbdatW3w7SeK
	vEAZyrghnf6WjKsHPpAmqItc2TK0mWu0DUCwRNpKN6VkikZEzzDZtgnccjZ85oo02A50c3QbY4P
	dzIe+IaOtlJkAnJpUZbeElZmfPYs/UoSFpMjVIEUOAzOXzAzRFDkBBsKPP7Nt2fqcoiv4G276xH
	qJdj9EzTgwHHje1xw==
X-Received: by 2002:a05:600c:c168:b0:4bb:81b2:c801 with SMTP id 5b1f17b1804b1-4bb889238f1mr154507125e9.20.1795307723242;
        Sat, 21 Nov 2026 16:35:23 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-2025-a95f-1d53-595d.rev.sfr.net. [2a02:8434:fda5:4201:2025:a95f:1d53:595d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm74017825e9.5.2026.11.21.16.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:35:22 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tools/bootconfig: Use the registered global tracing parameter names
Date: Sun, 22 Nov 2026 01:34:58 +0100
Message-ID: <fecf6e33d4f7e2ddf031526e7a1abef27e28f754.1795307698.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795307698.git.edumucelli@gmail.com>
References: <cover.1795307698.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The boot-time tracing guide lists four kernel.* keys that do not match
the parameters registered by the tracing code. For example,
ftrace2bconf.sh emits kernel.fgraph_max_depth, which bootconfig passes
as fgraph_max_depth on the kernel command line. The function-graph
tracer registers ftrace_graph_max_depth.

Use the registered names in the guide and the exporter. Teach
bconf2ftrace.sh to read those names, with the previous script keys as
fallbacks so existing replay configurations still work.

Fixes: 47781947947a ("Documentation: tracing: Add boot-time tracing document")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
 Documentation/trace/boottime-trace.rst   |  8 ++++----
 tools/bootconfig/scripts/bconf2ftrace.sh | 21 ++++++++++++++++-----
 tools/bootconfig/scripts/ftrace2bconf.sh |  5 +++--
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 2c3c1fedb..68fd6152c 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -36,20 +36,20 @@ these options are passed as a part of kernel legacy command line.
 kernel.tp_printk
    Output trace-event data on printk buffer too.
 
-kernel.dump_on_oops [= MODE]
+kernel.ftrace_dump_on_oops [= MODE]
    Dump ftrace on Oops. If MODE = 1 or omitted, dump trace buffer
    on all CPUs. If MODE = 2, dump a buffer on a CPU which kicks Oops.
 
 kernel.traceoff_on_warning
    Stop tracing if WARN_ON() occurs.
 
-kernel.fgraph_max_depth = MAX_DEPTH
+kernel.ftrace_graph_max_depth = MAX_DEPTH
    Set MAX_DEPTH to maximum depth of fgraph tracer.
 
-kernel.fgraph_filters = FILTER[, FILTER2...]
+kernel.ftrace_graph_filter = FILTER[, FILTER2...]
    Add fgraph tracing function filters.
 
-kernel.fgraph_notraces = FILTER[, FILTER2...]
+kernel.ftrace_graph_notrace = FILTER[, FILTER2...]
    Add fgraph non-tracing function filters.
 
 
diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index 6a3535a2c..e7cda59d2 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -276,15 +276,26 @@ setup_instance() { # [instance]
 }
 
 # ftrace global configs (kernel.*)
-if xbc_has_key "kernel.dump_on_oops"; then
-	dump_mode=`xbc_get_val "kernel.dump_on_oops" 1`
+# Prefer the kernel parameter names and accept the old script keys as fallbacks.
+dump_key=kernel.ftrace_dump_on_oops
+xbc_has_key "$dump_key" || dump_key=kernel.dump_on_oops
+if xbc_has_key "$dump_key"; then
+	dump_mode=`xbc_get_val "$dump_key" 1`
 	[ "$dump_mode" ] && dump_mode=`eval echo $dump_mode` || dump_mode=1
 	run_cmd "echo \"$dump_mode\" > /proc/sys/kernel/ftrace_dump_on_oops"
 fi
 
-set_value_of kernel.fgraph_max_depth $TRACEFS/max_graph_depth
-set_array_of kernel.fgraph_filters $TRACEFS/set_graph_function
-set_array_of kernel.fgraph_notraces $TRACEFS/set_graph_notrace
+graph_depth_key=kernel.ftrace_graph_max_depth
+xbc_has_key "$graph_depth_key" || graph_depth_key=kernel.fgraph_max_depth
+set_value_of "$graph_depth_key" $TRACEFS/max_graph_depth
+
+graph_filter_key=kernel.ftrace_graph_filter
+xbc_has_key "$graph_filter_key" || graph_filter_key=kernel.fgraph_filters
+set_array_of "$graph_filter_key" $TRACEFS/set_graph_function
+
+graph_notrace_key=kernel.ftrace_graph_notrace
+xbc_has_key "$graph_notrace_key" || graph_notrace_key=kernel.fgraph_notraces
+set_array_of "$graph_notrace_key" $TRACEFS/set_graph_notrace
 
 # Per-instance/per-event configs
 if ! xbc_has_branch "ftrace" ; then
diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index b3c976bc9..c23e7cc8a 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -46,10 +46,11 @@ emit_kv() { # key =|+= value
 
 global_options() {
 	val=`cat $TRACEFS/max_graph_depth`
-	[ $val != 0 ] && emit_kv kernel.fgraph_max_depth = $val
+	[ $val != 0 ] && emit_kv kernel.ftrace_graph_max_depth = $val
 	if grep -qv "^#" $TRACEFS/set_graph_function $TRACEFS/set_graph_notrace ; then
 		cat 1>&2 << EOF
-# WARN: kernel.fgraph_filters and kernel.fgraph_notrace are not supported, since the wild card expression was expanded and lost from memory.
+# WARN: Cannot export kernel.ftrace_graph_filter and kernel.ftrace_graph_notrace.
+# Only the expanded function list is available.
 EOF
 	fi
 }
-- 
2.53.0

