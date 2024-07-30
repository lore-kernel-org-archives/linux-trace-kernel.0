Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298741BF323;
	Tue, 30 Jul 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355227; cv=none; b=DLrVw1EjZxTzdPZUMeB6d8izvACTJtnzrv62nrWJBCAsBT0qjs+khF1UQN51bp0omZ8pyfUTMlFATUdaRAmdiwnovh6O5v99O01okkfTkUxBHoV2jGC7cnvx+nN+q+TjidyEy7fbdGHR+GI0m1VnSGn4vbx6rPxA7+mOtE16l58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355227; c=relaxed/simple;
	bh=7kEFzKvb+2kvsc9DM4YMRT7BQ4fgSkAEYz8Cpv71pXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BunnfjWG0POCP2CaxoRkCgWIT4HHISWMhna7DEGXcr3ycIhBHJYHvATRufXW+9iZie1PqQDdASWhJzVLLCpESmKlwxFtVu4hsfVI3zizlkTpgg85tb5yv/R9qLrig0Qm/vyhpFttxraxPvAS4CLVfQkIanS0IliX1wRYSm2zcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkGS4vDs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkGS4vDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722355225; x=1753891225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7kEFzKvb+2kvsc9DM4YMRT7BQ4fgSkAEYz8Cpv71pXM=;
  b=ZkGS4vDsLGrXMx48ksniEbU5u/J7P7a1TB6KO2z5itEn40JIEwEmxUb8
   2bwdqJgQL2mnkwHykatgRRp0M6D0oYJx4L56TiQvafiN3wR5RIliulOxp
   2BMUY7ncJIpvcCaUUAZZHcNGL7Z02h0G04Q8UCpOwgWXcXF5NhOoiZAet
   RxXlgYYX4SrvMFOiCpVsDOHkef0D2LtvmakGL96XRBv9Lhqv48ZEZHbS1
   ogKhTutHUYiewRSw4n3vfdkhpwaUiBlZrMbYJI+ymX7bL72gSyirsBpIK
   vBIzXmL7yVWYwg+Vg1uMd8Ozri4sljkDIAv1oZZrOjRQnxnaHCG0j/z99
   A==;
X-CSE-ConnectionGUID: r8Wws8yuSm6u60CvVBMhag==
X-CSE-MsgGUID: HFwXCAZ/TYWiNjfr1lQVXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20339525"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20339525"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 09:00:25 -0700
X-CSE-ConnectionGUID: ODccXaP/TlGGmR+xvfhqNw==
X-CSE-MsgGUID: z3M9hNmPTEC1LOFE7iu5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="59231322"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 09:00:24 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jithu Joseph <jithu.joseph@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: [PATCH v1] platform/x86/intel/ifs: trace: Avoid hole in ifs_status trace struct
Date: Tue, 30 Jul 2024 15:57:58 +0000
Message-Id: <20240730155758.1754419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rearrange the ifs_status trace struct members to eliminate a 4-byte
alignment hole. It reduces memory overhead.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 include/trace/events/intel_ifs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
index 0d88ebf2c980..32e9532e954e 100644
--- a/include/trace/events/intel_ifs.h
+++ b/include/trace/events/intel_ifs.h
@@ -15,8 +15,8 @@ TRACE_EVENT(ifs_status,
 	TP_ARGS(batch, start, stop, status),
 
 	TP_STRUCT__entry(
-		__field(	int,	batch	)
 		__field(	u64,	status	)
+		__field(	int,	batch	)
 		__field(	u16,	start	)
 		__field(	u16,	stop	)
 	),
-- 
2.25.1

