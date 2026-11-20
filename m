Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197281;
	b=K8BbDIBHIMt9MEnPe7ijDWDejIkSHhMKZRDiS+CjdZPr7JxYBAy2OPJK/XfHoWeukwnE
	 S4iLwA9C3YIqTt2f5Oq5o9jCzV59KkbfhrLgYh7RCT6D2v12IptFhkaC0lMGWD7CrsTnX
	 bRgLyQQv4rDT3/WkDTrWn3KRlMiGyJlPHJ/FIy1wWgzF+zgHKcd+cpqN0Ai9iEA2zFzwe
	 tGixKLBnPSIvLZnYbJbYzZe32cHpfp8K7N3TQTMfc2uMGCVeRoFNGx3/hWwGyM9Kr3qvf
	 xco0hutulkU9mgnk0Xaf7i3/kCkZTmJQ/Ri+ZHxvzvQ4SS5htGQvQF9Afi/th6gTyuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197281;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RQE2y430F4QFZdqDVWQlA5DbfJfk1Y9f7ww+035mR2A=;
	b=MrwNaMkq8SY89H3sPQ/t8Ex3U0/Akh9oTXZ896b/YWpmVbON+QUJu78zm19BL/2Dh6NS
	 FRwcmfYKIU2LLKuWgyMd1sAlToJLxBAxpy+BlMSeda8eN1g3/wxhIGIPhkII4Ktz5neDc
	 7QN3JGZXmMTWGS4BL5OfhZiX2kFss9c4dRgyyMvI/N+DyCEe8oG9dxX/c5SfAK11vpL/P
	 QRIFBTXq5YvBviwFTPXTZR7F8xUjFh9BbHG94lixA6IvEty39YVP2nBCrHU58NpmW4Qyj
	 ML5TUyfGnuS2dTDu3YdJ5zYIMnHDU9Hi+3XeL+JNPFVuAGBIi7IO1nCsy7pGRALx95g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fJEkI6cO;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E539606E74C;
	Fri, 20 Nov 2026 17:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E539606E74C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fJEkI6cO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197281; x=1826733281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bplOvcD7EbJ7PXLZmN5d4oIe+bw+vEcUPGo8mKzDe88=;
  b=fJEkI6cOQ6BfGtii5k+ISGVEimj7CML7wMHyktqyZ8wymfw+YSyevyCr
   stzsGYUpM0C709i5J0kL3cjikYxrQrQe1GWW+cuAjVBfGHQIqoHimSoyu
   7oBuJ2ZQ2xnhhAz+lXOj2r13yisnpqZ3FCkxB6hwOX7uTxNa233a0Inw1
   h//jdr+DgZuVRcCNfz3MNiPw8F2FmMj4Hne6X770FekFABWHYNlGzADco
   pcmpIAJpctiMim3TcrwI1MxXPGra2M6zk1U6iQnnJ2dRl0RkjH8KpxoNi
   GgtODXdK80bRqMVOiGkFlhTR0AbX755xY2QSQKIvOEYFv0bar5Tl1FU8l
   g==;
X-CSE-ConnectionGUID: DkSDX5hqQA6p3Zj0MfQ6tg==
X-CSE-MsgGUID: MPV17LRDTNaLuMxLv3E9YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4109041"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4109041"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:29 -0800
X-CSE-ConnectionGUID: Y62PtoUMQVS/NtjU6chbtg==
X-CSE-MsgGUID: 0hMMFegoQzuMJGZExijqaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171103"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:29 -0800
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
Subject: [PATCH v3 17/17] Documentation/ABI: Update IFS ABI doc
Date: Fri, 20 Nov 2026 10:56:58 -0700
Message-ID: <20261120175658.1147030-18-ehab.ababneh@intel.com>
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

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Add documentation for the new sysfs interfaces {status, details,
additional_details, cpus_ran}_list.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 .../ABI/testing/sysfs-platform-intel-ifs      | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 2b922c2cd821..519ad83a89f9 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -22,6 +22,10 @@ KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	The status of the last test. It can be one of "pass", "fail"
 		or "untested".
+		When the test ran on a group of CPUs (see cpus_ran_list), it
+		is "pass" only if all of them passed. Otherwise it is "fail"
+		if any CPU failed, or "untested" if any CPU was not fully
+		tested. status_list shows the result of each CPU.
 Devices:	all
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/details
@@ -31,6 +35,8 @@ Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
 Description:	Additional information regarding the last test. The details file reports
 		the hex value of the STATUS MSR for this test. Note that the error_code field
 		may contain driver defined software code not defined in the Intel SDM.
+		When a group test did not pass, the details are for the first
+		CPU with the reported status (see details_list).
 Devices:	all
 
 What:		/sys/devices/virtual/misc/intel_ifs_<N>/image_version
@@ -56,3 +62,31 @@ Description:	Write a number to load an IFS test image.
 		Reading the file will provide the suffix of the currently loaded IFS test image.
 		This file is present only for device instances where a test image is applicable.
 Devices:	intel_ifs_0
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/cpus_ran_list
+Date:		Mar 3 2025
+Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
+Description:	The CPU list of the last test. These CPUs share the same SCAN
+		test engine.
+Devices:	intel_ifs_0
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/status_list
+Date:		Mar 3 2025
+Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
+Description:	The status list of the last test for CPUs sharing the same
+		SCAN test engine.
+Devices:	intel_ifs_0
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/details_list
+Date:		Mar 3 2025
+Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
+Description:	The detail status list of the last test for CPUs sharing the
+		same SCAN test engine.
+Devices:	intel_ifs_0
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/addnl_details_list
+Date:		Mar 3 2025
+Contact:	"Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
+Description:	The additional detail status list of the last test for CPUs
+		sharing the same SCAN test engine.
+Devices:	intel_ifs_0
-- 
2.43.0

