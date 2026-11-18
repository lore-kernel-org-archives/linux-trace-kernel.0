Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030233;
	b=S71Ydic8zafyn+3svS+ge/yoHkaZTinaWzJGWHD/zxPIFBtBFNhFeB7/7JF8g1OFqEd6
	 Ba6Bpn0S1gVikMoNKp/H2KDrw4OihhInR+giPzb+dVIxXGtoLmJkwCORKNLMLaSEYVGGk
	 tIU7SusJCsGyUOJKEjGaRV8yNXW/EA5p0Gzvu4t3HTgB9TN+8yQ2HOYLMq/eFqgLGwLYZ
	 nS9wRWeCrByth6s5tEI3miY0v9r8HK04HhN/rRGi0qU94kdqJbri3YB2CQ0o/nJZHdgr/
	 g4ijW4ijBP/lBIiyu9rsRZZMtN41Pbz2E3T782ACJbrkzFFeM/dW9jILO8lnipiUJ8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030233;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cQewTEPkyw3kp2h4gFNFMrGHZf8DZcx9qy/D0pmnsIs=;
	b=Cq1endBqNfMUNKiUxZOsMvU1KK0g44/9k8+qe4zg3uQcRJna3o8dInuv8X+DQCtVCNHA
	 BfYbQ7byKjs/8gYrDFaCiHCYszDqxoRrhmvRFkOkWTkaQj33yReFIOA0v3l1vYGJG21qy
	 nIHzBCC/ZD/R+fDQJCNojNp9VTJQf76KbSVtHUVKE5w8eH86eultrnfE0VrVGMSBazZBH
	 tQKF8ImsAN0B7R0wbxFQwdsw3WqqDcqQfyGnhuKD5PtiMpebzOicp2NBnfd4HdvUj0HPK
	 9K/cMSyq7uHd1StSp4xiA2u16j3i65LR94stpJICmZZHzzUYr8Kiazsw1yC3HZUVS7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TNiq3BMe;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF1607E736;
	Wed, 18 Nov 2026 19:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4CF1607E736
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TNiq3BMe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030233; x=1826566233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LTUGA8xEweZcU7WiZm0D/WHFEi8lEi/5EaGm3yu1zbo=;
  b=TNiq3BMe0a8oe2BRGkzv3Fm/YHugvWamSdK4OVtVYSpeDTTltYtYrn7K
   LxCVQFx54/aL1ar+QgNgQwvMeOQmIfSEEgF5qn0UV58m/srS9ggYyUntk
   7QtzjlkOdWIhNfM2UY9SRTyti+r0rTUFMGZgKcKoYAIpD+BJg3kaY2mU8
   oOu+ikb1udzsCA1Zl9ppTNiUeoRmD5RGLG5qo2sFYwCO7Ckb27YBM3gRM
   iTDkS4TwlU/pX2e1uytyOJIHr+OTw6YC4++IIPRBE05Dow7n7mBPY19rP
   pYoWdnZq8wdXrLRFQzJwDf5qplOIAxDGcNXQs4n++WvldlnmQsYwfSSv+
   w==;
X-CSE-ConnectionGUID: DQE4UO08T9GgSfgmuds3OQ==
X-CSE-MsgGUID: aZNAI1f1TleSoqBqKLig6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781339"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781339"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:32 -0800
X-CSE-ConnectionGUID: 3woM+pWmTc+RhWlzlPSYQQ==
X-CSE-MsgGUID: 8s4MjzydRf69kXp3jckphA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468139"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:31 -0800
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
Subject: [PATCH v2 17/17] Documentation/ABI: Update IFS ABI doc
Date: Wed, 18 Nov 2026 12:32:59 -0700
Message-ID: <20261118193259.519568-18-ehab.ababneh@intel.com>
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

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Add documentation for the new sysfs interfaces {status, details,
additional_details, cpus_ran}_list.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 .../ABI/testing/sysfs-platform-intel-ifs      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 22430926ceaa..420de690e9c3 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -55,3 +55,27 @@ Description:	Write a number to load an IFS test image.
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

