Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039739;
	b=vPMANcDI72DSWpZhVHTpcDHRJ64zaGi22nADVgfXoRmo2x1fRn1csdmT6uww0yv4WP9t
	 IPKZRO8xtxK8u/hCz2wrvhMdxnrrN03SonW4rvuzE3YiIOUfCF8N2IudHyuN6HismKZvL
	 BluOXw3b94IBbsYaYNg9YVM8tQYL9RQH7ckiNFz7r/1alANpjLI4XJf5AtMa31F2gdk3W
	 shNCPdeSSNcfIoUknAXx+/t2iF5cbf/mS6rtDfVAoGgyMlGDM7hF4zjdfOwMYlNhLPHDz
	 kwCh8duTxfRbCHIq+nuUNEP0YxBV/RHEonBGUEtCYOKWyZkwAg9CNumbQinkNu+8Fpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039739;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cgCm+pG8k3RFR1ROsOmoa7TW5+XfmkJ+4zM7kPxGHnc=;
	b=D4jFpNFC3ZZ8QWuPn+i38zLDUOCIqc52/DJx6cYvH/sDnK+mDJOrDmAG/c5wCV7+eIig
	 LiuZC2cHVuJ5HnuCffRpjYXs59khG3la7o9EWi7EXKYhwkMSwBVgVCd/jzfNx3mjrDXHr
	 P3ooBEldVHapAiyUZRAdAj7XUHp3/G+dgIGCz79TTaRxoEUl4KGbzvvIyHNe8387Fx5bP
	 Km8lt5pOq3ZTGqtLWoGOvAqUYCqPQpdJIiuEGhf8OFiebsbg3FqjrThTR986imHMmn2TK
	 Wj6uDXP6FZlFciJgKhulHFxlP0YUXfbn5+lzCCI2R14RSpObjcHMBIve5IVxVsbzL4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cO6ssCaU;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC0606A31A;
	Mon, 26 Oct 2026 18:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDBC0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cO6ssCaU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039737; x=1824575737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Php1DkcmOqLRyD2pMbq7OXrC1gS6ZGBRh45j7DZv9cY=;
  b=cO6ssCaUTJYCLj4x95CWtUYF35BtSjGqLxZfH2Doz8HA8ca6f5e6IdXq
   aYbvlxMlhCKIXpmiz6lGQgcVbqok3br+S78lPj7QSwTinyXBdJxbYGn9u
   nwTZmU4r9G4IxxUtXkaK1xfj0r+1rLYUz5pkMKK2fToAqRdfRByJ6rNBr
   1NER0cC/JYQDh3eYOE6Ba1VxytKeGYDXJhvBiRYzE5fvFUbuEHNOB2htU
   lOt6i9sjzMUTNX50UwdSc049piIMT5cnwXLZwbFHmITNhwUrYHeYMPtth
   m03HsD6ZfiWo/6AntUYaqhMN67/J3Xrl+KO9jwr2AYELw1po83ApGg60R
   Q==;
X-CSE-ConnectionGUID: yVeac3VrSCmliJB9zA1elg==
X-CSE-MsgGUID: gsfHI7P7RVaRCGbqM1DiMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731441"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731441"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:35 -0700
X-CSE-ConnectionGUID: WVQTPFMeQ/qQx7hjOkohaQ==
X-CSE-MsgGUID: RiyC5z1FQC6smlBm5ikyeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293860"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:35 -0700
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
Subject: [PATCH 01/17] platform/x86/intel/ifs: Revert SBAF feature
Date: Mon, 26 Oct 2026 11:38:04 -0700
Message-ID: <20261026183820.129459-2-ehab.ababneh@intel.com>
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

Structural Based Functional Test at Field (SBAF) test was initially
expected to be supported in Granite Rapids (GNR) CPUs. However, due to
recent roadmap changes, the SBAF test support will not be included in
GNR and is unlikely to be included in future CPUs.

Additionally, Intel has never published the SBAF scan files, and the
SBAF feature and its interface [1] are not utilized. Therefore, it's
safe to remove them. Given this, remove the SBAF test from the In-Field
Scan (IFS) driver by reverting the following commits:

  commit 1e701372d7ac ("platform/x86/intel/ifs: Fix SBAF title underline length")
  commit 61b74964536e ("trace: platform/x86/intel/ifs: Add SBAF trace support")
  commit 3c4d06bd6e37 ("platform/x86/intel/ifs: Add SBAF test support")
  commit 0a3e4e94d137 ("platform/x86/intel/ifs: Add SBAF test image loading support")
  commit 744a6a1f2a83 ("tools arch x86: Sync the msr-index.h copy with the kernel sources")

[1] /sys/devices/virtual/misc/intel_ifs_2

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 arch/x86/include/asm/msr-index.h         |   2 -
 drivers/platform/x86/intel/ifs/core.c    |  24 ---
 drivers/platform/x86/intel/ifs/ifs.h     |  65 +------
 drivers/platform/x86/intel/ifs/load.c    |  16 +-
 drivers/platform/x86/intel/ifs/runtest.c | 233 -----------------------
 include/trace/events/intel_ifs.h         |  27 ---
 tools/arch/x86/include/asm/msr-index.h   |   2 -
 7 files changed, 5 insertions(+), 364 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3a8e51a0c9e8..ac73dadb44e0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -280,8 +280,6 @@
 #define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
-#define MSR_INTEGRITY_CAPS_SBAF_BIT		8
-#define MSR_INTEGRITY_CAPS_SBAF			BIT(MSR_INTEGRITY_CAPS_SBAF_BIT)
 #define MSR_INTEGRITY_CAPS_SAF_GEN_MASK	GENMASK_ULL(10, 9)
 
 #define MSR_LBR_NHM_FROM		0x00000680
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 3dafa28a1010..574f2a366d06 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -34,7 +34,6 @@ bool *ifs_pkg_auth;
 static const struct ifs_test_caps scan_test = {
 	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
 	.test_num = IFS_TYPE_SAF,
-	.image_suffix = "scan",
 };
 
 static const struct ifs_test_caps array_test = {
@@ -50,20 +49,6 @@ static const struct ifs_test_msrs scan_msrs = {
 	.test_ctrl = MSR_SAF_CTRL,
 };
 
-static const struct ifs_test_msrs sbaf_msrs = {
-	.copy_hashes = MSR_COPY_SBAF_HASHES,
-	.copy_hashes_status = MSR_SBAF_HASHES_STATUS,
-	.copy_chunks = MSR_AUTHENTICATE_AND_COPY_SBAF_CHUNK,
-	.copy_chunks_status = MSR_SBAF_CHUNKS_AUTHENTICATION_STATUS,
-	.test_ctrl = MSR_SBAF_CTRL,
-};
-
-static const struct ifs_test_caps sbaf_test = {
-	.integrity_cap_bit = MSR_INTEGRITY_CAPS_SBAF_BIT,
-	.test_num = IFS_TYPE_SBAF,
-	.image_suffix = "sbft",
-};
-
 static struct ifs_device ifs_devices[] = {
 	[IFS_TYPE_SAF] = {
 		.test_caps = &scan_test,
@@ -82,15 +67,6 @@ static struct ifs_device ifs_devices[] = {
 			.groups = plat_ifs_array_groups,
 		},
 	},
-	[IFS_TYPE_SBAF] = {
-		.test_caps = &sbaf_test,
-		.test_msrs = &sbaf_msrs,
-		.misc = {
-			.name = "intel_ifs_2",
-			.minor = MISC_DYNAMIC_MINOR,
-			.groups = plat_ifs_groups,
-		},
-	},
 };
 
 #define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index f369fb0d3d82..f55528ac517b 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -127,38 +127,11 @@
  * 2) Hardware allows for some number of cores to be tested in parallel.
  * The driver does not make use of this, it only tests one core at a time.
  *
- * Structural Based Functional Test at Field (SBAF):
- * -------------------------------------------------
- *
- * SBAF is a new type of testing that provides comprehensive core test
- * coverage complementing Scan at Field (SAF) testing. SBAF mimics the
- * manufacturing screening environment and leverages the same test suite.
- * It makes use of Design For Test (DFT) observation sites and features
- * to maximize coverage in minimum time.
- *
- * Similar to the SAF test, SBAF isolates the core under test from the
- * rest of the system during execution. Upon completion, the core
- * seamlessly resets to its pre-test state and resumes normal operation.
- * Any machine checks or hangs encountered during the test are confined to
- * the isolated core, preventing disruption to the overall system.
- *
- * Like the SAF test, the SBAF test is also divided into multiple batches,
- * and each batch test can take hundreds of milliseconds (100-200 ms) to
- * complete. If such a lengthy interruption is undesirable, it is
- * recommended to relocate the time-sensitive applications to other cores.
  */
 #include <linux/device.h>
 #include <linux/miscdevice.h>
 
 #define MSR_ARRAY_BIST				0x00000105
-
-#define MSR_COPY_SBAF_HASHES			0x000002b8
-#define MSR_SBAF_HASHES_STATUS			0x000002b9
-#define MSR_AUTHENTICATE_AND_COPY_SBAF_CHUNK	0x000002ba
-#define MSR_SBAF_CHUNKS_AUTHENTICATION_STATUS	0x000002bb
-#define MSR_ACTIVATE_SBAF			0x000002bc
-#define MSR_SBAF_STATUS				0x000002bd
-
 #define MSR_COPY_SCAN_HASHES			0x000002c2
 #define MSR_SCAN_HASHES_STATUS			0x000002c3
 #define MSR_AUTHENTICATE_AND_COPY_CHUNK		0x000002c4
@@ -168,7 +141,6 @@
 #define MSR_ARRAY_TRIGGER			0x000002d6
 #define MSR_ARRAY_STATUS			0x000002d7
 #define MSR_SAF_CTRL				0x000004f0
-#define MSR_SBAF_CTRL				0x000004f8
 
 #define SCAN_NOT_TESTED				0
 #define SCAN_TEST_PASS				1
@@ -176,7 +148,6 @@
 
 #define IFS_TYPE_SAF			0
 #define IFS_TYPE_ARRAY_BIST		1
-#define IFS_TYPE_SBAF			2
 
 #define ARRAY_GEN0			0
 #define ARRAY_GEN1			1
@@ -226,8 +197,7 @@ union ifs_chunks_auth_status_gen2 {
 		u16	valid_chunks;
 		u16	total_chunks;
 		u32	error_code	:8;
-		u32	rsvd2		:8;
-		u32	max_bundle	:16;
+		u32	rsvd2		:24;
 	};
 };
 
@@ -284,34 +254,6 @@ union ifs_array {
 	};
 };
 
-/* MSR_ACTIVATE_SBAF bit fields */
-union ifs_sbaf {
-	u64	data;
-	struct {
-		u32	bundle_idx	:9;
-		u32	rsvd1		:5;
-		u32	pgm_idx		:2;
-		u32	rsvd2		:16;
-		u32	delay		:31;
-		u32	sigmce		:1;
-	};
-};
-
-/* MSR_SBAF_STATUS bit fields */
-union ifs_sbaf_status {
-	u64	data;
-	struct {
-		u32	bundle_idx	:9;
-		u32	rsvd1		:5;
-		u32	pgm_idx		:2;
-		u32	rsvd2		:16;
-		u32	error_code	:8;
-		u32	rsvd3		:21;
-		u32	test_fail	:1;
-		u32	sbaf_status	:2;
-	};
-};
-
 /*
  * Driver populated error-codes
  * 0xFD: Test timed out before completing all the chunks.
@@ -320,12 +262,9 @@ union ifs_sbaf_status {
 #define IFS_SW_TIMEOUT				0xFD
 #define IFS_SW_PARTIAL_COMPLETION		0xFE
 
-#define IFS_SUFFIX_SZ		5
-
 struct ifs_test_caps {
 	int	integrity_cap_bit;
 	int	test_num;
-	char	image_suffix[IFS_SUFFIX_SZ];
 };
 
 /**
@@ -356,7 +295,6 @@ struct ifs_test_msrs {
  * @generation: IFS test generation enumerated by hardware
  * @chunk_size: size of a test chunk
  * @array_gen: test generation of array test
- * @max_bundle: maximum bundle index
  */
 struct ifs_data {
 	int	loaded_version;
@@ -369,7 +307,6 @@ struct ifs_data {
 	u32	generation;
 	u32	chunk_size;
 	u32	array_gen;
-	u32	max_bundle;
 };
 
 struct ifs_work {
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 50f1fdf7dfed..329400908cb2 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -262,22 +262,20 @@ static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
 		return -EIO;
 	}
 	ifsd->valid_chunks = valid_chunks;
-	ifsd->max_bundle = chunk_status.max_bundle;
 
 	return 0;
 }
 
 static int validate_ifs_metadata(struct device *dev)
 {
-	const struct ifs_test_caps *test = ifs_get_test_caps(dev);
 	struct ifs_data *ifsd = ifs_get_data(dev);
 	union meta_data *ifs_meta;
 	char test_file[64];
 	int ret = -EINVAL;
 
-	snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.%s",
+	snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.scan",
 		 boot_cpu_data.x86, boot_cpu_data.x86_model,
-		 boot_cpu_data.x86_stepping, ifsd->cur_batch, test->image_suffix);
+		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
 
 	ifs_meta = (union meta_data *)find_meta_data(ifs_header_ptr, META_TYPE_IFS);
 	if (!ifs_meta) {
@@ -307,12 +305,6 @@ static int validate_ifs_metadata(struct device *dev)
 		return ret;
 	}
 
-	if (ifs_meta->test_type != test->test_num) {
-		dev_warn(dev, "Metadata test_type %d mismatches with device type\n",
-			 ifs_meta->test_type);
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -400,9 +392,9 @@ int ifs_load_firmware(struct device *dev)
 	char scan_path[64];
 	int ret;
 
-	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.%s",
+	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.scan",
 		 test->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
-		 boot_cpu_data.x86_stepping, ifsd->cur_batch, test->image_suffix);
+		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
 
 	ret = request_firmware_direct(&fw, scan_path, dev);
 	if (ret) {
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index dfc119d7354d..1762eab7fe5c 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -30,13 +30,6 @@ struct run_params {
 	union ifs_status status;
 };
 
-struct sbaf_run_params {
-	struct ifs_data *ifsd;
-	int *retry_cnt;
-	union ifs_sbaf *activate;
-	union ifs_sbaf_status status;
-};
-
 /*
  * Number of TSC cycles that a logical CPU will wait for the other
  * logical CPU on the core in the WRMSR(ACTIVATE_SCAN).
@@ -154,7 +147,6 @@ static bool can_restart(union ifs_status status)
 #define SPINUNIT 100 /* 100 nsec */
 static atomic_t array_cpus_in;
 static atomic_t scan_cpus_in;
-static atomic_t sbaf_cpus_in;
 
 /*
  * Simplified cpu sibling rendezvous loop based on microcode loader __wait_for_cpus()
@@ -396,225 +388,6 @@ static void ifs_array_test_gen1(int cpu, struct device *dev)
 		ifsd->status = SCAN_TEST_PASS;
 }
 
-#define SBAF_STATUS_PASS			0
-#define SBAF_STATUS_SIGN_FAIL			1
-#define SBAF_STATUS_INTR			2
-#define SBAF_STATUS_TEST_FAIL			3
-
-enum sbaf_status_err_code {
-	IFS_SBAF_NO_ERROR				= 0,
-	IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN		= 1,
-	IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS		= 2,
-	IFS_SBAF_UNASSIGNED_ERROR_CODE3			= 3,
-	IFS_SBAF_INVALID_BUNDLE_INDEX			= 4,
-	IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS		= 5,
-	IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY		= 6,
-	IFS_SBAF_UNASSIGNED_ERROR_CODE7			= 7,
-	IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT	= 8,
-	IFS_SBAF_INTERRUPTED_DURING_EXECUTION		= 9,
-	IFS_SBAF_INVALID_PROGRAM_INDEX			= 0xA,
-	IFS_SBAF_CORRUPTED_CHUNK			= 0xB,
-	IFS_SBAF_DID_NOT_START				= 0xC,
-};
-
-static const char * const sbaf_test_status[] = {
-	[IFS_SBAF_NO_ERROR] = "SBAF no error",
-	[IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN] = "Other thread could not join.",
-	[IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS] = "Interrupt occurred prior to SBAF coordination.",
-	[IFS_SBAF_UNASSIGNED_ERROR_CODE3] = "Unassigned error code 0x3",
-	[IFS_SBAF_INVALID_BUNDLE_INDEX] = "Non-valid sbaf bundles. Reload test image",
-	[IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS] = "Mismatch in arguments between threads T0/T1.",
-	[IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY] = "Core not capable of performing SBAF currently",
-	[IFS_SBAF_UNASSIGNED_ERROR_CODE7] = "Unassigned error code 0x7",
-	[IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT] = "Exceeded number of Logical Processors (LP) allowed to run Scan-At-Field concurrently",
-	[IFS_SBAF_INTERRUPTED_DURING_EXECUTION] = "Interrupt occurred prior to SBAF start",
-	[IFS_SBAF_INVALID_PROGRAM_INDEX] = "SBAF program index not valid",
-	[IFS_SBAF_CORRUPTED_CHUNK] = "SBAF operation aborted due to corrupted chunk",
-	[IFS_SBAF_DID_NOT_START] = "SBAF operation did not start",
-};
-
-static void sbaf_message_not_tested(struct device *dev, int cpu, u64 status_data)
-{
-	union ifs_sbaf_status status = (union ifs_sbaf_status)status_data;
-
-	if (status.error_code < ARRAY_SIZE(sbaf_test_status)) {
-		dev_info(dev, "CPU(s) %*pbl: SBAF operation did not start. %s\n",
-			 cpumask_pr_args(cpu_smt_mask(cpu)),
-			 sbaf_test_status[status.error_code]);
-	} else if (status.error_code == IFS_SW_TIMEOUT) {
-		dev_info(dev, "CPU(s) %*pbl: software timeout during scan\n",
-			 cpumask_pr_args(cpu_smt_mask(cpu)));
-	} else if (status.error_code == IFS_SW_PARTIAL_COMPLETION) {
-		dev_info(dev, "CPU(s) %*pbl: %s\n",
-			 cpumask_pr_args(cpu_smt_mask(cpu)),
-			 "Not all SBAF bundles executed. Maximum forward progress retries exceeded");
-	} else {
-		dev_info(dev, "CPU(s) %*pbl: SBAF unknown status %llx\n",
-			 cpumask_pr_args(cpu_smt_mask(cpu)), status.data);
-	}
-}
-
-static void sbaf_message_fail(struct device *dev, int cpu, union ifs_sbaf_status status)
-{
-	/* Failed signature check is set when SBAF signature did not match the expected value */
-	if (status.sbaf_status == SBAF_STATUS_SIGN_FAIL) {
-		dev_err(dev, "CPU(s) %*pbl: Failed signature check\n",
-			cpumask_pr_args(cpu_smt_mask(cpu)));
-	}
-
-	/* Failed to reach end of test */
-	if (status.sbaf_status == SBAF_STATUS_TEST_FAIL) {
-		dev_err(dev, "CPU(s) %*pbl: Failed to complete test\n",
-			cpumask_pr_args(cpu_smt_mask(cpu)));
-	}
-}
-
-static bool sbaf_bundle_completed(union ifs_sbaf_status status)
-{
-	return !(status.sbaf_status || status.error_code);
-}
-
-static bool sbaf_can_restart(union ifs_sbaf_status status)
-{
-	enum sbaf_status_err_code err_code = status.error_code;
-
-	/* Signature for chunk is bad, or scan test failed */
-	if (status.sbaf_status == SBAF_STATUS_SIGN_FAIL ||
-	    status.sbaf_status == SBAF_STATUS_TEST_FAIL)
-		return false;
-
-	switch (err_code) {
-	case IFS_SBAF_NO_ERROR:
-	case IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN:
-	case IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS:
-	case IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT:
-	case IFS_SBAF_INTERRUPTED_DURING_EXECUTION:
-		return true;
-	case IFS_SBAF_UNASSIGNED_ERROR_CODE3:
-	case IFS_SBAF_INVALID_BUNDLE_INDEX:
-	case IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS:
-	case IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY:
-	case IFS_SBAF_UNASSIGNED_ERROR_CODE7:
-	case IFS_SBAF_INVALID_PROGRAM_INDEX:
-	case IFS_SBAF_CORRUPTED_CHUNK:
-	case IFS_SBAF_DID_NOT_START:
-		break;
-	}
-	return false;
-}
-
-/*
- * Execute the SBAF test. Called "simultaneously" on all threads of a core
- * at high priority using the stop_cpus mechanism.
- */
-static int dosbaf(void *data)
-{
-	struct sbaf_run_params *run_params = data;
-	int cpu = smp_processor_id();
-	union ifs_sbaf_status status;
-	struct ifs_data *ifsd;
-	int first;
-
-	ifsd = run_params->ifsd;
-
-	/* Only the first logical CPU on a core reports result */
-	first = cpumask_first(cpu_smt_mask(cpu));
-	wait_for_sibling_cpu(&sbaf_cpus_in, NSEC_PER_SEC);
-
-	/*
-	 * This WRMSR will wait for other HT threads to also write
-	 * to this MSR (at most for activate.delay cycles). Then it
-	 * starts scan of each requested bundle. The core test happens
-	 * during the "execution" of the WRMSR.
-	 */
-	wrmsrq(MSR_ACTIVATE_SBAF, run_params->activate->data);
-	rdmsrq(MSR_SBAF_STATUS, status.data);
-	trace_ifs_sbaf(ifsd->cur_batch, *run_params->activate, status);
-
-	/* Pass back the result of the test */
-	if (cpu == first)
-		run_params->status = status;
-
-	return 0;
-}
-
-static void ifs_sbaf_test_core(int cpu, struct device *dev)
-{
-	struct sbaf_run_params run_params;
-	union ifs_sbaf_status status = {};
-	union ifs_sbaf activate;
-	unsigned long timeout;
-	struct ifs_data *ifsd;
-	int stop_bundle;
-	int retries;
-
-	ifsd = ifs_get_data(dev);
-
-	activate.data = 0;
-	activate.delay = IFS_THREAD_WAIT;
-
-	timeout = jiffies + 2 * HZ;
-	retries = MAX_IFS_RETRIES;
-	activate.bundle_idx = 0;
-	stop_bundle = ifsd->max_bundle;
-
-	while (activate.bundle_idx <= stop_bundle) {
-		if (time_after(jiffies, timeout)) {
-			status.error_code = IFS_SW_TIMEOUT;
-			break;
-		}
-
-		atomic_set(&sbaf_cpus_in, 0);
-
-		run_params.ifsd = ifsd;
-		run_params.activate = &activate;
-		run_params.retry_cnt = &retries;
-		stop_core_cpuslocked(cpu, dosbaf, &run_params);
-
-		status = run_params.status;
-
-		if (sbaf_bundle_completed(status)) {
-			activate.bundle_idx = status.bundle_idx + 1;
-			activate.pgm_idx = 0;
-			retries = MAX_IFS_RETRIES;
-			continue;
-		}
-
-		/* Some cases can be retried, give up for others */
-		if (!sbaf_can_restart(status))
-			break;
-
-		if (status.pgm_idx == activate.pgm_idx) {
-			/* If no progress retry */
-			if (--retries == 0) {
-				if (status.error_code == IFS_NO_ERROR)
-					status.error_code = IFS_SW_PARTIAL_COMPLETION;
-				break;
-			}
-		} else {
-			/* if some progress, more pgms remaining in bundle, reset retries */
-			retries = MAX_IFS_RETRIES;
-			activate.bundle_idx = status.bundle_idx;
-			activate.pgm_idx = status.pgm_idx;
-		}
-	}
-
-	/* Update status for this core */
-	ifsd->scan_details = status.data;
-
-	if (status.sbaf_status == SBAF_STATUS_SIGN_FAIL ||
-	    status.sbaf_status == SBAF_STATUS_TEST_FAIL) {
-		ifsd->status = SCAN_TEST_FAIL;
-		sbaf_message_fail(dev, cpu, status);
-	} else if (status.error_code || status.sbaf_status == SBAF_STATUS_INTR ||
-		   (activate.bundle_idx < stop_bundle)) {
-		ifsd->status = SCAN_NOT_TESTED;
-		sbaf_message_not_tested(dev, cpu, status.data);
-	} else {
-		ifsd->status = SCAN_TEST_PASS;
-	}
-}
-
 /*
  * Initiate per core test. It wakes up work queue threads on the target cpu and
  * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
@@ -648,12 +421,6 @@ int do_core_test(int cpu, struct device *dev)
 		else
 			ifs_array_test_gen1(cpu, dev);
 		break;
-	case IFS_TYPE_SBAF:
-		if (!ifsd->loaded)
-			ret = -EPERM;
-		else
-			ifs_sbaf_test_core(cpu, dev);
-		break;
 	default:
 		ret = -EINVAL;
 	}
diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
index 70323acde1de..0d88ebf2c980 100644
--- a/include/trace/events/intel_ifs.h
+++ b/include/trace/events/intel_ifs.h
@@ -35,33 +35,6 @@ TRACE_EVENT(ifs_status,
 		__entry->status)
 );
 
-TRACE_EVENT(ifs_sbaf,
-
-	TP_PROTO(int batch, union ifs_sbaf activate, union ifs_sbaf_status status),
-
-	TP_ARGS(batch, activate, status),
-
-	TP_STRUCT__entry(
-		__field(	u64,	status	)
-		__field(	int,	batch	)
-		__field(	u16,	bundle	)
-		__field(	u16,	pgm	)
-	),
-
-	TP_fast_assign(
-		__entry->status	= status.data;
-		__entry->batch	= batch;
-		__entry->bundle	= activate.bundle_idx;
-		__entry->pgm	= activate.pgm_idx;
-	),
-
-	TP_printk("batch: 0x%.2x, bundle_idx: 0x%.4x, pgm_idx: 0x%.4x, status: 0x%.16llx",
-		__entry->batch,
-		__entry->bundle,
-		__entry->pgm,
-		__entry->status)
-);
-
 #endif /* _TRACE_IFS_H */
 
 /* This part must be outside protection */
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 18c4be75e927..d70f160425a2 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -280,8 +280,6 @@
 #define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
-#define MSR_INTEGRITY_CAPS_SBAF_BIT		8
-#define MSR_INTEGRITY_CAPS_SBAF			BIT(MSR_INTEGRITY_CAPS_SBAF_BIT)
 #define MSR_INTEGRITY_CAPS_SAF_GEN_MASK	GENMASK_ULL(10, 9)
 
 #define MSR_LBR_NHM_FROM		0x00000680
-- 
2.43.0

