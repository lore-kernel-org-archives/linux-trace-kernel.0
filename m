Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197265;
	b=FCx+L6tNeJydoMv5d+Jb/Y3w0K1XfVcTKNpKT/d1eSsWt1TVCOzJLwAwe+lN1CTBhLB4
	 MOV00bPiea5mGz7JZgLYwzwdBeLQLwRXoHxc+17XFE9MudncjLMko2vxvh2lpWfzwBhRw
	 +8L5sT6ewJ3Z5xJHsNOxdbfZ0KoeTCpWWNvZmX/nDcOI/bG+nMjMozlRiLScTyVm8PsOX
	 NYnoPWe4BpEH2Ea99UyMWxQlpuhF2wJ/fsC8TnowmXRP1FFVTSsskRnmeri6Xxm15O5n+
	 hkErCugsAnIYa/MG9D/Qnz9D5xjQPHwGWN6oLfb8jsINUUR41O2ny9sZPPZKhIBqhqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197265;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+zbw+9dEryfCbBPy37sn6USntTVE0xFg0XydIK5Fbqc=;
	b=0DRFW1qFxSxnp0JR61iHWYSQUmfwUsfJ7+rhFKnxE3PDPjvzKw9OFCGdNYAI6KUGRmjk
	 3mjBHRbAskSwy/Y/gvdJwFgkwNckGmN82vzbUZmx/i1kKzqZO1lAYLreOvnUKQubAWGi0
	 s2vMlq5PHXasen8oXrGu8OU5fZUHu/G4gPE9+9ebtQpj5PqIM/zj1c/AzwPsb3YxHzjrk
	 OEHEmd50q9p+yRQvno1NeyDxyqniYdkP/D+yWDNHvJLfGdtSd9Fj42IG/iLkaS8b0RxrF
	 4GtH6Ot8g9tonNMtN3EGrBeBcdI11eeSLZBYVERsi2DBMZw4illATKPlm/d4EGeqXzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RDT55Eq1;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F160A2622;
	Fri, 20 Nov 2026 17:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D55F160A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RDT55Eq1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197265; x=1826733265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rlqwKCJdfx49L70h4PlBEi7+zKqF7NaERB9xr22BVDw=;
  b=RDT55Eq1dPzmyNtXA9eUpdcZBVzqqbNOUEVtNqtMiXMYb+Gu9wWwsWqJ
   SIwF9PyIKF/KPrew64DnT/t3s6mPZ9VH0vz1Ujq6tY6WLb6dhwn+iFrps
   6Kt0oWI89It4iPXfLx9C7p8bCybOdX9dMKn6gOLSdUfNCnwTvskY7kKoo
   4dZxnuPmihnW6mM3fEXVyqjl96DH0Bf3liDfcZX2vYVT9XdhTwbdYeQuc
   LCsOf5fEGiwNmjApzwHvDK/WZPoVuIRhDH6NYpUzkHHhkOyfMNuKyV0oU
   EE5VCLF5gWc1VOpoZ2WRUHmU2bMCXHTBsKZAW/+NfmwjgOaKGFdd8A1EQ
   A==;
X-CSE-ConnectionGUID: cFjba+YsSTO7Amh9TA7usA==
X-CSE-MsgGUID: hvpFQz/BRgysaqLJ6unSrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108897"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108897"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:22 -0800
X-CSE-ConnectionGUID: gmM+Q66xTwSnI+xG8dOOTA==
X-CSE-MsgGUID: qLehQ3XTRqiJUa3Nk/s8GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171029"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:22 -0800
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
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 03/17] platform/x86/intel/ifs: Clarify In-Field Scan MSR bit macro definitions
Date: Fri, 20 Nov 2026 10:56:44 -0700
Message-ID: <20261120175658.1147030-4-ehab.ababneh@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120175658.1147030-1-ehab.ababneh@intel.com>
References: <20261120175658.1147030-1-ehab.ababneh@intel.com>
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
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 arch/x86/include/asm/msr-index.h       | 12 ++++++------
 drivers/platform/x86/intel/ifs/core.c  |  4 ++--
 tools/arch/x86/include/asm/msr-index.h | 12 ++++++------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index addbcdd02b9b..fcf58e1b381f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -277,12 +277,12 @@
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
index a65cfa7a10e4..2a243fda4e5c 100644
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

