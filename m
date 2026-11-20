Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197279;
	b=yLlzoonMPi/aIA6Q7eeXwy0S82B6J2WLVuD5viJRbLeIpUrXHE7mRVnBLfh/YBM9VSfX
	 ZK3rHogWoofRBnU4nvJtCQMX8t/5FrTBO9Fx/wjF3Z2ddXdRgDW3UQ46cVCD7eVQeYtte
	 iqbzSD5PRNh+oP88xz8hMTqJw+1K9342Ac352TBG8OZH4dV7hpvvFqRvhTHHPHkj88LN5
	 /Po1YSEerleKRShEpDZ1cvz8wy3JJ9zijuMXEDmflmPbrk5jrVBjPJ2rB8eivM9PMmrmo
	 gka0N8FxidLnkVxKVC6PmznTGdhmq/yvIaFHPr7Vh5YVsPzmtSxDp5qFZT0Q+RdUd2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197279;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MOmUZs5qk7yOcZMtFkqkO9BnoJVynhrkjL7ZY1zlFCk=;
	b=TATHOk0NRps8MzsfaDUdqSxPNZZB+c2FVrtUs9KNzUvpiLTxw89GKfbSQgPskniOexsP
	 2UjnxFG6WbAZSTgpti7nk0khLa5Dh9b5LTaLQ2l74Ggu/L7P3oGMMY3tlYEHSQV9yZnyg
	 R7+F6PzHPZG332ojiU1d2NYCaIJmlrlEnJ4JGJXN0Cb3051Rhf9Curfew0lSMkDuNhbrW
	 DQ9LMUAodFH6FXPDSIuJ9LxR7RcREHHu6I1ZHNnWGN1h+kFTNH8jDw1fzrT/rssc5sO2G
	 hnLTlT3eaCencyCWMkn09SUJDeWV+jQIS1WPFcuwre+Fv3/UPuwFkRwZ9gRQLEehheg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O14kuxJ7;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BB60A5BFC;
	Fri, 20 Nov 2026 17:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E8BB60A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O14kuxJ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197278; x=1826733278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+MDTGLJRbJVSQSklCJ9yYpIrlgJ2THGI82CmyYARngY=;
  b=O14kuxJ72rF3/DQI7oqgeNpLdXkyr2plmYC1ryYEpNsQ7E14vkC5nDsQ
   tSpOffsiz2AUFL2nIE3Mtc3QBQCEclLJXubCcfsLXRPwPHj4kp4z5PIiU
   NXa9N7PXxjN/9AyPSMVOEzs3NkrpybUkTwfBr/7fFKEKKJqU5+cEn29sc
   Ws8mKO3IRWU3VX5QXTvzMnAKh9GQJPZ2JS8x5j0KqRf0YiAb5eF0xndM4
   H897RF3lgCQs4A+5nfDLBr9cFIDRzCZ01Ta4Q6BXgqv1fyXM3ffeY9PS9
   +DWfZpbAJocLteHTpgRcqdZuYEHwyrQsMtDyFRcDpx2i5x1BvQUpEFM/X
   g==;
X-CSE-ConnectionGUID: FkEPJSLCSlS3omxLYYXtPg==
X-CSE-MsgGUID: /T2eiymHTom1PXuW3mQASQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4109013"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4109013"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:28 -0800
X-CSE-ConnectionGUID: vitlpc4SRNqhPtM9R9x6Nw==
X-CSE-MsgGUID: 4Zu3R25mSMyfQGThN0WpIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171086"
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
Subject: [PATCH v3 14/17] platform/x86/intel/ifs: Add Intel Diamond Rapids server support
Date: Fri, 20 Nov 2026 10:56:55 -0700
Message-ID: <20261120175658.1147030-15-ehab.ababneh@intel.com>
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

Intel Diamond Rapids CPU is a Dual-Core Module (DCM) based system
where two cores in a module form a group that must simultaneously
run the In-Field Scan (IFS) testing. The intel_ifs driver already
supports IFS for this type of DCM-based system. Add the Diamond
Rapids CPU model ID for IFS support.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/platform/x86/intel/ifs/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 25b7c0f6427e..85b5323cdd2e 100644
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

