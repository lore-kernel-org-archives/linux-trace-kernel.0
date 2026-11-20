Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197282;
	b=imT9XUH3u2JzFTRBUNAUtEdkdYh0Rxxsvzj0BwttPT3yFtwKPHWJlNfTsXOwBMYWGSwW
	 gjTAGzNl2skJ6glRcdpqc0TB5EC79oKPKLcVvE301PQwlLf16/thz5C1xeu6QByOifhiJ
	 tE39R+/hXHtNefLzzZj4ZBmmsCR+P51gzYj/TYHt2u06TUT4sbE9F/fjUNVfWwpjHyway
	 M7oFzh26voOqf60xzod8p+bdn93vddGomTgoI2Yr7cthWK0349GUq3fwzdKNCFddTiM2s
	 XPXfVqGs3XCmcaUpEp2RVFNHIe0JNJ544fHFBHZ5p40WtnDjUY0yK1nL9Wur7XawH3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197282;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hFqZz2h/h7TudkofaL8xz2dLX3fTj+nuD//ec3A6Lrw=;
	b=Q26Tiyyh6jVYEKo6gdnTk9YNBGZ+B+ME9qw/1DQTHv+5UtPilDEBGWA4gfLSk8xSv5/W
	 +VDHcQRU8RsYAmplZLWpOnxaAWgi9CMKyAsWL44SKSLKofBcl6eon1K6Y1KoGt3KwjrOH
	 pZqUM9JwuohCP250VaT2ovHTXHGchlGyVBIXda5ZtzBwX5psLj1SlGCZzkTTbcTzp41B4
	 MRvzbNNLAH9ul+lD/BmQz09YssEY8FD9vs6/BMC0vgAzOmSix4rzZ4ViSWLBAiEWATIMq
	 kH2fucNDTeZirTYyShm0/ThgdD3yMo3GVkfDrTElZM8nQngKIoQ6eV8rZ0eJA1oFbcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eZ5xp39E;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3960A5BDE;
	Fri, 20 Nov 2026 17:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1B3960A5BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eZ5xp39E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197277; x=1826733277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ConwBO883fH7Ku8ncBEy7FwYn6WifnoRIWbzm8B92rM=;
  b=eZ5xp39ER/qKC2LyLuaPXlTKG52j9VCc0S5cpDll4Pehi1ORd1p0oPPq
   dIuTW+PDAF/FPrmokzMsHvyrNiSYoKgkjmwfJfbP5PiIi9OjbVu9Fen0B
   KcRLoxB4wrkw9Pz+qQtI602xTG5xwo877AmtyUY0t2s6BU6EmOYtqXZP3
   OL0DCsjBBHwNs3+gLIg/u+tYMLBcsospzs2zP4P55CnsnFGflGUQAWjDF
   Wy3goMTwa0MV44vLk6ICj7Idk+C+xLBVY4PReoUvT6O9xA4gLjwKOk8wj
   WZGdT2IA8BX3FS4CHd/ehNJ5xznxVdJZtK3EaMccLtydBo8f+E8mncRb+
   g==;
X-CSE-ConnectionGUID: eZf5Fko4T2yfjESQ0kdx1w==
X-CSE-MsgGUID: OvsIRoeESjaEaipf2u+Zlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108993"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108993"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:26 -0800
X-CSE-ConnectionGUID: qxn3RrBrTkWn4veiCN3eMQ==
X-CSE-MsgGUID: v/lDymdCQgWLxWPfCOJO+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171073"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:26 -0800
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
Subject: [PATCH v3 12/17] platform/x86/intel/ifs: Add new sysfs interfaces {status, details, cpus_ran}_list
Date: Fri, 20 Nov 2026 10:56:53 -0700
Message-ID: <20261120175658.1147030-13-ehab.ababneh@intel.com>
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

From: Jithu Joseph <jithu.joseph@intel.com>

Problem
=======
The current legacy interface for Intel In-Field Scan is designed to
simultaneously test all CPUs in a group [1], but it only reports a
single result for the whole group and doesn't indicate which CPUs have
been tested. This results in the following issues:

  - All CPUs in a group can hold different statuses, but when the group
    does not pass, the user cannot see which CPU failed or was not
    tested.

  - The topology of a group of CPUs may vary across systems. For example,
    in a Hyper-Threading (HT) system, the group consists of all CPUs in
    a core, while in a Dual-Core Module (DCM) based system (e.g., Intel
    Diamond Rapids CPU), two cores in a module form a group. The user may
    be unaware of the group topology and test each CPU of the system
    individually, leading to duplicate test runs.

Solution
========
The user continues to write a single value to run_test, and while the
legacy sysfs reports the result of the whole group (pass only if all
CPUs in the group passed), new sysfs interfaces {status, details,
cpus_ran}_list provide results for each CPU tested as part of a group.
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

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/platform/x86/intel/ifs/sysfs.c | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 287f96bb033e..46a74826606d 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -135,6 +135,61 @@ static ssize_t image_version_show(struct device *dev,
 
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
+
+	if (cpumask_empty(&ifsd->grp_cpumask))
+		return sysfs_emit(buf, "%s\n", "none");
+
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&ifsd->grp_cpumask));
+}
+
+static DEVICE_ATTR_RO(cpus_ran_list);
 /* global scan sysfs attributes */
 struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_details.attr,
@@ -142,6 +197,9 @@ struct attribute *plat_ifs_attrs[] = {
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

