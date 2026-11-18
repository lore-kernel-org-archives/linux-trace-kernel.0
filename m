Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030231;
	b=QSgCzVU9UeydlpIrQvvntqBpwcFsIt+ZVeyWl7Pt++B69RoMFyinWIouxVnHwxRSt8Jr
	 fsG9k4D4VZj6SAWhFvJjsvvtwwGIIsEbeSlrBXRKukjRxSpmHLVyXZ5KjsMTmbSJQsaJu
	 lBVg1MHypbaE/6FjwCJSQc8B29swdeSnqt5x12q8BhRT7C2jAkCpuFMFtYqQt9TFj9vvF
	 k+qCGacNR3LVKSdTKGBWLvd5YUULYEkHbxWosai86vWnw0nJj3Lh369x8WdzJG5kMKwrO
	 F6aSQCWLpcCnVSJywGg+1cRZh+bT0pfJkz1K3iED8ddkcyM0Otg8X91RYe2Om7S2xbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030231;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VGDs3kU3f20OjjTBwCDUx/cpJCUY1HK2f+BLKDWgijc=;
	b=xzQz699sVztBgZELxr2l/bJWOMKqOqyqqJgoKmfAUUKDdX+mtYXaV3t6l/rtep/932R5
	 Di9myxbDQb9xQNTVbvLzYBunmFE8Mby3es4mSUNARRZLVkPVsgQUIawD9AqxBbPoHPR6v
	 tufxjhUnS3y8eeae/P/fnyiVAbk+M7QRxPtbbPYC5BCGc/muBKA30Bzw7vTVpxnEY/WDU
	 hRdzOxnJ4kHFVpW7Y5yLCRpK8k86P2ZsBweCMLOatOmNpV/Xv2I7BUo+fxh1vTk/Zpr/Y
	 JrTcj0XYyyjiVW86ABLmAawHw8goJoTocejTwaOE00KkgkkvhXRScPRhx8Lajs9XQmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NmWvI4zt;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DBC60A5BD5;
	Wed, 18 Nov 2026 19:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07DBC60A5BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NmWvI4zt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030231; x=1826566231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQfcaLKg9dWaMZCvauGLK9QonhIzsdvCLLnn+a/SGOU=;
  b=NmWvI4ztnMtKH6MWdk8U/LvEd0RoF68+AV6fQKFeO/35a1qD7zd3f9OA
   elbHVtWO8yexrKUrqnwmp++63TIeyPzm9fYZweQiY4FROy8fMlCzfVk+0
   POtBikx+32kKYEUrcfvUIQicO5UXpMAF/YNhMOYzUCrwHpYyp8tnci3S+
   35hRVy09MJCPOtoe+QJEk8qYamz1M1D09AfsUsMZXleyJkSWQXFmJUTmF
   Ul6yy3x150hJOsVUpGX59xTsDRIZnBX9CBal7fEtY4HPIaCbIdv1o6wNc
   8LUWUErYvnHudDrN+f0dHIBFuUfH0pXQLZCQX2hE9gVYF7x+/eg4qQrJ3
   Q==;
X-CSE-ConnectionGUID: W2hCcsAQR/uEe63IiZGm5A==
X-CSE-MsgGUID: mAVk0CUJQkCFPSXjWXIsPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781309"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781309"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:30 -0800
X-CSE-ConnectionGUID: dYHodO/OQPmhxBU+pr6TGw==
X-CSE-MsgGUID: qGpqgkQJSXKv+EjgASJQSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468128"
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
Subject: [PATCH v2 14/17] platform/x86/intel/ifs: Add Intel Diamond Rapids server support
Date: Wed, 18 Nov 2026 12:32:56 -0700
Message-ID: <20261118193259.519568-15-ehab.ababneh@intel.com>
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

Intel Diamond Rapids CPU is a Dual-Core Module (DCM) based system
where two cores in a module form a group that must simultaneously
run the In-Field Scan (IFS) testing. The intel_ifs driver already
supports IFS for this type of DCM-based system. Add the Diamond
Rapids CPU model ID for IFS support.

[ Qiuxu: wrote the commit message. ]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/platform/x86/intel/ifs/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index e019c986ac0d..917ca5429073 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -22,6 +22,7 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 	X86_MATCH(INTEL_GRANITERAPIDS_D, ARRAY_GEN0),
 	X86_MATCH(INTEL_ATOM_CRESTMONT_X, ARRAY_GEN1),
 	X86_MATCH(INTEL_ATOM_DARKMONT_X, ARRAY_GEN1),
+	X86_MATCH(INTEL_DIAMONDRAPIDS_X, ARRAY_GEN0),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
-- 
2.43.0

