Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390013BFE26
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406854; cv=none; b=ASVXP94VG9zEwTY2w3UHsUTPF9L4mDCz74IHlqsILP/KoJJD2hQ00ZlseZjy/DdC5RRMfBiq6Wf+Ii71xzIJ2Yb5XbzC25yB4KgTc/IC0JeyNhAeZtcsNogak72v2W4t1p7LsNVuAgba4TGd6C6fd1OmMIlrFpOaIX3QtzPgjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406854; c=relaxed/simple;
	bh=uti0HuVKkz9KXrAZ/9jbGQ5MFKh/9sEgEM+VEybzHS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hBN9+Jf0fL7GkmI082N+tD6BV+Ax6PzDuGPKsM+dxvVh404/LZUkMvojRop5k743g+3ur1rlOVO8ITMBtIoMlOQiCTWcYNPd6aM4RYrmlbtG1ccKBVKn/36Vm2n4900xDsHpcpNycDGzWF3+18FRtZqazqiTp3l3DP+m6c70JVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7ZLp8+S; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7ZLp8+S"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so17149685e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406850; x=1788011650; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NcGHYE7YHIQuleStFkafOmsPgUJAwjDqEsHvPsytY4A=;
        b=h7ZLp8+SUOVvwgkfjIFHLhFmMRYyINfg03d6Ep1sTiU1r1QdCB6sZJsgYz538IELgc
         Sn1yk7/JUqUqJEQLtGlBFeLXWa/3G/iXeJHQfyHLkYyf4qvKK+Af7FOozK7B5eePXcEq
         G71EVLGub6mPaxSU9UltZVekkKEqTTIR+cv6Tkduaga8vAbJmZWce2fxstpKdz99D8RM
         GtqMn+DF1ql4+Bt/mMwso1u8c8saX0dLwY94HTcT3NFJCS7/6HosOjRDaD0Vwv30MBHL
         a7OlSswQUc8qmoivAKJjLZ3R23wk2DwC6cAvIQqYyb98mYZhI55sqzRqKIfJviaelpae
         aGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406850; x=1788011650;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NcGHYE7YHIQuleStFkafOmsPgUJAwjDqEsHvPsytY4A=;
        b=btoH+xfYAwFrEf8orTSJ265/BNv4wAIIqPlSxKWW+voINLDSQrFZYW5EivqZv3K1dR
         GmoyhTEVFo44MzWnNPhrWosP831Mbux+ca/KIx3SrTWBQ7t9VGMURC03994Je2jQuqyx
         Bfp/t1Gf9TDSf+i9JZUGqlemmJBr1tZWw/pq4LWqcW8ugYt9lkwM2PBjB+2sgt8s0olj
         x8scmaCK6xgH2jsnkitJEGzdw58GSNl+5TU3+AhiPcxYIzaCgq1CkLakPfInjLuzrz2l
         DI2tv2xGGK+9Xib/mbyQtV4TJ8I5/5R38Cz9WdUFLK3QxjQM1uvu49uAWD6Da/6+i8GT
         3QYg==
X-Forwarded-Encrypted: i=1; AHgh+RrUICk7rW+xhFfst/un4AusuVbMpY0YcynJN3buXbbVGWGRtmyAAAmSIPuiKuJajvdtPT0iy4OAgSb6ZxI6JNRJ+NA=@vger.kernel.org
X-Gm-Message-State: AFuF++kRBvcKwhSVuLc1D0tJFaDGtbJMQ2x7oNF3tvwspSOLc9G1iiYt
	JUouGMv1Dud+g3kHAFZ7P6O8wTH8QKIfXuqkyYTFvtFAAsS+4KdrvjxLFZEHh4Lisy8OtMUwKg=
	=
X-Received: from wmbeq6.prod.google.com ([2002:a05:600c:8486:b0:496:c04d:501e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b77:b0:499:48bb:417e
 with SMTP id 5b1f17b1804b1-499b82f4163mr187121695e9.2.1787406850393; Sat, 22
 Aug 2026 06:54:10 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:28 +0200
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822135323.795946-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053; i=ardb@kernel.org;
 h=from:subject; bh=ZgfBeS04NmMym7tXXunDIhp6k1y9y951qTGwH0jNq+o=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatz5R0+ffGnRqHZvHKiZ171Tuq2SUp6rLQk556gl5X1W
 i/DWes6SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERETjH8M/j158SWE9PaK6yK
 v2ytKl+pf26qsfCdLZf/86WJtv8K2sjwP73gZ/33YNcPt9OyeQsCeNaV807jMt4k6LzywRmh2Rv W8gAA
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-17-ardb+git@google.com>
Subject: [RFC PATCH 6/9] arm64: Enable the execmem ROX cache for module text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Wire up the existing support for the execmem ROX cache on arm64, so that
it will be used for module .text and .init.text regions. This will be
relied upon by a subsequent patch in order to allocate those regions
from a single chunk of memory.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig   |  1 +
 arch/arm64/mm/init.c | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3afe0688919..080b97b0bbd5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -27,6 +27,7 @@ config ARM64
 	select ARCH_HAS_DMA_OPS if XEN
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
+	select ARCH_HAS_EXECMEM_ROX
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 97987f850a33..e6c98045046e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -531,7 +531,8 @@ struct execmem_info __init *execmem_arch_setup(void)
 			[EXECMEM_DEFAULT] = {
 				.start	= start,
 				.end	= end,
-				.pgprot	= PAGE_KERNEL,
+				.pgprot	= PAGE_KERNEL_ROX,
+				.flags	= EXECMEM_ROX_CACHE,
 				.alignment = 1,
 				.fallback_start	= fallback_start,
 				.fallback_end	= fallback_end,
@@ -548,9 +549,25 @@ struct execmem_info __init *execmem_arch_setup(void)
 				.pgprot	= PAGE_KERNEL,
 				.alignment = 1,
 			},
+			[EXECMEM_MODULE_DATA] = {
+				.start	= start,
+				.end	= end,
+				.pgprot	= PAGE_KERNEL,
+				.alignment = 1,
+				.fallback_start	= fallback_start,
+				.fallback_end	= fallback_end,
+			},
 		},
 	};
 
+	if (!system_supports_bbml2_noabort())
+		execmem_info.ranges[EXECMEM_DEFAULT].flags |= EXECMEM_NO_HUGE_VMAP;
+
 	return &execmem_info;
 }
+
+void execmem_fill_trapping_insns(void *ptr, size_t size)
+{
+	memset32(ptr, AARCH64_BREAK_FAULT, size / sizeof(__le32));
+}
 #endif /* CONFIG_EXECMEM */
-- 
2.55.0.860.g4b6b3295ed-goog

