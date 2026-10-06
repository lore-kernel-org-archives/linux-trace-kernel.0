Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3738837D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Oct 2026 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326411; cv=none; b=TpAsPzpZ5kyReiIip4qLFoyZ6yLFWRZqStghofNj1HqkGGAW2l+HB0dnIBOMb9nari0VoryU5cfhUCNjg1Ep5ZW3BimBpCuOPCetluGPit2BgTcUQh0YMqESwsZgAndBPfd0xwqfFum3CeMOMmLmUMUX4x0Fy8yxCsckFUy+lbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326411; c=relaxed/simple;
	bh=hPOUmV/xGE5eS0kZpd5MJCVPYwrNotNiv1TTrk+TckI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bamR7VQifGHOU+SwWmmv7F1GmCxZGAU4Cp18tGl8CMr3R8b9yy/4DEDDT3CCg7p+XsaVmTNsuL9Zfhs1fKfvJTbrwD070Pkeczf3sE/DfA3jewzeiKwDLkFCxUPHuTReVUNRW1NFCsnihnDaIMFJKSewRkWiLu2VgBo/S5t8J4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=AJx39qsk; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="AJx39qsk"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-49e09a20082so674689fac.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 15:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791326409; x=1791931209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bMDhGYH4rM/hZGPUiF2V3RD2josdEfJ5uDI1Xaf78dg=;
        b=AJx39qskExIGcEEPyA1S7gUovLD1/9lvzGRuxxNGEQCvkP4boMxmhU/DcwqJkX9NGD
         J3WVyGeqh3EBpMLNczl6mJFHsel61um7gppKrwGleCcaRLWgkfZBpG4mMPrfd5dfeB/V
         yBzuutgPa9qLtUR2P7Nm0bCr+H5dOEucSLzCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791326409; x=1791931209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMDhGYH4rM/hZGPUiF2V3RD2josdEfJ5uDI1Xaf78dg=;
        b=Qxu4l9+sCBFc3k9i59vhmp8JhY6JxP6LwzK3kQZNYWgHU0bfPDNkIDO1FEBcx9kD2C
         ncT5jTpQF0ndC5Lvfsn4+rDST0N8PXJBXE5OdGvNHvKqXpW5NXEviZti4Rnp6/MBmTaX
         ZFcMUcV1wBevaC4YvJ4ddAaWhPXYOcwUtCz8OMNzAWPwAXKvXD/laoXo5PuDg6I3hte4
         3c0DTFNbPefpS0tX1mUYHPNH4Q44c7UDVuWX98XYea28r7QBnNY6nPm6loJVsqC6oX9h
         YuNWUmVmqlVZ9tAIhXiGQfpqxUTi+v+UUbKGNl/UiHpboiROQ+X8f+4+soDlLvsYadcs
         hH5g==
X-Gm-Message-State: AFuF++n5YNU9RhbwkBk5tuGg9mNHaxovPBTk1qZ8wA5qQxXGs3cfKkjc
	HYg6DMqXMvcFxPliEMD5bngThB7H/uP5MPROv5h2dL/CPJbrjtgiixSeZNcmHz7ZvfQ/6WGIQGq
	TVoyxhb0=
X-Gm-Gg: AYBFou11X/4szdJu6IUIYYDg+gglSGlfqcrd2PIL9k3CAOBlZIpBEEPG6L6wDHht5fw
	WX4dDtOVOOIeqpFi7OLqp6MMyga1pGEkKtdv8Nu8xEMPk4Vx6w32wbhL6Slq9sBUgmpoLu5Xb1F
	Cj4h+QH+IytF1qvvMP+5xctWWGGJCzt/clLtjU3JhIZGbWri2ji9x/6rmO7dkXiW/K7iiztXHth
	Lt5qzpjzx0gt2emKLEhmJjppWXZnbJGD9dL+WWgsLkHrrscoYdzaRNAfQN8besXdkLdqNYqr9tQ
	xFRoI1Ep3AXJQQ3gvD06yDTmOZ+U5XlPWlp1dXBs7GrUGgC6/B0yWuC6asI1kuKKbUSCTjSgzsx
	rPPsav9QXiHwzpLUfMEEz7yr0Q7CsUjhdRm3WlgkIGyqjUy2FyronTzs/4Mr9N50qjPURqdFCTZ
	APZX1SxJI0+2MLJjtVc6NS7Gvgn4+CRu2sp4/iyR29qhaBLBff3dQkMHyQokNMVkiqeq14P1VVg
	awywtM7FA3duNVFZMVoV+duL5nTNVdHVIEt4lLe8QhvzWjwJL5Ti120tQmkhHnAdvi7NimjMdU=
X-Received: by 2002:a05:6870:6128:b0:494:b0db:4e0d with SMTP id 586e51a60fabf-4a259148369mr477880fac.7.1791326409160;
        Tue, 06 Oct 2026 15:40:09 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a25701702esm689475fac.6.2026.10.06.15.40.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:40:08 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] tracing: Restrict perf filters that read kernel strings
Date: Tue,  6 Oct 2026 15:40:05 -0700
Message-ID: <20261006224005.49636-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A task-bound, counting-only syscall tracepoint can be opened without
permission to read raw kernel tracepoint data. Setting exclude_kernel
does not prevent its filter from running: perf_syscall_enter() submits
the saved user-mode registers.

Pointer-string filters use FILTER_PRED_FN_PCHAR by default, which reads
through strncpy_from_kernel_nofault(). For sys_enter_openat, for example,
the filename field comes directly from a syscall argument. An
unprivileged caller can pass a kernel address, install a filter such as
'filename ~ "Linux version*"', and use the event count to test the
contents of kernel memory, even with perf_event_paranoid=2.

Check the compiled filter before installing it and require the same
kernel and raw-tracepoint permissions as access to raw kernel tracepoint
data for FILTER_PRED_FN_PCHAR. Inspect every predicate so that other
events, operators, and boolean expressions cannot bypass the check.
Return the permission error through the existing cleanup path before
publishing the filter.

Keep user-pointer (.ustring) and record-local predicates available under
the existing policy. This leaves tracefs filtering and authorized kernel
string filtering unchanged.

Fixes: 5967bd5c4239 ("tracing: Let filter_assign_type() detect FILTER_PTR_STRING")
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 kernel/trace/trace_events_filter.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536045..76aca560491b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2704,6 +2704,28 @@ static int ftrace_function_set_filter(struct perf_event *event,
 }
 #endif /* CONFIG_FUNCTION_TRACER */
 
+static int ftrace_profile_filter_perm(struct event_filter *filter)
+{
+	struct prog_entry *prog = rcu_dereference_protected(filter->prog,
+						lockdep_is_held(&event_mutex));
+	int i, err;
+
+	for (i = 0; prog[i].pred; i++) {
+		if (prog[i].pred->fn_num != FILTER_PRED_FN_PCHAR)
+			continue;
+
+		/*
+		 * Even a counting filter can reveal kernel string data.
+		 * Require the same access as raw kernel tracepoints.
+		 */
+		err = perf_allow_kernel();
+		if (err)
+			return err;
+		return perf_allow_tracepoint();
+	}
+	return 0;
+}
+
 int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 			      char *filter_str)
 {
@@ -2725,6 +2747,10 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 	if (err)
 		goto free_filter;
 
+	err = ftrace_profile_filter_perm(filter);
+	if (err)
+		goto free_filter;
+
 	if (ftrace_event_is_function(call))
 		err = ftrace_function_set_filter(event, filter);
 	else

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
-- 
2.53.0

