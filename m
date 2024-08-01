Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D226143758;
	Thu,  1 Aug 2024 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722489653; cv=none; b=UW+/GNvr3XfMUgp3Cj/b7+02IyVzhRudo6IAu4o6lbt/BwZ+WXgFDYd0N8GKD11QnVrcixSUCTdVyxT+EmRjdMu63EIb05VA81n9QOxMoSDgt9SnO58Jkt9XUlGw5ui+t06bnh2YAsib77H+4OedKAbDJePhs3k9nrMB7E79jWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722489653; c=relaxed/simple;
	bh=1ct1zzpZpQ5/mKSr4UvvDbKaJaYWHq6GH4YiIwYrPqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPdZuXRBhM+G76Vd8NBSxXW3q69RMv0YFdPIG6tXVS4Aa9Qk3TDhNEbwshFs9bZa8g+/YpEKbSf8L1YwS7gvVgOHx3rhDmqcsk7pQ++uuxM5BtMAON5wjwSmugW4pjbf5efW1A9/wN2Isu83t8jjgRMt4vgHC3rZ+V2VKDN/WSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjhCvo8a; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjhCvo8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722489652; x=1754025652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ct1zzpZpQ5/mKSr4UvvDbKaJaYWHq6GH4YiIwYrPqQ=;
  b=PjhCvo8aLb3udrAY7WgdqBpqdwaeJfaTnzmtLr4LwpNpJkFeEjdqy0Wx
   zrsVK52JtSXR9tN6julDVP6PhEF76H/9HCuHUg2vNRgVZudco/r+PHd+m
   Q1xHOp6AEYq3UfW7C/p1QAkp+7c7TwmXis5ugJMNUPqUyI72zwT3oMHyn
   rO5C6i3s8jHrgroB8SUVIRa8ZR1WQD1PP7dl4rDQSV0w03mw4K7HMOZr7
   SG2RGDG1awpDE/cneWHDVf/C+WpYx/fuDVstUbKkJTgV1fRTot6WACXZE
   1JJOBD5eP4ljJq7fJyVDrguSEHTxWACyr5otNhXotXnOAMpEhNHyQ3kRM
   g==;
X-CSE-ConnectionGUID: 6KrON7wYTmmORa+0viDJLw==
X-CSE-MsgGUID: S5oG7K3bTaqu9u6o6Xp2hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="12821738"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="12821738"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 22:20:47 -0700
X-CSE-ConnectionGUID: k1wdMx6bTaKrvNkSbb8vHA==
X-CSE-MsgGUID: MYMCFPHkT6uDpbunYs04FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59951375"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 22:20:46 -0700
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
	Shankar Ravi V <ravi.v.shankar@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] trace: platform/x86/intel/ifs: Add SBAF trace support
Date: Thu,  1 Aug 2024 05:18:14 +0000
Message-Id: <20240801051814.1935149-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801051814.1935149-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240801051814.1935149-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jithu Joseph <jithu.joseph@intel.com>

Add tracing support for the SBAF IFS tests, which may be useful for
debugging systems that fail these tests. Log details like test content
batch number, SBAF bundle ID, program index and the exact errors or
warnings encountered by each HT thread during the test.

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 include/trace/events/intel_ifs.h         | 27 ++++++++++++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c |  1 +
 2 files changed, 28 insertions(+)

diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
index 0d88ebf2c980..70323acde1de 100644
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
+		__field(	u64,	status	)
+		__field(	int,	batch	)
+		__field(	u16,	bundle	)
+		__field(	u16,	pgm	)
+	),
+
+	TP_fast_assign(
+		__entry->status	= status.data;
+		__entry->batch	= batch;
+		__entry->bundle	= activate.bundle_idx;
+		__entry->pgm	= activate.pgm_idx;
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
index 2a37f009d0b3..7670fc89153d 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -528,6 +528,7 @@ static int dosbaf(void *data)
 	 */
 	wrmsrl(MSR_ACTIVATE_SBAF, run_params->activate->data);
 	rdmsrl(MSR_SBAF_STATUS, status.data);
+	trace_ifs_sbaf(ifsd->cur_batch, *run_params->activate, status);
 
 	/* Pass back the result of the test */
 	if (cpu == first)
-- 
2.25.1

