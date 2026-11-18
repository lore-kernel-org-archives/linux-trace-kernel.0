Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030231;
	b=W726Dxy9h2kyc/fQ6lVbQXkgZAm74R7V4r6JkM4+TUcmJ3+BpUldTprA53AwoSXUnVCw
	 mzLKPqUDIJf3xK4TuczRStiYy3m4M84+6+W8nyb30M/TOilOMdKiVyudcr73wgaBfDujP
	 4HU6n+PpNotnRsL2sDF/WvLazzpoLZ+Q2AFUmcQARmYLHW6ATzDYLnfurKp9128qojiVL
	 Q5qextwCYmRgj5i7/tqKKLSa9wzSm3uXAIgKJkSaX/VG6u7Jl+rDIP/j0Vq3YMqsSXPWq
	 UCIP0LcpKzp8H4fGMle7yUSK9qvVry3e1IXUBb9OjsIE+T6nkyfLvAw84taSyUvpTNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030231;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z3ax4p4ykhMnWP9Yt7LSQVaJSJVTstr+8vvb/dp5iIc=;
	b=XbsVWp2vYGYAdGrrABVenoz8A0Y9+jNEtI+UpSQSoQsQ1hhwjVoXVNiEBopx7QXBGp2O
	 IPaGZGKoldKpQbWABTTRZHcKO7G8NE8ac/yQNBRF4fgc1sAft54sG074OnWlqo9N8zjG9
	 LkDT2Seuif6lem8IN53KS3urR7KHU+UpMTIfDykdli1E7WFxkfyZrjTl9cOe7FCGwgobX
	 IDLARMgviDFgqBKRTk5M5SiTdTI89Q2xNnnDJsppS5gsT20NR4dz31phbskDw+FS9Du01
	 pBSqeFZIFHjdKPm4jK8agbVGObXG23zhXwj50xIIwD/JqWT0xF+ejuhQnDUr2SU1DuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GRnBM0zZ;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5060A5BC5;
	Wed, 18 Nov 2026 19:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABC5060A5BC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GRnBM0zZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030231; x=1826566231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxW/pyfo8B8McXZ6l6ncb1+Do3A3TgWi3id6HDxgoxc=;
  b=GRnBM0zZt9BxkJL6mgzaI0ALINzQVS1ordZvxuI1s2YEAfq3C0rWnQ3o
   KOLMV/anAjEhyPdjHXnVE75ktyJ6n5rLgF0/GdqaGG9TlCJ2xqPCCaTcm
   jdM2iq/guHHzy/QynJIAskYL/4KnTS02S/fz/OE2rFTbWLXwEhcAltwuJ
   f+wpI8w31tdbDUOEYX6hClFV9ga4h+Bi1PNmmTZ49xt2veuC+/DcOuRGX
   yR93d8xhrb+BTMqEpiW2dejN9aBwDvRgKE0s06M1grH3cDvULxXzXm55w
   tzeEgzxNLhAXSx62L6C0B4LruShJse0BMSmk/rNecMeuOfSp7KbAE2g5A
   A==;
X-CSE-ConnectionGUID: lUEt0SEtROWkgK/AARQNAA==
X-CSE-MsgGUID: cepMLHjRREKJThHEhStDlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781300"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781300"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:30 -0800
X-CSE-ConnectionGUID: vCynTrSMS+Cp8DQP7BWr/w==
X-CSE-MsgGUID: Ca6KgTvqRtCkxA0gJAl3DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468122"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:30 -0800
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
Subject: [PATCH v2 13/17] platform/x86/intel/ifs: Add additional details sysfs interface
Date: Wed, 18 Nov 2026 12:32:55 -0700
Message-ID: <20261118193259.519568-14-ehab.ababneh@intel.com>
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

The MSR_LAST_SAF_WP register provides information about the core when
the last WRMSR(ACTIVATE_SCAN) was executed. It is available only if
enumerated in bits [10:9] of MSR_INTEGRITY_CAPABILITIES.

Add a new sysfs interface, addnl_details_list, to the user space to
provide additional details about the last In-Field Scan testing.

[ Qiuxu: wrote the commit message. ]

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
index b93d8de4ca06..829676e1775d 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -177,6 +177,7 @@ static int doscan(void *data)
 	struct run_params *params = data;
 	union ifs_status status;
 	struct ifs_data *ifsd;
+	u64 saf_wp = 0;
 
 	ifsd = params->ifsd;
 	pcpu_scan = this_cpu_ptr(ifsd->result_ptr);
@@ -202,6 +203,8 @@ static int doscan(void *data)
 	wrmsrq(MSR_ACTIVATE_SCAN, params->activate->data);
 	rdmsrq(MSR_SCAN_STATUS, status.data);
 
+	if (ifsd->generation)
+		rdmsrq(MSR_LAST_SAF_WP, saf_wp);
 	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
 
 	/* Pass back the result of the scan */
@@ -209,6 +212,7 @@ static int doscan(void *data)
 		params->status = status;
 
 	pcpu_scan->test_details = status.data;
+	pcpu_scan->addnl_details = saf_wp;
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index e96faf7bf0fa..1a111e6101d8 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -192,6 +192,29 @@ static ssize_t cpus_ran_list_show(struct device *dev, struct device_attribute *a
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
@@ -202,6 +225,7 @@ struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_status_list.attr,
 	&dev_attr_details_list.attr,
 	&dev_attr_cpus_ran_list.attr,
+	&dev_attr_addnl_details_list.attr,
 	NULL
 };
 
-- 
2.43.0

