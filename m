Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184089;
	b=j5Ppy7W/LjGJ4rHmDGpwMnPotIEi6Y+H4F8sNspd1hkoiXHWqAO1S5VWfIEyCV2ugKOs
	 Aam5fEJeQOk1L03yMfiQULQvdRc4V1fgVKPnqdmWZRQguiL7oW/D/lwA/LwjvE8Y1577B
	 rw/Sb+EwiARFs7edPStX1iDhNp1uBgmfn+Hbx5+B5mfwN6GBoDqxWiAJMuoJhy0H+9tEK
	 ovz38Eq88tfmMb540fWtr0Gwf4lE1vKkFXyqoELH58hQFsqp1cGuO/c0LLPWEbJ86FNpb
	 k5u8A4Xp9VIbjaxjF14ySqvgDE6DY1sIejfeO/bcxVNES8myWfu2W+atEAlWkzU34WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ux0Zaj0xe7b1cSzHWuZY8OfnusQsADIhat5L9cgZ35w=;
	b=2nPNje+kI63gyLK8PISwdFxfYttU0ermjurkt2SAK/qoazZwdalBv+uSYc6YFKdw5L2y
	 6QxHVhYDFyJecx9dQW2Y8ebSM0Q57r2MY+8K5A0SZGRp+HNTthncXnfYp3RgwOLVltZdH
	 Yp0m9wPzdG0X1kHrMbYkomtzlI6newXaRphDTVX6BIVXfsJIn5wm+VGYXdwfFvThcSEnR
	 qd+Lr5AwagmLfjNiilnYUH2vGQ7iN/7lySpkYqq6ufLHFeD0fZiOxHr3ITnS/LacUwpep
	 lBb5wg30l1pDRbJp0YhMrXEZnisG8o03/XEuBs1SvDhhpyKrH7GLzcX3E4be45zUPig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSoALyQr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A8606A31C;
	Mon,  9 Nov 2026 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSoALyQr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE6C1F0089F;
	Mon,  9 Nov 2026 00:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184088;
	bh=Ux0Zaj0xe7b1cSzHWuZY8OfnusQsADIhat5L9cgZ35w=;
	h=From:To:Cc:Subject:Date;
	b=ZSoALyQrkYG3iRvqfJvc9qW9LIvUmkeHOMcwuUcYMbnbigCyNBVWRNFUbfMpZTmQu
	 t0r1AR+tPs9qa2SU3d6x9boJfnsbVg89c6AqG0K5nudAypxXrgp/tTihfqLf2MWGWZ
	 cez4932UF6UjLeeHCexfGHmYFbRbQ0oIPlknQEf5NEa6cIvQwYQVWpoGewMAdc+l2P
	 wBn8ihqFyG1iC0SdeN/l3eW/Q/P7avI/tUr50FoyFBhsYIRsntfZkJ4DN5DSWGW/Dj
	 76jyDvQrGye+vaOICadj7n2/Aegt6aKZzieOjn3iU2Dhr4dVRFbv9idmSf218OiIFs
	 p9TFSO7IhIcGQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 00/12] tracing/probes: Fix various bugs in dynamic probe events
Date: Mon,  9 Nov 2026 09:28:04 +0900
Message-ID: <179418408457.227715.1485179201014819821.stgit@devnote2>
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

This series fixes several bugs in dynamic probe events (kprobe, fprobe,
uprobe, and eprobe) and BTF/fetch-argument handling:

- [01/12] Check whether the target event is enabled or busy before
  unlinking a sibling probe during multiprobe unregistration, and add
  the missing checks to trace_uprobe and trace_eprobe.
- [02/12] Enable newly appended fprobes and uprobes immediately when
  the target multiprobe event is already enabled, matching trace_kprobe
  behavior.
- [03/12] Fix BTF bitfield parsing for non-kflag bitfields (such as
  enum bitfields), select a narrow container fetch type to avoid
  out-of-bounds buffer writes, and compute bitfield extraction
  parameters from the container width with bounds validation.
- [04/12] Add missing BTF_KIND_PTR, NULL, and BTF_KIND_INT checks in
  btf_type_is_char_ptr() and btf_type_is_char_array().
- [05/12] Use explicit fixed-width integer types (s8/u8, s16/u16,
  s32/u32) in eprobe get_event_field() so 1-byte signed fields are
  properly sign-extended under -funsigned-char.
- [06/12] Disallow attaching eprobes to fprobe events to prevent
  potential recursion issues, matching kprobes and uprobes.
- [07/12] Check FETCH_OP_UDEREF before advancing the fetch instruction
  pointer in finalize_fetch_insn() so user-space dereference string
  arrays emit FETCH_OP_ST_USTRING instead of FETCH_OP_ST_STRING.

Minor updates/cleanups:
- [08/12] Reject array specifiers on non-dereference string sources
  (such as $comm or symstr) in finalize_fetch_insn().
- [09/12] Allow the symstr type on function entry arguments ($argN) in
  return probes (FETCH_OP_EDATA).
- [10/12] Reject empty fetch expressions before :%pd and :%pD in
  traceprobe_expand_dentry_args().
- [11/12] Validate the command prefix in kprobe, uprobe, and eprobe
  creation when the colon separator is omitted so invalid prefixes are
  rejected.
- [12/12] Propagate actual error return codes in eprobe and fprobe
  creation paths instead of overwriting them with -EINVAL.

Notes:
- These bugs were identified and the fixes and cover letter were
  prepared with the assistance of an LLM coding assistant.

Thank you,

---
base-commit: be94710b1f6ba1bea33e73129c110af80e999b2d

Masami Hiramatsu (Google) (12):
      tracing/probes: Check enabled and busy state before unlinking sibling probes
      tracing/probes: Enable newly appended probe when target event is enabled
      tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write
      tracing/probes: Fix missing BTF kind checks in char pointer/array helpers
      tracing/eprobe: Fix 1-byte signed field fetch in get_event_field()
      tracing/eprobe: Disallow attaching eprobes to fprobe events
      tracing/probes: Fix user-space dereference string array store type
      tracing/probes: Reject array count on non-dereference string sources
      tracing/probes: Allow symstr type for function entry arguments in return probes
      tracing/probes: Reject empty fetch expression for %pd and %pD
      tracing/probes: Validate command prefix in kprobe, uprobe, and eprobe
      tracing/probes: Propagate error codes in eprobe and fprobe creation


 kernel/trace/trace_eprobe.c |   39 ++++++++++++-------
 kernel/trace/trace_fprobe.c |   26 ++++++-------
 kernel/trace/trace_kprobe.c |   11 +++--
 kernel/trace/trace_probe.c  |   88 ++++++++++++++++++++++++++++++++++---------
 kernel/trace/trace_uprobe.c |   76 +++++++++++++++++++++++++------------
 5 files changed, 165 insertions(+), 75 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
