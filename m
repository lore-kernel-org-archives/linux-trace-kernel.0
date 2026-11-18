Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030227;
	b=q6BK/FoBazTEwBdOuurbbS3F67eyCv1kQT0t8hYJTDqr7hwuom9XTVQfEdksWfSrGTRe
	 WyiMjnxLslhGA46Dfih7e6LAF7GDbG0rzUZ6YcwohKgLGmPjFzA9b/Qbaw5TRLRSiwqip
	 T2KOGr69/u3qtrMWjEFj1RE4kUFocp7k3kihYOg9DveDh7QH00srA+oPa+FUsXp4U0B9U
	 xbyhdy/CqI7LtE6snI0bSPROsPLYYc1EpKQbLq8/vzI2/tkmn01qnINe8sCE1jXIwLci8
	 59j/qZuXbYXiULt0iVcKb6Jh6RWr/F11gS1o53bHHXWHXLQgKKWd5+/tfZmwKFll9WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030227;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+zbw+9dEryfCbBPy37sn6USntTVE0xFg0XydIK5Fbqc=;
	b=fKkjcZJyplFdGb6tqkQgb6EAqDgGlEAH/dwCnHrGA37WiEErBozVLb1wLDw6BR9Nnunm
	 dySFls1GU9Lpgi20oHideSPr0K/MBi3s/cmvhkK+SalYfCsyFwamXXG6HlGsBFKmkDfZv
	 k9zg6QCKTZNPF61SdiZnnU22UBkPogjiysFw07WCduCI5tUeSlUrxdRBnjGLRzqaSYkFS
	 o88W5+pBSa77D7LAky/xefMXWt+RC2OKP2JkTn8nqjl5cW/Kp3OfFGTVef8yVrl6L/Llp
	 fgGoFt6pjTbAhn5OOn3IjJc9gCL+fDQNBgnW117Ys5Zy1oZ4Z66SjH0Yg8GNSYTwPhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bUsB91Fi;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC982606DD23;
	Wed, 18 Nov 2026 19:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC982606DD23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bUsB91Fi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030227; x=1826566227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rlqwKCJdfx49L70h4PlBEi7+zKqF7NaERB9xr22BVDw=;
  b=bUsB91Fi5cCibu7EHRNd7YdX/q2e2RepJAnQnzLKI76NL94XT7CHJdw7
   yr27j1gAgMUYL1bviWDM+YB3dssx1nWNVkxzQhO4A+d8M5Hv3zv9SXnn/
   +R/LXNTV15Jel+Cu876QFECiuJGYcSOk1SGbpwAR086TkEFbrcHYkDdBb
   6rBlw1+E5KyAh7AnFO1r6bxbk+Wx0enGwffYtpUZN6q/sw/lSG7j9X6vk
   LfuLh4uS9tyUujJ6l3zpVCk01ab1ntdg6/XnkidewlBj/ssJwwlS1g/9w
   QQ75iQf/UusQb231sTVgh2JNTj/eTJ6V55tsoLbqULLw7swzvFIIn0RXR
   Q==;
X-CSE-ConnectionGUID: Mu9O3jQ/Tte6GO6yJ2aEIA==
X-CSE-MsgGUID: lswofqc4R76UsV06MuIyJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781212"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781212"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:26 -0800
X-CSE-ConnectionGUID: /nuFYbZ7R/ux8f55iXXc8A==
X-CSE-MsgGUID: FBpJ2y8mS3iAR8X3fcb7Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468073"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:25 -0800
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
Subject: [PATCH v2 03/17] platform/x86/intel/ifs: Clarify In-Field Scan MSR bit macro definitions
Date: Wed, 18 Nov 2026 12:32:45 -0700
Message-ID: <20261118193259.519568-4-ehab.ababneh@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118193259.519568-1-ehab.ababneh@intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com>
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

