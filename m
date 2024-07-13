Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD9C2ED;
	Sat, 13 Jul 2024 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720831343; cv=none; b=f6rmImZiLum4jHHqVscGvFfx67YV+TXyubkdhYYA4v6JdVuugR9G2FyU/8kNsXQxpdfnIm8l8yudbSrYuy5v4WcJjDY622Y4Ascftecga/6ty8kRr6y4zZvhDBMGPiq2GWHxqM/cutS+kq1UkT7wK7eDWhxFYheYd2LIu4NEpbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720831343; c=relaxed/simple;
	bh=YvYiP0i+6rgg8Nlzb8WqjRFhOHQxDv12mgUpuHorRn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Inavlsiutb3ctoCEVBx6sHByWLUtMDKdg18vpGnL0Uh0zQTF5HRzBXFjqQdhZeMTwy6FYqY7BminuDKuUu5aGnIqNYKMEXIY31IhnrjAGUJknCLPfr4KHqPX4kMHmg2XRklYa4CWiPnXtW7Xszn5lLVn19PaX8QpIONPJXueB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mly0e7yx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mly0e7yx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720831341; x=1752367341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YvYiP0i+6rgg8Nlzb8WqjRFhOHQxDv12mgUpuHorRn0=;
  b=mly0e7yxaMIC5V5s6lyuEKKZRW+iB1A0c+brf7FO61/vRW9gsiCgQ+gE
   or5rgOotKPFJ5N3RCHvd7sdu3tnGktodcWhzrXtkuFbUb18llJoH2aCRK
   2+fwFqYTc9tkRJLiNKw/PLftAI4jdf9fs4r3QRUjGpKhAD/2BWJ38xi+r
   TctemHrUazCJCYVsbFCBvBUGRd4E2iCop79n3B6xzmfQIRynP4yMGke8R
   DPvknumevAwHzj3QuX9elujGsIVqTKx3/9DjBQUhsZNPVeD0dkFtPT14/
   ughw6CpGlNYgfV+H12BcK+16MWjEuNJaCSxhbRLgWQNCBvY8u9+EY8F0A
   w==;
X-CSE-ConnectionGUID: MRPAiUODRXyLxzuMPo7S2w==
X-CSE-MsgGUID: xpTw8jn9T7WZEb4KyEtuew==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="35833384"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="35833384"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 17:42:20 -0700
X-CSE-ConnectionGUID: yqQFKpPGToiumX05JYQj2A==
X-CSE-MsgGUID: km9lULFcTHGzdAsJcEq3MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="48955784"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 17:42:21 -0700
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
Subject: [PATCH v3 2/4] platform/x86/intel/ifs: Add SBAF test image loading support
Date: Sat, 13 Jul 2024 00:39:59 +0000
Message-Id: <20240713004001.535159-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240713004001.535159-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240713004001.535159-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jithu Joseph <jithu.joseph@intel.com>

Structural Based Functional Test at Field (SBAF) is a new type of
testing that provides comprehensive core test coverage complementing
existing IFS tests like Scan at Field (SAF) or ArrayBist.

SBAF device will appear as a new device instance (intel_ifs_2) under
/sys/devices/virtual/misc. The user interaction necessary to load the
test image and test a particular core is the same as the existing scan
test (intel_ifs_0).

During the loading stage, the driver will look for a file named
ff-mm-ss-<batch02x>.sbft in the /lib/firmware/intel/ifs_2 directory.
The hardware interaction needed for loading the image is similar to
SAF, with the only difference being the MSR addresses used. Reuse the
SAF image loading code, passing the SBAF-specific MSR addresses via
struct ifs_test_msrs in the driver device data.

Unlike SAF, the SBAF test image chunks are further divided into smaller
logical entities called bundles. Since the SBAF test is initiated per
bundle, cache the maximum number of bundles in the current image, which
is used for iterating through bundles during SBAF test execution.

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h      |  2 ++
 drivers/platform/x86/intel/ifs/ifs.h  | 37 ++++++++++++++++++++++++++-
 drivers/platform/x86/intel/ifs/core.c | 24 +++++++++++++++++
 drivers/platform/x86/intel/ifs/load.c | 15 ++++++++---
 4 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e022e6eb766c..503d7acdda3f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -247,6 +247,8 @@
 #define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
+#define MSR_INTEGRITY_CAPS_SBAF_BIT		8
+#define MSR_INTEGRITY_CAPS_SBAF			BIT(MSR_INTEGRITY_CAPS_SBAF_BIT)
 #define MSR_INTEGRITY_CAPS_SAF_GEN_MASK	GENMASK_ULL(10, 9)
 
 #define MSR_LBR_NHM_FROM		0x00000680
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 738cbc7a5d00..600bb8a1b285 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -126,11 +126,38 @@
  * The driver does not make use of this, it only tests one core at a time.
  *
  * .. [#f1] https://github.com/intel/TBD
+ *
+ *
+ * Structural Based Functional Test at Field (SBAF):
+ * ------------------------------------------------
+ *
+ * SBAF is a new type of testing that provides comprehensive core test
+ * coverage complementing Scan at Field (SAF) testing. SBAF mimics the
+ * manufacturing screening environment and leverages the same test suite.
+ * It makes use of Design For Test (DFT) observation sites and features
+ * to maximize coverage in minimum time.
+ *
+ * Similar to the SAF test, SBAF isolates the core under test from the
+ * rest of the system during execution. Upon completion, the core
+ * seamlessly resets to its pre-test state and resumes normal operation.
+ * Any machine checks or hangs encountered during the test are confined to
+ * the isolated core, preventing disruption to the overall system.
+ *
+ * Like the SAF test, the SBAF test is also divided into multiple batches,
+ * and each batch test can take hundreds of milliseconds (100-200 ms) to
+ * complete. If such a lengthy interruption is undesirable, it is
+ * recommended to relocate the time-sensitive applications to other cores.
  */
 #include <linux/device.h>
 #include <linux/miscdevice.h>
 
 #define MSR_ARRAY_BIST				0x00000105
+
+#define MSR_COPY_SBAF_HASHES			0x000002b8
+#define MSR_SBAF_HASHES_STATUS			0x000002b9
+#define MSR_AUTHENTICATE_AND_COPY_SBAF_CHUNK	0x000002ba
+#define MSR_SBAF_CHUNKS_AUTHENTICATION_STATUS	0x000002bb
+
 #define MSR_COPY_SCAN_HASHES			0x000002c2
 #define MSR_SCAN_HASHES_STATUS			0x000002c3
 #define MSR_AUTHENTICATE_AND_COPY_CHUNK		0x000002c4
@@ -140,6 +167,7 @@
 #define MSR_ARRAY_TRIGGER			0x000002d6
 #define MSR_ARRAY_STATUS			0x000002d7
 #define MSR_SAF_CTRL				0x000004f0
+#define MSR_SBAF_CTRL				0x000004f8
 
 #define SCAN_NOT_TESTED				0
 #define SCAN_TEST_PASS				1
@@ -147,6 +175,7 @@
 
 #define IFS_TYPE_SAF			0
 #define IFS_TYPE_ARRAY_BIST		1
+#define IFS_TYPE_SBAF			2
 
 #define ARRAY_GEN0			0
 #define ARRAY_GEN1			1
@@ -196,7 +225,8 @@ union ifs_chunks_auth_status_gen2 {
 		u16	valid_chunks;
 		u16	total_chunks;
 		u32	error_code	:8;
-		u32	rsvd2		:24;
+		u32	rsvd2		:8;
+		u32	max_bundle	:16;
 	};
 };
 
@@ -261,9 +291,12 @@ union ifs_array {
 #define IFS_SW_TIMEOUT				0xFD
 #define IFS_SW_PARTIAL_COMPLETION		0xFE
 
+#define IFS_SUFFIX_SZ		5
+
 struct ifs_test_caps {
 	int	integrity_cap_bit;
 	int	test_num;
+	char	image_suffix[IFS_SUFFIX_SZ];
 };
 
 /**
@@ -294,6 +327,7 @@ struct ifs_test_msrs {
  * @generation: IFS test generation enumerated by hardware
  * @chunk_size: size of a test chunk
  * @array_gen: test generation of array test
+ * @max_bundle: maximum bundle index
  */
 struct ifs_data {
 	int	loaded_version;
@@ -306,6 +340,7 @@ struct ifs_data {
 	u32	generation;
 	u32	chunk_size;
 	u32	array_gen;
+	u32	max_bundle;
 };
 
 struct ifs_work {
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 1a7ca74abb61..4f571b79f028 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -33,6 +33,7 @@ bool *ifs_pkg_auth;
 static const struct ifs_test_caps scan_test = {
 	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
 	.test_num = IFS_TYPE_SAF,
+	.image_suffix = "scan",
 };
 
 static const struct ifs_test_caps array_test = {
@@ -48,6 +49,20 @@ static const struct ifs_test_msrs scan_msrs = {
 	.test_ctrl = MSR_SAF_CTRL,
 };
 
+static const struct ifs_test_msrs sbaf_msrs = {
+	.copy_hashes = MSR_COPY_SBAF_HASHES,
+	.copy_hashes_status = MSR_SBAF_HASHES_STATUS,
+	.copy_chunks = MSR_AUTHENTICATE_AND_COPY_SBAF_CHUNK,
+	.copy_chunks_status = MSR_SBAF_CHUNKS_AUTHENTICATION_STATUS,
+	.test_ctrl = MSR_SBAF_CTRL,
+};
+
+static const struct ifs_test_caps sbaf_test = {
+	.integrity_cap_bit = MSR_INTEGRITY_CAPS_SBAF_BIT,
+	.test_num = IFS_TYPE_SBAF,
+	.image_suffix = "sbft",
+};
+
 static struct ifs_device ifs_devices[] = {
 	[IFS_TYPE_SAF] = {
 		.test_caps = &scan_test,
@@ -66,6 +81,15 @@ static struct ifs_device ifs_devices[] = {
 			.groups = plat_ifs_array_groups,
 		},
 	},
+	[IFS_TYPE_SBAF] = {
+		.test_caps = &sbaf_test,
+		.test_msrs = &sbaf_msrs,
+		.misc = {
+			.name = "intel_ifs_2",
+			.minor = MISC_DYNAMIC_MINOR,
+			.groups = plat_ifs_groups,
+		},
+	},
 };
 
 #define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index ad0c107f0922..8f2aded38f1c 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -261,20 +261,22 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 		return -EIO;
 	}
 	ifsd->valid_chunks = valid_chunks;
+	ifsd->max_bundle = chunk_status.max_bundle;
 
 	return 0;
 }
 
 static int validate_ifs_metadata(struct device *dev)
 {
+	const struct ifs_test_caps *test = ifs_get_test_caps(dev);
 	struct ifs_data *ifsd = ifs_get_data(dev);
 	union meta_data *ifs_meta;
 	char test_file[64];
 	int ret = -EINVAL;
 
-	snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.scan",
+	snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.%s",
 		 boot_cpu_data.x86, boot_cpu_data.x86_model,
-		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
+		 boot_cpu_data.x86_stepping, ifsd->cur_batch, test->image_suffix);
 
 	ifs_meta = (union meta_data *)find_meta_data(ifs_header_ptr, META_TYPE_IFS);
 	if (!ifs_meta) {
@@ -304,6 +306,11 @@ static int validate_ifs_metadata(struct device *dev)
 		return ret;
 	}
 
+	if (ifs_meta->test_type != test->test_num) {
+		dev_warn(dev, "Metadata test_type %d mismatches with device type\n",
+			 ifs_meta->test_type);
+	}
+
 	return 0;
 }
 
@@ -391,9 +398,9 @@ int ifs_load_firmware(struct device *dev)
 	char scan_path[64];
 	int ret;
 
-	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.scan",
+	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.%s",
 		 test->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
-		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
+		 boot_cpu_data.x86_stepping, ifsd->cur_batch, test->image_suffix);
 
 	ret = request_firmware_direct(&fw, scan_path, dev);
 	if (ret) {
-- 
2.25.1

