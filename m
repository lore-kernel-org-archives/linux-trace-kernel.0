Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746334;
	b=tD+m/iwkEYZkpbnp5NORYlaWiVNalBeg9esvB5u0pSjnIuwOAK4zpLH/RCLHjZQkVvw+
	 7dq0S6xaaoPYLGPcYHVFXIbqtddeedaPrdW380eD58lXMCFdiqnbChwhx1OpyoPSUVfAI
	 1coyVgvl7LsS8muQtQZc83CFasq2REP4SXU4Nop+zbn0LpQwX+CvBaJmTMZGN383F/Nha
	 MFE/PNDE60hpWS2jxHnRWX0JUUyD7Htl9v0ip6EUzpym3nnXRkCuTbzle5pDh+v1x8qkq
	 5AfhHZ4QE88azTdh9Fl6FiyZuLyuYDyet4miubCPZfoUwdAnDZY30p3SF/lkPmERxDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746334;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=Vkb7O1AQumfLgUaII4/yprJziQzcBJl7799yF6eYSDE=;
	b=N4TjC5narPICG7RbQMY0j0VM5Q4pqIIhnaUx5NSScdYuRJUap24ASidzlRXG3dnjPUIC
	 NxJ6ki/vEJ4wpljJxlfogYthfH/AYHvLB8fHsFMcwYdmc35pxWCEroDENU1oQIFLAdycZ
	 2ZKiphUnVGfipQENOg1q6/82M800EsTrJgJi3CCMTu7fK3KT3OsIyVFPXafHdkBR5MBvT
	 1bAbsLL4MIVi+f6PUlObggznKQKzH3tWfOmZgWdEpYqxMEvwbZy0adDDtepGYPjgcIQvl
	 trYvCVSbIptA9Vhub2FBmQ2PXH8XBRVMjZOhLD+pB57BcCpYzBN8POzNszA6OU8i6Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1A5606A31A;
	Sun, 15 Nov 2026 12:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D1A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794746338; x=1826282338;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=w9+PrJPy3C6TaGPCLLB+9hxO8eYoyLxHkknQ9247xUM=;
  b=JjGaLT3bjYzE6NKrEG8WQDneH3l4NwklU4HB0HUyWEPoTNbainf8VPMM
   plQTLVTlqyqqP/UtW4KI0BO4SOH7v6ApPIEeqgsiiDNJ3S1+Mm3DrFUSu
   F13oezO5Tmhseq9/7TP9ViKCE3/+8we6sRRfKCv63+Wp1JtE+I4p51SKq
   STDMG5i3qBQ3SSZhDVn0HZGadYZwe0KzF8ZD5yc8TeQGWGfTDBi9py4Sm
   M5WTggiXPAR4i9ZpKFZ9Y1LHP253SJ1EDqM7yTwQC1Z/K1HgvJX6W7bUz
   Z3SQYXJTdNqMFJErydnYAq5eyHTS4Yv3yk1DT7DYNVXvECUt54wMRY9D6
   g==;
X-CSE-ConnectionGUID: bO6yt3efRpiLCb+V0r4gCg==
X-CSE-MsgGUID: goLjLQhPRfa6beG8FYsEfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 14:38:50 +0200
X-CSE-ConnectionGUID: i/UPQMHlS4mBh7ry+NDfJw==
X-CSE-MsgGUID: iBpeRpW/QY+HIX4idDwMhg==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 15 Nov 2026 14:46:58 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Sun, 15 Nov 2026 14:38:41 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: [PATCH v4 0/3] riscv: probes: reject probes inside an LR/SC
 sequence
Date: Sun, 15 Nov 2026 14:37:32 +0200
Message-Id: <20261115-probes-in-lrsc-v4-0-48b9b036bd1d@mobileye.com>
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
X-B4-Tracking: v=1; b=H4sIAIyn+WoC/33NTQ6CMBAF4KuQrh1DCy3FlfcwLmgZpAYoaZFIC
 He34Mb4N7uXvPfNTDw6g54copk4HI03tgsh3UVE10V3QTBlyITFTNBw0Dur0IPpoHFeQ6p1iUK
 rKk0ECaPeYWXuG3g6P7O/qSvqYVXWRm38YN20fRzp2vuJjxQopFWelyUWvBLy2FplGpxwr21LV
 n9k/wUGMSjGGVcZUpT4RUheBfYhJEEoch7LXHJW0OxNWJblAZUsMB9FAQAA
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

Patch 3 adds KUnit test, suggested by
Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com> in [2]

[1] https://patch.msgid.link/20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com
[2] https://lore.kernel.org/linux-riscv/20261019134121.1763-3-yuanxiaofeng@eswincomputing.com/

---
Changes in v4:
- Add KUnit test as suggested by Guo Ren <guoren@kernel.org>, based on
  work by Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
- Scan for SC up to maximum possible sequence length. SPU does not know
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

 arch/riscv/include/asm/insn.h                      | 28 +++++++
 arch/riscv/kernel/probes/decode-insn.c             | 91 ++++++++++++++++++++++
 arch/riscv/kernel/probes/decode-insn.h             |  7 ++
 arch/riscv/kernel/probes/kprobes.c                 | 28 +++++--
 arch/riscv/kernel/probes/uprobes.c                 | 31 ++++++++
 arch/riscv/kernel/tests/kprobes/test-kprobes-asm.S | 58 ++++++++++++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.c     | 32 ++++++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.h     |  6 ++
 8 files changed, 274 insertions(+), 7 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261111-probes-in-lrsc-4ccde6cbf436

Best regards,
--  
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

