Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477722;
	b=w3nHsY1KdTxk71RAU2GpgWx97vBXlcMwftJwMpf8gfkFgMp/CHmlzu1H/67o5PhPER8L
	 +iufyAhz4PGR6fS0JW3mA1nVhvzajBGHNHxYDQx0i0x/IgIdpZO4AwFJoP2OTmJ8Qq46l
	 z8Q/coCRutggGupJXYHp3B02SPlZfsZYFwPRDde+w7VIYKtaufsMdJUnqTQw5DToXEPCq
	 u5k5AQiYR1fs20xHxuJO2YW+yccylR7tzOPrCSY3qPYOcr39XoyS1u+djV0PfWbr2fbcW
	 yNNlzzPB/I09tSsMBN8Cd6By4FQnIR1rSshAO/RPVXiP4462DS3NEQaZ1BDVTe3ueZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477722;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=1FXEgYcxxXJgy5WPQEF/P/pK5xzBtD9gYmvBHS9U4mU=;
	b=e3fp2wuFaI9aR3APAchD93DJBS51MBy4anbt5LPuvPyKjfYUrUYtpmG8JPYjYJY4OaOJ
	 K6duj4/f3Xr+g2ZxVDuMjrZec0YXAgmczemu86daMPrVUUueRG5cJ6gesuF2kiJ9W00TG
	 FZET9nNHwZ7DKIJwHgEmc2472gGFG3S6Rr+7VZRwplQ7H2UQmahoKseNl8nQi9FEEhhYg
	 uXACCdSkMdb7XK1NkDOMlTRngILKpctR1FvOBWvXRx7JVe2UlcF6z+9X74YY9Fo7OwJvO
	 wFws6/FM6WV54df9Y+HSAwNu85wHZ0o1rjZwkL1xSPDTDnRv2ZTIRs9/F2HoY0Exc4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB97606A31C;
	Thu, 12 Nov 2026 10:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AB97606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794477722; x=1826013722;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=mMjEjjNBNeQ3hphvJgHcDnn3rGQSMsTx89cdVFhbk/I=;
  b=uq+Yd8xSUrtZbj4sz7D1Xp70Jk9h09KTiHuimHq5hX2aRt/i3a64ncFt
   wDTxxXh4usabTds3lFnR/LDfiChaxL8U9wkiu65+7S25Swl0Kq7pShLw2
   1DwMbdtlNbMI1cp1Clnred10bt84BvNcGAaTO3rPbHooEgSE20sc+MxQt
   p1OnzPCjn6kHGZcotz8x25FLJ8fTqAKyKIlHgK0DNTb7W/gHTkA+O4aOJ
   WOX4UjPjLlpf+ke+bYa1nIs8YGUoYc+YEUvltGPIqUu7Z9l41p3dCSzV6
   VyiXyeMh1IUkChKtyqmgq/5avaDK6ACTpHq1FBs7e2ZqzYlb/7h2wEVaS
   A==;
X-CSE-ConnectionGUID: 282oaaNjRsSWk8RHbGxu9Q==
X-CSE-MsgGUID: Zp/gv4PYSiqnf0PE5BH9ew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:01:59 +0200
X-CSE-ConnectionGUID: tqG99rijSfOKtEoICM7JmA==
X-CSE-MsgGUID: FJ0d8Z2lTPmSSo5/ZwY//Q==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 12 Nov 2026 12:09:55 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 12 Nov 2026 12:01:57 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: [PATCH v3 0/2] riscv: probes: reject probes inside an LR/SC
 sequence
Date: Thu, 12 Nov 2026 12:01:43 +0200
Message-Id: <20261112-probes-in-lrsc-v3-0-a95089852a17@mobileye.com>
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
X-B4-Tracking: v=1; b=H4sIAIeO9WoC/33NQQ6CMBAF0KuQrh1DC1Rw5T2MC9pOpQYoabGRE
 O5uizsTnd1P/n+zEo/OoCfnbCUOg/HGjjEUh4zIrh3vCEbFTFjOOI0Hk7MCPZgReucllFIq5FL
 osuAkjiaH2rx28Hr7ZP8UD5RzUlKjM362btk/Bpp6P/FAgUKpm0YpbCvN68tghelxwaO0A0l+Y
 P8FBjkIVrFKnJBijV/Ctm1vFN9chAMBAAA=
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
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0

Patch 1 fixes page fault reported by sashiko-bot@kernel.org that
existed before this patch series

Patch 2 rejects probes inside the LR/SC sequence. This commit was
submitted as patch 1 of the series [1].
Detaching it from that series with slightly edited commit message,
because it is not depending on other stuff.

[1] https://patch.msgid.link/20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com

---
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
Vladimir Kondratiev (2):
      riscv: kprobes: fix out-of-bounds read in riscv_probe_decode_insn
      riscv: probes: reject probes inside an LR/SC sequence

 arch/riscv/include/asm/insn.h          | 28 +++++++++++
 arch/riscv/kernel/probes/decode-insn.c | 91 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/probes/decode-insn.h |  7 +++
 arch/riscv/kernel/probes/kprobes.c     | 29 +++++++----
 arch/riscv/kernel/probes/uprobes.c     | 31 ++++++++++++
 5 files changed, 177 insertions(+), 9 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261111-probes-in-lrsc-4ccde6cbf436

Best regards,
--  
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

