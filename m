Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030227;
	b=i6YngkvGPNY5DWqMiBBeyhr18HBKTDoKsZSyzdArZfFckoJ+VOGyS23F/QW2cIH7Z/zG
	 f3H+91Ebt43K2Su8YlyT4Ntsb803YZIiVK/nVsfEiSpg2C26/toOvLe23s87xW+lDz1fW
	 0HX63dGJTNe4NtCpXV0s+UQ8cz6ngfNLNzd06JpaTXsvj/uR3AtaDWoPcUyWHnsP34zwt
	 zS3ik/hyLYkhoWxJFBiROPdtpEZzL72tmjnbRXJ5Nlcglh+ENsDzk75BUZHV8xIhB3k09
	 csr3OmxnXW+PoU1kCS5Z/yD0JvRp+nq/hX5vIi8zZAFC59iYS/Paut9EmzqGTAL7izA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030227;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fIALKS6j1QHbo6lCje8nv06Y9CozFk03PXZTpPMpa3M=;
	b=JDThN1wvnSmdCrwemx+HDhSum0UmVksMlIe9cSIWVmfr6RWcMfgAWisbKjwrAmyITt2S
	 vmswWAvi8zaoxjNfN0sG7nyBIrTgAge9hIwKCRut9XK8bJo9Sdb4R/oJA5eajpZFxuNA0
	 5YpmqpUDQ4sK3julzZjVNap/h5RHqFhmhaZXCJqH5lfI8eATQz+BEK1B+V8LObyOnVqt0
	 6DQfS+S09jrLqrNLAOw8mMoph/8cY68CxMDlEx6gRf9WKC8Ijkluu3ke8vMuEMWsDH1AF
	 BlbZDg6RUi46XgX8d/r7s4xreUObiaqIAGfDqO39QRbqlKYA57lBkJ1A52To4Y91cLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MI2JYmrl;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E8606DD31;
	Wed, 18 Nov 2026 19:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 273E8606DD31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MI2JYmrl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030227; x=1826566227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLwZ1mSEPrbAIFjkVbImtbWEdEayXGy0Zjs+ER9nAf4=;
  b=MI2JYmrl8pLokFveGIiiXRfLYE0PB5qjMBj4dm+/9i51mUNhoZCWdpfF
   D2xcFHqWCUkHQ0ftMUcm4BT2tBqOGuQRA9ISokP8TeB579mBwuZtpdrUi
   e16peb7hpnPcne37rZcI14TpqvuUZqoJfQAEUotSx0hYJ8+yuRorAtTTb
   eHBZyxmCK82yocFl+2MDrrJq8bmEB4EYCHwooEJ/asewuzSECVyRDOZPA
   PV8TWnx0Qbl3IgCe6fZYGmwr8fbVhtb9DWTkNk1W5efzuNWOaY2TB7juz
   JtJp3ZmlCwl1pCdtgsNhr4NckmiKSZ/gbJIJat+lIQsRP9PI3/e9a1Kxu
   Q==;
X-CSE-ConnectionGUID: OYaegU9CRIGp2kcs/0jQ3Q==
X-CSE-MsgGUID: HY8Tzi2JS7GesmkjradO2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781225"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781225"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:27 -0800
X-CSE-ConnectionGUID: EypiLkAhR9WpaiW+0QVHsA==
X-CSE-MsgGUID: OCHzS0LFSkaQUyEcE/cfSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468082"
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
Subject: [PATCH v2 05/17] platform/x86/intel/ifs: Early return on the IFS image hash/chunk error
Date: Wed, 18 Nov 2026 12:32:47 -0700
Message-ID: <20261118193259.519568-6-ehab.ababneh@intel.com>
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

