Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921F3815D3
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 23:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898388; cv=none; b=nqVJ7g9WmAiDSsguG7RqxX2NEQSGbXHbVjOngPUF+iCClMfKApaxG4TmPB7PuWbT6xfce0ctxp4HIsJZboHu3Nzw/B02lSAZwIoonWxS6YWV5ualebQ/D9JZt4vNWKC9w75Zxate+KZy7louylJ+uLPveS1yQdC7fEeag647BU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898388; c=relaxed/simple;
	bh=Whjk9IC5hygHpAH3BmB9KIBiB7myeCeEHo2qEY17RHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCJ2SLCL5DfKTDhs3bC8Vzo39CvNFvBiYKFythWmrH7s7tolTtXK4F43Sli5A12yLLIdvDRqxgf9ZHKReGvtSX42vR6WG4yV3rMjY8njxnXwn4dVaUurSHMxTabEJfyxhbKwjg2CpvLssQwRH3Po8AsgL0UWe1D5SGxbO3h5w9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euEe1hdh; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euEe1hdh"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144efd1ea76so4405712c88.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Oct 2026 16:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790898386; x=1791503186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2hby3hPpEJUKa8O9qSBl+BlKsHlHonnOrzx+w19uMQ=;
        b=euEe1hdhF6VfSCJaFC3mITA/GfSSHXHztkyVXq/xe1bHJR54WDJmEODB8IAMYdP8Zs
         vUhM9NOsgWba/HE09LXsv/PRB6DL8i7CTo+H0Zyiemnjy4Mr9NhFSYptrCoxdg8tGA3Z
         BmoiJWdx0aiK3ogTp3m89tfOlUDZsKUvnghiP4hxXABflBetg9hFZ5OQVwWJYcPvssPr
         ayNyEBld2HJBpnCtOtdGVl15SnyHBEhkdovuWl6wlGZ1ejn2mhqYm86voMOIeMHrpmcY
         H+RK8vpwJvXXXgvcqbIt7UldFZ9GHO98yMdpQKoMQ8Hci2OFWKtJR+ymtro9Vvf97Uci
         8h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790898386; x=1791503186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2hby3hPpEJUKa8O9qSBl+BlKsHlHonnOrzx+w19uMQ=;
        b=Q8WuebacaxnE4RyP63D+GaXZDBDLlGTfWOpEnctYlfyTtiLYQfbZotSlLLFuC1NH9K
         RMtDb7bEl8hviiM1WX1avLtgObwH0R1RKcs2LM9SP4O4S8mjGVNenqnLkIaeaexWvVsD
         vNuXBwY0rL559JAkB+OpXQFvUYjQSNGazRAHG4SA0DCDibxLU88P2oWwMa0cHg79iuEg
         nTwbh318gz7EXX7FqM6tEiVOoVhnwut1UcJ7NSrdhxK5Q7bMLgGJhtSIlbBJYtCMHMTi
         by2qdDiWCMEN+eDt0AfaJKL26KfyhPYEz3u/TAhrA/mkGwO3IkpL+igIFEPoZ52ip5s4
         Innw==
X-Forwarded-Encrypted: i=1; AKwUvBwX8UEv1ZtkY/H3ia2w6942ucxbnblqDRM37BNhlX0zRhyHnRSzeNtLz9wL9auspbcy8ntY/D8wWuWyvRNRU47eNYU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8qlxqMnQLGxzUaUqC/bNSYYFkhzK7F+FXr6bcykmSk0LxiR4c
	3fsDCgp5kIlMOxlJCgvnC2obhc8VVrhEEjMVvNGCNf9Fr063TNwdkd4q
X-Gm-Gg: AYBFou3R4fKj/O5TBsxD7LR0snFMMrQ9M1qPJNOwohd2YxDF9YjDU57jOG9g7Cgq9+s
	TeXlvLVjEJq/Pt1HrWYchh21iFWgwfTrGFfiFvnDkA82arL/7Lzaob4REqC+ZR+IU+aC6y8jicz
	EKq4gPVSF2pKEi+YUUpObSNx6Zp6jcUlSwSRWfcOvtauchqVzCsfgGX43ikkrWIrhDvO8O3JfKs
	5dAavcLCb6ZEYzHT0jfV4YKxKIk4MqmhuscILnc5ythkgDme5Hf9xv5H47Pr1JP2CYPJLBgwP1i
	Ir7h0WuIxmfoiXdb1IyoOKibp6um+tzeJHLKSBtT8vp+q1SD5WsVwGZnzEaCuaKYMMMnNrtgH1v
	IsMrsJgO7bqV3tMwVGpN6pKUcyNC3tX8pOP0XvOl6Kj1NuR41+DOrwwMfmIzZxMyO/YcTD8M4Rp
	zIcgZ+p0DGOGRrgblo0NdYzhQNSvA1a7fGdHinnGDPVoglYcHL5FlrgVlL/2b5BikeJK+2ju4EG
	sa2QBR4
X-Received: by 2002:a05:7022:ea8b:b0:148:302e:1bed with SMTP id a92af1059eb24-14f5c2f1505mr962254c88.38.1790898385400;
        Thu, 01 Oct 2026 16:46:25 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fedd43sm2542818c88.4.2026.10.01.16.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 16:46:25 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ross Zwisler <zwisler@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengchuan Liang <zcliangcn@gmail.com>
Subject: [PATCH v2 1/1] perf/core: Restrict function predicates in trace event filters
Date: Thu,  1 Oct 2026 16:46:11 -0700
Message-Id: <e66d86bf790ce51ca865c354a9b7a716c08b552f.1790891867.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1790891867.git.zcliangcn@gmail.com>
References: <cover.1790891867.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Count-only perf tracepoint events can be opened without tracepoint
permission because they do not expose raw sample data. Their
PERF_EVENT_IOC_SET_FILTER ioctl can still pass filter expressions to the
tracing parser.

A .function operand makes the parser resolve either a numeric kernel
address or a kernel symbol. The ioctl return value can therefore be used
as an oracle to recover the randomized kernel text base.

Trace events marked TRACE_EVENT_FL_CAP_ANY are different: task-local
events may expose their raw fields to unprivileged users. Syscall
tracepoints and uprobes deliberately use this exception, so denying every
filter without tracepoint permission would break their ordinary filters.

Check perf_allow_tracepoint() in perf. If permission is denied, continue
only for a task-attached TRACE_EVENT_FL_CAP_ANY event whose filter does
not contain an unquoted .function postfix. This rejects the predicate
before the tracing parser can resolve either form of operand. The scan
uses the parser's quote rules, so .function inside a string operand
remains an ordinary filter value.

This preserves ordinary filters on task-local events whose fields are
already available to the caller, while non-CAP_ANY filters and kernel
address resolution remain unavailable without tracepoint permission.

Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
---
Changes in v2:
- Keep the entire fix in perf, without modifying kernel/trace/*, as
  requested by Steven.
- Preserve ordinary filters for task-local TRACE_EVENT_FL_CAP_ANY events
  while rejecting their unquoted .function predicates without tracepoint
  permission.
- Reject all filters on other trace events without tracepoint permission.
- Follow the tracing parser's quote rules so .function inside a string
  operand remains an ordinary value.

v1: https://lore.kernel.org/all/95d3721fa8d4c7a4577ec14e9d7caec4fd0cefcc.1790553331.git.zcliangcn@gmail.com/

 kernel/events/core.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 634d2ccbab82..11db8689ac90 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12251,6 +12251,33 @@ perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
 	return ret;
 }
 
+#ifdef CONFIG_EVENT_TRACING
+static bool perf_event_filter_has_function(const char *filter_str)
+{
+	char quote = 0;
+
+	for (; *filter_str; filter_str++) {
+		if (quote) {
+			if (*filter_str == quote)
+				quote = 0;
+			continue;
+		}
+
+		switch (*filter_str) {
+		case '\'':
+		case '"':
+			quote = *filter_str;
+			break;
+		default:
+			if (str_has_prefix(filter_str, ".function"))
+				return true;
+		}
+	}
+
+	return false;
+}
+#endif
+
 static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 {
 	int ret = -EINVAL;
@@ -12264,6 +12291,14 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 	if (perf_event_is_tracing(event)) {
 		struct perf_event_context *ctx = event->ctx;
 
+		ret = perf_allow_tracepoint();
+		if (ret && (!(event->attach_state & PERF_ATTACH_TASK) ||
+			    !(event->tp_event->flags & TRACE_EVENT_FL_CAP_ANY) ||
+			    perf_event_filter_has_function(filter_str))) {
+			kfree(filter_str);
+			return ret;
+		}
+
 		/*
 		 * Beware, here be dragons!!
 		 *
-- 
2.25.1
