Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63854C8E9;
	Thu, 27 Jun 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455869; cv=none; b=VF05Mb8YubJ8h36pazkaZoS4j4uZThLLgxTd/ILj3sy+oj6pdLARahkOJfBm7uZ5qPA/QNDa/HQd3Kt32Ya0EBp/VbEn9EMXkzMvX+il08/NndSP8tYgETL5Dnfeb/3quPqXDNl49VQxgadBljOU3szR17SdRFI7IxFiN+RepUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455869; c=relaxed/simple;
	bh=OBp+67Tvck2axK2SJa+el04tfq6pZcR+s8OZwOZk3kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pim7PoI7LUCZD049npoWWpr3MNz3hS4XGta2IMRSwljv7WbWsIvb4bAAQPXYbszoo+I7jrnMh3h/F36QgcsanD4p3ZyjqUvMmZU0/drw4w5q9u8Se0kw5+wlyKBJ9JUNpzOqt5qq1Znbt72HDH0h8QCy0lv0jr+dyv1mtVR2HrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yad25XLh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yad25XLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719455869; x=1750991869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OBp+67Tvck2axK2SJa+el04tfq6pZcR+s8OZwOZk3kk=;
  b=Yad25XLhDsbSYxga5jkeZC0aT16s3a2sTgdpyAC0zfyAVLFX0X+KE8W8
   u9e0MpSRJ/xJEJVpNQ0T6bd4eZ2jVMxUuRiKuuZbh5PIIP8DgQUe+0IHk
   ZgTsHnPqWSEKFsZFCvmfi9VygBLK5j8c6WleGIoZLDqeLMBlU3l0xJaye
   9/mw1qXCnFKo0uqs6FZRi8H86BDopQzf6v8wh8dTLIhWKRzEpOWwhaY7a
   BndcrBv/1l36jI8IXkKBOzFUu8XVLLqy8RNJDiUCHAU1b5apDyEwujsGg
   8YGLPAoVL2cDnRKd5NWgph/iY41jTYyeKdQromy7PLYSDuv6u8yItDBjW
   Q==;
X-CSE-ConnectionGUID: VQrv2AF6TmuGO/HxNbEDxg==
X-CSE-MsgGUID: 4/QNs9bARle7etXL9Va4xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27959510"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="27959510"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:37:46 -0700
X-CSE-ConnectionGUID: 4B/p0t/eT2qrK5FbWTuXsw==
X-CSE-MsgGUID: RUbKdxMAQJa9wwjwL77omg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44052408"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:37:45 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Jithu Joseph <jithu.joseph@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ashok Raj <ashok.raj@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-trace-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: [PATCH v1 4/4] trace: platform/x86/intel/ifs: Add SBAF trace support
Date: Thu, 27 Jun 2024 02:35:16 +0000
Message-Id: <20240627023516.3783454-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jithu Joseph <jithu.joseph@intel.com>

Add tracing support for the SBAF IFS tests, which may be useful for
debugging systems that fail these tests. Log details like test content
batch number, SBAF bundle ID, program index and the exact errors or
warnings encountered by each HT thread during the test.

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 include/trace/events/intel_ifs.h         | 27 ++++++++++++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c |  1 +
 2 files changed, 28 insertions(+)

diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
index 0d88ebf2c980..9c7413de432b 100644
--- a/include/trace/events/intel_ifs.h
+++ b/include/trace/events/intel_ifs.h
@@ -35,6 +35,33 @@ TRACE_EVENT(ifs_status,
 		__entry->status)
 );
 
+TRACE_EVENT(ifs_sbaf,
+
+	TP_PROTO(int batch, union ifs_sbaf activate, union ifs_sbaf_status status),
+
+	TP_ARGS(batch, activate, status),
+
+	TP_STRUCT__entry(
+		__field(	int,	batch	)
+		__field(	u64,	status	)
+		__field(	u16,	bundle	)
+		__field(	u16,	pgm	)
+	),
+
+	TP_fast_assign(
+		__entry->batch	= batch;
+		__entry->bundle	= activate.bundle_idx;
+		__entry->pgm	= activate.pgm_idx;
+		__entry->status	= status.data;
+	),
+
+	TP_printk("batch: 0x%.2x, bundle_idx: 0x%.4x, pgm_idx: 0x%.4x, status: 0x%.16llx",
+		__entry->batch,
+		__entry->bundle,
+		__entry->pgm,
+		__entry->status)
+);
+
 #endif /* _TRACE_IFS_H */
 
 /* This part must be outside protection */
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index bdb31b2f45b4..69ee0eb72025 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -530,6 +530,7 @@ static int dosbaf(void *data)
 	 */
 	wrmsrl(MSR_ACTIVATE_SBAF, run_params->activate->data);
 	rdmsrl(MSR_SBAF_STATUS, status.data);
+	trace_ifs_sbaf(ifsd->cur_batch, *run_params->activate, status);
 
 	/* Pass back the result of the test */
 	if (cpu == first)
-- 
2.25.1

