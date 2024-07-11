Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34A2F5A;
	Thu, 11 Jul 2024 00:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720656180; cv=none; b=WrV2begVNAdqCvINv8BunfGZc6U4KzLcsHDVMK5EVmsRp/9hkf2+guN1wD8j3cTkxG+wzMXLbkJuG1pD7oJEQzA5fyY2vVlBgYuCY+5i16c5v+EZ72wXEsUQCednYlLP2LyZwotXRjmPKt8Q+huQRiDC8gFStlXTYOluVgrSzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720656180; c=relaxed/simple;
	bh=QXI6mesmLC2LdoII6Znd1npv05vdgiUMxWfcK42xfs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtOMkf9kXS1QTEJG/V/4Cptr58DHEpzJl46kIhQHNrqYXAR72mZPDO3rrVI2mk/9Jbmdt/fYFMRsWyvOGVDJlor3/lWhUOoHTx/g5qdymOEaFDv2HANe07s+71R3xstkM6WTG63Q2XzehmLkNzokXkEdOf9XAmAYbbxVin2uSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzwGwTjt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzwGwTjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720656178; x=1752192178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QXI6mesmLC2LdoII6Znd1npv05vdgiUMxWfcK42xfs8=;
  b=hzwGwTjtoLts3nLxqfYc80g1nzgKEgn5ZGx/7UMP+XNIT+Q1ZS0DcHwp
   YQsl9zhgybhki7T7VVvfLaDabD5DLrpcAFXElanpfK4mFNAaP1sxBx0+T
   IA8BgIXVlsTZXddL4VuXDL7mpwXXJHFoJbuA2HUOXAaScAvEffHqQlPPh
   wyZyOhL8DgPVnIldA9IblSgUZUhs32tuEIpfhJ9FX7pwHgF07XhUQuNbX
   oTXZG5vZwv0+5azTxh5IB6Jdde0E7P6zjWyy15G+Av9Yn+C3G8sulX93R
   elKSZMCeppo8K7TpdK+CcKa1EDYdw17QCGs6WM/0fMfIhRZyNGV4csWOc
   g==;
X-CSE-ConnectionGUID: 4/VyoFkSTvKqbQGFVJtTAg==
X-CSE-MsgGUID: lkOLwbjSTV+bO52LmYlvBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18153756"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18153756"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:02:55 -0700
X-CSE-ConnectionGUID: fa6Zsf+kQgSaGCR1V8T/RA==
X-CSE-MsgGUID: oZgpY/OzR1yjz0OmGdvjNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48349933"
Received: from cmdeoliv-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.125.109.234])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:02:52 -0700
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
Subject: [PATCH v2 4/4] trace: platform/x86/intel/ifs: Add SBAF trace support
Date: Wed, 10 Jul 2024 17:02:33 -0700
Message-Id: <20240711000233.684642-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
index a812ec7761b9..2ec9a8c93d04 100644
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

