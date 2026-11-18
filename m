Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030231;
	b=EgusUo4tbruKAQQbaf9+tgkHGMKMPnhBILWb4V2PB2e/M7jQb/EWVQBaI55xApVSFrrP
	 YArkzn5ZyWJnruA8cJKEDsGtoDvmPqA/VYeUzK1mHLp+6T7Rnbj5UZcT5qGfLwJBLTpff
	 VRn5zUnxlV4a2RciuwVcJEJTDFz5eU/TlUP9KHxX/qzvHBG7R9pw1IX7Ab4/2zeqbMJ6P
	 h1zaWR9lOHov9EQPdZkC+P3R8Yv6WXXDIfaGS4DpDIzP75S+eIzLzXFY+0WjfgxrqDvVB
	 mUqqTfV7jWteEnHTcsULnpE7MnbQbQ2a5bedtRbTv+FMppn66jjQPdt8YDgnoKiN99Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030231;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3wmdkSg1KF15ntOGo9WBNYUTEmWMvwU2lNeHwzxdT0Y=;
	b=PVTIB4ZtMccCWHMvaAP+Tm2iFvGvO4eCt6WKwO3GAmreo8SNnVfs4IdhNtjmfYRsHpA8
	 DFUr4+9lk8b0WKM/sToThngxIJKxzMyfGF0r8EG7mT/QWvBdmSraFWGVqv50pWokZWThu
	 CvmD+rRESd6sSdajQU4UFchg5nILp82GgeHRvv9TlTMALhzS0VxhIQ11cxtWAn23kaM9Y
	 IL0WVTvx7PspaCIvsTwbJrs3F5x42DXWMexhm2qYcO3sO3Dk4MqJ6QBXbn2GphSU6dd2D
	 Cnsc7RBabHS0eBj0YOy2NM9yLLzH67jblsyUSNF0eyvOMFxK0AuoEU6EE35UbQN2ddg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IcpmxXag;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B4607D6A9;
	Wed, 18 Nov 2026 19:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 831B4607D6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IcpmxXag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030231; x=1826566231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rhGkQE4bmoqmysTt3reB+nTwyGCy2zwtfv+d2+7A6WA=;
  b=IcpmxXagmASLva9O2nwETFjdGWYNdx1PUhrfb+OSboxaaHWI306ZU18r
   7zGRAKff0ZE0W9RvcOPYfjoMB2aURbanLn4JS4EWwcSD4tSjyZCBXkXj0
   iQJnVROMrXWz+KFP3kbe/5G4w3vMArktsc4pRWZcBUPy8If0j7iUXUNZl
   X1k24QpjNsM+pinc9y4ZrMd1EECqN4pk6vvQjkzRtr0sOE0hDMXoMdAFH
   PvRooEQDJ3Bld0js2cKNJ3GX5pIT/isTd+cHsLYCAG8VF2FJVkunWAH+Y
   LScOjIhdJIQTryh2B2KL1tGAM3sIQzGJKpvHaX8sB+6CL5Kv6H3bXYN8k
   Q==;
X-CSE-ConnectionGUID: 7X4JKJrqSu+WhLM4cWoBtg==
X-CSE-MsgGUID: bHevym5HR06I/ewDcP8lig==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781290"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781290"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:30 -0800
X-CSE-ConnectionGUID: He1Rgxo8RM2UjcZW+odIlA==
X-CSE-MsgGUID: c07mUmwkR4WV4/0eduFjkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468114"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:29 -0800
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
Subject: [PATCH v2 12/17] platform/x86/intel/ifs: Add new sysfs interfaces {status, details, cpus_ran}_list
Date: Wed, 18 Nov 2026 12:32:54 -0700
Message-ID: <20261118193259.519568-13-ehab.ababneh@intel.com>
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

From: Jithu Joseph <jithu.joseph@intel.com>

Problem
=======
The current legacy interface for Intel In-Field Scan is designed to
simultaneously test all CPUs in a group [1], but it only reports the
status of the primary CPU in this group and doesn't indicate that
secondary CPUs have been tested. This results in the following issues:

  - All CPUs in a group can hold different statuses, but the user can
    only see the status of the primary CPU, as any errors observed by
    secondary CPUs are ignored.

  - The topology of a group of CPUs may vary across systems. For example,
    in a Hyper-Threading (HT) system, the group consists of all CPUs in
    a core, while in a Dual-Core Module (DCM) based system (e.g., Intel
    Diamond Rapids CPU), two cores in a module form a group. The user may
    be unaware of the group topology and test each CPU of the system
    individually, leading to duplicate test runs.

Solution
========
The user continues to write a single value to run_test, and while the
legacy sysfs reports results for the tested CPU to ensure backward
compatibility, new sysfs interfaces {status, details, cpus_run}_list
provide results for multiple related CPUs tested as part of a group.
The user can check for the presence of new sysfs interfaces to
understand that multiple results are available, read them, and identify
which CPUs have been tested to avoid duplicate tests.

  intel_ifs_0
  +---- run_test	<--- Same legacy file
  +---- current_batch
  +---- details
  +---- details_list	<--- Details for all CPUs in the group (new)
  +---- dev
  +---- image_version
  +---- status
  +---- status_list	<--- Status for all CPUs in the group (new)
  +---- cpus_ran_list	<--- CPUs in the group tested along with CPU written to run_test (new)
  \---- uevent

Example of reading the cpus_ran_list to see the CPUs tested:

  echo 0 > run_test
  cat cpus_ran_list
  0,96

  cat status_list
  pass pass

  cat details_list
  0x8086 0x8087

[1] Indicated by bits [20:16] of MSR_INTEGRITY_CAPABILITIES when bit 21 is set.
    E.g., in Hyper-Threading (HT) systems, a group includes all threads in a core;
    in Dual-Core Module (DCM) system, a group includes all CPU cores in a module.

[ Qiuxu: wrote the commit message. ]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/platform/x86/intel/ifs/sysfs.c | 60 ++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 287f96bb033e..e96faf7bf0fa 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -135,6 +135,63 @@ static ssize_t image_version_show(struct device *dev,
 
 static DEVICE_ATTR_RO(image_version);
 
+static ssize_t status_list_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	struct ifs_test_output *pcpu_state;
+	int lcpu, len = 0;
+
+	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
+		pcpu_state = per_cpu_ptr(ifsd->result_ptr, lcpu);
+		len += sysfs_emit_at(buf, len, "%s%s", (len > 0) ? " " : "",
+				     status_msg[pcpu_state->test_result]);
+	}
+
+	if (!len)
+		return sysfs_emit(buf, "%s\n", "none");
+
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
+static DEVICE_ATTR_RO(status_list);
+
+static ssize_t details_list_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	struct ifs_test_output *pcpu_state;
+	int lcpu, len = 0;
+
+	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
+		pcpu_state = per_cpu_ptr(ifsd->result_ptr, lcpu);
+		len += sysfs_emit_at(buf, len, "%s%#llx", (len > 0) ? " " : "",
+				     pcpu_state->test_details);
+	}
+
+	if (!len)
+		return sysfs_emit(buf, "%s\n", "none");
+
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
+static DEVICE_ATTR_RO(details_list);
+
+static ssize_t cpus_ran_list_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	int len;
+
+	len = sysfs_emit(buf, "%*pbl", cpumask_pr_args(&ifsd->grp_cpumask));
+	if (!len)
+		return sysfs_emit(buf, "%s\n", "none");
+
+	return len + sysfs_emit_at(buf, len, "\n");
+}
+
+static DEVICE_ATTR_RO(cpus_ran_list);
 /* global scan sysfs attributes */
 struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_details.attr,
@@ -142,6 +199,9 @@ struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_run_test.attr,
 	&dev_attr_current_batch.attr,
 	&dev_attr_image_version.attr,
+	&dev_attr_status_list.attr,
+	&dev_attr_details_list.attr,
+	&dev_attr_cpus_ran_list.attr,
 	NULL
 };
 
-- 
2.43.0

