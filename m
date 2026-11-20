Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197281;
	b=B6WrWfLR43HPNca/C2WjlWqqae9XkFvHHQMjidkiauFsTGcHUXIVu7v8tzHEj+v/E11L
	 I/0ahtH4zFEl3DcJKL1EPATbiBBVJZHYZ5nZUWR8u7wq2UjKhJ3DZLcIa9zWUxyBZkwNS
	 2vS+iGy/2yKQx+XgVW3L3txfRuO0R0eTJfcCBIROQF8bYJsJM6fdjeFGqUlnCBiigNlfO
	 xOKoZH+xHB1XPhwh3pBQiGElIN5lnuAVmI4w40F1on8qFgvWCy3h6jlsspql7ag6hZvSL
	 HkAqpNlkl3bKVPnlw/ecoYx56tifq+OQoVhHee3qgo2vUpFqPYWT5Rf74+q6LDN4bWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197281;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T6+rhEPEcvhiRLD7RzSkOEq9TmenfUVOqBI3e6kNHHs=;
	b=kX4skHQupG4ZSj1kfFeDfZ2rvhMDzCqmT46+o5RcdLsfZ0ikTMmsPgyfAOtjspsdI3Az
	 4Qs5E8pBxXkxQNKWSAH0eiAaaQhmElR1yz3SizSZVFKmC4yp+I8yXH2jFzbgRs04XzQ0n
	 07RjN+NssD3GLL3wEkreGfgqeFO2CEAyW+5gFWRTrTifUcQgSuLi/Dgkqu/LVtlUZfnn7
	 CXxJo4ev3j42llQ0Fz42Ufujzq6YExR4GXmCbI5BgqkMu/S6mX58RAwq/eTNEiLomL1fW
	 9olF7ijp+Dnk5+G8ET++p/ZIBlM6I4TMwrcFQQPxnR3pe3iuqFblLs+FhvTV3KpRSjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CVJUQMEC;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73460A6F5F;
	Fri, 20 Nov 2026 17:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C73460A6F5F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CVJUQMEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197279; x=1826733279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P7C5+FrqUMCVz5G6CdHeaSCfovjilj4kmJEHrSwsk10=;
  b=CVJUQMEC/NJKCvlXPw6oiIrxZ9+/+zATc9kjg1nJGqo2qgLB4VND/yyU
   uVuAfuMALmBUzzhu15cfFbXyOnd2IlAdaTxBdSLIJfYdF+oAW1lI9z4EI
   a+D+39UkM07p6KMwYPOarL+Fwrz0bPobSPNENFUjURfk5J8ZUE9Bu1m4/
   jJWpAIWGOx5bqxNUHxGHjcnqVH8qra4eQgz/Hsfl7604rKqFVAM/lCoZ9
   VleGfoOWbTp7KHe/GW2jAOFo8SCW/6PVfuu33coRjAI7EdVParxTbpOOC
   6JvC3yfjBfPbL+KrcOQAVQrKntTVPw8P1ht8KWBrvgq3SXftxOXrTJ7dP
   Q==;
X-CSE-ConnectionGUID: zPmr5NB8RzCxgbqsFOCyCA==
X-CSE-MsgGUID: yIzzMww5ScyYgVmLwkbqpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4109022"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4109022"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:28 -0800
X-CSE-ConnectionGUID: 3pTYYCfIT7idc/32fioGCQ==
X-CSE-MsgGUID: vxS7F5+wRzmADS/MXLwHBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171091"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:28 -0800
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
Subject: [PATCH v3 15/17] platform/x86/intel/ifs: Remove limit on number of batch files
Date: Fri, 20 Nov 2026 10:56:56 -0700
Message-ID: <20261120175658.1147030-16-ehab.ababneh@intel.com>
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

From: Tony Luck <tony.luck@intel.com>

Writing to the current_batch sysfs file rejects batch numbers above
0xff. That limit was expected to be enough, but Diamond Rapids needs
more than 256 IFS test image (batch) files.

Remove the limit check on the batch number supplied by the user.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-intel-ifs | 10 +++++++---
 drivers/platform/x86/intel/ifs/sysfs.c             |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 11cd2f412d81..2b922c2cd821 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -46,9 +46,13 @@ What:		/sys/devices/virtual/misc/intel_ifs_<N>/current_batch
 Date:		Nov 16 2022
 KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
-Description:	Write a number less than or equal to 0xff to load an IFS test image.
-		The number written treated as the 2 digit suffix in the following file name:
-		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
+Description:	Write a number to load an IFS test image.
+		The number written is used as the <batch> suffix in the
+		following file name:
+		/lib/firmware/intel/ifs_<N>/ff-mm-ss-<batch>.scan
+		where ff, mm and ss are the CPU family, model and stepping,
+		and <batch> is the number written, in lowercase hex,
+		zero-padded to at least 2 digits (e.g. 02, ff, 100).
 		Reading the file will provide the suffix of the currently loaded IFS test image.
 		This file is present only for device instances where a test image is applicable.
 Devices:	intel_ifs_0
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 917de0efdeef..5dffe584d6f7 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -91,7 +91,7 @@ static ssize_t current_batch_store(struct device *dev,
 	int rc;
 
 	rc = kstrtouint(buf, 0, &cur_batch);
-	if (rc < 0 || cur_batch > 0xff)
+	if (rc < 0)
 		return -EINVAL;
 
 	if (down_interruptible(&ifs_sem))
-- 
2.43.0

