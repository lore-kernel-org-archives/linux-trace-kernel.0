Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039748;
	b=hKIaDLsDRxR07DCAUjTMWCzmtaniNSr9wloa7w+vnZLrPM5/kbEAe0svvfHiyW0lXScU
	 IQq65ILI1Co4TOMOHtmJiqGKEPPHVbCvhXl8GeJG5hgJJBTO97/6sFPmQITCm9Ls40Gpt
	 9Y5GJ3XmmGOpS0dtBQ0afHF6hE9FGdo+sslDIFh5/RcGdEMsNC7UGVElM04jA8Hx06Jp/
	 D9OBKBn4jI1T5+cF7whpQwX7yRcOmLSIWiJEcOQKYlkEgfsK0X83GxxGd7/gmPbQh8dd6
	 XRZa2OJPtz7pIrh0J8RZE4bgVw+zLWSP4FdM8e6g62pPwyOodUiJXnzkjCwjX2jw8Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039748;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MJ1UWsUjbcLi2/gOeHM1VIxSHs13bsbqmSIxqvL3JtI=;
	b=GrA06QkyoSzcThnY0GFNmknTEe4p9F/2o6F/65j6XnqzNvksunNPEErD1PjEKbBe/AIr
	 Y0BsP4+DfwpXD7NGD//EyeiOdTiiTXKzXyRh4h+ebB+Yd9yQXjIuH9JeQGUugNikulleL
	 +JWraWxfjgCt0lu2LLpzzrYP+JkBMMRMekKHZInNDH3rz6poymKatoHDSniN4cKsnNgCL
	 3uGimieleJst9tAwrH0TahOJjkVvyUX3Nari+h06n3Gtx6Xc9EEGTuQ9QWkFCsbTPJVew
	 Go/dpEV6brBBme9q//FVbhlx7CUOezZQkbMfPCbNl6I9qc2u1ZbuaG+fMEPJxK4azRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l+Psd+j7;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59360A380D;
	Mon, 26 Oct 2026 18:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C59360A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l+Psd+j7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039747; x=1824575747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YaR3i5zWpwMqXGdgbCXu/fddebtf8ZoNzStCuH9eIbE=;
  b=l+Psd+j7DjbxCd4b8NiEVNZ/Qbg7AidVXCjWKP84ZeQsQQNIhJHCjj7z
   gMkQyKPgGFPBGspS8EXv7lE5/PheNwYGRpm5cpxYvSNlAGkg1aP+RWLfB
   pYaiKj8ei7lAfUQm0MCW26Db6yx8vIqPkiDz+42yqzpd1vImOjKJQl/I+
   S3hnIxspZgl+q/OsjvGCOHMzFIyEvLqK1HNinn2mpImaT4Ft2K/K1s3wO
   mhqBTfxaDWXaH1AHEGKRvtOYMC/KyBC3bL6KmOBD+1dQX01NngLc4MB2H
   8uB5Zl7b0RA9PTbAvH/4um32eLse7EjE3HJqGTdenyVK4tHHwasbRPfQW
   g==;
X-CSE-ConnectionGUID: qvuJl6ouQsecz9FwB5gCaQ==
X-CSE-MsgGUID: DYu76SCvTU+Wy7rcPbcrkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731536"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731536"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:37 -0700
X-CSE-ConnectionGUID: BxTwo0LMQ0O8fGrO6x4TJA==
X-CSE-MsgGUID: abVsb/E0T7OyJei3+fwpgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293902"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:37 -0700
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
Subject: [PATCH 12/17] platform/x86/intel/ifs: Add new sysfs interfaces {status, details, cpus_ran}_list
Date: Mon, 26 Oct 2026 11:38:15 -0700
Message-ID: <20261026183820.129459-13-ehab.ababneh@intel.com>
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
---
 drivers/platform/x86/intel/ifs/sysfs.c | 56 ++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 287f96bb033e..82a603cd1fd3 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -135,6 +135,59 @@ static ssize_t image_version_show(struct device *dev,
 
 static DEVICE_ATTR_RO(image_version);
 
+static ssize_t status_list_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	struct ifs_test_output *pcpu_state;
+	int lcpu, len = 0;
+
+	if (cpumask_weight(&ifsd->grp_cpumask) == 0)
+		return sysfs_emit(buf, "%s\n", "none");
+
+	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
+		pcpu_state = per_cpu_ptr(ifsd->result_ptr, lcpu);
+		len += sysfs_emit_at(buf, len, "%s%s", (len > 0) ? " " : "",
+				     status_msg[pcpu_state->test_result]);
+	}
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
+	if (cpumask_weight(&ifsd->grp_cpumask) == 0)
+		return sysfs_emit(buf, "%s\n", "none");
+
+	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
+		pcpu_state = per_cpu_ptr(ifsd->result_ptr, lcpu);
+		len += sysfs_emit_at(buf, len, "%s%#llx", (len > 0) ? " " : "",
+				     pcpu_state->test_details);
+	}
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
+	if (cpumask_weight(&ifsd->grp_cpumask) == 0)
+		return sysfs_emit(buf, "%s\n", "none");
+
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&ifsd->grp_cpumask));
+}
+
+static DEVICE_ATTR_RO(cpus_ran_list);
 /* global scan sysfs attributes */
 struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_details.attr,
@@ -142,6 +195,9 @@ struct attribute *plat_ifs_attrs[] = {
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

