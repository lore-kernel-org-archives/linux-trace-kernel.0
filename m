Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030227;
	b=Bsp2iNb/KykZa0n+xw4XNDce/HI0H1NTfhMeDjgSaB2AyyHnl7ol1jL8jhRqCu3trFo0
	 zKkkwiKvQ0xkXk2I55ax1Cm0Q9LCEu4ouo75GEUTGWsy0PpRKyE/ErtxzU7i1kRfsAjfx
	 IV6M8l9G4ASm9cC8A8SVYEjPvtJ0ETJcoaAJ2xlJUnvfheOHMUzCWKVjKbHoCkLWdvxCy
	 OBe+8ip2JqWcnUifu/UBvOT2x+YKJQnw9pRjM8mmvTM+hLh5Yway/HOzw1vyPVAS4EcVk
	 AtByKCkP1UmhkhIunU5lXO3eBHRdeXmFnX58ejlLADRSrg8XLT/Gn4BPpkeEPI/uXxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030227;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gL8WpIgQ36vCPAYIYJZB9KCJJBB718sye55u4y1ovpU=;
	b=aUxJEMA5KunF1542iBhCu/l529F4BBZXw4bJlqcIa/YC8QD1XBmPIfNqbfoQiKnGr4W4
	 6zMv7cbpXI4p/9wqQOJT3UNDPBophp2CBpeXVJK6hTrEhmYZQ/rplSRs5MjAA0457NuIy
	 d88sxELJjs6GAYhN4Ajlg5opbTG37/2uW2rBJqsu9o3Sg0l3a/AXOFKVXJblTkcNg57mf
	 bHKyxrZj38aHab0oJnyB8s6b5akPWGjzlrHRty+aUPonJBW7eyQHEVol0cl0t/ousLKWX
	 M0rAKD1Cmk/yIMVOpeViyTEHNIh97PEWPJFIu2pM4N6s5AkZSeF0oOeHOc36bi7l7XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FepESh23;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B03606DD26;
	Wed, 18 Nov 2026 19:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B03606DD26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FepESh23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030227; x=1826566227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k/CbGNg9sKfFv56tzoARlw8/HM9hrb5vTSwcjPJlytk=;
  b=FepESh23yso+JvUEFQNdm6At+xVpjtNSQg9OMq7oBV2/V23tdcEtxtkC
   Gma+zOee3fVobC8wBUk/thFS3rfXIGJx/eBElsFwyfFrhdq1+uwkebcLw
   /EiJ0DdiqoXVbbIlycvqDPTQAM0zxVFchvtOWjE4IsKGX+3hlQtr0fuKW
   4VIifVsqfYKq3WKUsIqJnYyCgcZwsnpQBtnvQcJL1+QD7honVK825v8ZZ
   UGfXFLAz/A7QeAm+LUFPHJQh4YkkBm3ZxYXMJuU8lbxuvB4mkcCSeK+qc
   XYORBvu40tXT8UFfg3npn8+WOwbSKseeHMHJZ5wH8dVXMvyA90aYv7Yhs
   Q==;
X-CSE-ConnectionGUID: MHNxV/xSRJO1RS1ktDuEbQ==
X-CSE-MsgGUID: gyn39h1ZSoiKUFnwL3bM0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781222"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781222"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:26 -0800
X-CSE-ConnectionGUID: V5Y849akRu6I6knC3IdvAQ==
X-CSE-MsgGUID: wzuXr2+4TLCd/sJIXBqYmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468078"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:26 -0800
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
Subject: [PATCH v2 04/17] platform/x86/intel/ifs: Use u64 to define the bits of IFS MSR registers
Date: Wed, 18 Nov 2026 12:32:46 -0700
Message-ID: <20261118193259.519568-5-ehab.ababneh@intel.com>
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

The IFS (In-Field Scan) related MSR registers are all 64-bit wide.
Use a single u64 within a struct to define the bits of an IFS MSR
register in a more compact form, instead of using {u16, u32} for
each bit, to enhance readability.

No functional changes.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
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

