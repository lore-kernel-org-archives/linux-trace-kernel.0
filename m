Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039739;
	b=aZDZGk86vp5n47usDH4yAbR0vuPQEfIHUYDx/imfXgXuPJLk71OtI6l8jMpZwKdRKg8G
	 q5HRLeD/766L/3n6mlyBtiTMEgYL+L2IsejnEBF0W0B0YCsxTQeHTthrAbUZzM3qfYQ+V
	 pUwCTH14wWLFYXb/BJ2+D6y6nlhT27obGSpDlCCMEbyFZ+h8OScjgJ+3mUTv4Q50Ho1XG
	 ucnyTB57tpInRGjhjE9rDbmW6bn6x1/F4zF7KNRBhDswi0mPi3W4No9OuBtzCsw4U0Quv
	 kWfFc1bekxToPy5aD4ygzOAgt/Xbe/CFTy6aV6Ty1+gtm+F/jdVl8Ewb6pHG/ee67sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039739;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oOsWYs5J52jJpaI/tqgmvUEXCNrzxmHhTjyrVcOLTo8=;
	b=QADG8h4mKNCMHyzY7RydvakllcCV3lvZBI/8ixuDPYvFOE/yKe4muET/34I/6h+PhPjK
	 d5l5FgjO3M7/5QyoKFFoQRYxQJ/8f3wskJdaBa1GueE8DD22JZemS0ECWBbaEr38HBJci
	 RnplM4ZjJbgssPF+vfXbpjvEllt2nbjPCW/aI83RzeLmUCgiSloGTtI4MkPh4ExZLnFC5
	 CMGM5fJzStM2ftC/8/bgVbGYMpw0pqJGEgRSkBKgLvqRulkAg9y0OSqQxP73NUD5Gs+O/
	 esfVIaGfU/VLZOe5snh8GEN6VRhd47Wi+SNwkpf5GbbZWNKkkEtDtKge7yeECRXDC0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TGtR5Lvk;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB93606A326;
	Mon, 26 Oct 2026 18:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DB93606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TGtR5Lvk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039739; x=1824575739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vOEetN6B1gQxi1WFP/OWgNL1Gb2g8930BL49ybIBsq8=;
  b=TGtR5LvkLYiFBtgrDMvyae+IubIMQ5Yo4oDx0gk/+XpCIokE5V3NI6Gv
   XuAO2pi1y4z71rTUzEB7rPGWYjqZAeFs2SD0012A0iqgdNeFj5r9DufkP
   W7Htq09ccsTebjyDZqW8YqxorDWhYA+Sc4rIrquXUZ0HufqBfrtPKyYfc
   9T6vBOBdLAVN/YQ3GpVQF/XQ5rNfl9NOuzb8z8M2GjLQ0eXxnMPqnZpZd
   wrOpRQHwcoX2UpBtEYTj3I9H/pCkypCPsjNKWpsqWMDL8ToS1hZt3jJ2l
   am5CHMXmrgMNZizB+Z01wzrMMBAqXJFJzqIXipwtB+6jO1iVlRs5amP1/
   w==;
X-CSE-ConnectionGUID: vPZ+iWDsTuyL52owsyMFHw==
X-CSE-MsgGUID: tNhLvw5GR/ye0eO+I2nCMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731469"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731469"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:35 -0700
X-CSE-ConnectionGUID: flF4SY08QgS2g3tg0+kcoQ==
X-CSE-MsgGUID: 8Mp/5OSTSXiNIETBlGSV7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293870"
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
Subject: [PATCH 04/17] platform/x86/intel/ifs: Use u64 to define the bits of IFS MSR registers
Date: Mon, 26 Oct 2026 11:38:07 -0700
Message-ID: <20261026183820.129459-5-ehab.ababneh@intel.com>
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

The IFS (In-Field Scan) related MSR registers are all 64-bit wide.
Use a single u64 within a struct to define the bits of an IFS MSR
register in a more compact form, instead of using {u16, u32} for
each bit, to enhance readability.

No functional changes.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h | 66 ++++++++++++++--------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 0f5cdc1ad14d..f52287745366 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -156,26 +156,26 @@
 union ifs_scan_hashes_status {
 	u64	data;
 	struct {
-		u32	chunk_size	:16;
-		u32	num_chunks	:8;
-		u32	rsvd1		:8;
-		u32	error_code	:8;
-		u32	rsvd2		:11;
-		u32	max_core_limit	:12;
-		u32	valid		:1;
+		u64	chunk_size	: 16,
+			num_chunks	:  8,
+			rsvd1		:  8,
+			error_code	:  8,
+			rsvd2		: 11,
+			max_core_limit	: 12,
+			valid		:  1;
 	};
 };
 
 union ifs_scan_hashes_status_gen2 {
 	u64	data;
 	struct {
-		u16	chunk_size;
-		u16	num_chunks;
-		u32	error_code		:8;
-		u32	chunks_in_stride	:9;
-		u32	rsvd			:2;
-		u32	max_core_limit		:12;
-		u32	valid			:1;
+		u64	chunk_size		: 16,
+			num_chunks		: 16,
+			error_code		:  8,
+			chunks_in_stride	:  9,
+			rsvd			:  2,
+			max_core_limit		: 12,
+			valid			:  1;
 	};
 };
 
@@ -183,21 +183,21 @@ union ifs_scan_hashes_status_gen2 {
 union ifs_chunks_auth_status {
 	u64	data;
 	struct {
-		u32	valid_chunks	:8;
-		u32	total_chunks	:8;
-		u32	rsvd1		:16;
-		u32	error_code	:8;
-		u32	rsvd2		:24;
+		u64	valid_chunks	:  8,
+			total_chunks	:  8,
+			rsvd1		: 16,
+			error_code	:  8,
+			rsvd2		: 24;
 	};
 };
 
 union ifs_chunks_auth_status_gen2 {
 	u64	data;
 	struct {
-		u16	valid_chunks;
-		u16	total_chunks;
-		u32	error_code	:8;
-		u32	rsvd2		:24;
+		u64	valid_chunks	: 16,
+			total_chunks	: 16,
+			error_code	:  8,
+			rsvd2		: 24;
 	};
 };
 
@@ -216,8 +216,8 @@ union ifs_scan {
 				u16	stop;
 			} gen2;
 		};
-		u32	delay	:31;
-		u32	sigmce	:1;
+		u32	delay	: 31,
+			sigmce	:  1;
 	};
 };
 
@@ -236,10 +236,10 @@ union ifs_status {
 				u16	chunk_stop_index;
 			} gen2;
 		};
-		u32	error_code		:8;
-		u32	rsvd2			:22;
-		u32	control_error		:1;
-		u32	signature_error		:1;
+		u32	error_code		:  8,
+			rsvd2			: 22,
+			control_error		:  1,
+			signature_error		:  1;
 	};
 };
 
@@ -247,10 +247,10 @@ union ifs_status {
 union ifs_array {
 	u64	data;
 	struct {
-		u32	array_bitmask;
-		u16	array_bank;
-		u16	rsvd			:15;
-		u16	ctrl_result		:1;
+		u64	array_bitmask		: 32,
+			array_bank		: 16,
+			rsvd			: 15,
+			ctrl_result		:  1;
 	};
 };
 
-- 
2.43.0

