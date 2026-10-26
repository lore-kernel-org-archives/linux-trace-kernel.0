Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039750;
	b=bT3LVNulc/cAPXrAbQX8eOtha0GzezwxnWByGQHvnllvN3mJobvP0+ILHqWiV+9nQli4
	 oEGFgJas5f7WD9PNHlF7x+PKP0Oxcm0TwptgJUEy8vQBtQQjh46x3e1bp8yFqa9WDHSMy
	 E7exUS3+rsRab8SxDUe9CuOOF8g0VYKWFVW/RSiVwjjAiIFu/hQAtkk6fyg8/AENzL9/k
	 pBPhjJ/KPifee9iLQK6/romLbjfCvti6qODRWEs9Dxl/ZQxByGanWvenijXbvRKht0ANp
	 uFUAYwf6OeTx6zj/7NISSuhmnoZS6aDf2vNIZxawU4vqgQfsruXFjcrF0BDTeYvzJOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039750;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ya6pL5DLSD/HXjM7vyyyoaYE2rbAu1UTNVbNgXkja2U=;
	b=z5uM8wq8p2cpZkrsmmDM+6et5DcFfnHPagV2fv66VRAu9tuKEq6bl59Anfvr/oprprz/
	 j2yLZO8DfML3qN3L2y/oX0Dp4hfgbQCbab0wiNsTPbp3/ak2/EGZNy43bIuy66HvIdPjd
	 s9NRw42MYNR3D6t/uYGacDKOVkDNb/JpnG2n6HAl5ZYUhC2epHv2V92ervVRrTnz+J1Y1
	 EdEwkURgpus366bjFfqIMTVWG9QaQNx3aksNZjjf3/37C4lMfdPZ77yYj4mgXnxd519QA
	 OpTbD73hm0fJLdRjgRUGrCLhPizf5Mu7Shepq87HsrRS5hzyD6zW3Mptdxtmxf374HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CWjjGeyM;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7660A5BDF;
	Mon, 26 Oct 2026 18:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B7660A5BDF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CWjjGeyM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039749; x=1824575749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RbyJaYvRHpjtgPeYHGFm3gn6UtbJiN2tV9VK1Y/Iyjw=;
  b=CWjjGeyMIGqsYSobRITZHLZgJE+Fh09Jk0ohABAMcx3P6idwJOOZjTz6
   3PFC4YZ9edA+m4rzPNZzIdeKn73jd9gk3nUjIjDJAUFfxTECtUTw3BJqH
   D1F39gNJpgW4cZ77HnXd4+L+4iHmB2YRDMQhNCMAcfLcCbDsE7gnHDXCb
   SSZSfqqI5/CoHIXdojV6E9qWgA/QUKWMQ2wCdbsCBTayLnnAYw4INpQIs
   NniHN691fyOjw+0B84veVqlsldETdYOg++2BOjM9DAcnZ/OdB9EHU5h1k
   YxZTaXulu8z3HJ5Mi5+d/jvLcSokf13fItW8RiEMFdImeJBS4ZfJmibsA
   A==;
X-CSE-ConnectionGUID: 03KvtXjVRjGHAZuPNkkQUQ==
X-CSE-MsgGUID: SqOZ6FaDTtuYJSvmmIPbeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731578"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731578"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:38 -0700
X-CSE-ConnectionGUID: vJMInCRRRY22cYY2GKrdqA==
X-CSE-MsgGUID: EoDXtdFARy+qS1wgJffBxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293917"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:38 -0700
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
Subject: [PATCH 17/17] Documentation/ABI: Update IFS ABI doc
Date: Mon, 26 Oct 2026 11:38:20 -0700
Message-ID: <20261026183820.129459-18-ehab.ababneh@intel.com>
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

Add documentation for the new sysfs interfaces {status, details,
additional_details, cpus_ran}_list.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 .../ABI/testing/sysfs-platform-intel-ifs      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 76770648e63e..dc33d8f62c3f 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -53,3 +53,27 @@ Description:	Write a number to load an IFS test image.
 		Reading the file will provide the suffix of the currently loaded IFS test image.
 		This file is present only for device instances where a test image is applicable.
 Devices:	intel_ifs_0
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/cpus_ran_list
+Date:		Mar 3 2025
+Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
+Description:	The CPU list of the last test. These CPUs share the same SCAN test engine.
+Devices:	intel_ifs_0
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/status_list
+Date:		Mar 3 2025
+Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
+Description:	The status list of the last test for CPUs sharing the same SCAN test engine.
+Devices:	intel_ifs_0
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/details_list
+Date:		Mar 3 2025
+Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
+Description:	The detail status list of the last test for CPUs sharing the same SCAN test engine.
+Devices:	intel_ifs_0
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/addnl_details_list
+Date:		Mar 3 2025
+Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
+Description:	The additional detail status list of the last test for CPUs sharing the same SCAN test engine.
+Devices:	intel_ifs_0
-- 
2.43.0

