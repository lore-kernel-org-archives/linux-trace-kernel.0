Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416535;
	b=if1EBnXKp0GFrA/djnXnWNei6rLqlvUsNR4oKM/12hy83gdb18So7yqjJ46i0FYgLPyi
	 VCHzuLlNcFEX6tNLHezVgy4dgsgFjVCHsZkRkRwnyiGX5PwpyUj61osFxUOYACV11keCU
	 pkYBtaSSNcnVMt4kb+yxuMxMnr8fpSbvsI/OCxxdb0BEVZCgiv0qERCfzHGm8qSDV09nm
	 iQVSv9ERBeKhjf7Ygvu675n9SjhAsxOUfMGBnwZFxr2p+u+DuakHRChB8iMDuT5j0H5Ev
	 84MR3B4BR9CFlz9GRdXL/vCR7wrZh4tJewgiDSmTLHEG9FQZRp2MmQlgHXOInCT1MUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416535;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=f4aBxUGI/i9IEXmcYaWufy/MGpOz2B+4nsSppFFrS+8=;
	b=p65eCBWWW600qQ2I81E/Oz/+2GTXlOeNO+A4trKrgqbTP83eFsXRL9u/xSv071khFB5Y
	 6qojIk3klL51Y5CtYmy+Selfm05HIk7pVnFmXDo1Oc6KlfW6R82Sgz35TVKEUksoouXYZ
	 aME1NEMF0t6V19Qkc/JWNjhh8uCzmaNFEv3xXEDkIPCY5lR2d1mxfzyU4qxIKiH6jV4y1
	 Gvnq5/HJOtovzwhHbeoiaOppFIBPIlw17wEfybArLS4O1wv2jWIgaK8unueVSAV4GPdmD
	 hpdNY+kqK23CTGKY0ZYqMZejt+4+2HDoEvPSHhUD4ppHjJbBfaM35WwBLFKwOwFuX4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8AB606A321;
	Wed, 11 Nov 2026 17:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB8AB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794416532; x=1825952532;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=IxwxnDIA+/sk0ZQAuVTz9Rbo8EW+wUc/VXSIbwOtVmg=;
  b=heV+4Yz7B150muGizQT0rjEIp6Yg85LqmBKw9Tlhvbupy8j30zJfXrpu
   ulduKVG0aQt4EG555A1MVxjdb6iQinPzdnnRHYg/fGFiXAhZ+ri6AESiW
   i2y3gSMNlf1MRyeuwv1lkynpedPI3wAQNgR6TAGgHJJXNDaqvz/6F4FAS
   VPYSF5A0D13tSIXahIPFJpJrFbtm37hDu1sqaMszSI9Aznz5ONjA1iZZd
   neTbVdDelRc899ILnTBH0GnwJdr/z4o1TTyjj9lhi+lFF98qLRHxVxWVz
   hQft8ARCcRDxbtk0LLa7PQGxcXziEYgTBV2JOMu+h9PHC6KHr3MOzZ00h
   g==;
X-CSE-ConnectionGUID: SstvAGBKSkGBgrDjF7ev4A==
X-CSE-MsgGUID: NHw9QPdIRly4uX2HLMRIqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 19:02:05 +0200
X-CSE-ConnectionGUID: 6qT7i9r2SxWwP4clXhYOwg==
X-CSE-MsgGUID: Ss41W1xXRjCBviLuEz8/JA==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces02_data.me-corp.lan with SMTP; 11 Nov 2026 19:10:10 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 11 Nov 2026 19:02:03 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: [PATCH v2 0/2] riscv: probes: reject probes inside an LR/SC
 sequence
Date: Wed, 11 Nov 2026 19:01:06 +0200
Message-Id: <20261111-probes-in-lrsc-v2-0-b2525b7e1e8e@mobileye.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFKf9GoC/3WNwQ6CMBBEf4X07BqL2Ign/8NwoNutrAFKukgkh
 H+34Nm5vWTmzaKEIpOoW7aoSBMLhz5BfsgUNnX/JGCXWOWn3OgUGGKwJMA9tFEQCkRHBq0vzka
 l0RDJ82cXPqofy9u+CMfNsjUaljHEeX+c9Nb7K580aCh8WTpH9cWb670Lllua6YihU9W6rl9e0
 DwzwQAAAA==
X-Change-ID: 20261111-probes-in-lrsc-4ccde6cbf436
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
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
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
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

