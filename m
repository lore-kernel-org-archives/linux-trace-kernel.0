Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030229;
	b=5tCJn96mo3uXQNFIYF+Iiv9ywbpMhuFQEXH1Vp+a1pkKOdSFd9U7e2GYqf07f08E6PxZ
	 2Is0At3xrGPK7xSOsu5ww4wwv6dISNiS3HpQ+qs8/IPM2sFqEgm3MUz61d+kGg+xxpaY5
	 82XwEDrGI2w21FTn9ZKRStbTZCIUrqYN6v1o4JyPj/nEnmSK3pEiX+y56Cb/WFENLjqpL
	 a0N5/cJX+2MHpAa6raaA+k4UeWxTm6g7ADDRYTHHb3ZGaYfJdO6K08CXHIXCaV+YDt7tS
	 g4/6U2gNRpyHpTBpDtdGVIcI85/ec6z4M/aEhK0ma+TXbZfDhc2GAhw5WmMNUyc5UPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030229;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=xHB6JF0nrZwYGRX0B39f9wXPera4tmnRPmj2TzdjwX0=;
	b=HHiN4GLcKDe4mL5bZ0ALWvzR4qOd1u6zzGyOmcTqgr8/qPC5a3lGZkkrpdq5K0ROzVy4
	 WZGT43lu8BEdJDqBai39s2XWOG1CkiAvXfhsy/g3vrIl74gZknfsC7455DKs3uYxQ+cWf
	 0d9aU9Jbi6hSIITCa5jMVVByy/Op7rWFBTv/CeryclirF0rEdTBQxGg2/kLPLTShx4j1v
	 UQFUJW5s0UcP53k246MtdXs5V6LlmgKsx3MmtHRPP5ap9DdKj/gkWSEzTyehXIEMBRpvV
	 QggTPi/OCHS4hg68HlZFw4MxroZSd2baJ5+JSXDy1Ef+N4wPrqVfuAQtJlzD4bqT3Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C8BgXII4;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FCF607D6B1;
	Wed, 18 Nov 2026 19:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7FCF607D6B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C8BgXII4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030229; x=1826566229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RjF5LP919KksJoO2OcNI4PIrsKQdH1+IzECh5dVG5Fo=;
  b=C8BgXII4IF3hWt498NZdQO6N1m128nyUENjRhJ2LblnJ9lL7MCVc7fzr
   v+ZGdvl1uHhsNJ5H7sKOHVIEt4cGXcI7TI5oKr2EAy1lT2p6we1JqhbFH
   MocAY0IeiRvpFT233e9X5mCzNYyapqssW5gnsFTZ7IQjdEvBKywa3EWMy
   fNeHOGhkgUF1yT/FaHY+opoAVbLnMRqu4uarEgBdQ0rByQ50FKlut1oXd
   Q7U3FPX5fLanJf0+YmZINK+GJzdI/AelmFfLSxJ8/fLWza0np6e6F+JgS
   cHTOSsz7jUNVl9DiQ0o6gcVmLjI8UgkXPsV7Fo3iomftARfA3ogItAdNt
   A==;
X-CSE-ConnectionGUID: a6lUs0MbTH2D7RD78zPRtg==
X-CSE-MsgGUID: //6B2E88TLSs+DsaJrPwcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781254"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781254"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:28 -0800
X-CSE-ConnectionGUID: K1S8MYwvTii2j+TxiYVH6w==
X-CSE-MsgGUID: t+GboIU1QNi8HbHmLOSfQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468095"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:27 -0800
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
Subject: [PATCH v2 08/17] platform/x86/intel/ifs: Enumerate the bit to determine if CPUs need to join for IFS tests
Date: Wed, 18 Nov 2026 12:32:50 -0700
Message-ID: <20261118193259.519568-9-ehab.ababneh@intel.com>
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

