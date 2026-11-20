Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197274;
	b=Sv6+ILCriMvOqsbX0LO1822wOvVNZ5hbn3YRolharHfzQP0AA3i0FBp2MLAG5qnjM0YZ
	 DCV9HYO11vKdEIedR8NsoYw+UWqgBy6SVt7X6yfxJZzcnagpDoQGbHswf3ji+kzu3ojQm
	 GV2w129+xdGkfmfBM65uDjRnv2JjUMZzDFUGSnQc/BDmpeFiR74Zp6GdO8apMCvixqrM9
	 RtB0dBT1eJ522HSt8WtkI9gy10P3zIBl+xS8TGLoETOPn/YwVbs7bPE8NU+7wKqBCa/kY
	 SbjrdYNTJram8IWBaQaOs9bBQKITGaEzeXjIHANhxVWJe/he34zYz0WjxkiuXp8JNqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197274;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gL8WpIgQ36vCPAYIYJZB9KCJJBB718sye55u4y1ovpU=;
	b=iPPg0gdfrkbTo93FZf4TcQ9U3bwz0r+wpoJBdCQpokPjkmiIDmCzwIwS2wglxTnnwWNN
	 /SO5W0X/p/Ayy1gJmS63mNcfb2guAXGWMdoqDy81WFxBybbqgfbdYtMnBZUWW/G3WKwk/
	 r/kQoqtmTnKNopdZ+zrT/3Z2wFBelkm/TGNtkks1xWCTUpD5RVQ0nFU4v4jop21bOfu6T
	 vjqB3BPXR4fC9furnTd/MS2jvZaKzniNva8CVACQi9QmbY6WWd6XOKTVadbp8eaif5hyl
	 1juX3it0+srfsBFF6BLRPqIRCz8sDwBvSMrZjmn1ssU7cTPrDwT4dZwwqso4BJRilVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KIeNP5Lc;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2260A2610;
	Fri, 20 Nov 2026 17:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D2260A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KIeNP5Lc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197265; x=1826733265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k/CbGNg9sKfFv56tzoARlw8/HM9hrb5vTSwcjPJlytk=;
  b=KIeNP5LcfsKq6oArNb0iSHTBNb1Qow0BjvJ494Uw5jIZ+odchRkn6uFu
   R21g1Q4EOloa9/shPTkI0uUXSkgQlgTrzlBersDlkmdpbdeEcHqfDBQw4
   7LDh7ME6Fx6GFqBKuNtTsMB1mDHibw9gxQPhUTj3Vlx28kE7LCmHnBB/+
   6MjWUEOMg2SCOciXpNT4B0NcpdMipEHb6p6AlbZ546BKOL7IS2HJI1gsG
   MTCwsKVCnyc46p6QyKNkbcfgVZMDxlB87m4avSAjvqlk3nOv+w2NoAAQz
   EG/6B8HuHa+TxKg0dMWuMJMGb3yL1woBAsczI5Xaf6j+WuMiK+EBasAr+
   Q==;
X-CSE-ConnectionGUID: RmnQlx5ASfGrZeB+/B92+g==
X-CSE-MsgGUID: rCd7GEnLTL2HBdp8vEE8HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108907"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108907"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:22 -0800
X-CSE-ConnectionGUID: dJMCiN+qTDmgFzKfAsTIcA==
X-CSE-MsgGUID: wiI3CuFcTXCA4aPH4GaF1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171033"
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
Subject: [PATCH v3 04/17] platform/x86/intel/ifs: Use u64 to define the bits of IFS MSR registers
Date: Fri, 20 Nov 2026 10:56:45 -0700
Message-ID: <20261120175658.1147030-5-ehab.ababneh@intel.com>
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

