Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608243E088
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202369; cv=none; b=G4eLem2NEjwjqWsrwyQC0bX6ONulHcxrIl7+w9m6SRHNIS5kDpeLKVxXpAvW5FBt8pW0XHMhsoLZofs5fawEUvLkQeoRCBucPWooFjqC6W66MSVwC5I5GJDv0+vZD3Vqt9BB23ffQYz/oJWvIaIdkT387se6p/NMJFQ8FI74Dlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202369; c=relaxed/simple;
	bh=AlXy/RKa7lYPwwjke68rrp2i8gDyh6I1oVn1T+ezKJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LyRw+OV49KuyuY1JwiZkmLCsEZ53Oby89dXOlVTdzzOSdmnGfCts8OxsYW345AJ6fbuhQSQINrf1n8UWpSKLvJKrN+/4UqX39o7fPts2mpt5x4Z+qX1dj1Cn9Bi0M2j86ylsUJbPgLeVoA5VO4Thx8CXy1VzYsH27NxFKpodiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEA5XJPk; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEA5XJPk"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398beb616f5so206746a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789202366; x=1789807166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDxUakfEYtbtvuobWNHRWYrRJD4789BvjbDj2lgSuqE=;
        b=SEA5XJPkMYIHca8aXoZZ32uSGhWGnr6OUlWID78UXv8mpW+TzfSresFwKdnQYrZxTw
         TRFfSZoUrN2gzjOJ64ZXMV5PdB6FkX/pIxMAzy7OGipa2OmhoawfR6fbeMYOwdOF7cRu
         SJgCcxxWXT5Q6iBN1u78tGwjbGml0KT66p7ceufbrMSa6I9JftQI9R3B/YkDz34Z6Xjf
         I/nvti661Mtt+CrOi7tKB8qTaeD7QbSwWKCfJqORTOSf/DEiNhiAbVmXlhtLEEPi1vwu
         Jyk+SStFPQ2DTtFHWCTjIXiWyifbHbyS0/zdD70YCZ0avVU7dPU+IkDnMZ5ENk4p2RkV
         NBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202366; x=1789807166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qDxUakfEYtbtvuobWNHRWYrRJD4789BvjbDj2lgSuqE=;
        b=fg40aShvU/AMrTm15Spai18qOGnMVyqqRzBJjJlgaj52l6Zmbz47dgUC5ND1BSrKII
         ZpG2xq34YPNxGGVTuFbuSrHQbPfw4rrGAM9EdDKAFrlaaE6+rnZDxXFcKPO22iuVhFHu
         DDZOOdMDHx4+sFuuuuSytjWFvuUX7aYnfPvueF8FhZKU+Hkh/gL0vyO6HZ0XglZsGuVm
         ZmkKBJFgviyUFnjjN1PNRq/gGQlzyM2x2dVem7kIYQerNXJPdiQRMY/F1cis+PGbgfuw
         C4sH6RzUbx+V6uBzLmUoSyaWfWTTmjR7yOA9aKuHwfLHCqaOxNEED69xmDEQhJgeAdo5
         cYLw==
X-Forwarded-Encrypted: i=1; AKwUvBznfN8LCTBnkYgNi69tfPlYoWFK2/W+5qwoocctNh5dISi+Ezn0PMcsu06K0T+bjSqhVKCrYLz+iN5/G/OSG97+3LA=@vger.kernel.org
X-Gm-Message-State: AFuF++kPsSI4Modk4Idpdj+iuPHfdhWegyt4QjqJ5FB2lU3bMzSWepaw
	crQS2sORtFrk8qt1FSGXQAcgphuxh5fEnSHF0wfBLhAoBBY3tw/70yfM
X-Gm-Gg: AYBFou1FPu6FnvdJ9u7NcvXlmqyziy4zFyOxeMY4VreDm7kznnvDvTXwy56GUyM6UE0
	ePBsLDpZFSfR9o6ifCu2YiExL3lsvFbehNueFzJauxmp1ooqbc74QA2OJCucxohKgBQetLOegp+
	vy/co0XePwsImd7gdStRA9OLEiFPpJpFZ0bMeASrpLQzB5z/4X/iO+UoauOa/J4oIecTg4LFF7B
	sMt039WKhN2WvJ8A9cZYN8wRf73nqA991sTy72/nnX3ZhN0WQPNzz+MgQW0UcabOhvIqoqoXhj0
	OeXTW0pWgs92Rt92bMdaa43qP/nv21CFrqVQIsf1Ib16INu+MTSK6JuKE786Hx4S8PdE27fM7EV
	7THpiyvASMsJanpnT07GLFuCNBSHalUCJSWP/ymIr1vFSpUXb8zIuKlk5K0ORmRRrkgwJdGCypG
	Dvr2WNoywH+2ygextOtnJanCGrDaKiCxrhIlha/aZf4qrIH2oeIspRwYDoEGLASqKMF2Mnujx2M
	H/3RcvWXFLDyrWqMIvYAe7/csH/KrgiOPTgVESz
X-Received: by 2002:a17:90a:f947:b0:398:baa7:4c2f with SMTP id 98e67ed59e1d1-39d97eeac5cmr7896910a91.5.1789202366232;
        Sat, 12 Sep 2026 01:39:26 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:16a3:d08b:6ddb:dec6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm9790583a91.3.2026.09.12.01.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:39:25 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	lkp@intel.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH v7 05/10] trace: make the stackmap capacity settable on the kernel command line
Date: Sat, 12 Sep 2026 16:37:48 +0800
Message-Id: <20260912083753.3426176-6-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Add ftrace_stackmap.bits=N to size the map at boot, replacing the fixed
capacity the map was created with so far.

N is clamped to [10, 18], and the value is clamped again at create time
so a bogus setting cannot get through even if early_param is bypassed.
The upper bound keeps the worst case bounded: bits=18 means 256K
elements, 512K table slots and a ~130 MB element pool. The default stays
at 14, which gives 16K elements and a ~8 MB pool.

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++
 kernel/trace/Kconfig                          |  4 +++
 kernel/trace/trace_stackmap.c                 | 36 +++++++++++++++----
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..9ca271e21bf0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1794,6 +1794,13 @@ Kernel parameters
 			can be changed at run time by the max_graph_depth file
 			in the tracefs tracing directory. default: 0 (no limit)
 
+	ftrace_stackmap.bits=
+			[FTRACE] Set the stackmap capacity to 2^N records.
+			Format: <int>
+			default: 14; values are clamped to the range 10-18.
+			The upper bound reserves roughly 130 MB for the element
+			pool. See Documentation/trace/ftrace-stackmap.rst.
+
 	fw_devlink=	[KNL,EARLY] Create device links between consumer and supplier
 			devices by scanning the firmware to infer the
 			consumer/supplier relationships. This feature is
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 7001453bbfd3..b2cde74d803b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -435,6 +435,10 @@ config FTRACE_STACKMAP
 	  deduplicated when stackmap is enabled for their trace array. Stackmap
 	  is currently available only for the global trace array.
 
+	  Map capacity defaults to 2^14 records and can be changed with the
+	  ftrace_stackmap.bits= boot parameter. Values are clamped to 10-18;
+	  the upper bound reserves roughly 130 MB for the element pool.
+
 	  The deduplicated stacks are exported via:
 	    /sys/kernel/debug/tracing/stack_map
 
diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackmap.c
index 439d3be9e351..49ea403822ba 100644
--- a/kernel/trace/trace_stackmap.c
+++ b/kernel/trace/trace_stackmap.c
@@ -150,12 +150,31 @@ struct ftrace_stackmap {
 };
 
 /*
- * Map capacity: 2^FTRACE_STACKMAP_BITS stack records, with the hash
- * table over-provisioned 2x on top of that. This gives 16K elements
- * and a ~8 MB element pool, sized for the repetitive-stack workloads
- * the map targets.
+ * Map capacity: 2^bits stack records, with the hash table
+ * over-provisioned 2x on top of that. The range is capped to keep
+ * worst-case allocations bounded:
+ *   bits=18 -> 256K elts, 512K slots, ~130 MB elt pool, and a
+ *              stack_map_bin reader walking that many entries.
+ * The default of 14 gives 16K elts and a ~8 MB pool, which suits the
+ * repetitive-stack workloads the map targets; raise it through
+ * ftrace_stackmap.bits= for a higher stack-record capacity.
  */
-#define FTRACE_STACKMAP_BITS		14
+#define FTRACE_STACKMAP_BITS_MIN	10
+#define FTRACE_STACKMAP_BITS_MAX	18
+#define FTRACE_STACKMAP_BITS_DEFAULT	14
+
+static unsigned int stackmap_map_bits = FTRACE_STACKMAP_BITS_DEFAULT;
+static int __init stackmap_bits_setup(char *str)
+{
+	unsigned long val;
+
+	if (kstrtoul(str, 0, &val))
+		return -EINVAL;
+	val = clamp_val(val, FTRACE_STACKMAP_BITS_MIN, FTRACE_STACKMAP_BITS_MAX);
+	stackmap_map_bits = val;
+	return 0;
+}
+early_param("ftrace_stackmap.bits", stackmap_bits_setup);
 
 /* --- Element pool --- */
 
@@ -182,12 +201,17 @@ static struct stackmap_elt *stackmap_get_elt(struct ftrace_stackmap *smap)
 struct ftrace_stackmap *ftrace_stackmap_create(struct trace_array *tr)
 {
 	struct ftrace_stackmap *smap;
-	unsigned int bits = FTRACE_STACKMAP_BITS;
+	unsigned int bits;
 
 	smap = kzalloc_obj(*smap, GFP_KERNEL);
 	if (!smap)
 		return ERR_PTR(-ENOMEM);
 
+	/* Defensive clamp even if the early parameter path is bypassed. */
+	bits = clamp_val(stackmap_map_bits,
+			 FTRACE_STACKMAP_BITS_MIN,
+			 FTRACE_STACKMAP_BITS_MAX);
+
 	smap->tr = tr;
 	smap->map_bits = bits;
 	smap->max_elts = 1U << bits;
-- 
2.34.1

