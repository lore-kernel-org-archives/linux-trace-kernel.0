Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D374413;
	Sat,  1 Jun 2024 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717280443; cv=none; b=BtVzZTZGe+5aMpda30HH4QQ7JO1EjiM3bAAM/rGOxHzBJ3nNzizGALhcefb7Vj+GDOcAUdLjDAHPFZcypvZXkDJSuUfNen/6Qa2tsT+0W6pinsrDNjHzFKeFHgH49b45UK0642Etbj7bvgSUyZNys07nWPXOz21f0vFmm016CvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717280443; c=relaxed/simple;
	bh=gHK9tl5GEnjnYCuTPq+4cdcE8U5jN9ghgvl5krpm6NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=kckYLApoD/4dJUIkPwxqTGpiFhGOO0SiM9NoBGe7BdXbCmC1oPpPTb3dfHyZ23B8/7J006sRTien7/EAdxkkbgGI7f3vu9q1o+WdFcop3tcefMwJ7RFIN1gmrsIDdWpJwRyAz7ntRaJd3wh6TSBoUMe7L5QUADEe8b8QLJiMU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JkP3hdZ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JkP3hdZ9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 451MDY2O031347;
	Sat, 1 Jun 2024 22:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6OISiKHtMTYN/NQBy17uHh
	49OHuLtPu75D6jMfKGm8w=; b=JkP3hdZ9Y0OxDxNNQIS4ZZ1qpfBTNNAgV6LpU9
	ERpdBbbHbAtC1dYAy6hIo351O4Xbh9QTAQZCcN77WA48WeqBOSRBQCcz84b4eZMf
	3HkshemXiIYBMKhFnwEMMBgM5+LPmi7ohEmTXM30d08ImDT7TvfpgbL/LnIF4XZf
	Wih9AEwV3gBhgeGYnmT9tzYs1PlD8KSXmO2jXYGOjzqYZPIJQKieqZvwT9mcIHz+
	qhjrcTsMAyYcHuW24OjlDHgUQ26mxuRTW5uvTpgTVs3Z/U4RgRtp+wtAQOPg07fA
	zW0cV5IHmNvgFDFpJZuh/xL7sKEEAaxLwectc+9sjlF1W5KA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6v1avp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 22:20:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 451MKNuh020346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 22:20:23 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 15:20:22 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 15:19:39 -0700
Subject: [PATCH] KUnit: add missing MODULE_DESCRIPTION() macros for
 lib/test_*.ko
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-lib-test-v1-1-a728620e37d8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHqeW2YC/x3MQQqDMBBA0avIrDuQxKK1VykuEjOtAxrLTFoC4
 t1Nu3yL/3dQEiaFe7OD0JeVt1RhLw1Ms08vQo7V4Iy7ms5YXCMuHDCTZrSdubVxiH1PDmrxFnp
 y+d8eY3XwShjEp2n+PRZOn4Kr10wCx3ECJXwlLHwAAAA=
To: Andrew Morton <akpm@linux-foundation.org>,
        "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy
	<anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cki3P3WcaOihKwRWzKiLC6vK7YRZbsUQ
X-Proofpoint-ORIG-GUID: cki3P3WcaOihKwRWzKiLC6vK7YRZbsUQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406010178

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
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_user_copy.o
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
 lib/dhry_run.c             | 1 +
 lib/test-kstrtox.c         | 1 +
 lib/test_bits.c            | 1 +
 lib/test_blackhole_dev.c   | 1 +
 lib/test_firmware.c        | 1 +
 lib/test_free_pages.c      | 1 +
 lib/test_hash.c            | 1 +
 lib/test_hexdump.c         | 1 +
 lib/test_ida.c             | 1 +
 lib/test_kprobes.c         | 1 +
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
 lib/test_user_copy.c       | 1 +
 21 files changed, 22 insertions(+), 1 deletion(-)

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
index 0648f7154f5c..e707f7b3a366 100644
--- a/lib/test_kprobes.c
+++ b/lib/test_kprobes.c
@@ -400,4 +400,5 @@ static struct kunit_suite kprobes_test_suite = {
 
 kunit_test_suites(&kprobes_test_suite);
 
+MODULE_DESCRIPTION("simple sanity test for *probes");
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
diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 5ff04d8fe971..9cfef46fa2d2 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -328,4 +328,5 @@ static void __exit test_user_copy_exit(void)
 module_exit(test_user_copy_exit);
 
 MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
+MODULE_DESCRIPTION("Kernel module for testing copy_to/from_user infrastructure");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-lib-test-16083d9d77e2

