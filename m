Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623164;
	b=Z59uOvJp6pfZ5Z8qHWO7P/I5gbyuqUCJnf8L/Z3m7mZb9G/gc2je/W8MsFUB63Pxbwdw
	 pnHgJFuPJS8Zm92uUXfvkxZzdlnYsLUgq5zJXKD877QLnUnWPiVdICZzNUgm92eFdmGeT
	 ZZBBwbEtn/6CNgkzh9uUcsyKVIpKkVsMSKw3u2gpmpp14zRg0XChoePPfub92Ct7BTzVR
	 Z8SCZeubrNVVbNG6SkfEm6Vx9D4EzVym84amrMoV4saFd6Mt0Q8aBJSF17vhdZkN52esb
	 BrskynUmZzL5mcUvXADF5JYJo8RiqFKG5yWGP1bvs9hiykaRk641p1U6zKPvW0NZkdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623164;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=awO1h/PsVxaBgw8sGTVlKtRB3AZEVT1WSAHJtpIZSf4=;
	b=PHwmWq59KDlQPA2Rn9kDd90OxEDVfavnDsWPIx741Lr7QkQHOF+8EF1+fgBSGnQIR3ki
	 j3YisX+FB5ZlbJlAPCae8CZzh7/5Ry3KtNkYcX7aPyW/P3UkbzjBJMTPDGDQSRAnk0IRT
	 PMtqH1sBe6Qyw36k1/RrJDVTTb/WDltNnnB/JoRtmzuAKm7ReSnGsyXvUB5hPS8zNLFrE
	 A5HhJKPOW3ByYTEHVANkzJuFERW42GfQIDuvhFP6GDkzcM9bQ/gx2EqNt1vK2wPEgYDRB
	 jiS22IV0C9nphIx7HK6GjLCzgxvsmLHkXicG5vuHw4SlZp5kyvRIbjuoAWCL0WxnwjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBB5606A323;
	Wed, 25 Nov 2026 16:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DBB5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795623170; x=1827159170;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=CnhhFMklWzjd95oYOPU/3D5K5rD8MM8uGI8AKlVW5kQ=;
  b=WDcytfQFD2VVm6LWiqG/gWiVTDucVu0kU1VhmiBhrMPbHBI+qvMieoAq
   RmXby6H2iIe+FN63re+5MWYuAGIysVQEo4Pl32zdTo9HSjeKOQgEpjMVQ
   4+OoBWIM8x0qh56/Mhd/umTCIEuu6uD0Uvr8eYr6u5/CeV7XCGVPAB3IH
   Rm9wKCfwYzgaLo1iTJ8cX0Dzere+Qic3dw7m+VkihfH/HewsgkwYCs9KP
   4vaiU4LAUvIoNr6alMklJ+DuPnpzum7UvBy9Z2wudwSOy/0F6aQbwkS0z
   fwP1X4lt5/y551MTJOVGCoZKJK0TkSQvweoufZ9KrxfJ9SqGdQkATtdhV
   w==;
X-CSE-ConnectionGUID: 68gFUhiVSEeRj4swVpyeQw==
X-CSE-MsgGUID: HPMZQ6cORWy9x3Ueje+hmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:12:41 +0200
X-CSE-ConnectionGUID: YCXxgs58RB2YjqznLCUEEg==
X-CSE-MsgGUID: J1QBbANCSGSym1h8odoI2g==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces02_data.me-corp.lan with SMTP; 25 Nov 2026 18:20:56 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 25 Nov 2026 18:12:32 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: [PATCH v5 0/3] riscv: probes: check for LR/SC sequence
Date: Wed, 25 Nov 2026 18:12:16 +0200
Message-Id: <20261125-probes-in-lrsc-v5-0-38a32e53fcc2@mobileye.com>
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
X-B4-Tracking: v=1; b=H4sIAOAIB2sC/33NTQ7CIBAF4KsY1o4pFBBceQ/jogNTxWgxoI3G9
 O5S3Rj/ZveS9765sUwpUGaLyY0l6kMOsStBTSfMbZtuQxB8yUxUQvNycEwRKUPoYJ+yA+mcJ+2
 wlbVmZXRM1IbLA1ytnzmfcUfuNCpjYxvyKabr42PPx95PvOfAQbbWek+NarVZHiKGPV1p5uKBj
 X4v/gsCKkChhMI5cTL0RahfBfEh1EVorKqMNUo0fP5FkK+C+hBkEaRBi1Wt0XP/JgzDcAdhrwS
 LhwEAAA==
X-Change-ID: 20261111-probes-in-lrsc-4ccde6cbf436
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>, 
 Pekka Enberg <penberg@kernel.org>, 
 =?utf-8?q?Patrick_St=C3=A4hlin?= <me@packi.ch>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Sashiko <sashiko-bot@kernel.org>, 
 Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
X-Mailer: b4 0.16.0

Patch 1 fixes page fault reported by sashiko-bot@kernel.org that
existed before this patch series

Patch 2 rejects probes inside the LR/SC sequence. This commit was
initially submitted as patch 1 of the series [1].
Detaching it from that series because it is not depending on other stuff.
Do a Call Flow Graph analysis to correctly detect reachable SC
instructions

Patch 3 adds KUnit test, suggested by
Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com> in [2]

[1] https://patch.msgid.link/20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com
[2] https://lore.kernel.org/linux-riscv/20261019134121.1763-3-yuanxiaofeng@eswincomputing.com/

---
Changes in v5:
- add KUnit tests for text literals inside code and exit branches in the
  LR/SC loop, both forward and backward (patch 3)
- Do a Control Flow Graph analysis to correctly detect reachable SC
  (patch 2)
- allow backward branch inside LR/SC sequence, it can be on exit
  path of the valid LR/SC sequence
- fix LR/SC loop maximum size (patches 2 and 3), reported by
  Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
- Link to v4: https://patch.msgid.link/20261115-probes-in-lrsc-v4-0-48b9b036bd1d@mobileye.com

Changes in v4:
- Add KUnit test as suggested by Guo Ren <guoren@kernel.org>, based on
  work by Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
- Scan for SC up to maximum possible sequence length. CPU does not know
  about symbols, it is not correct to stop scanning at the end of
  symbol. Globally visible symbol placed within LR/SC sequence should
  not turn probe within the sequence into acceptable.
- Link to v3: https://patch.msgid.link/20261112-probes-in-lrsc-v3-0-a95089852a17@mobileye.com

Changes in v3:
- Fix lr/sc loop detection logic for lr at probe position
- Add "Fixes" trailers as suggested by sashiko-bot@kernel.org
- Link to v2: https://patch.msgid.link/20261111-probes-in-lrsc-v2-0-b2525b7e1e8e@mobileye.com

Changes in v2:
- Allow kprobe on the LR itself unless it is part of the LR/SC loop.
- Fix error (reported by sashiko-bot@kernel.org) where
  arch_prepare_kprobe() returns -EILSEQ for LR/SC probes.
  Make codes returned by arch_check_kprobe to indicate -EINVAL
  if probe falls within the LR/SC loop, consistent with the case when
  INSN_REJECTED returned by riscv_probe_decode_insn
- add patch fixing out-of-bounds read in riscv_probe_decode_insn()
  reported by sashiko-bot@kernel.org (as patch 1)
- Link to v1: https://patch.msgid.link/20261111-probes-in-lrsc-v1-1-4f99ddea5f68@mobileye.com

To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Guo Ren <guoren@kernel.org>
To: Pekka Enberg <penberg@kernel.org>
To: Patrick Stählin <me@packi.ch>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

---
Vladimir Kondratiev (3):
      riscv: kprobes: fix out-of-bounds read in riscv_probe_decode_insn
      riscv: probes: reject probes inside an LR/SC sequence
      riscv: kprobes: add KUnit test for LR/SC sequence rejection

 arch/riscv/include/asm/insn.h                      |  29 ++++
 arch/riscv/kernel/probes/decode-insn.c             | 171 +++++++++++++++++++++
 arch/riscv/kernel/probes/decode-insn.h             |   7 +
 arch/riscv/kernel/probes/kprobes.c                 |  39 +++--
 arch/riscv/kernel/probes/uprobes.c                 |  31 ++++
 arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S | 148 ++++++++++++++++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.c     |  32 ++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.h     |   6 +
 8 files changed, 453 insertions(+), 10 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261111-probes-in-lrsc-4ccde6cbf436

Best regards,
--  
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

