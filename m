Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9DC8E9;
	Thu, 27 Jun 2024 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455868; cv=none; b=CLdaroV7l20ie621aYLZiXf1rI7YX1m2SFTdfNYcaAxU1ZN91jpzKuve1S6tlB5ubkUaUQqz9c8OdbXGuI1ncKMHMmFzwZi/dfRa3MclyAOi4vg+hga++bKU0X54FBY5bzrdbI+TUkluFo5P5mdHdcMo867Lekbw/8CK1ZKHtVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455868; c=relaxed/simple;
	bh=CNvKn99alv1qrOJStM18Pg4taxwCXDbEobey+C9j0rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZqgupLBzkDoxowe6azazkXtyAQ2zWow1R819r2mbq0cP/kiASfc0KQ6atWc0sARocIyEGY8Dwa2xL3MekHLsExliFw9EX9sB53xQF5xDdJoafwBzy/gh8BsIsJpZuYUXA2L6Dq7TRy3HDTd6cvqlqvTOs4rfwTZM4by58bEM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4iDt8Iz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4iDt8Iz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719455867; x=1750991867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNvKn99alv1qrOJStM18Pg4taxwCXDbEobey+C9j0rQ=;
  b=F4iDt8IzrRE8aEEROAs/KuyS6635My1KgpMRZLkCoK9QXAMxEOzsMQPc
   UIsJqpmFN+ZqMLrfmdfdongCXvJ6RG7DcFcogSNkBEk0HMTvB0N4Vt+WU
   AGUPH1p8Ki2u3jKET7kmg1UfisI5PmRprsNe6E8tylj+H0YZ89qetNZlp
   784pkdWOmgLmkg3XGRhlL98jKL7teiye7SLK5OB1m65W/Ii1lUqI61hZC
   kN7PVrFKEXfItF4BDoY+s+wU1a3Ekmh/4nW/NsJALfIS18YyqCJ1zEZyE
   A1+xBAKz91rvp3mwleosVBMYqly5UZPX2NA/1qLkI8Vi6kD5Sv+KU+sx6
   Q==;
X-CSE-ConnectionGUID: 0iVuzKE6QkGESg5vZLuiEA==
X-CSE-MsgGUID: v8+pku18RQKb6ca7ELZ3rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27959492"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="27959492"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:37:45 -0700
X-CSE-ConnectionGUID: PGYJisARTFKkFD3XQdkMXg==
X-CSE-MsgGUID: UtSHwiO1Tj+4ckjsZVXXow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44052389"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:37:44 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Jithu Joseph <jithu.joseph@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ashok Raj <ashok.raj@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-trace-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: [PATCH v1 1/4] platform/x86/intel/ifs: Refactor MSR usage in IFS test code
Date: Thu, 27 Jun 2024 02:35:13 +0000
Message-Id: <20240627023516.3783454-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IFS tests such as Scan at Field (SAF) or Structural Based Functional
Test at Field (SBAF), require the user to load a test image. The image
loading process is similar across these tests, with the only difference
being MSR addresses used. To reuse the code between these tests, remove
the hard coding of MSR addresses and allow the driver to pass the MSR
addresses per IFS test (via driver device data).

Add a new structure named "struct ifs_test_msrs" to specify the
test-specific MSR addresses. Each IFS test will provide this structure,
enabling them to reuse the common code.

This is a preliminary patch in preparation for the addition of SBAF
support.

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  | 25 +++++++++++++++++++++++++
 drivers/platform/x86/intel/ifs/core.c |  9 +++++++++
 drivers/platform/x86/intel/ifs/load.c | 24 ++++++++++++++----------
 3 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 56b9f3e3cf76..738cbc7a5d00 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -266,6 +266,22 @@ struct ifs_test_caps {
 	int	test_num;
 };
 
+/**
+ * struct ifs_test_msrs - MSRs used in IFS tests
+ * @copy_hashes: Copy test hash data
+ * @copy_hashes_status: Status of copied test hash data
+ * @copy_chunks: Copy chunks of the test data
+ * @copy_chunks_status: Status of the copied test data chunks
+ * @test_ctrl: Control the test attributes
+ */
+struct ifs_test_msrs {
+	u32	copy_hashes;
+	u32	copy_hashes_status;
+	u32	copy_chunks;
+	u32	copy_chunks_status;
+	u32	test_ctrl;
+};
+
 /**
  * struct ifs_data - attributes related to intel IFS driver
  * @loaded_version: stores the currently loaded ifs image version.
@@ -299,6 +315,7 @@ struct ifs_work {
 
 struct ifs_device {
 	const struct ifs_test_caps *test_caps;
+	const struct ifs_test_msrs *test_msrs;
 	struct ifs_data rw_data;
 	struct miscdevice misc;
 };
@@ -319,6 +336,14 @@ static inline const struct ifs_test_caps *ifs_get_test_caps(struct device *dev)
 	return d->test_caps;
 }
 
+static inline const struct ifs_test_msrs *ifs_get_test_msrs(struct device *dev)
+{
+	struct miscdevice *m = dev_get_drvdata(dev);
+	struct ifs_device *d = container_of(m, struct ifs_device, misc);
+
+	return d->test_msrs;
+}
+
 extern bool *ifs_pkg_auth;
 int ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 7b11198d85a1..1a7ca74abb61 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -40,9 +40,18 @@ static const struct ifs_test_caps array_test = {
 	.test_num = IFS_TYPE_ARRAY_BIST,
 };
 
+static const struct ifs_test_msrs scan_msrs = {
+	.copy_hashes = MSR_COPY_SCAN_HASHES,
+	.copy_hashes_status = MSR_SCAN_HASHES_STATUS,
+	.copy_chunks = MSR_AUTHENTICATE_AND_COPY_CHUNK,
+	.copy_chunks_status = MSR_CHUNKS_AUTHENTICATION_STATUS,
+	.test_ctrl = MSR_SAF_CTRL,
+};
+
 static struct ifs_device ifs_devices[] = {
 	[IFS_TYPE_SAF] = {
 		.test_caps = &scan_test,
+		.test_msrs = &scan_msrs,
 		.misc = {
 			.name = "intel_ifs_0",
 			.minor = MISC_DYNAMIC_MINOR,
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 39f19cb51749..ad0c107f0922 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -118,15 +118,17 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 	union ifs_scan_hashes_status hashes_status;
 	union ifs_chunks_auth_status chunk_status;
 	struct device *dev = local_work->dev;
+	const struct ifs_test_msrs *msrs;
 	int i, num_chunks, chunk_size;
 	struct ifs_data *ifsd;
 	u64 linear_addr, base;
 	u32 err_code;
 
 	ifsd = ifs_get_data(dev);
+	msrs = ifs_get_test_msrs(dev);
 	/* run scan hash copy */
-	wrmsrl(MSR_COPY_SCAN_HASHES, ifs_hash_ptr);
-	rdmsrl(MSR_SCAN_HASHES_STATUS, hashes_status.data);
+	wrmsrl(msrs->copy_hashes, ifs_hash_ptr);
+	rdmsrl(msrs->copy_hashes_status, hashes_status.data);
 
 	/* enumerate the scan image information */
 	num_chunks = hashes_status.num_chunks;
@@ -147,8 +149,8 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 		linear_addr = base + i * chunk_size;
 		linear_addr |= i;
 
-		wrmsrl(MSR_AUTHENTICATE_AND_COPY_CHUNK, linear_addr);
-		rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
+		wrmsrl(msrs->copy_chunks, linear_addr);
+		rdmsrl(msrs->copy_chunks_status, chunk_status.data);
 
 		ifsd->valid_chunks = chunk_status.valid_chunks;
 		err_code = chunk_status.error_code;
@@ -180,6 +182,7 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 	union ifs_scan_hashes_status_gen2 hashes_status;
 	union ifs_chunks_auth_status_gen2 chunk_status;
 	u32 err_code, valid_chunks, total_chunks;
+	const struct ifs_test_msrs *msrs;
 	int i, num_chunks, chunk_size;
 	union meta_data *ifs_meta;
 	int starting_chunk_nr;
@@ -189,10 +192,11 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 	int retry_count;
 
 	ifsd = ifs_get_data(dev);
+	msrs = ifs_get_test_msrs(dev);
 
 	if (need_copy_scan_hashes(ifsd)) {
-		wrmsrl(MSR_COPY_SCAN_HASHES, ifs_hash_ptr);
-		rdmsrl(MSR_SCAN_HASHES_STATUS, hashes_status.data);
+		wrmsrl(msrs->copy_hashes, ifs_hash_ptr);
+		rdmsrl(msrs->copy_hashes_status, hashes_status.data);
 
 		/* enumerate the scan image information */
 		chunk_size = hashes_status.chunk_size * SZ_1K;
@@ -212,8 +216,8 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 	}
 
 	if (ifsd->generation >= IFS_GEN_STRIDE_AWARE) {
-		wrmsrl(MSR_SAF_CTRL, INVALIDATE_STRIDE);
-		rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
+		wrmsrl(msrs->test_ctrl, INVALIDATE_STRIDE);
+		rdmsrl(msrs->copy_chunks_status, chunk_status.data);
 		if (chunk_status.valid_chunks != 0) {
 			dev_err(dev, "Couldn't invalidate installed stride - %d\n",
 				chunk_status.valid_chunks);
@@ -234,9 +238,9 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 		chunk_table[1] = linear_addr;
 		do {
 			local_irq_disable();
-			wrmsrl(MSR_AUTHENTICATE_AND_COPY_CHUNK, (u64)chunk_table);
+			wrmsrl(msrs->copy_chunks, (u64)chunk_table);
 			local_irq_enable();
-			rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
+			rdmsrl(msrs->copy_chunks_status, chunk_status.data);
 			err_code = chunk_status.error_code;
 		} while (err_code == AUTH_INTERRUPTED_ERROR && --retry_count);
 
-- 
2.25.1

