Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039740;
	b=zd4R1T9iZFmcDMXrdNg6ALjZC/3IOkJuMedBOJYpowosA8tRjO0K8pCYSTpSK69AlveG
	 1MGulhBkuHtLfgj1H1UtgRw4KjHaf5bEcfwSryvD8gG+H68O4oAWU2WwZVQmn8S83H60i
	 lWlawmkOGaZXjs3JRKWfsuFblR4s5wjl1fVkR56EDuxxFM9TAdeA3oYgt3XHIn36myX3l
	 p/cHOe0CblJhwGUQ+PaviX9xCErN303lSguUo3aftqccFVMeqZ7pMjSwAsPjOPwqf6fp4
	 fnNWgcMFwjECLlHSaxmCUQAgvyll2NUUtZHIj6L+OwfvzVOL/eF4WyvxRg6OO40kp7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039740;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rv6AIpDXvnQTrC51AiIITPnLzcoKlq7eSTo4+LUL2o4=;
	b=OtRCoPY157hhGkudPtAi3lkreLQF4kkdUCVWXrPSxyiYwYVoWnFOwjYE02MQ2bzXR4YW
	 XIYscnKTxtYmZGB6ApiHzI0p0IHYsmLc47pJ/e6JjDgV36zoZMYa7asvY3J/wY8KGrzIo
	 0pWbd1XaIjtJjBKUo1kKgvC93BdJk0IbZQ4lQeTBMc293jLz6SXWycf1d3GvdtsenLpI3
	 QJpRkn4jvGX1zy93VpZOzpz1A3wspV7Ax2CCOAu6SuumshFwQItGmQD08xEpc7XLC122w
	 WEL8GDljUrNQ1IUZ/LSbazOyEEZOaRINd2R5uUV6pEGxug8yM4oXXnjDvdAV88xTuuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AFsE35LB;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846A606A32D;
	Mon, 26 Oct 2026 18:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5846A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AFsE35LB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039739; x=1824575739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SK4oM9TS8l19Iqq7XDE6OBeWE8tQB9efP7xp85FUbF8=;
  b=AFsE35LBDu9Sck5TxinT7qmW3j3yQ3+B7ODkB+6rx7/9pvxpgTqTmHHt
   227ZwyPRIeI6j7hUa8afnJIrIpSP2qhCQKPigDGtSVecIoaHDiNSZDO7Y
   zS3A4oEFU9Cv+NskFgs9Khm5mGjNWrFbfDXi2v/DzFXiMw5Ft8wuFODw8
   cilPYJXpP3xq9cZjJ7Rlwtl4b138U1zbYHvqiwhnoU+wGG+q0lkqEtmKH
   XLR9LVwlnvd+EfVmJtbXEopZqrhjgMap5txRoLBJxId9yyeCLACbY0CHA
   DFZREkJBcESR1TVe08/0I48emF6ZLAxQr/70rHfsgggoRslgFkPgJ4Jk9
   A==;
X-CSE-ConnectionGUID: 1MiAzN71Rsye/JcyijxARw==
X-CSE-MsgGUID: o7ZvLockR2CMqODn4uqU+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731478"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731478"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:36 -0700
X-CSE-ConnectionGUID: KYQ8KhfAQbyel1UZNNP8wQ==
X-CSE-MsgGUID: 4D9OqU8gTya8Mvdyy775sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293874"
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
Subject: [PATCH 05/17] platform/x86/intel/ifs: Early return on the IFS image hash/chunk error
Date: Mon, 26 Oct 2026 11:38:08 -0700
Message-ID: <20261026183820.129459-6-ehab.ababneh@intel.com>
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

Return immediately upon encountering a hash error or chunk error in the
IFS (In-Field Scan) test image to avoid meaningless assignments following
these errors.

Additionally, assign the boolean value 'true' instead of '1' to the
boolean variable 'ifs_pkg_auth', and use SZ_1K macro instead of '1024'
for better readability.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 34 ++++++++++++---------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index dde3f5eb379f..0edbf9eedc12 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -123,7 +123,6 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 	int i, num_chunks, chunk_size;
 	struct ifs_data *ifsd;
 	u64 linear_addr, base;
-	u32 err_code;
 
 	ifsd = ifs_get_data(dev);
 	msrs = ifs_get_test_msrs(dev);
@@ -131,17 +130,16 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 	wrmsrq(msrs->copy_hashes, ifs_hash_ptr);
 	rdmsrq(msrs->copy_hashes_status, hashes_status.data);
 
-	/* enumerate the scan image information */
-	num_chunks = hashes_status.num_chunks;
-	chunk_size = hashes_status.chunk_size * 1024;
-	err_code = hashes_status.error_code;
-
 	if (!hashes_status.valid) {
 		ifsd->loading_error = true;
-		hashcopy_err_message(dev, err_code);
+		hashcopy_err_message(dev, hashes_status.error_code);
 		goto done;
 	}
 
+	/* enumerate the scan image information */
+	num_chunks = hashes_status.num_chunks;
+	chunk_size = hashes_status.chunk_size * SZ_1K;
+
 	/* base linear address to the scan data */
 	base = ifs_test_image_ptr;
 
@@ -153,14 +151,13 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 		wrmsrq(msrs->copy_chunks, linear_addr);
 		rdmsrq(msrs->copy_chunks_status, chunk_status.data);
 
-		ifsd->valid_chunks = chunk_status.valid_chunks;
-		err_code = chunk_status.error_code;
-
-		if (err_code) {
+		if (chunk_status.error_code) {
 			ifsd->loading_error = true;
-			auth_err_message(dev, err_code);
+			auth_err_message(dev, chunk_status.error_code);
 			goto done;
 		}
+
+		ifsd->valid_chunks = chunk_status.valid_chunks;
 	}
 done:
 	complete(&ifs_done);
@@ -199,16 +196,15 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 		wrmsrq(msrs->copy_hashes, ifs_hash_ptr);
 		rdmsrq(msrs->copy_hashes_status, hashes_status.data);
 
+		if (!hashes_status.valid) {
+			hashcopy_err_message(dev, hashes_status.error_code);
+			return -EIO;
+		}
+
 		/* enumerate the scan image information */
 		chunk_size = hashes_status.chunk_size * SZ_1K;
-		err_code = hashes_status.error_code;
-
 		num_chunks = get_num_chunks(ifsd->generation, hashes_status);
 
-		if (!hashes_status.valid) {
-			hashcopy_err_message(dev, err_code);
-			return -EIO;
-		}
 		ifsd->loaded_version = ifs_header_ptr->rev;
 		ifsd->chunk_size = chunk_size;
 	} else {
@@ -344,7 +340,7 @@ static int scan_chunks_sanity_check(struct device *dev)
 			ret = -EIO;
 			goto out;
 		}
-		ifs_pkg_auth[curr_pkg] = 1;
+		ifs_pkg_auth[curr_pkg] = true;
 	}
 	ret = 0;
 	ifsd->loaded_version = ifs_header_ptr->rev;
-- 
2.43.0

