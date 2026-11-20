Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197276;
	b=BTTttEC+Dg3FnnwizgDEVkZzK7GveS4h7mCCQI+mvR8LYeH64278PDhBxRGYOAL0jZOC
	 gMTZ/8AVYTC9F1/eRk38wbZ1EwoJRR77IQHrxD6wlYUQ0cREZBOuPNb1I8hDyzikJdzWT
	 XpsdXL6nZzMS/yA7lJA/5/kxpbqBm43fjrB9rGy+uWHUVxcCOFLEssxz/aSMB4i4eATgM
	 9QHi0MsfEUsy0/xihxTRhBxiAkg8w7Ea/l3RUdZn4FpcMvEwR5lsYHQvg47LYh+HeGJvs
	 XuoHST0XDomONI23TRz8wObS/RQK+P1BltYV5XGhIueKuciGPAlMQ6TPoEy2tD3DWtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197276;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7UsYq/cOStDF5QUFcq9lxiOi5VT38dFFs276ey3jsuA=;
	b=OKLHj3DzOG0JMYr/HfnUhFIo0KQS3eZNmmGD+iiiqIFBILrr0k6nqPVqMGGFQRM1wZQM
	 tpwRcducWDsGtowCTqpkC7GVGEhtlHzNd8abBw3e7/784lTrB2UMPv5n7g+bsIfudFqLT
	 E30XmuhAwKzqQEmXtUTd6gYOgKsIVMOUVVwOMVQJ73Np+oTAuzpvvbQG89gYfWfa8bGUx
	 ykWT0H/0Oa7WXzr6Obhk1tH2b3NzR6uZv20SULBKOzvZqNzrRDThix8zxk+VObEnvsD3U
	 zjOpGowKlf6UmWG30Dd4M8YAWZ9Y3NxjpXsvRDyt7Tce6xc/V0AFjGxeHKIc7kezbmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="W/tGIYlk";
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5A60A3812;
	Fri, 20 Nov 2026 17:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81C5A60A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W/tGIYlk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197267; x=1826733267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ga71Wq7BqrzUIP/vHSoAKkoEApVBN/rgnyENY8hHh0I=;
  b=W/tGIYlkb7KpKPVlR4WPIY/HbkJipzKHw20lj01LPANgE3yHI8O8pV5h
   QqTv8H8eiwfSWy77wlbpEM05kDKpDNKYE4P30sNfkRbtXgULHIoV/ZzfM
   aW6v9q1ibAilf1/GSVUJEKSSJd+DHHnA4dCUEQTRS5XuyV19es0mrDo37
   bxtpoSh37Kar0cCDhVctZoRI0+mHLXkkPMDu5aPCTGDE8/555inirtmKF
   KGSsn9PGrnEVwS3a85eHcfPU5UX16ZEnDayYBNNU8g5xfgImx/5yJh737
   4ZZ4T3EfB2AyC+Mhsv2SNefu2nzaXE/jwd/lYt2eB4Gy/R2XyyUDOU4C2
   g==;
X-CSE-ConnectionGUID: WR1+iQY3TlyiYbok3ApsEA==
X-CSE-MsgGUID: tlyo3cdbQHu9JewAewk/Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108927"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108927"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:23 -0800
X-CSE-ConnectionGUID: w82t+pzVSBumuMwGrWur1g==
X-CSE-MsgGUID: 7OqMQOZ6SWGh1jPzgrkWeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171045"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:23 -0800
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
Subject: [PATCH v3 06/17] platform/x86/intel/ifs: Refactor Array BIST function interface
Date: Fri, 20 Nov 2026 10:56:47 -0700
Message-ID: <20261120175658.1147030-7-ehab.ababneh@intel.com>
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

In preparation for upcoming changes, refactor the Array BIST test to use a
more generic structure (run_array_params) when passing parameters to the
caller function.

This change enhances maintainability and flexibility for future
modifications.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/platform/x86/intel/ifs/runtest.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 96b538c665f4..c6a4d6dcccf1 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -30,6 +30,11 @@ struct run_params {
 	union ifs_status status;
 };
 
+struct run_array_params {
+	struct ifs_data *ifsd;
+	union ifs_array *command;
+};
+
 /*
  * Number of TSC cycles that a logical CPU will wait for the other
  * logical CPU on the core in the WRMSR(ACTIVATE_SCAN).
@@ -302,10 +307,12 @@ static void ifs_test_core(int cpu, struct device *dev)
 
 static int do_array_test(void *data)
 {
-	union ifs_array *command = data;
+	struct run_array_params *params = data;
 	int cpu = smp_processor_id();
+	union ifs_array *command;
 	int first;
 
+	command = params->command;
 	wait_for_sibling_cpu(&array_cpus_in, NSEC_PER_SEC);
 
 	/*
@@ -324,12 +331,14 @@ static int do_array_test(void *data)
 
 static void ifs_array_test_core(int cpu, struct device *dev)
 {
+	struct run_array_params params;
 	union ifs_array command = {};
 	bool timed_out = false;
 	struct ifs_data *ifsd;
 	unsigned long timeout;
 
 	ifsd = ifs_get_data(dev);
+	params.ifsd = ifsd;
 
 	command.array_bitmask = ~0U;
 	timeout = jiffies + HZ / 2;
@@ -340,7 +349,8 @@ static void ifs_array_test_core(int cpu, struct device *dev)
 			break;
 		}
 		atomic_set(&array_cpus_in, 0);
-		stop_core_cpuslocked(cpu, do_array_test, &command);
+		params.command = &command;
+		stop_core_cpuslocked(cpu, do_array_test, &params);
 
 		if (command.ctrl_result)
 			break;
-- 
2.43.0

