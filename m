Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665359;
	b=4wfnhwDfZl+OnXvu6dMQe1dVLYxNlDvM6tHV/dxEGLF9N7/a/KLyP0sVIg2YOqM4aIaa
	 Nq80uTJqHmknRl3RM2qiLZ2K1v9DfESSySdBVZ4FMM8I44I5MOQYx48afOlcUv5VpMcc5
	 z3HViPxxCqUA7BDIETBhs4bBEm/SWfFjJIabpcWukjb6+pOWLKsV9AmYb7ZbqDfdfiQ6o
	 /CnxSnkgVDOv0M3db7x28vgmgOzl7L9DrCluItpCbY622yEX8lvl2jLzqmLrQSa/tIYjf
	 NCe3c7sn/tUVqsb0u//5QTDD4AkTtKIdcOJGI3KRFZwj3ultdIRNYfXmnM47h40t20w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=MhqFB6pnO6vVF0MC+tK2ZxQFR0y2pYsdL1jLclN0qoM=;
	b=b178qYiRoi79klbA+XfFV1VkALsb39Xig8OCRNtK+3i2M9Tkkd3V6bMzz24KADEQWOmb
	 ozgYAxnjhbZAuZPpAuNbsVtsMim2HcOhGzSMw0YtoDCxHI3Pdd/xMVPjB8t+5OBh+pqnP
	 8nxO5r/NJWaqrvThzh5DfJu75vf0SFOFSW0vEOp/UwpvntSifm4j/Guc5p03jNhPWeCN2
	 XRngPfWuQrRroVS0V+FXIYOf6kTRB0CF5X0GWctby1IdnTpyhVCqSqjVP4+8odaFjNRDa
	 pJSrwsR2RgNZdV33vky5CyAgeauk7Rf4nR5Rw8gKyHdss7OQL2yX6pvX+kT2ZVgawNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i5KZzsXv;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A588D606A323
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 03:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A588D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i5KZzsXv
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a359c7f47bso54088255e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 19:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795665357; x=1796270157; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MhqFB6pnO6vVF0MC+tK2ZxQFR0y2pYsdL1jLclN0qoM=;
        b=i5KZzsXv2F090W8Shpe0PqNTzgtUWQGusKcr40zxJ29sExjkFXFfo9tAduz4DqM02D
         yzDTs/hDisVjV344N+vhdeoQ/E7NjAET9pl6qW72C5nUQfHUVndzgqIDCq7U+RANzltm
         opxShwWzPyuRo+wuSAniBfqv+qhzoVBqBb5It36eLFGj7uBx5jA+5pY3NyYPWToijSSK
         8VYCyxSKs0fHFts9u1Y9wS9vjFwM162UadIRnYftzcc4BYz2fjvrR8gSL/Xre2stle2q
         17OwZsPRyisffOXQIo6Dzh4DGoiTP7Yi5Xze5PTinyBgh1fYmOjIo4UalbgRxZNDnOW3
         Vt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795665357; x=1796270157;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhqFB6pnO6vVF0MC+tK2ZxQFR0y2pYsdL1jLclN0qoM=;
        b=2Pe9rfO3W4GR+9RqHFKrWv1wVUF/6G6PPAdJIKL09wsASO+1Hf9j6NJDAf/PSlCZBw
         RqupDriS62QrMzyZ2TGucEFYyzFavl6zoRcwGr1YhiCk9UTUhEN6sKhycPLeXnclGCVV
         qRucr0IRRR8VdPDdg64Ev9tRQkfMhuigF+NwBBO8HNRexk1RlasAXEP6Luqtns/LeYRP
         KKAL0wfJ2o0JH2YmQSRi2nn94zpBHsJrkeNGjyCveXrkLCw1uW5B/NWEZ1vQsokDwrBz
         pN6GDHefGpHHOsE9XFibCx3O5VVYWTHZI9MFOYiCy24QPF/R0hNx3Inz4I/E1Cj6HqxE
         kg2Q==
X-Forwarded-Encrypted: i=1; AL+hErG7uSmCh0uj7C52xMYLmBssfdbnyI24yYJlvr2toMiYeRhiJzvZWyKT1IR2pj7npqlVlK6tESNERELCTRu57KsAvDk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/GcRicCZtkS3xLLozzPEah8LLJLgsjtNGGcpgF1QuE2OahY2o
	ohH8yaz1b8aerlTFUE1sePbHwzEmGcTXcVwSIJK0RfVsSiSYlFzOZzHUiFkbwHixnD6+HVrIDA=
	=
X-Received: from wmo17.prod.google.com ([2002:a05:600c:2311:b0:4a2:c25:d91a])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:34c9:b0:4a3:5d64:df91
 with SMTP id 5b1f17b1804b1-4bb88810d28mr432891425e9.18.1795665356871; Wed, 25
 Nov 2026 19:55:56 -0800 (PST)
Date: Thu, 26 Nov 2026 04:55:56 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
Message-ID: <20261126035556.407947-1-dmnk@google.com>
Subject: [PATCH] tracing/probes: clear dynamic data_loc on stage-2 dereference fault
From: Dominik Maier <dmnk@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

When recording dynamic probe arguments, store_trace_args() initializes
the first u32 data_loc slot to make_data_loc(maxlen, dyndata - base)
before calling process_fetch_insn().
Commit 797311bce5c2 ("tracing/probes: Fix to record 0-length data_loc in
fetch_store_string*() if fails") removed the ret < 0 fallback in
store_trace_args() so that stage-3 helpers (fetch_store_string*()) would
record a 0-length data_loc per element on string arrays.

However, process_fetch_insn_bottom() can fail earlier in stage 2
(FETCH_OP_DEREF or FETCH_OP_UDEREF) and return immediately before stage
3 runs:

- On a dynamic string array (such as +0(%di):ustring[4]) whose pointer
  array faults at or after element 0, returning early from stage 2 aborts
  __get_data_size() (dropping space needed by earlier valid elements) and
  leaves the remaining u32 data_loc slots uninitialized in
  uprobe_cpu_buffer or the ring buffer. When the trace is read,
  print_type_string() interprets those stale bytes as a non-zero
  (len, offset) pair and reads out of bounds past the copied trace entry.
- On a multi-dereference dynamic string or symstr argument (such as
  +0(+0(%si)):ustring), if an intermediate pointer faults in stage 2
  after succeeding during __get_data_size(), *dl keeps its pre-set
  non-zero maxlen and exposes uninitialized buffer bytes instead of
  printing "(fault)".

Formatting a uprobe string array whose pointer table crosses into an
unmapped page triggers a KASAN slab-use-after-free read past iter->ent:

  BUG: KASAN: slab-use-after-free in string+0x476/0x570
  Read of size 1 at addr ffff88800bb3c948 by task repro_probe_sta/65
  Call Trace:
   string+0x476/0x570
   vsnprintf+0x396/0x1630
   seq_buf_vprintf+0x99/0x1e0
   trace_seq_printf+0x149/0x370
   print_type_string+0xe3/0x130
   trace_probe_print_args+0x286/0x3a0
   print_uprobe_event+0x1ce/0x3b0

When a stage-2 dereference fails on a dynamic string or symstr argument,
record a 0-length data_loc for that element and continue the
FETCH_OP_LP_ARRAY loop if at the innermost dereference, or clear all
data_loc slots of the argument if an outer dereference fails.

Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
Fixes: 797311bce5c2 ("tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails")
Cc: stable@vger.kernel.org
Signed-off-by: Dominik Maier <dmnk@google.com>
---
Found with an AI-assisted code review tool (ARTIST) and verified in
QEMU/KVM with KASAN and lockdep against v7.4-rc4 (reproduces the
slab-use-after-free read in print_type_string() before the fix, clean
and preserves valid array elements after); standalone reproducer
available to maintainers on request.

 kernel/trace/trace_probe_tmpl.h | 36 ++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 8acc0f0..4e0c49a 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -164,8 +164,42 @@ stage2:
 			lval = llval;
 			goto out;
 		}
-		if (ret)
+		if (unlikely(ret)) {
+			struct fetch_insn *next = code + 1;
+
+			while (next->op == FETCH_OP_DEREF ||
+			       next->op == FETCH_OP_UDEREF ||
+			       next->op == FETCH_OP_CPU_PTR)
+				next++;
+
+			if (next->op == FETCH_OP_ST_STRING ||
+			    next->op == FETCH_OP_ST_USTRING ||
+			    next->op == FETCH_OP_ST_SYMSTR) {
+				if (code + 1 == next) {
+					s3 = next;
+					if (dest) {
+						u32 offs;
+
+						loc = *(u32 *)dest;
+						offs = get_loc_offs(loc);
+						*(u32 *)dest = make_data_loc(0, offs);
+					}
+					code = s3 + 1;
+					goto array;
+				}
+				if (dest) {
+					u32 offs = get_loc_offs(*(u32 *)dest);
+					u32 zloc = make_data_loc(0, offs);
+					int cnt = 1;
+
+					if (next[1].op == FETCH_OP_LP_ARRAY)
+						cnt = next[1].param;
+					for (i = 0; i < cnt; i++)
+						((u32 *)dest)[i] = zloc;
+				}
+			}
 			return ret;
+		}
 		llval = lval;
 		code++;
 	} while (1);

base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838
-- 
2.56.1.911.g883d8bcb20-goog

