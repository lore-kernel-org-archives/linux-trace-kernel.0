Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197268;
	b=g69Fq4GWdBWXB7v5Om2ldEdDuo8RfTFC5T3apzxDrF8PtF19r/wkNXxFChR4oc74JtTX
	 mwk/4G2uJs9kSyuQ6KgRKe1DFhtOL2t3q1WJNk/Z1NY7ZI2p8I6CwqI5cQDirk28MhHB9
	 3H3lRJaRw3eNimLphzHqjdB5FyDS7vdtoMhv3HkX4LC3Rnlx9fd4UgB4mnPX/cg4JwXgF
	 Yy8N1iI52E6yguIs45oPp0AklzuqWlNEULZXXmtptvjLLanGIieP3/A6KPT6wA0ck5GQr
	 8/9NfjaI82/RfTM7OMjN5whPLzfGy0LivuO2MEOaRa4xZVf+vYqj9XpqwpvoB7aWtUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197268;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fIALKS6j1QHbo6lCje8nv06Y9CozFk03PXZTpPMpa3M=;
	b=JuEX/b/FYWGcvqSm4ikhcoqF/BAmNc36TsR+5m7jzscFJeWTETtPkLXllA4ZQ4QL0ISN
	 TfytXsUJyBmMxGHWkE0+U6U8dwAzbnpGzGjTEuGn4nlOlEytv26WarX7z8y6zKltu02Mq
	 sU7vhEQ7YkRjddJWdM+Rn0rzjlhR7wmnfHvxZrqPK/PB5hCN1vWn22uiNXLVmiHNLp0Ux
	 8wp0JElYH02eYDI+ADio1bpDyoIgxwlvEkQ11aobQM8uS9kVpGJjtyG+eRcBKrEN3OppP
	 29KZ9gx1HU4ucDb5GixVrcrrk3nJBqlqcTvrHNtNxJRF9ENNQTgQ8hfY0N/Bqb1nO4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z28e2TSo;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1F60A263A;
	Fri, 20 Nov 2026 17:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08B1F60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z28e2TSo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197266; x=1826733266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLwZ1mSEPrbAIFjkVbImtbWEdEayXGy0Zjs+ER9nAf4=;
  b=Z28e2TSo8j6L492hvEo3UUBvqEskKQyFh+vo5uXxI/cl4zuFaxIo21JV
   jFTaSSXDdQea22yQ41TXsV/A45n3Uih1xcFDbr/PTq0vaTmIxRj3+hxMh
   LZU/epI619ejyFefKjy1RahWA47kZf4HGU8L8SPS7A7l2neZlCiHAmY79
   wO0xeLuaqU+mWaitD4CX9ktCbYwCKjyvcPMVYq0YoqirrCUR8XQ/bDyXA
   keOSoRjlHDqgShZL9EmNQaaTe1OOsomU/u1+UJYD9xjXZes6EBIAVBGLG
   /Jcuh0fyFO4bJmVXoErswLuZzTLSxeZe+ofbw+0G7eZY646cynroG7fim
   w==;
X-CSE-ConnectionGUID: 4GRwVkTWQT6PWjrb5Le9kQ==
X-CSE-MsgGUID: pae7VmoWQ/6mJOKgQtGAyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108918"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108918"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:23 -0800
X-CSE-ConnectionGUID: Qd6AcplmRYGasu+kHBO+Mg==
X-CSE-MsgGUID: 6GWgrYvPTPaYHeQRXFCeaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171038"
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
Subject: [PATCH v3 05/17] platform/x86/intel/ifs: Early return on the IFS image hash/chunk error
Date: Fri, 20 Nov 2026 10:56:46 -0700
Message-ID: <20261120175658.1147030-6-ehab.ababneh@intel.com>
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

Return immediately upon encountering a hash error or chunk error in the
IFS (In-Field Scan) test image to avoid meaningless assignments following
these errors.

Additionally, assign the boolean value 'true' instead of '1' to the
boolean variable 'ifs_pkg_auth', and use SZ_1K macro instead of '1024'
for better readability.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
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

