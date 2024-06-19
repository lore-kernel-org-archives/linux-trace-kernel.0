Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4162139D1;
	Wed, 19 Jun 2024 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830799; cv=none; b=eEy3XQ/kunFBRFTO2d0ySNxdG/ZyV0OPdSZEEyI2b+FPUCmj41XPKtMtQG72fYs8Ho7Ay/hvhZz2R8Vsp1XggdB+6mZGvnZBhzPUeCXmSSF109TIozp51ciKu6dwjNNp/scSmwkwsohM1BIJVtW+mDIbw7QlfGQkyf3WfThC1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830799; c=relaxed/simple;
	bh=KqK32rBbg1/puw90erK7Ev853CBQmSd6IMrecODJyCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=d8CSVh+L0pYEd44cvtA1G0aMzme66o+Fnhw7q1azPbhIU7cCzOLfK2Pp/JjwN+ramH4DhJWywoX4Nn0h+cwPg37In61Ul1i+eNjBLGGn+GAI95JbDrGFWgCX4WE4nf1uwJvxEzK/weKPV4C9++ibqGrwnS92JhiF3Rz0kB17OW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B6blBkui; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B6blBkui"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JAuggI024184;
	Wed, 19 Jun 2024 20:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sS6hxKTOgAqdHUHY7wg2cf
	ZntPPcSf25gQ4xdbP3wrI=; b=B6blBkuimwnaVFBm5pa+j2lvmJ2bdAXSzHiWlh
	sJGW1RfaRAJYFdRFSGkgphkso7w2f8cB6oLr46w4tOM17uoEFdHaZPerYnrjpN8W
	WV1nvH5daqJWpa8SSLJ/XNPHq35KKuXDsJETwS+MvBmds6NC/In3nN2+vxmonFRg
	o8O8KsgdiDufmoxNYabhsEVwEsOaYZ/1ksiCAXRql2pbGfV5g1CZk7ogUs8HYrFm
	4K6VFXva0tn4BFUlP4ml8cJaF2K2YB8NoKUrKwnFsSx9XkYB2sIEOSVSF7gBK2uB
	hsORAFGEoIM1BBkZ6DLpyUL6pWfYSLHFw6qj7mUJi0GBnGCQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yux1519dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 20:59:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JKxGcN029784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 20:59:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 13:59:16 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 19 Jun 2024 13:59:15 -0700
Subject: [PATCH v2] KUnit: add missing MODULE_DESCRIPTION() macros for
 lib/test_*.ko
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240619-md-lib-test-v2-1-301e30eeba1e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKJGc2YC/22NQQ6CMBBFr0K6dkxbDEVX3sOwKO0ok0DRTiEYw
 t0trF2+5P/3VsEYCVncilVEnIlpDBn0qRCus+GFQD6z0FJfZCUVDB56aiEhJ1CVrEt/9cagFvn
 xjvik5bA9msytZYQ22uC63dFTmBYYLCeM+7wjTmP8Hu1Z7af/mVmBAmt0XWmJpfH1/TORo+DOb
 hxEs23bD9D2kcjHAAAA
To: Andrew Morton <akpm@linux-foundation.org>,
        "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy
	<anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GS_K5xxJs56BZFeSz5KMVHivUN28SWJn
X-Proofpoint-ORIG-GUID: GS_K5xxJs56BZFeSz5KMVHivUN28SWJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190159

make allmodconfig && make W=1 C=1 reports for lib/test_*.ko:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hexdump.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_dhry.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_firmware.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_sysctl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hash.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ida.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_list_sort.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_min_heap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_module.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_sort.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_static_keys.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_static_key_base.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_memcat_p.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_blackhole_dev.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_meminit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_free_pages.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_kprobes.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ref_tracker.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bits.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Updated the description of lib/test_kprobes.c per Masami
- Removed references to lib/test_user_copy since that is being renamed in
  https://lore.kernel.org/all/20240612195921.2685842-2-kees@kernel.org/
  and the description added in
  https://lore.kernel.org/all/20240619202659.work.532-kees@kernel.org/
- Link to v1: https://lore.kernel.org/r/20240601-md-lib-test-v1-1-a728620e37d8@quicinc.com
---
 lib/dhry_run.c             | 1 +
 lib/test-kstrtox.c         | 1 +
 lib/test_bits.c            | 1 +
 lib/test_blackhole_dev.c   | 1 +
 lib/test_firmware.c        | 1 +
 lib/test_free_pages.c      | 1 +
 lib/test_hash.c            | 1 +
 lib/test_hexdump.c         | 1 +
 lib/test_ida.c             | 1 +
 lib/test_kprobes.c         | 3 ++-
 lib/test_list_sort.c       | 1 +
 lib/test_memcat_p.c        | 1 +
 lib/test_meminit.c         | 1 +
 lib/test_min_heap.c        | 1 +
 lib/test_module.c          | 1 +
 lib/test_ref_tracker.c     | 3 ++-
 lib/test_sort.c            | 1 +
 lib/test_static_key_base.c | 1 +
 lib/test_static_keys.c     | 1 +
 lib/test_sysctl.c          | 1 +
 20 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/dhry_run.c b/lib/dhry_run.c
index e6a279dabf84..4a6d05ce4361 100644
--- a/lib/dhry_run.c
+++ b/lib/dhry_run.c
@@ -83,4 +83,5 @@ static int __init dhry_init(void)
 module_init(dhry_init);
 
 MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
+MODULE_DESCRIPTION("Dhrystone benchmark test module");
 MODULE_LICENSE("GPL");
diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
index f355f67169b6..ee87fef66cb5 100644
--- a/lib/test-kstrtox.c
+++ b/lib/test-kstrtox.c
@@ -732,4 +732,5 @@ static int __init test_kstrtox_init(void)
 	return -EINVAL;
 }
 module_init(test_kstrtox_init);
+MODULE_DESCRIPTION("Module test for kstrto*() APIs");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/lib/test_bits.c b/lib/test_bits.c
index c9368a2314e7..01313980f175 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -72,4 +72,5 @@ static struct kunit_suite bits_test_suite = {
 };
 kunit_test_suite(bits_test_suite);
 
+MODULE_DESCRIPTION("Test cases for functions and macros in bits.h");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_blackhole_dev.c b/lib/test_blackhole_dev.c
index f247089d63c0..ec290ac2a0d9 100644
--- a/lib/test_blackhole_dev.c
+++ b/lib/test_blackhole_dev.c
@@ -96,4 +96,5 @@ module_init(test_blackholedev_init);
 module_exit(test_blackholedev_exit);
 
 MODULE_AUTHOR("Mahesh Bandewar <maheshb@google.com>");
+MODULE_DESCRIPTION("module test of the blackhole_dev");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 9cfdcd6d21db..bcb32cbff188 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -1567,4 +1567,5 @@ static void __exit test_firmware_exit(void)
 module_exit(test_firmware_exit);
 
 MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
+MODULE_DESCRIPTION("interface to trigger and test firmware loading");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_free_pages.c b/lib/test_free_pages.c
index 9ebf6f5549f3..48952364c540 100644
--- a/lib/test_free_pages.c
+++ b/lib/test_free_pages.c
@@ -44,4 +44,5 @@ static void m_ex(void)
 module_init(m_in);
 module_exit(m_ex);
 MODULE_AUTHOR("Matthew Wilcox <willy@infradead.org>");
+MODULE_DESCRIPTION("Check that free_pages() doesn't leak memory");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_hash.c b/lib/test_hash.c
index bb25fda34794..a7af39662a0a 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -235,4 +235,5 @@ static struct kunit_suite hash_test_suite = {
 
 kunit_test_suite(hash_test_suite);
 
+MODULE_DESCRIPTION("Test cases for <linux/hash.h> and <linux/stringhash.h>");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index fe2682bb21e6..751645645988 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -253,4 +253,5 @@ static void __exit test_hexdump_exit(void)
 module_exit(test_hexdump_exit);
 
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_DESCRIPTION("Test cases for lib/hexdump.c module");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/lib/test_ida.c b/lib/test_ida.c
index 072a49897e71..c80155a1956d 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -214,4 +214,5 @@ static void ida_exit(void)
 module_init(ida_checks);
 module_exit(ida_exit);
 MODULE_AUTHOR("Matthew Wilcox <willy@infradead.org>");
+MODULE_DESCRIPTION("Test the IDA API");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_kprobes.c b/lib/test_kprobes.c
index 0648f7154f5c..b7582010125c 100644
--- a/lib/test_kprobes.c
+++ b/lib/test_kprobes.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * test_kprobes.c - simple sanity test for *probes
+ * test_kprobes.c - simple sanity test for k*probes
  *
  * Copyright IBM Corp. 2008
  */
@@ -400,4 +400,5 @@ static struct kunit_suite kprobes_test_suite = {
 
 kunit_test_suites(&kprobes_test_suite);
 
+MODULE_DESCRIPTION("simple sanity test for k*probes");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_list_sort.c b/lib/test_list_sort.c
index cc5f335f29b5..30879abc8a42 100644
--- a/lib/test_list_sort.c
+++ b/lib/test_list_sort.c
@@ -119,4 +119,5 @@ static struct kunit_suite list_sort_suite = {
 
 kunit_test_suites(&list_sort_suite);
 
+MODULE_DESCRIPTION("list_sort() KUnit test suite");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_memcat_p.c b/lib/test_memcat_p.c
index 849c477d49d0..7e0797a6bebf 100644
--- a/lib/test_memcat_p.c
+++ b/lib/test_memcat_p.c
@@ -112,4 +112,5 @@ static void __exit test_memcat_p_exit(void)
 module_init(test_memcat_p_init);
 module_exit(test_memcat_p_exit);
 
+MODULE_DESCRIPTION("Test cases for memcat_p() in lib/memcat_p.c");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 0dc173849a54..6298f66c964b 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -436,4 +436,5 @@ static int __init test_meminit_init(void)
 }
 module_init(test_meminit_init);
 
+MODULE_DESCRIPTION("Test cases for SL[AOU]B/page initialization at alloc/free time");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_min_heap.c b/lib/test_min_heap.c
index 7b01b4387cfb..a2dd478997bb 100644
--- a/lib/test_min_heap.c
+++ b/lib/test_min_heap.c
@@ -191,4 +191,5 @@ static void __exit test_min_heap_exit(void)
 }
 module_exit(test_min_heap_exit);
 
+MODULE_DESCRIPTION("Test cases for the min max heap");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_module.c b/lib/test_module.c
index debd19e35198..3d1b29b74807 100644
--- a/lib/test_module.c
+++ b/lib/test_module.c
@@ -31,4 +31,5 @@ static void __exit test_module_exit(void)
 module_exit(test_module_exit);
 
 MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
+MODULE_DESCRIPTION("module loading subsystem test module");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_ref_tracker.c b/lib/test_ref_tracker.c
index 49970a7c96f3..b983ceb12afc 100644
--- a/lib/test_ref_tracker.c
+++ b/lib/test_ref_tracker.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Referrence tracker self test.
+ * Reference tracker self test.
  *
  * Copyright (c) 2021 Eric Dumazet <edumazet@google.com>
  */
@@ -112,4 +112,5 @@ static void __exit test_ref_tracker_exit(void)
 module_init(test_ref_tracker_init);
 module_exit(test_ref_tracker_exit);
 
+MODULE_DESCRIPTION("Reference tracker self test");
 MODULE_LICENSE("GPL v2");
diff --git a/lib/test_sort.c b/lib/test_sort.c
index be02e3a098cf..81aef88b48b5 100644
--- a/lib/test_sort.c
+++ b/lib/test_sort.c
@@ -45,4 +45,5 @@ static struct kunit_suite sort_test_suite = {
 
 kunit_test_suites(&sort_test_suite);
 
+MODULE_DESCRIPTION("sort() KUnit test suite");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_static_key_base.c b/lib/test_static_key_base.c
index 5089a2e2bdd8..9f507672afa5 100644
--- a/lib/test_static_key_base.c
+++ b/lib/test_static_key_base.c
@@ -57,4 +57,5 @@ module_init(test_static_key_base_init);
 module_exit(test_static_key_base_exit);
 
 MODULE_AUTHOR("Jason Baron <jbaron@akamai.com>");
+MODULE_DESCRIPTION("Kernel module to support testing static keys");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_static_keys.c b/lib/test_static_keys.c
index 42daa74be029..00c715f30df9 100644
--- a/lib/test_static_keys.c
+++ b/lib/test_static_keys.c
@@ -236,4 +236,5 @@ module_init(test_static_key_init);
 module_exit(test_static_key_exit);
 
 MODULE_AUTHOR("Jason Baron <jbaron@akamai.com>");
+MODULE_DESCRIPTION("Kernel module for testing static keys");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 9321d850931f..b6696fa1d426 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -280,4 +280,5 @@ static void __exit test_sysctl_exit(void)
 module_exit(test_sysctl_exit);
 
 MODULE_AUTHOR("Luis R. Rodriguez <mcgrof@kernel.org>");
+MODULE_DESCRIPTION("proc sysctl test driver");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-lib-test-16083d9d77e2

