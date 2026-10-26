Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792988745;
	b=sFCAj2z29fs0naz5WUTfG6YhP8B5yB0uJ+MKjTdhyrMu/enzf5AaPwvJmObHHmD8neJI
	 96at+oPfYt5MzkZ4wu4agShT+cf4xGnmefh5F2fM2S6CKzEM79PhiZpMnBtk7mTS2C8FG
	 aRWS/+1FzGW1bkCsqbAk9aEOxSTNCuaHuBOtaOaqXAmk7zB3kJQ47C28q99o9+sFVNq3e
	 fxxCzpwtPeCCPBLb/wlJa3u8rQnuzVgORGcBVW/axMEWE6SKqMdWRZD3FYr1xdAIru2l1
	 lOsp4V8GV1JNQMTEcxHW6AZQagoID7N6B2Qthm9Exknt6BN3bB7wnDy/9wjgslDMPpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792988745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7mQckdVoqDDwNSwgKOH35rCXSMgCp0iItUYI9NdOZh8=;
	b=0hXp7ZWzjYoAs0aei88zn6j0K+iuYiKsVAqePacQhwx04RlfrkF2LSMK5BvZ8ir1KPac
	 3QkxtVQ7irV0H2tKHzlGYouOQ1cqnmKvmjJ+9iZewb+t+JmgqbliFS1hFkXl7GkUHY6OG
	 HBiT7jxXW0ghGBBQYRoH21u8Vw+vf3BjrNvLnmWTDTLmnJyFafKAnhv9MvWm6jqZ8lXA3
	 I5yFMYcd8hItnMCAN1oL1cDMaSAdkGh/sR98rbXgdqRMI8uUiFGw73rmHL+J5IBRZyauR
	 k1nTRW7034QfyQfU/AXXzrl76sZRVrdAG80jWCKx7P0Vs2sDWktgkfaY6OJReyFwoNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OKpiugzi;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EA606A31A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 04:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E2EA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OKpiugzi
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35829219da8so4590464eec.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 21:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792988744; x=1793593544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7mQckdVoqDDwNSwgKOH35rCXSMgCp0iItUYI9NdOZh8=;
        b=OKpiugziXYboBMw6cR6frUtuKeRR1Khot153CgmwsHq4U5LS//3gyGZVV6KzejolnJ
         50b5JkT7hp5qavIQYzrUPp/vMJOQ+EIJdOGsfSUyQcn/z7MzbQwJB65NsWEkRcLwss7H
         lEvSHynr1pWxnUq4bFXEHQejyTSgebjifEv/g32YeN6BdDwhsbEfWwnwbrQHbykd+eMs
         /CQy8285a0CqpGix45YmThueJW+xGDeCmCE5ua5zmQMJAro+6JAvcIWZcolJnuyqlUug
         V4AsGHab/y06oDkcXQLV/IrFui/QGg7I2kAAHEDN5aU5uAv4BCRzzNDW2jAqcWO1gtQf
         tOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792988744; x=1793593544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mQckdVoqDDwNSwgKOH35rCXSMgCp0iItUYI9NdOZh8=;
        b=kSdMQWDY4C/V/AplIUpOlSuxz8n0ReoVC8gHSCIjXlrpdofV1uFwLq1639w7MCTQOO
         3QMcfaBiceVCPkIVHApJbt21ohZrHFCG2W6iwxCsLZSVeTALsvLZwi0KoHnDYyZCPMpB
         EtRp1KtRRXMKZ9N/AUslMQe56DIff9AI9wwGCCN67181kCY1wSgDbFEb+ztuLdbpPaWL
         bD07uc1IsGCNBJvAqGr7fupsbzj7K78sMatLJjlVzy4U33mIodcMIA6wqVWg7ak018j4
         YUCaMnUlwyjB1XPZvWbfsSL4ZezEzwe2PFDDgqfyd5lwwzWZLHH7nOS57WyIntKfqkIb
         WZQg==
X-Gm-Message-State: AFq9FYJ47247MxtSVc8B5WAVHNmhcWBA07gVJOx6kUj+4rmDEGGT0lZY
	VgcmOv0HGjvkhZSZR1n1EfdZJd8UHK14XsmMu4hy7aOH788WC9z6Pj7AWWE3
X-Gm-Gg: AYBFou3u8RO68CFFizaTLfuhVN6IvaMk/UVV45QOf14jHg+RYNmC1ZgTNIuFSyZopGt
	0q8ZVEb1JkzzBkDgY6HEl5aphzbtLT0dSIyk+3pln9e9Pb+UETaitFky3koHOLpeG+bAmk7/Lzc
	71k1cVucICE/gwpl6/lXQUqPDqobOSJgQm/YtXrhY2lwFEOOL2FGaMluTfg608BwO75igFHTo1A
	wnQAvp/JbfeXuK3ZGlkuH9f5joELq/h5r1pU59dvwQNAjeYnanBK8HywFBZrgeTWRAplr7LCNUq
	+vMC8+Wo6sjoGgvzink3zEwKahNEnao2tbpmy4GOGsOAJGMOuognUdRWIR3Z7LjDkidsTeK2Rrj
	0xwX4SjcY//uV6rpVN/zW3kV0fdjX3wUAfsBhJz3OwMIDHiRekvaWK7jZ3fF4LKikp8RlKKB5KO
	NJ885bHb7IBWxlHDStBlD6D/GrgUFcxHuZznJkjEIEBAEmQ8c/+AYw8NBWYEdwPDaKiCueoKcOm
	MmmzApcoYnYkFi9N4CQg8dG2jJtWnOMON0uZyfPIFay3da3yAHofMB9+lCMR08OUETFfNeEhxAY
	3zDGXtJgn4YMfpgNdA==
X-Received: by 2002:a05:7301:1530:b0:351:77a3:55f1 with SMTP id 5a478bee46e88-369e84e00c3mr8104891eec.19.1792988744218;
        Sun, 25 Oct 2026 21:25:44 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ff5a4d68sm6569034eec.14.2026.10.25.21.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 21:25:43 -0700 (PDT)
From: "JongHyuk Kim (MalHyuk)" <malhyuk97@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Reject filter expressions that end on an operator
Date: Mon, 26 Oct 2026 13:25:39 +0900
Message-ID: <20261026042540.2478566-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
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

predicate_parse() seeds every new program entry with a backwards link:

	prog[N].target = N-1;

so prog[0].target starts out as -1. It is expected to be overwritten by
update_preds() before the second pass walks the program.

If the expression ends right after "&&" or "||", the pending PROCESS_AND
or PROCESS_OR bit on the operator stack is never consumed, update_preds()
never runs, and prog[0].target is still -1 when the second pass starts:

	for (i = N-1 ; i--; ) {
		int target = prog[i].target;
		if (prog[i].when_to_branch == prog[target].when_to_branch)
			prog[i].target = prog[target].target;
	}

That reads prog[-1], 16 bytes in front of the kcalloc()ed program. The
value read there is then stored back as a branch target, and the only
check on a branch target is the lower bound in the third pass:

	if (WARN_ON(prog[i].target <= i))

so any positive value is accepted, and filter_match_preds() goes on to
use it as an unchecked index into prog[].

Reproduced on 6.12.112 with KASAN as uid 1000, with perf_event_paranoid=2
and without tracefs. One perf_event_open() and one ioctl() are enough:

	a.type = PERF_TYPE_TRACEPOINT;
	a.config = <any tracepoint id>;
	a.exclude_kernel = 1;
	fd = perf_event_open(&a, 0, -1, -1, 0);
	ioctl(fd, PERF_EVENT_IOC_SET_FILTER, "common_pid==1||common_pid==1&&");

	BUG: KASAN: slab-out-of-bounds in process_preds+0x151e/0x1b60
	Read of size 4 at addr ffff8881014ad474 by task exp_progm1/123
	CPU: 1 UID: 1000 PID: 123 Comm: exp_progm1 Not tainted 6.12.112-dirty #1
	Call Trace:
	 process_preds
	 create_filter
	 ftrace_profile_set_filter
	 _perf_ioctl
	 perf_ioctl
	 __x64_sys_ioctl

The faulting address is prog - 12, that is prog[-1].when_to_branch. On a
kernel built with CONFIG_SLAB_VIRTUAL the same read lands on the unmapped
guard page in front of the slab whenever the program happens to be the
first object in it, and that is a fatal page fault rather than a silent
read.

An expression is not supposed to end on an operator, and that is the only
way a PROCESS_AND or PROCESS_OR bit survives to the end of the parse, so
reject it there.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: JongHyuk Kim (MalHyuk) <malhyuk97@gmail.com>
---
 kernel/trace/trace_events_filter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -602,6 +602,13 @@
 		goto out_free;
 	}
 
+	if (*top & (PROCESS_AND | PROCESS_OR)) {
+		/* Expression ends on an operator */
+		ret = -EINVAL;
+		parse_error(pe, FILT_ERR_INVALID_OP, ptr - str);
+		goto out_free;
+	}
+
 	if (!N) {
 		/* No program? */
 		ret = -EINVAL;
