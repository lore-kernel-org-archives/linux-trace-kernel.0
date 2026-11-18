Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030231;
	b=qz3J0a08WzvYJve+k6yb569tE4PkyYBxHdUpGKiAH6DQHTUqZZZnW0oSPO/QzU5nvb86
	 PWywV46wvvUxD1i2yzd3SrZ651uoAPK1m7349iiWqrRNfb130f4HtFZoHIWMojra8Nfnn
	 t6gP4SrRajqwFFVDTvdYakFYcaJmPgAUI+YSdJKCguMW/MeGEnWVLNOPXE4oBsAonEgI4
	 Y2VU+/Ww7Cafl/jZTydi2mG10fRGSOaMnm9gNv5nhTCLvqeP8DGCFXSVTnHSHoiu4yP+R
	 +dFObS2bz4ssMIVoUcz7EWhn3SNJ3CMAa0qIX+YmuSJ/w9zfTXufimI4YGTmma8pdXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030231;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jO09XBskkDpbk/KzoSDF2MXrlaEtBxnmQAnn10uJib4=;
	b=2B94LrJGrmxpRGubLp1CJsyAtk4caujT/w3OaTwdd6id/MAPyHzDddvKbEdKU8zL61uI
	 oySVSWTdUzC9jDH6N0G+bE8z/0wEeP99ajFrdsVJaf2in9RHKgV+pQtazpvYeIBDoHfs/
	 K81uX0Gp462O/lVWJ0XvRK7xhEyweqqJkKb4rGP1zEg69Xk3MUNOzez8uMHKKz2RCy5rp
	 eXtgm4UvLBakCrUBLynfo2VKCgcBmuTP1sdBaDHusJxL0kR/MOEG3Qdm7jtQ4P57+ZYia
	 LXZcYbU87Ee9aluNA1bfb+nn8jC7CyDIEpImLTNPTojKtUCJsdxXhAjIv+uz5dJ6hOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E8ui3g5L;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AE660A5BE6;
	Wed, 18 Nov 2026 19:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32AE660A5BE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E8ui3g5L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030231; x=1826566231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N1GZLWe8lJFeg/LwOvudrBIHsGKhEM6gK23TFz2GvQE=;
  b=E8ui3g5L6SqO/melvYvaWeebvBp+YqZWuasZtAeauSTI3rutx6eM93/y
   yQXmx8AMe4Gl4rS3QlYjTnvTf+Ab1kPQxTEjFNtk04nPhFtDNICY+yfxB
   JeXWMoQiIAVPFcjfAJnDsPcJPLAsa3ewBO08fK7ffclQs+YAIxkV9V97j
   1ujkFXWM3nXyKTcTWJq1xPguM05m/Qx4HaVMu68W/PTk7ZZrDGbYoi9GK
   V8qliXWeQ7Uz5rCXVHPwIO8FeWhw8h6Mg4RuwaYO585gviE9OcQ906tNr
   r0DaTRGLRORqnwLid+5Gr42xHkFCKhLSwwHDpZ/tQQybJ/75kaSC4V1aX
   w==;
X-CSE-ConnectionGUID: BZ4FkXItT4q778l90fIegA==
X-CSE-MsgGUID: cCElCTKaTk2HpGH0JGKC4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781321"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781321"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:31 -0800
X-CSE-ConnectionGUID: N7Qa/gTFSN6Fb+fAY8Hu+w==
X-CSE-MsgGUID: iwG5HqsFQtqRRxP8VK1zPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468132"
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
Subject: [PATCH v2 15/17] platform/x86/intel/ifs: Remove limit on number of batch files
Date: Wed, 18 Nov 2026 12:32:57 -0700
Message-ID: <20261118193259.519568-16-ehab.ababneh@intel.com>
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

From: Tony Luck <tony.luck@intel.com>

Writing to the current_batch sysfs file rejects batch numbers above
0xff. That limit was expected to be enough, but Diamond Rapids needs
more than 256 IFS test image (batch) files.

Remove the limit check on the batch number supplied by the user.

[ Qiuxu: Update IFS ABI documentation to reflect the change. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-intel-ifs | 9 ++++++---
 drivers/platform/x86/intel/ifs/sysfs.c             | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 11cd2f412d81..22430926ceaa 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -46,9 +46,12 @@ What:		/sys/devices/virtual/misc/intel_ifs_<N>/current_batch
 Date:		Nov 16 2022
 KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
-Description:	Write a number less than or equal to 0xff to load an IFS test image.
-		The number written treated as the 2 digit suffix in the following file name:
-		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
+Description:	Write a number to load an IFS test image.
+		The number written is used as the <batch> suffix in the following file name:
+		/lib/firmware/intel/ifs_<N>/ff-mm-ss-<batch>.scan
+		where ff, mm and ss are the CPU family, model and stepping, and <batch> is
+		the number written, in lowercase hex, zero-padded to at least 2 digits
+		(e.g. 02, ff, 100).
 		Reading the file will provide the suffix of the currently loaded IFS test image.
 		This file is present only for device instances where a test image is applicable.
 Devices:	intel_ifs_0
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 1a111e6101d8..1a0bfa2a2821 100644
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

