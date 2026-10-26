Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039739;
	b=Jntw4L1p73zjRfVVOAOWcjLSUfg9OfTw1O9uXC7/JmvRP21w6DodockD+8xdqyzUJBwU
	 XDgTPFQVR+qK3nYhiFhmq2fj8gQw6Cj/jacS1wV/MZPPclc9V+bRK8s7idtHuW+g8irg2
	 r2mhYjGO3D43velaMITD5OWEeqlvsHlPU9k7wclS6CQ+VkwRbSGaXVhMUj6tQEfviYYp7
	 tMmvGi43qH3TxWfVSKpx0xCAYfgb6gX+on054n3Wm1v4cTOd/h+jgW4hrxsJ6D+tI0QWB
	 CNVQKmrvrwlLU79kexiLeEGfiz08+/450g/iVdqQA67jPUEuFTIz3zLpNzIZGfk7nGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039739;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zYc1qAVr0ISWTHVsxU8GI+37KVT00reqFx70LBZ02HQ=;
	b=L3SXmg68rtyZXgzslfgiuFEHTXOxESIo9qEcjU7LX28U18LAzTRDLVziQ8/+WqmM3MVW
	 hZ6yMJv362PDXt692LlmolRdOx+vKowJXlcZuRG3Q2kkNfiBTgJJ8h0kRFnBTeTCCt0nU
	 HFL6Md3u8+4Haxik132Gn6T9Bc1SON5LB5/zXLe36TNOvxDQLzK2olBtio1hV07ltwFu4
	 wwz7MrHqWZH1ueNalxD4U4IWUy0hJIRZkeyHtW9o4v4ZjFPCJem0bysKlzRa2XnE15bNd
	 nkisohJGHBN7LOREaLrrbknCz6N8BuwzI+sD3z4v7MXDmmbAUsT9HWciH/FSe13v3eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FXMV8+My;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC2606A322;
	Mon, 26 Oct 2026 18:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDBC2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FXMV8+My
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039738; x=1824575738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wiGXJW5Ajpuf77PQD6Ta/tn8uoRwAjZ5goY4B0Ax0lI=;
  b=FXMV8+MyWZjmU4PWIM8oaVo0d8qEFOKPtHeXpEI64MbUELwpbUxpbtpc
   LZzlFrESgTH0gFv4R9e2cgu9tIQo0EVXnOc46uBUOHteKka5Jt8nly0Ju
   Yya02o0TAvMchYUU5gJNtkk7Fyd4PagAlWkbS6ecIjDteHNYfEKTsb0so
   SSc0lxZ+5sUWEtcXjv/Ii3cnXc/9ufbACw4OM5oFeYEbj8uXtydZNEHvu
   Cuar9W5MdVOnaanz90wKMZH0O2fOCnSNxa42vVqXHc5penqt7GHw+20v1
   BEp/lpuWPIGntGamxHl2XFsq8/SoVF1FPYUuGSOIrUcoo9WSX1M8+p6EU
   Q==;
X-CSE-ConnectionGUID: oWsaUUwGSviGIA62zhvF9Q==
X-CSE-MsgGUID: 8MlVkaS5TPCoK7Zd9DwSow==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731460"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731460"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:35 -0700
X-CSE-ConnectionGUID: skM+Px+yQxOn2HOXCjYUvw==
X-CSE-MsgGUID: 5IvpKqaNR4y3r4MALXt/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293866"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:35 -0700
From: Ehab Ababneh <ehab.ababneh@intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	tony.luck@intel.com
Cc: ashok.raj.linux@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	pengfei.xu@intel.com,
	ravi.v.shankar@intel.com
Subject: [PATCH 03/17] platform/x86/intel/ifs: Clarify In-Field Scan MSR bit macro definitions
Date: Mon, 26 Oct 2026 11:38:06 -0700
Message-ID: <20261026183820.129459-4-ehab.ababneh@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026183820.129459-1-ehab.ababneh@intel.com>
References: <20261026183820.129459-1-ehab.ababneh@intel.com>
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

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Current macros for Intel In-Field Scan MSR bits are confusing. They don't
clearly distinguish between testing types (Scan At Field vs. Array BIST)
or testing timing (processor startup vs. Linux Intel IFS driver at
runtime).

Clarify these macros by adopting the naming convention from [1]:

  - PERIODIC (vs. STARTUP) indicates testing capability at runtime.

  - SCAN_BIST indicates Scan At Field testing capability.

  - ARRAY_BIST indicates Array BIST testing capability [2].

Additionally, align these macros vertically for better readability.

No functional changes.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual (SDM),
    Vol. 4, "Additional MSRs Supported by the Intel Xeon 6 P-Core
    Processors".

[2] Use ARRAY_BIST instead of MEM_BIST used in [1], which is confusing
    with DDR memory.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 arch/x86/include/asm/msr-index.h       | 12 ++++++------
 drivers/platform/x86/intel/ifs/core.c  |  4 ++--
 tools/arch/x86/include/asm/msr-index.h | 12 ++++++------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ac73dadb44e0..660b0c332be2 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -275,12 +275,12 @@
 #define MSR_IA32_POWER_CTL_BIT_EE	19
 
 /* Abbreviated from Intel SDM name IA32_INTEGRITY_CAPABILITIES */
-#define MSR_INTEGRITY_CAPS			0x000002d9
-#define MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT      2
-#define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
-#define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
-#define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
-#define MSR_INTEGRITY_CAPS_SAF_GEN_MASK	GENMASK_ULL(10, 9)
+#define MSR_INTEGRITY_CAPS				0x000002d9
+#define MSR_INTEGRITY_CAPS_PERIODIC_ARRAY_BIST_BIT	2
+#define MSR_INTEGRITY_CAPS_PERIODIC_ARRAY_BIST		BIT(MSR_INTEGRITY_CAPS_PERIODIC_ARRAY_BIST_BIT)
+#define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT	4
+#define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST		BIT(MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT)
+#define MSR_INTEGRITY_CAPS_SAF_GEN_MASK			GENMASK_ULL(10, 9)
 
 #define MSR_LBR_NHM_FROM		0x00000680
 #define MSR_LBR_NHM_TO			0x000006c0
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 574f2a366d06..85a04ecc9dbe 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -32,12 +32,12 @@ ATTRIBUTE_GROUPS(plat_ifs_array);
 bool *ifs_pkg_auth;
 
 static const struct ifs_test_caps scan_test = {
-	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
+	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT,
 	.test_num = IFS_TYPE_SAF,
 };
 
 static const struct ifs_test_caps array_test = {
-	.integrity_cap_bit = MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT,
+	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_ARRAY_BIST_BIT,
 	.test_num = IFS_TYPE_ARRAY_BIST,
 };
 
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index d70f160425a2..8c4424c43a4a 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -275,12 +275,12 @@
 #define MSR_IA32_POWER_CTL_BIT_EE	19
 
 /* Abbreviated from Intel SDM name IA32_INTEGRITY_CAPABILITIES */
-#define MSR_INTEGRITY_CAPS			0x000002d9
-#define MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT      2
-#define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
-#define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
-#define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
-#define MSR_INTEGRITY_CAPS_SAF_GEN_MASK	GENMASK_ULL(10, 9)
+#define MSR_INTEGRITY_CAPS				0x000002d9
+#define MSR_INTEGRITY_CAPS_PERIODIC_ARRAY_BIST_BIT	2
+#define MSR_INTEGRITY_CAPS_PERIODIC_ARRAY_BIST		BIT(MSR_INTEGRITY_CAPS_PERIODIC_ARRAY_BIST_BIT)
+#define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT	4
+#define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST		BIT(MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT)
+#define MSR_INTEGRITY_CAPS_SAF_GEN_MASK			GENMASK_ULL(10, 9)
 
 #define MSR_LBR_NHM_FROM		0x00000680
 #define MSR_LBR_NHM_TO			0x000006c0
-- 
2.43.0

