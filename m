Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A913DDDC;
	Thu,  1 Aug 2024 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722489651; cv=none; b=OVZtgvV8P9XyKKKspD94gplvmHIEKnVr++NB/YGK4J2TwgQFiGyndgBcH2PsL1vhTU7PmlSffQ64ZBuSbo5TfsliEY8f/Rz39jT0ImsGoVKMYeG2a9V3x592Dkv9eY486plTQ26/VrxTqiEyjtv9B71MOME3pwcYOSvEJEagfow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722489651; c=relaxed/simple;
	bh=68YiapbQtvvR5pOi7DFgMf/tjPRRiO9PO74ZsxZJ7rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vzu88yiQTHRncsOJb2v8CNFl8x6hwwJ9JqRi7rhbqtSyWIZO564C7+IGNs5sjsvEjUk0p6Wtvlbw5GM/GCsaMFTE/xfXwHarXx8gd3yZ/S7yAuBvGJO6mBJlVYKeAnyn3avjMNAOBXwIbyxCNYAV5yJ+7b5MUjpLBmL5351CF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbQ45w+p; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbQ45w+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722489649; x=1754025649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=68YiapbQtvvR5pOi7DFgMf/tjPRRiO9PO74ZsxZJ7rI=;
  b=CbQ45w+pW7kc7iTp5gwJ+Z+iSjAN565oRYbDJceocuwJy87yL+Ia90Me
   CWFWNjsY9gITlILMdeIHH87+2umc4NiGSzBAyLRAisr7crQDzmA1Ct1J2
   eSmXRTnuQFS2IkFFco7bSMPjygiZFcvyXi29mJ8u0qdWy+I7WJ79JVzpC
   JA1+UCq12LHru9EWYgEEj1AsLSZlWhqmmdhcgns/9SRndjHucDvFV4ceM
   d3hjrFVDCaM0oUfkCY1dVcEEYyvMBG9kfkeLX/4ynSU5Y0eMKh4x4lr+l
   dRRbSB1WfmMKtAw2t6bcbUH2+GV3aMTIu5TJrwGjfAwPdyh7wE3KZ6IMy
   w==;
X-CSE-ConnectionGUID: H32gauu5QReen01HmUacwg==
X-CSE-MsgGUID: M2AKOO83R9KBLAookB1ENw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="12821735"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="12821735"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 22:20:46 -0700
X-CSE-ConnectionGUID: wf76Cby/T32pF8mmddAvmw==
X-CSE-MsgGUID: o2rhRZB2RhmnXlTtP4V8kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59951365"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 22:20:46 -0700
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
	Shankar Ravi V <ravi.v.shankar@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] platform/x86/intel/ifs: Refactor MSR usage in IFS test code
Date: Thu,  1 Aug 2024 05:18:11 +0000
Message-Id: <20240801051814.1935149-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801051814.1935149-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240801051814.1935149-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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
index 33412a584836..f204ebbbf769 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -39,9 +39,18 @@ static const struct ifs_test_caps array_test = {
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

