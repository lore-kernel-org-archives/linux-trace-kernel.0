Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197273;
	b=SkKJMIMzjN7MrBTZKaFf5AC6RA8CKCR99vsqWplh2p9PJJK4QoHy7tnzZywNQX5pIEy2
	 kLloHibiP2JQWaqlX7jX7ff1fwrKNPnaqfjTV84kVCaHXuftiFehg4inD51fPM77MNyM0
	 LvlMV88dFQnwXYjQsw5MeZbZQeH6vGDtquweMOXx+UL9l56BCmFIczxpMjfnDr1MijUuE
	 3faOqZOZUpeZP4kWdz7N4Rh0bGmudCcRVZRgw5sKRJR7fR1IX8Hi1K/uUIB+ajBPu4yRG
	 l7JnIsmIirApNf2iwcxnB58kyt7IcCQqkSpJglag67mKeMKUEP0iX4ml20xag7jziIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197273;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=bUnK0r3vfncL1FjP3sjPQpHeRU41YeQlwu/6ylRFx3g=;
	b=IaZVrEP603G0QYak6F0YwUdvYm0r0nXLkuzGk0raKqAMQyfbjshutZRQGmloOsPH2Q8C
	 kWvTOWDvmsdZdmZ8q7H6xb8vGC6olaswSa58Vb/J/Wps5H85S5pO/YsK17FXeq4q7xtZw
	 vY0FWMDXdJXH/raoexXzndj+gi6dKc3992KArSrU5BrzokYqVU3SM8bqd/9k0+KlitCKL
	 YKWGAz/GcBE82M5wfKBqvVea4MBwoYX7JsPVDdpubAaT52SJpRWtsNUIiiohys+jqV5XR
	 L++PCaPxUsL1FGUWfBSLSxlNhl4fE0ajgjfxqSlKMzfjiEOX6nAA9+rJ2b2VP5zOQDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fl6UFcLD;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEE60A3827;
	Fri, 20 Nov 2026 17:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EEE60A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fl6UFcLD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197272; x=1826733272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hkM4azn/EnZXY6GdTp8kcNRxpG0cX6607L/7loakvno=;
  b=fl6UFcLDzSB96Vx4d0GO2EysNMrcSx6qnHInXWEKLY9fqa+V96cB5Fxz
   nhDp9ChM6PdenGlHAC3Pd6JI4op7jqEbKcltb+gdf08eARcL/7EiKhVoL
   ib+kaBF7/Y0lYUZnWy1lUZjecJ2lIUGUgEhISGLgUrNaegGY8TesXIg20
   r7UFVNT6elyI35Ky/fXB/EDXCl8o25mf+1bjBi5qW5UOw+UKdAP76kms/
   AZPa7nVRkDMdZDsAGcK7S5ZscsIXrgPWN/8TDxyxwTkItbXnn7iXUtFV3
   QeGzMb0GiAlFlSHnaewLX1Z50WhTpXhNbm3y2eJDKkyOozkFVcLAhR187
   w==;
X-CSE-ConnectionGUID: eCZs0ErYQLuXlOgPSw4IwA==
X-CSE-MsgGUID: QzcEen82THu4neVO+Czq7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108949"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108949"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:24 -0800
X-CSE-ConnectionGUID: x6hApR10QFi7+BhwXNQf+w==
X-CSE-MsgGUID: ZFaOv/JLTKS3ek56u1//VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171056"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:24 -0800
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
Subject: [PATCH v3 08/17] platform/x86/intel/ifs: Enumerate the bit to determine if CPUs need to join for IFS tests
Date: Fri, 20 Nov 2026 10:56:49 -0700
Message-ID: <20261120175658.1147030-9-ehab.ababneh@intel.com>
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

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 arch/x86/include/asm/msr-index.h      |  2 ++
 drivers/platform/x86/intel/ifs/core.c | 12 ++++++++++++
 drivers/platform/x86/intel/ifs/ifs.h  |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index fcf58e1b381f..9224b55e1f07 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -283,6 +283,8 @@
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

