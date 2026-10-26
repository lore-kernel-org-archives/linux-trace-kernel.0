Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039747;
	b=fanmLrxfnjEV/dn61703X5FrDS3FZyt8ySpKHGB24lPINwLIuuCwW2Z/Bj/qS/Zg0HVF
	 qT90s3tKU6fvunCCrfvXv9d/tIhRNMPDPuUhawvnEyZwG9lO4N2Glo9wsav1B3oR0V+6x
	 eCoGrf73DXNPdq+vFI5DRxgzXYrIqiEfrKosl3p1uPzdx0tjsVP8jXieoAJBCoyoO0eHN
	 gd3GJEbfQe+loZPukDvD8owtSAGe+BRwdC57155EILl2xuu/4HKRbzQfD89/7h7gk/Lj9
	 ZJ4J84zgXd/53CqxC6//6vj6zgkgOjHczIAMuJKxrnWCiIjKNfjZ8f+PoKOqU3FDNCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039747;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=J+/2ZGkYGblq1D6EinElHR6AhsB8a3+/ajje3J+qxU0=;
	b=Df9kLeZOcAa/GEEmFBEwxFSlszYxBeQMGP8+zATxmArUNsdYBF5ct+SrN7Wk+AVu7Tct
	 IwjOGtltPafI8GLMUWjTGYIKGWHcMz0Nkwlix3kpLBzIpU915SdMeaQxjxQwdn/xD47BN
	 leFdwx6zN/Ftg1+VSonKTIvwPm3uMG0tdWyEHtPWYjAIIReKRhx4C8p+myTqkX2K3haS5
	 JDV6tkL6VCQAY/rWWu7+77d+vCCYGnY5jEQkE1bLZ3LqhsncQOMSWXRxeku5Vn0dsEZuD
	 zUVxPA5W56J3SfUqSsdHYV+xJv87fG6FeOnipGqKqrFmbDWhc4kEqeVoMfcIWQZxU7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GgPrZAD8;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61C606A336;
	Mon, 26 Oct 2026 18:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC61C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GgPrZAD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039741; x=1824575741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DuPXL8HNeovHwLqqgOcPU0U1BhZU9PUtkUI29p6d8SU=;
  b=GgPrZAD8ND3ZpN0hGoclIqd3eC0m/hvKsthJBC/ei34Somy85Q+zhkKu
   nOacc7KD9/VgAu+fUle0doOY9xcyvY4cM7ra2Ex6/AGs9jP0JQtt2AUAq
   jslMxWgX3qKM50OFCt0xRVbQcRm8A6Dx1ZSB+22qLN2SkS3i3eIAK9qrf
   nU9tae8m/OulVTFbeaSFTCJ6lmxcjPSPbEljN/AbOLltR08maVXZm+gQf
   guwUB5j8Eu75j21jeIWp3w3V+G77FyxEeb7nxWFK+YsJjSBxVPfXNleGY
   yfKy6d2bUldVPNyyhpYeW06VnGYjn6UPwpsaSdZTe8PO1i9twxha0qcSB
   Q==;
X-CSE-ConnectionGUID: usKS0uWKQbSbB/9RIJigNg==
X-CSE-MsgGUID: KJeDafirSvW9LQ6kTiyO/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731506"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731506"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:36 -0700
X-CSE-ConnectionGUID: 3kbwZ+9nT9eoDBnu9oqGFQ==
X-CSE-MsgGUID: ZBF+8o78STifHwKIZgEVaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293887"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:36 -0700
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
Subject: [PATCH 08/17] platform/x86/intel/ifs: Enumerate the bit to determine if CPUs need to join for IFS tests
Date: Mon, 26 Oct 2026 11:38:11 -0700
Message-ID: <20261026183820.129459-9-ehab.ababneh@intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jithu Joseph <jithu.joseph@intel.com>

Starting with Granite Rapids (GNR), bit 21 (ALL_LP_JOIN_NEEDED) of
MSR_INTEGRITY_CAPABILITIES register [1] indicates whether all CPUs sharing
the scan test engine need to be tested together. These CPUs must join
using MSR_ACTIVATE_SCAN.

Add an enumeration of bit 21 to determine if CPUs need to join to run IFS
tests together.

[1] Vol. 4 "Table 2-56. Additional MSRs Supported by the Intel® Xeon®
    6 P-Core Processors" in the Intel Software Developers' Manual,
    March 2025.

[ Qiuxu: Elaborate commit message. ]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 arch/x86/include/asm/msr-index.h      |  2 ++
 drivers/platform/x86/intel/ifs/core.c | 12 ++++++++++++
 drivers/platform/x86/intel/ifs/ifs.h  |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 660b0c332be2..554ce662fdf4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -281,6 +281,8 @@
 #define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST		BIT(MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_SAF_GEN_MASK			GENMASK_ULL(10, 9)
+#define MSR_INTEGRITY_CAPS_ALL_LP_JOIN_BIT		21
+#define MSR_INTEGRITY_CAPS_ALL_LP_JOIN			BIT(MSR_INTEGRITY_CAPS_ALL_LP_JOIN_BIT)
 
 #define MSR_LBR_NHM_FROM		0x00000680
 #define MSR_LBR_NHM_TO			0x000006c0
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 85a04ecc9dbe..f2d2caab0479 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -110,6 +110,18 @@ static int __init ifs_init(void)
 			continue;
 		ifs_devices[i].rw_data.generation = FIELD_GET(MSR_INTEGRITY_CAPS_SAF_GEN_MASK,
 							      msrval);
+		/*
+		 * For Sapphire Rapids and Emerald Rapids (SAF_GEN=0), the ALL_LP_JOIN
+		 * indicator is unavailable. However, all the threads within a core still
+		 * need to run IFS simultaneously, so the variable 'all_lp_join' is
+		 * forced to true.
+		 *
+		 * For Granite Rapids and later generations (SAF_GEN=2), the ALL_LP_JOIN
+		 * indicator is available, the variable 'all_lp_join' is determined by
+		 * this indicator.
+		 */
+		ifs_devices[i].rw_data.all_lp_join = ifs_devices[i].rw_data.generation ?
+						(msrval & MSR_INTEGRITY_CAPS_ALL_LP_JOIN) : true;
 		ifs_devices[i].rw_data.array_gen = (u32)m->driver_data;
 		ret = misc_register(&ifs_devices[i].misc);
 		if (ret)
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index f52287745366..814ebac10a5d 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -295,6 +295,7 @@ struct ifs_test_msrs {
  * @generation: IFS test generation enumerated by hardware
  * @chunk_size: size of a test chunk
  * @array_gen: test generation of array test
+ * @all_lp_join: all logical processors join test
  */
 struct ifs_data {
 	int	loaded_version;
@@ -307,6 +308,7 @@ struct ifs_data {
 	u32	generation;
 	u32	chunk_size;
 	u32	array_gen;
+	bool	all_lp_join;
 };
 
 struct ifs_work {
-- 
2.43.0

