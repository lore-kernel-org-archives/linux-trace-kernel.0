Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197280;
	b=I3GWQBi1thl44uT98kQyg7gdgDNWFvd1GifaKffASg6ej1WuJ0YIjWZFkyIykaKjMJVT
	 pnbUb50qiB+aMky0c0C3gHR3cH9mE4fmTRkRFnIeUYRo5H80PnaZpd0VwyWcUnt2L+LGs
	 MTSvpgG5BogsyUoTCl7b3nYDbWy4KJFJyN6x8D9151qHNJz60c3QdaHg2IhAI/HSDG34+
	 Ok2mfzd+salS+SLL7e6eOwRwteUCSZD4ieDtaiLXQQ+oKZQkYEjPaRhEH0tgMenyTQvD9
	 YuL59yr+l5QBq45PHQ5TdawdqArDRfJI+srPg/w/Brr4jihFllvsBFq5xOl3jLtrxdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197280;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vTuHCi+MkC4HXtz/oSYZwMJifdqnv7u43FoGtbXHh34=;
	b=yfUOsBpdV5Mx9i434up9gY9g1MSly939pvkRRVRddNHjUDDaPZ8Yo/F641oKWB0fkgJ3
	 KTT2/B+iFFk87k7nyd6+GoL8Mvf7H0rVsKlVzrGrcxhBeSSYVbxlFuhIqT5MbpeknBFQy
	 mwgbdpB1AgLB4I5bqrAk+xxyw0+8FW7f7HgAePh2xAHxhPUbzopmRBB9fTfMUWpgaN/6D
	 BjW065T0BL30+gHWfY6UUgjeGEcsm6SyXINBWmLXXnsmw7V/kuHRp+NBB0bqq0c3xV9hb
	 gqu4XO3HfE1SxMJ8X0lcmp9XLV1u/drZGTudXFX4PjaTjKVAZyk1pbc2s6cncAnbN7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OWDmtS79;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042CE60A5BE9;
	Fri, 20 Nov 2026 17:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 042CE60A5BE9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OWDmtS79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197277; x=1826733277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dUlnmwcih5DDBhNZFNFBUpRMDkxMyI2Ot7iHydLVDRs=;
  b=OWDmtS79JhZHF9lQRpByHQHEwV/WWeRNH4x7JG4IQcR3cBu3K0qx5jSM
   OCm5F9p2OH0/Dpvxmy/jMCQKY3j2kfaHGTjXg+NIvmn53sZSx7DI3pThw
   VU7QYsKxKuMJwhtBOFBmW5MWb7u0Vxc+U/nVrGEfnPjQJYjEEuGPmPfXZ
   sRqb2zdKQk9pZ8umu8ktKrJIg8YxzW6kvLvlz7ZODN2zeten8rfLKcq3h
   2qA9SPDjLDauG0MOHWXPLqDJNWRTrccd/V+dFazdJJBSAw5LdP05Txddy
   wseGAq8JHgqcIbPjNdLj4T0l0Lpl+HAVDelJocOAf/b0p1Zo0MzR7yWgZ
   g==;
X-CSE-ConnectionGUID: XhitsymTQYKzLL/cpo49NA==
X-CSE-MsgGUID: 0AtWx6WPTQqvgC+yBdZuqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4109004"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4109004"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:27 -0800
X-CSE-ConnectionGUID: TvaBmivLSLS0eDxlIQrOQw==
X-CSE-MsgGUID: MP2E2zFHRT+n1da2U/taZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171077"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:27 -0800
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
Subject: [PATCH v3 13/17] platform/x86/intel/ifs: Add additional details sysfs interface
Date: Fri, 20 Nov 2026 10:56:54 -0700
Message-ID: <20261120175658.1147030-14-ehab.ababneh@intel.com>
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

The MSR_LAST_SAF_WP register provides information about the core when
the last WRMSR(ACTIVATE_SCAN) was executed. It is available only if
enumerated in bits [10:9] of MSR_INTEGRITY_CAPABILITIES.

Add a new sysfs interface, addnl_details_list, to the user space to
provide additional details about the last In-Field Scan testing.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     |  2 ++
 drivers/platform/x86/intel/ifs/runtest.c |  4 ++++
 drivers/platform/x86/intel/ifs/sysfs.c   | 24 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index acf8d8a7b105..10eea2c6b871 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -139,6 +139,7 @@
 #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
 #define MSR_ACTIVATE_SCAN			0x000002c6
 #define MSR_SCAN_STATUS				0x000002c7
+#define MSR_LAST_SAF_WP				0x000002c9
 #define MSR_ARRAY_TRIGGER			0x000002d6
 #define MSR_ARRAY_STATUS			0x000002d7
 #define MSR_SAF_CTRL				0x000004f0
@@ -334,6 +335,7 @@ struct ifs_device {
 
 struct ifs_test_output {
 	u64	test_details;
+	u64	addnl_details;
 	int	test_result;
 };
 
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 9022ec55d0a1..041d281b0103 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -190,6 +190,7 @@ static int doscan(void *data)
 	struct run_params *params = data;
 	union ifs_status status;
 	struct ifs_data *ifsd;
+	u64 saf_wp = 0;
 	int start, stop;
 
 	ifsd = params->ifsd;
@@ -216,9 +217,12 @@ static int doscan(void *data)
 	wrmsrq(MSR_ACTIVATE_SCAN, params->activate->data);
 	rdmsrq(MSR_SCAN_STATUS, status.data);
 
+	if (ifsd->generation)
+		rdmsrq(MSR_LAST_SAF_WP, saf_wp);
 	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
 
 	pcpu_scan->test_details = status.data;
+	pcpu_scan->addnl_details = saf_wp;
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 46a74826606d..917de0efdeef 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -190,6 +190,29 @@ static ssize_t cpus_ran_list_show(struct device *dev, struct device_attribute *a
 }
 
 static DEVICE_ATTR_RO(cpus_ran_list);
+
+static ssize_t addnl_details_list_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	struct ifs_test_output *pcpu_state;
+	int lcpu, len = 0;
+
+	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
+		pcpu_state = per_cpu_ptr(ifsd->result_ptr, lcpu);
+		len += sysfs_emit_at(buf, len, "%s%#llx", (len > 0) ? " " : "",
+				     pcpu_state->addnl_details);
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
+static DEVICE_ATTR_RO(addnl_details_list);
+
 /* global scan sysfs attributes */
 struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_details.attr,
@@ -200,6 +223,7 @@ struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_status_list.attr,
 	&dev_attr_details_list.attr,
 	&dev_attr_cpus_ran_list.attr,
+	&dev_attr_addnl_details_list.attr,
 	NULL
 };
 
-- 
2.43.0

