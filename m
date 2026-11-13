Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558484;
	b=wpCAV5M99KzmfKkRLfYJBWA7wiaUmIJs7VZLz2rkukp8GJXV2JhkOyQrMSrlOgbsP8Pg
	 mAd/owJhWr/Ui31MsYWyAyvZpnEJjTSSJtxsKL3cqF0xpvwc3YnXmZZOCHwD54rbrhKM/
	 rFGVkcof4Uc1CcrmLn3D+MniQN6NXdDU3KveTgws8ZGzfaGNlgqfjrnPJvMrs7PAcE40O
	 NlSGNgN7D+rymz5NNqRJiwGOa9NqaKQK6dWLP8aAoxswsyMHYUZrrPYgCCO35ea1qdz4y
	 VHQSEoDuLtSeRBD26HqRmtN3PqAassX1NF5qjhPivOUxfkRjZzOopeYpuOgpKpNRaUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558484;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0iN/FKxYUCGEpOFSamodvC5PzKD9DC9piKtcytUlbUY=;
	b=soRHgiynGn69R3UU9/jzDjE031PkWrJtCEyhyOTcNKI45s5plTQhG+x99/J4CYknjAip
	 L26Vhv0Jp/ZR8KSI5MQLDk3Drxgu+b6P0gILtj0U4an9ZdYNHfut8MtSArGtvkXaVkzde
	 cW2Kx7Z7001qB1xoGLiDf6hC55XR2cffo+bwhzUgR1ygVcMzT/hXZuVkIGwmPe4vrYYoI
	 XeyiUmIqWRgXLRSSYd8ZSs0dJgtWDNnR26RJ2HLxTVB4B2eiuZLIvcFTpvSg5VPT7+y1h
	 DKYLmV/2X8yW7skRtrVaclbic5DPef7g2xy0y0iWNsmqkatD/GFLo7AB2biMSHSp7aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3auLbta;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E07606B61A;
	Fri, 13 Nov 2026 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3auLbta
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8262B1F000C5;
	Fri, 13 Nov 2026 08:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558483;
	bh=0iN/FKxYUCGEpOFSamodvC5PzKD9DC9piKtcytUlbUY=;
	h=From:To:Cc:Subject:Date;
	b=D3auLbtaoNC3obhBxtpiu3oU8BuKyySWZDDHdk7MaeLlgoDYBULCEq+OQ7d8O3Dsc
	 wR6Vyh4xe0mC+gv20X6+zyOhnL1YVbG+oX0aYJ4yjiGkbPVgKkyHkg9IcMCivwjHBc
	 suUk+hqXjYJ3ZCQSijiQpjkBOynfqWGOSjYgqUXy+nkUFNC47GkI6u8py0mYw0ohRZ
	 SOKYlF6/CYXPWqba7aMeYI5/c2Bm5xIjKs/wfaan/DL4rFfwC2b2gwdClP+3XTVObd
	 oWi+LFMt9z5zGWlVDIh7Dl5zyQz8Qz0l8mdLjuoO61eewkaQ++qj9v9BGYfcOxlOTs
	 TB019cZof4Odw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 00/13] tracing/probes: Fix various bugs in dynamic probe events
Date: Fri, 13 Nov 2026 17:27:59 +0900
Message-ID: <179455847934.403392.15146485751358774349.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

This is the 3rd version of the series fixing several bugs in dynamic
probe events (kprobe, fprobe, uprobe, and eprobe) and BTF/fetch-argument
handling.

Here is the previous version:
  https://lore.kernel.org/all/179444679892.345731.5271591537517106679.stgit@devnote2/

This version updates [03/13] to fix BTF bitfield handling for kflag=0
bit offsets, non-power-of-2 container sizes, and big-endian bitfields
pointed out by Sashiko.

- [01/13] Check whether the target event is enabled or busy before
  unlinking a sibling probe during multiprobe unregistration, and add
  the missing checks to trace_uprobe and trace_eprobe.
- [02/13] Enable newly appended fprobes and uprobes immediately when
  the target multiprobe event is already enabled, matching trace_kprobe
  behavior.
- [03/13] Fix BTF bitfield parsing for non-kflag bitfields (such as
  enum bitfields, non-byte-aligned offsets, and non-power-of-2 sizes),
  select a narrow container fetch type to avoid out-of-bounds buffer
  writes, and compute bitfield extraction parameters from the container
  width for both big- and little-endian bitfields.
- [04/13] Add missing BTF_KIND_PTR, NULL, and BTF_KIND_INT checks in
  btf_type_is_char_ptr() and btf_type_is_char_array().
- [05/13] Use explicit fixed-width integer types (s8/u8, s16/u16,
  s32/u32) in eprobe get_event_field() so 1-byte signed fields are
  properly sign-extended under -funsigned-char.
- [06/13] Disallow attaching eprobes to fprobe events to prevent
  potential recursion issues, matching kprobes and uprobes.
- [07/13] Check FETCH_OP_UDEREF before advancing the fetch instruction
  pointer in finalize_fetch_insn() so user-space dereference string
  arrays emit FETCH_OP_ST_USTRING instead of FETCH_OP_ST_STRING.
- [08/13] Reject array specifiers on non-dereference string sources
  (such as $comm or symstr) in finalize_fetch_insn().
- [09/13] Fix memory leak of tail in __trace_uprobe_create() when
  generating a default event name.

Minor updates/cleanups:
- [10/13] Allow the symstr type on function entry arguments ($argN) in
  return probes (FETCH_OP_EDATA).
- [11/13] Reject empty fetch expressions before :%pd and :%pD in
  traceprobe_expand_dentry_args().
- [12/13] Validate the command prefix in kprobe, uprobe, and eprobe
  creation when the colon separator is omitted so invalid prefixes are
  rejected.
- [13/13] Propagate actual error return codes in eprobe and fprobe
  creation paths instead of overwriting them with -EINVAL.

Changes in v3:
- [03/13] Use ctx->last_bitoffs as code->lshift on
  __BIG_ENDIAN_BITFIELD architectures in parse_btf_bitfield(), and fold
  BTF_INT_OFFSET(intdata) into bitoffs before checking alignment and
  !is_power_of_2(type->size) in get_bitoffset_of_field().

Changes in v2:
- [03/13] Check (bitoffs % 8) in get_bitoffset_of_field() so unaligned
  byte-sized kflag=0 bitfields also record ctx->last_bitsize.
- [08/13] Add Fixes and Cc: stable tags.
- [09/13] Newly added to fix tail memory leak in
  __trace_uprobe_create().

Notes:
- These bugs were identified and the fixes and cover letter were
  prepared with the assistance of an LLM coding assistant.

Thank you,

---
base-commit: be94710b1f6ba1bea33e73129c110af80e999b2d

Masami Hiramatsu (Google) (13):
      tracing/probes: Check enabled and busy state before unlinking sibling probes
      tracing/probes: Enable newly appended probe when target event is enabled
      tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write
      tracing/probes: Fix missing BTF kind checks in char pointer/array helpers
      tracing/eprobe: Fix 1-byte signed field fetch in get_event_field()
      tracing/eprobe: Disallow attaching eprobes to fprobe events
      tracing/probes: Fix user-space dereference string array store type
      tracing/probes: Reject array count on non-dereference string sources
      tracing/uprobes: Fix memory leak of tail in __trace_uprobe_create()
      tracing/probes: Allow symstr type for function entry arguments in return probes
      tracing/probes: Reject empty fetch expression for %pd and %pD
      tracing/probes: Validate command prefix in kprobe, uprobe, and eprobe
      tracing/probes: Propagate error codes in eprobe and fprobe creation


 kernel/trace/trace_eprobe.c |   39 +++++++++++-------
 kernel/trace/trace_fprobe.c |   26 +++++-------
 kernel/trace/trace_kprobe.c |   11 +++--
 kernel/trace/trace_probe.c  |   94 ++++++++++++++++++++++++++++++++++---------
 kernel/trace/trace_uprobe.c |   79 ++++++++++++++++++++++++------------
 5 files changed, 171 insertions(+), 78 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
