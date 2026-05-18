Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B13372696
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117827; cv=none; b=BYcjX7FvC46IyoIz6rjCDERA9vW3cziPWoxCaCYPvDNoE+YVMI0qF4ZoaaVIRmzXIyhQNOCQp8noc4I5Mjk1up1mLbclcG6zAyfxmiBGd/ml+zx9V4YfA2mrd79Tbd5Bve0ZCwZPzqfg0HhMxIZ+RQaxjjeZ1IwoK03z6ICDKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117827; c=relaxed/simple;
	bh=tmS0yY9aJiTmj7PrQn+1aW5FlWIoZKFBBJCgg9x80n4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QZvEWYJmlGM18KmF7f9PzgJ4sTHMskUbVCLYr5YFO6TKaNX+kv0e7Rwpn8HVghCNZuyAzGu29LvqwfMZ/LWePGxT3D/DirXeFCLWKGu+MtxDdplnhFbvkxeFC4NDBzx8EVR0hGpwFSH28W708J3yPlwoLBi2dT66BvSpWIEW2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WooTIuQL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WooTIuQL"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd8f9889a8cso22317066b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117824; x=1779722624; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ay5gk0yjiV4+KahLRcNBOcR7+/tW2rOXFNeAxAhmkYg=;
        b=WooTIuQLwNE+fsitjWCFlBdA2YTdNtDeocarADaToNm+lhON1gZvzlFq7a/ANQYFyj
         voClv1IU5wpMFgnEbsfXr8pyLjfhXsQbTwDZHAlOh/I57T0lteVK2oplXv/UvmLcEgm5
         TeUeAjGpiQga4sOWUIJBpN+iNKQa4V0IfsJAnuC+1FK69H60rndBHUmb2ZtYPhjd1GUd
         TUyZXIPHSE2azc/bikZvTf0iBgNK8lUSWtzcanW6k48/WKLISp3k+/o3GJ/ACMWtdWkB
         L7kvuBBHp2LAeT+mVEbu/tUtMFI9l3RYMB80y9/8fyIMRtEmz/9l1HA6WrPmJST6wS6o
         yOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117824; x=1779722624;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay5gk0yjiV4+KahLRcNBOcR7+/tW2rOXFNeAxAhmkYg=;
        b=EutdVhUshMLfjVS+jafGOm9DoDSEEB9qVjYv/yhC0JCVMMlZJGfnJqxDtUq4TRTFb7
         FUz6++DrQtX5OvOGnBwC89Sw4Tz9CIRFUqARK0VAJQBDUvQwkmE828GRUm0wA6iyGZcu
         NbB0QjAXarmu8vaib0+7ENEu13//dKic/qLxWG4587O4QwEszpCTt0m6qM9tvxlc/lsh
         RjyRxAdb6CYegiSwujSUHRyXkebUjAQ0ZaJ6KiTTBuflAq/rSzKA6a+UfSKVpKjR1n3n
         94kSD03Skr1VFkDTYEMDIEMgI4dH+5d3ntixtybpS71kMmZ6tdqhojOjk3O8Wl1RNq6e
         lo8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8+ZBhESQsWqwx5Bvmai7vHIaggD8qdaooFTg0qUhdMHHm/cTroHzhpsjzHvMbVneF8LBclSVdu6ygvxjUo8U7MLX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRG0kq9sml1183oLLMX4ao3OU5zoP8r+4EqJZTKFRd01v1Z7D
	sC5za4l/eNxu1/o7cJC1iqY/XZMhCN//M4ItSLRZ65bmMfHc9Gs+1w0y
X-Gm-Gg: Acq92OEI9eBo7DpvlLMIYDV6CRo5GDbf+VWziG6cxp06jdeu6Nw6hj+veq8jdjyRP2J
	tTzehzO1F50l7hq6oSYaTFF6+DVkBCsaLRbY2PKn/hMazF38fs33fSNvH3kgn1z59g4NSg0TC4O
	3rymoP1QgW7+LnjpaxBPf2/sq/5eWvJMI/JGCOwmXUjF7rXmkcKRSdGh6H0YAyh4/NADv4wq5eT
	5pZwvN5tNR+pXl0gdaDa8BEfBT+Fnk8b25wxPSonS17MV+YkdivzDxsqDb2HUCzzwxpAxTkqqrd
	6tKq3c+w/qV6985ZtNf0QWnnSsDAFty6ek7cHAm3C5ho8s/0l83G/WrXnkVEhhukvsQgpGoPY9z
	MlR2otFT5jsGsZ/Clm3ugnTCAjIOFmE5khrZXwJoXWIUcN1Foi6jVy3YFop3cyquv/W5imCOD26
	4swYdJjtrxjrIzWg==
X-Received: by 2002:a17:907:9451:b0:bd8:ba46:db25 with SMTP id a640c23a62f3a-bd8ba46e86cmr135248666b.39.1779117823990;
        Mon, 18 May 2026 08:23:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:48::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd2f67sm575138966b.7.2026.05.18.08.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:23:43 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2 0/3] tracing: Expose tracepoint BTF ids via
 tracefs
Date: Mon, 18 May 2026 08:23:14 -0700
Message-Id: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOIuC2oC/23NQQqDMBBA0auEWZuSpGqjq96jSBnjqLMwkSSIR
 bx7wW67/vD+AYkiU4JWHBBp48TBQytMIcDN6CeSPEArwChTq0pZOZGnyO6dIzpaA/ssh9JarPC
 BvbZQCFgjjbxf6Av6dZSe9gxdIWDmlEP8XLdNX/0H6+ofvGmpJGKtmxGbUt/Nc6GMNxcW6M7z/
 AJ9VIBDvQAAAA==
X-Change-ID: 20260508-generic_tracepoint-d488a5a7ab18
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779117822; l=4524;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=tmS0yY9aJiTmj7PrQn+1aW5FlWIoZKFBBJCgg9x80n4=;
 b=axlmYjl9j8LHTyrPJZPSkDaYM2mCV1eNkopuhCRv/0L22fSuBPqG5hQsb4iS2zGZfhki71Zio
 odZYXsLG56BB1DR22Z+Q890xKm9UjLYcTBnGwMV9qm53mfS6p0LPcaa
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

BPF and other consumers that want to attach to or decode a generic
tracepoint need three pieces of BTF information for it:

  - the BTF of the object that owns the tracepoint's types
  - the FUNC_PROTO describing the tracepoint arguments (with names),
    consumed by raw_tp / tp_btf BPF programs
  - the STRUCT id of trace_event_raw_<call>, the ring-buffer record
    consumed by classic BPF_PROG_TYPE_TRACEPOINT programs

Today none of this is easily discoverable from userspace. The kernel
knows the ids - resolve_btfids fills them in at link time - but
consumers have to search them by the naming convention
("__bpf_trace_<name>", "trace_event_raw_<name>"), walking BTF for
every tracepoint.

This series stores those ids in trace_event_class and exposes them
via events/<sys>/<event>/btf_ids, e.g.

  # cat /sys/kernel/tracing/events/sched/sched_switch/btf_ids
    btf_obj_id: 1
    raw_btf_id: 28882
    tp_btf_id: 106335

  # bpftool btf dump id 1 root_id 28882 format raw
  [28882] FUNC_PROTO '(anon)' ret_type_id=0 vlen=5
        '__data' type_id=9
        'preempt' type_id=60674
        'prev' type_id=219
        'next' type_id=219
        'prev_state' type_id=108689

  # bpftool btf dump id 1 root_id 106335 format raw
  [106335] STRUCT 'trace_event_raw_sched_switch' size=64 vlen=9
        'ent' type_id=104654 bits_offset=0
        'prev_comm' type_id=580 bits_offset=64
        'prev_pid' type_id=92875 bits_offset=192
        'prev_prio' type_id=79365 bits_offset=224
        'prev_state' type_id=83958 bits_offset=256
        'next_comm' type_id=580 bits_offset=320
        'next_pid' type_id=92875 bits_offset=448
        'next_prio' type_id=79365 bits_offset=480
        '__data' type_id=407 bits_offset=512

For per-syscall events (all sharing the same dispatcher), raw_btf_id
is 0 — raw_tp / tp_btf programs attach to raw_syscalls/sys_{enter,exit},
not per-syscall events:

  # cat /sys/kernel/tracing/events/syscalls/sys_enter_write/btf_ids
    btf_obj_id: 1
    raw_btf_id: 0
    tp_btf_id: 106540

This unlocks few usecases for consumers:

  - Resolving tp_btf attach targets and argument types directly,
    instead of constructing "__bpf_trace_*" names and
    re-discovering them in vmlinux BTF.
  - Get a stable, machine-readable contract for tracepoint payloads,
    with field names preserved.

Patch 1 exports the two BTF helpers the tracing core needs.
Patch 2 wires DECLARE_EVENT_CLASS to publish the ids, adds the tracefs
        reader, and wires the syscall classes so per-syscall events
        carry tp_btf_id (raw_btf_id is 0 there — see above).
Patch 3 adds a selftest covering the sched_switch tracepoint.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
- kernel/bpf/btf.c: dropped both EXPORT_SYMBOL_GPL()
- kernel/trace/trace_events.c (event_btf_ids_read):
  replaced guard(mutex)(&event_mutex) with explicit
  mutex_lock/mutex_unlock. scnprintf() and simple_read_from_buffer()
  (which calls copy_to_user()) now run outside the lock work.
- tools/testing/selftests/bpf/prog_tests/tp_btf_ids.c:
  - Added if (!env.has_testmod) { test__skip(); return; } at the top of
    test_tp_btf_ids() so the test skips gracefully when bpf_testmod.ko
    is absent.
  - Wrapped ASSERT_EQ(btf_vlen(proto_t), 3, ...) with if (!...) goto out;
    to prevent OOB read of params[2].
  - Added if (!ASSERT_GE(btf_vlen(rec_t), 5, ...)) goto out; before reading
    members[0..4].
- Link to v1: https://patch.msgid.link/20260515-generic_tracepoint-v1-0-aa619fa94132@meta.com

---
Mykyta Yatsenko (3):
      bpf: Make btf_get_module_btf() and btf_relocate_id() non-static
      tracing: Expose tracepoint BTF ids via tracefs
      selftests/bpf: Add test for tracepoint btf_ids tracefs file

 include/linux/btf.h                                |   2 +
 include/linux/trace_events.h                       |   9 ++
 include/trace/trace_events.h                       |  24 ++++
 kernel/bpf/btf.c                                   |   4 +-
 kernel/trace/trace_events.c                        |  80 ++++++++++++-
 kernel/trace/trace_syscalls.c                      |  17 +++
 .../testing/selftests/bpf/prog_tests/tp_btf_ids.c  | 132 +++++++++++++++++++++
 7 files changed, 265 insertions(+), 3 deletions(-)
---
base-commit: 8668cd470c38011c44a42f6c7b188f4149f23a7a
change-id: 20260508-generic_tracepoint-d488a5a7ab18

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

