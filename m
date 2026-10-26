Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039739;
	b=2FFM7xGAR9hMcNHlv8zLMffT3cjDC5lrQt1M9XPb5vHXiR6XBaHpTaXJfRE0/tMwuSFj
	 BqAjSmdWznRRnPk9Faep5iBupyHRGtodinnkj5SUHiNk3C6ept+QBaCj8P6Mh8bQCVLvo
	 FMEf9OLH+KkJH61ttBkzuxBH/qGqGadapq4Lz1vLol0NCR43rcAzx+0iyaosH/Zxz5gU9
	 71++cpBT+cU5MC1sue421kPw38kTWGm93YCJ/RY5qYqlYaIOMNrQ18K7lJ7bsD4JJBzdf
	 5tfDr3hn8yR3Etp1PooQEJDr/Db2VIYvYP/oS2tF6jMn0bz9mGKc2CJbU4rih65NBtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039739;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EHZiiwB2jC0ynFjIbqY1k8ej0FqmnVaJZUQ0AjdtGwE=;
	b=h/WStHKg/QAtind3AhiowJZHAad77A+8dQxnd/9MjZpIyf3JiBiiiW80fbH17ia3Zgn0
	 r81iAJPX5k5xjCFNRt524//tzf9OsnqH0xCLo2jGtRgFyuARn5LTIi5Nr9J1DAU+5eKMK
	 8kjUMnicNjYWKDJv+dxuKO7u2WFiJf/N0tKhUGVe3ZY6W6w+UY1MvRPvz887Owc3+Ss6i
	 dpT8rQHdrQYeh5MOqwgu2x/Yj2XGpVRPx479BaLhty7M0fhzmmLTNm2k6UOcHJkxq9KB4
	 FBfvjP1sKbTF/TXPLWYvjMSaPurhsI64hTy0e748yEUzIygV6H2wAfh7oAFwX7AjChg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E4wBP0vb;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E957606A323;
	Mon, 26 Oct 2026 18:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E957606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E4wBP0vb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039738; x=1824575738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B6ofUcualEXrKcpSuDJW9R1mIcskONvqVnrqOGvC34k=;
  b=E4wBP0vbe0B56GiT8Mh6eSVfFmm59i7odeXtmR51Wb4nO7VBIEa0Xa6Y
   yW/POntGH4hgDN2aR/wPOun/T4DoErfhwO+mH5AUKfoI2srq2NvSgVVyj
   qGoCoLTdhTZl06VAzUEB3tuO6h+QbOEK+rTaf8qCH4XTLT2ek91sHX7UG
   6dlsIColvJXqdsK28U2Jwc0tRCtUg7Tt5+YcFKdLq0wjSQPPzkzo1rVu0
   Jwtfv+0btTiWys0jmEmoY/7L1dd2Xx1mtafbpbHDQk3Qdd+XuSaIvKq74
   /P2GamWM9Rcjt/kkYvSe+PMF6Jh0iyiGOHic3VyVSzRlGrbc/Ax4bt8KT
   Q==;
X-CSE-ConnectionGUID: WwjOz6+RRX6aZCqsptD0Pw==
X-CSE-MsgGUID: SgJjoCybSIqF6jCk+UjGyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731444"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731444"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:35 -0700
X-CSE-ConnectionGUID: bu1pf30sSriKXxVOPugqCA==
X-CSE-MsgGUID: uy3C7eCxQQWtup+n3/8oUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293863"
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
Subject: [PATCH 02/17] platform/x86/intel/ifs: Fix IFS sysfs interfaces in the comments
Date: Mon, 26 Oct 2026 11:38:05 -0700
Message-ID: <20261026183820.129459-3-ehab.ababneh@intel.com>
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

The sysfs interfaces in the comments in sysfs.c are incorrect. Fix them.
Additionally, improve some IFS comments and fix some typos in the comments
such as: s/cpu/CPU, s/intel/Intel, s/ifs/IFS.

No functional changes.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     | 16 ++++++++--------
 drivers/platform/x86/intel/ifs/load.c    |  2 +-
 drivers/platform/x86/intel/ifs/runtest.c |  8 ++++----
 drivers/platform/x86/intel/ifs/sysfs.c   | 23 +++++++++++------------
 4 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index f55528ac517b..0f5cdc1ad14d 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -35,10 +35,10 @@
  * IFS Image Loading
  * -----------------
  *
- * The driver loads the tests into memory reserved BIOS local to each CPU
- * socket in a two step process using writes to MSRs to first load the
- * SHA hashes for the test. Then the tests themselves. Status MSRs provide
- * feedback on the success/failure of these steps.
+ * The driver loads the tests into memory reserved by BIOS, local to each CPU
+ * socket in a two-step process. It first writes to MSRs to load the SHA hashes
+ * for the test, followed by the tests themselves. Status MSRs provide feedback
+ * on the success or failure of these steps.
  *
  * The test files are kept in a fixed location: /lib/firmware/intel/ifs_<n>/
  * For e.g if there are 3 test files, they would be named in the following
@@ -83,14 +83,14 @@
  *
  * Test a specific core::
  *
- *   # echo <cpu#> > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
+ *   # echo <CPU#> > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
  *
- * when HT is enabled any of the sibling cpu# can be specified to test
+ * when HT is enabled any of the sibling CPU# can be specified to test
  * its corresponding physical core. Since the tests are per physical core,
  * the result of testing any thread is same. All siblings must be online
  * to run a core test. It is only necessary to test one thread.
  *
- * For e.g. to test core corresponding to cpu5
+ * For e.g. to test core corresponding to CPU5
  *
  *   # echo 5 > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
  *
@@ -284,7 +284,7 @@ struct ifs_test_msrs {
 };
 
 /**
- * struct ifs_data - attributes related to intel IFS driver
+ * struct ifs_data - attributes related to Intel IFS driver
  * @loaded_version: stores the currently loaded ifs image version.
  * @loaded: If a valid test binary has been loaded into the memory
  * @loading_error: Error occurred on another CPU while loading image
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 329400908cb2..dde3f5eb379f 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -108,7 +108,7 @@ static void auth_err_message(struct device *dev, u32 err_code)
 }
 
 /*
- * To copy scan hashes and authenticate test chunks, the initiating cpu must point
+ * To copy scan hashes and authenticate test chunks, the initiating CPU must point
  * to the EDX:EAX to the test image in linear address.
  * Run wrmsr(MSR_COPY_SCAN_HASHES) for scan hash copy and run wrmsr(MSR_AUTHENTICATE_AND_COPY_CHUNK)
  * for scan hash copy and test chunk authentication.
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 1762eab7fe5c..96b538c665f4 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -149,7 +149,7 @@ static atomic_t array_cpus_in;
 static atomic_t scan_cpus_in;
 
 /*
- * Simplified cpu sibling rendezvous loop based on microcode loader __wait_for_cpus()
+ * Simplified CPU sibling rendezvous loop based on microcode loader wait_for_cpus()
  */
 static void wait_for_sibling_cpu(atomic_t *t, long long timeout)
 {
@@ -389,8 +389,8 @@ static void ifs_array_test_gen1(int cpu, struct device *dev)
 }
 
 /*
- * Initiate per core test. It wakes up work queue threads on the target cpu and
- * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
+ * Initiate per core test. It wakes up work queue threads on the target CPU and
+ * its sibling CPU. Once all sibling threads wake up, the scan test gets executed and
  * wait for all sibling threads to finish the scan test.
  */
 int do_core_test(int cpu, struct device *dev)
@@ -403,7 +403,7 @@ int do_core_test(int cpu, struct device *dev)
 	cpus_read_lock();
 
 	if (!cpu_online(cpu)) {
-		dev_info(dev, "cannot test on the offline cpu %d\n", cpu);
+		dev_info(dev, "cannot test on the offline CPU %d\n", cpu);
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 01b7502f46b0..287f96bb033e 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -10,14 +10,14 @@
 #include "ifs.h"
 
 /*
- * Protects against simultaneous tests on multiple cores, or
- * reloading can file while a test is in progress
+ * Protect against simultaneous tests on multiple cores and prevent
+ * the reloading of IFS image file while a test is in progress.
  */
 static DEFINE_SEMAPHORE(ifs_sem, 1);
 
 /*
- * The sysfs interface to check additional details of last test
- * cat /sys/devices/system/platform/ifs/details
+ * The sysfs interface to check additional details of the last test:
+ * cat /sys/devices/virtual/misc/intel_ifs_<n>/details
  */
 static ssize_t details_show(struct device *dev,
 			    struct device_attribute *attr,
@@ -37,9 +37,8 @@ static const char * const status_msg[] = {
 };
 
 /*
- * The sysfs interface to check the test status:
- * To check the status of last test
- * cat /sys/devices/platform/ifs/status
+ * The sysfs interface to check the last test status:
+ * cat /sys/devices/virtual/misc/intel_ifs_<n>/status
  */
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr,
@@ -53,12 +52,12 @@ static ssize_t status_show(struct device *dev,
 static DEVICE_ATTR_RO(status);
 
 /*
- * The sysfs interface for single core testing
- * To start test, for example, cpu5
- * echo 5 > /sys/devices/platform/ifs/run_test
+ * The sysfs interface for single-core testing.
+ * To start a test, for example on CPU5:
+ * echo 5 > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
  * To check the result:
- * cat /sys/devices/platform/ifs/result
- * The sibling core gets tested at the same time.
+ * cat /sys/devices/virtual/misc/intel_ifs_<n>/status
+ * The sibling thread gets tested at the same time.
  */
 static ssize_t run_test_store(struct device *dev,
 			      struct device_attribute *attr,
-- 
2.43.0

