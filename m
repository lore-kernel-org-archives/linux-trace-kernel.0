Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5035DEB64D7
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 28 Jun 2023 11:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjF1LyI (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 28 Jun 2023 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjF1Lxw (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:53:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979430C0;
        Wed, 28 Jun 2023 04:53:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so617918b3a.0;
        Wed, 28 Jun 2023 04:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953230; x=1690545230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZbLxco0Ofu4f2+jSlKqxXwiBG58604fkff8iqQqj3g=;
        b=Je17GfKPsUaJwNgDjv8NofN7dGzKWM8JuZwCDPH/+6hFcQ1mkslZ8lMMxgPf+K68sM
         LWfgnQ4nhpjthCplMD7L3t+Jcrj2ul8FM05x5TYx+q2orgRVPWl0K1qAu4uarU9cGgmp
         bc0qRL6I55+NZMiee4LqIW5TmxYiuBB2NqywC7XBSk6nhXoAQsyy1E6F9vp83kRRgizM
         NQaTs1dtFWHwJgANJaOvjcaNQToB0gyx1MA1d77zv4sP/aFd/RqPRzi3M1499SRMHVkK
         18MW2CHFG7ED8Su+lFISh3NNMDdlMzL3FcrN1Px9jD1Cy6MjuylIo1E+DwAFBFercvGv
         bJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953230; x=1690545230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZbLxco0Ofu4f2+jSlKqxXwiBG58604fkff8iqQqj3g=;
        b=jMocGsGapyAMQWqUbSF0E2nTqahNgAbomd4ZSCTOKY0vICBKAnCA+c4h0C50yuoTWT
         v64gQsSaMNjpzzJoZoZSYQ/lfG1lduQx9ZHn0C0QQ/TgPSOIqKGlJw6kDk/T681yCVA7
         HnCd3eaD9ibiK/xi20rGkJFCJgNsO2PkpMMz+8VabXzbp7ZqWNeXTdAqlNinUUPM1Ssy
         8qZLZQJqeie7Moj1K1zF0NVGc6gIOowVY/79rhAmuy1ftyIQ601sI4yrWZumYr9tE1Mx
         63sCxrGH2/8qxtIO/aAIMvjd2fJ15mu9bXTVOLcgDqEVbSY68uHrjAeYzEsveemPrrcq
         IYww==
X-Gm-Message-State: AC+VfDyjF3SuW8RrqE+Yn12pqxo+X880NxvApHg0YuexLQDCTcKDNF2r
        leXkPqKXi5gCQ6q5YOkmhyk=
X-Google-Smtp-Source: ACHHUZ67zh7HBk77qFYds65CxDQBGAX+6IDuifKway3Tykvx/cOVl1hOq8O+/Ink3l3rLAbisHZ8fw==
X-Received: by 2002:a17:90b:4fcc:b0:262:eb20:2dd8 with SMTP id qa12-20020a17090b4fcc00b00262eb202dd8mr1319105pjb.20.1687953230659;
        Wed, 28 Jun 2023 04:53:50 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:50 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, quentin@isovalent.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH v6 bpf-next 10/11] bpftool: Add perf event names
Date:   Wed, 28 Jun 2023 11:53:28 +0000
Message-Id: <20230628115329.248450-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Add new functions and macros to get perf event names. These names except
the perf_type_name are all copied from
tool/perf/util/{parse-events,evsel}.c, so that in the future we will
have a good chance to use the same code.

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/link.c | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 34fa17cd9d2a..ba67ea9d77fb 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -5,6 +5,7 @@
 #include <linux/err.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter_arp.h>
+#include <linux/perf_event.h>
 #include <net/if.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -19,6 +20,72 @@
 static struct hashmap *link_table;
 static struct dump_data dd = {};
 
+static const char *perf_type_name[PERF_TYPE_MAX] = {
+	[PERF_TYPE_HARDWARE]			= "hardware",
+	[PERF_TYPE_SOFTWARE]			= "software",
+	[PERF_TYPE_TRACEPOINT]			= "tracepoint",
+	[PERF_TYPE_HW_CACHE]			= "hw-cache",
+	[PERF_TYPE_RAW]				= "raw",
+	[PERF_TYPE_BREAKPOINT]			= "breakpoint",
+};
+
+const char *event_symbols_hw[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= "cpu-cycles",
+	[PERF_COUNT_HW_INSTRUCTIONS]		= "instructions",
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= "cache-references",
+	[PERF_COUNT_HW_CACHE_MISSES]		= "cache-misses",
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= "branch-instructions",
+	[PERF_COUNT_HW_BRANCH_MISSES]		= "branch-misses",
+	[PERF_COUNT_HW_BUS_CYCLES]		= "bus-cycles",
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= "stalled-cycles-frontend",
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= "stalled-cycles-backend",
+	[PERF_COUNT_HW_REF_CPU_CYCLES]		= "ref-cycles",
+};
+
+const char *event_symbols_sw[PERF_COUNT_SW_MAX] = {
+	[PERF_COUNT_SW_CPU_CLOCK]		= "cpu-clock",
+	[PERF_COUNT_SW_TASK_CLOCK]		= "task-clock",
+	[PERF_COUNT_SW_PAGE_FAULTS]		= "page-faults",
+	[PERF_COUNT_SW_CONTEXT_SWITCHES]	= "context-switches",
+	[PERF_COUNT_SW_CPU_MIGRATIONS]		= "cpu-migrations",
+	[PERF_COUNT_SW_PAGE_FAULTS_MIN]		= "minor-faults",
+	[PERF_COUNT_SW_PAGE_FAULTS_MAJ]		= "major-faults",
+	[PERF_COUNT_SW_ALIGNMENT_FAULTS]	= "alignment-faults",
+	[PERF_COUNT_SW_EMULATION_FAULTS]	= "emulation-faults",
+	[PERF_COUNT_SW_DUMMY]			= "dummy",
+	[PERF_COUNT_SW_BPF_OUTPUT]		= "bpf-output",
+	[PERF_COUNT_SW_CGROUP_SWITCHES]		= "cgroup-switches",
+};
+
+const char *evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX] = {
+	[PERF_COUNT_HW_CACHE_L1D]		= "L1-dcache",
+	[PERF_COUNT_HW_CACHE_L1I]		= "L1-icache",
+	[PERF_COUNT_HW_CACHE_LL]		= "LLC",
+	[PERF_COUNT_HW_CACHE_DTLB]		= "dTLB",
+	[PERF_COUNT_HW_CACHE_ITLB]		= "iTLB",
+	[PERF_COUNT_HW_CACHE_BPU]		= "branch",
+	[PERF_COUNT_HW_CACHE_NODE]		= "node",
+};
+
+const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX] = {
+	[PERF_COUNT_HW_CACHE_OP_READ]		= "load",
+	[PERF_COUNT_HW_CACHE_OP_WRITE]		= "store",
+	[PERF_COUNT_HW_CACHE_OP_PREFETCH]	= "prefetch",
+};
+
+const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[PERF_COUNT_HW_CACHE_RESULT_ACCESS]	= "refs",
+	[PERF_COUNT_HW_CACHE_RESULT_MISS]	= "misses",
+};
+
+#define perf_event_name(array, id) ({			\
+	const char *event_str = NULL;			\
+							\
+	if ((id) >= 0 && (id) < ARRAY_SIZE(array))	\
+		event_str = array[id];			\
+	event_str;					\
+})
+
 static int link_parse_fd(int *argc, char ***argv)
 {
 	int fd;
-- 
2.39.3

