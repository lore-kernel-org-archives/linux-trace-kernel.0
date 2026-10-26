Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039748;
	b=JeYr7mKSjhV7hqZfsNU0tS+kTU6/IlfObC4E9BmSEhAakcYf2fdKGywBldnVXv4yv7MQ
	 jhhjJAYYG8gnE1+aQmuXi3fFlxQLgKP/Cx6UKPb4CfvzsW2BW2vN87ReI/EopfOpWqtjx
	 LLNscLVmtQBCar9Qs23kOvDUUpLGnJUqsOLuxEtKNTqbhBDFOMwQSIu3Lz4lGmyXM4aox
	 2URhWArGfC0wsEIKgVlZMApsYVUUpcEnSBF1ZZZ8CoBjD/wDiqu7I8l9v4rCbj5DE/HEv
	 4BpoqrhC3Ma/RL1VpPXXVXKfo328jXSuxH6/YZqH7KD61S4edDL5eAY0+AveLtoFwcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039748;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=57QWcz2VwLkiTfWYRQpCpL2lvsPBjGYHYfShT0szcks=;
	b=HTDIh1xZgBPLeDSuPWuj3yXHNVu6kOxL8RS6ZvYuL4zp25vzqI0oiaY8b8zln9l8H8Pa
	 gQDKZTxSrrLhWtdo2vvZXcbBgDC+SzXFRTq2AKhKOWtqjfK/nxmKh6bGIUVF0gaZZOpoB
	 jdHlYeWArbD59rhmTcCumzYDsUabwKwmCMakCPOFToMwRsRrwBeb98qxJucgjonpnFnsr
	 LWxtehHHbXJdtYEc8vA+Yrk6zklXLCX2z39Sx8W0LVCLg5ETc3CcPvObQG6rfN5ass728
	 5Jta6buC6cpnIdqxaIk6+t4/aDLXQZFCp77E1kSI8++xGxoLBtUhu/Bdr7mDjy1vU2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LrM6Ktz2;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C460A381F;
	Mon, 26 Oct 2026 18:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D73C460A381F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LrM6Ktz2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039748; x=1824575748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MjKzI4/VWFi8ZwmeHtAEDvQa9E8SUAD8C9ReWxMpNlc=;
  b=LrM6Ktz2YwNgiQoy5TD7eRgxzTT8AOkJ98mshcm31MoKhK+OIgsgIGJU
   8tjLGIYf56pFT8NFQw1oLn66dQOh/GECgnHA9P+rAogqi6XjXkjUY6615
   sDQeuj+evlswxiZMPUV6Xx2wZzF80OdlAZDjkIQycHVxEYY76hl+0nPIe
   NYOKq/0l88ZXeaMwoY13cBSQ/+o/b+e+6JofjHNzE/vZiEJko0IrYBtgV
   VyGTJuLL3c2mkNDM7ThN0jiHQwjuhcb1Aaeu+M543JSXFfuQqXXcjYPMf
   RMOFT8Efo8NIw0Ug4QD9WxQGG9PZipoMlfGQm67Aj0ihXh31fqhmCMl3T
   w==;
X-CSE-ConnectionGUID: h1Iq7IEVTmSiJztTdo/Mbw==
X-CSE-MsgGUID: LSHc36qtQpSTXLR0RSNfLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731542"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731542"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:37 -0700
X-CSE-ConnectionGUID: TZWelxQwSWutBs/0u7IQjQ==
X-CSE-MsgGUID: e7WuVwHxRBeAPpmjd2LHlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293905"
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
Subject: [PATCH 13/17] platform/x86/intel/ifs: Add additional details sysfs interface
Date: Mon, 26 Oct 2026 11:38:16 -0700
Message-ID: <20261026183820.129459-14-ehab.ababneh@intel.com>
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

The MSR_LAST_SAF_WP register provides information about the core when
the last WRMSR(ACTIVATE_SCAN) was executed. It is available only if
enumerated in bits [10:9] of MSR_INTEGRITY_CAPABILITIES.

Add a new sysfs interface, addnl_details_list, to the user space to
provide additional details about the last In-Field Scan testing.

[ Qiuxu: wrote the commit message. ]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     |  2 ++
 drivers/platform/x86/intel/ifs/runtest.c |  4 ++++
 drivers/platform/x86/intel/ifs/sysfs.c   | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 1043378c60e5..3f11ae08dce1 100644
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
@@ -332,6 +333,7 @@ struct ifs_device {
 
 struct ifs_test_output {
 	u64	test_details;
+	u64	addnl_details;
 	int	test_result;
 };
 
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 6c3d025817e7..d5303dd72233 100644
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
index 82a603cd1fd3..3cbab2acca72 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -188,6 +188,28 @@ static ssize_t cpus_ran_list_show(struct device *dev, struct device_attribute *a
 }
 
 static DEVICE_ATTR_RO(cpus_ran_list);
+
+static ssize_t addnl_details_list_show(struct device *dev, struct device_attribute *attr, char *buf)
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
+				     pcpu_state->addnl_details);
+	}
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
@@ -198,6 +220,7 @@ struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_status_list.attr,
 	&dev_attr_details_list.attr,
 	&dev_attr_cpus_ran_list.attr,
+	&dev_attr_addnl_details_list.attr,
 	NULL
 };
 
-- 
2.43.0

