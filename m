Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030227;
	b=HRvQ4Auf088+GSxkI6IP12owAxw/FsDk3P3PR7lUVbqDsIIk1B6xE1z+LkObp/ZzH5TX
	 LV/kC0+aU7fhoRPvT420QWy1x5AvWrJypommFi2jFZRX+TxuoDTyQU1fEzO6vQJtCVFyR
	 70CfN/p0jKs7v+L/AZfSg2KVbn70rvjFVcfn6WHAkDxUnu94QgrmYmVXnidukz9czNAX0
	 wOR/SuShfcs2dhIfOu6iZ/kIVwp0oQ9HXIMvkeWJRfKZ/TaJ/FNtx0jUJXvdTCyXUp68f
	 FGmkaGDHxZ8aErn8LdAPa9tmgH8OXDjiWnszz2QN8RvZuN5n3h1YISj47IL2LSVI7gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030227;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7UsYq/cOStDF5QUFcq9lxiOi5VT38dFFs276ey3jsuA=;
	b=OCX3FAhA723SVNgU+D6c8zLPaLfXDBnT5jDo3tCxseao4enGAspqowy1T04ks+NzKrZb
	 wdzVuAyPayVUtZ03PB4PgWAQ5tlDMFA71hb7/khXOatBb2yg1H8bzOWLxW4iF8yL087Xi
	 jkjRxdAdLOj+n5p/cybgeMrPfQLpOvrBcVlSE/vUXm5IzcO9H05jQok5di+Z+YGd6jFKw
	 Ebfe+z+lhjlPxG6ce7woGOu1wdhwjMDFk6feH0yJeuoU2TiAT9hNq1CblCG9w4Q6vxKCF
	 I8W6qIb2qGFE371DUYUxkr+5afUMO8k83ANJ3Vn1lzkln45p0pbG05r87NhSudkvf+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Ri/bqMfC";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B56606DD3A;
	Wed, 18 Nov 2026 19:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53B56606DD3A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ri/bqMfC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030227; x=1826566227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ga71Wq7BqrzUIP/vHSoAKkoEApVBN/rgnyENY8hHh0I=;
  b=Ri/bqMfCbT2jAykmDchj5sRQUByXkui7nyMDKN6ErVl2FG5HtIKG7bwc
   Xm3iqlhVFEyzMqHMjd2sgVEYJpUUBUJw/RFWA7b4UDlfMuAMZ5Qu3fzfL
   uq/C8uoDI5CR/V7ZtPpKgKrRmJQ6+//BOIZtJB9FnAj9zkLXnWP4hdDuK
   IrXO7AfUvuM5zrfSnaK+tpfuACw/sjAKyCd9lOcYxflKgMM0zarESYNNp
   ioag0uuNQ6LsGs0vN0K6zdaIpWJaoG5OfZM4sZV1PVJFh82kVWeQSeqAW
   NEkOW8bBIRCNNfN6arFIox27EgzAlLlvw+TULQijRZwK/X2zndpFxC0dY
   A==;
X-CSE-ConnectionGUID: TnJdWxHdQAmgyQ2ycU6p7Q==
X-CSE-MsgGUID: hZl1cCUAQIK4leUIvjGcIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781234"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781234"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:27 -0800
X-CSE-ConnectionGUID: jr5w0k0RQS+u6RmUfP3gNw==
X-CSE-MsgGUID: bMFlNFWkTT+O5iBqlPoJTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468089"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:27 -0800
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
Subject: [PATCH v2 06/17] platform/x86/intel/ifs: Refactor Array BIST function interface
Date: Wed, 18 Nov 2026 12:32:48 -0700
Message-ID: <20261118193259.519568-7-ehab.ababneh@intel.com>
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

In preparation for upcoming changes, refactor the Array BIST test to use a
more generic structure (run_array_params) when passing parameters to the
caller function.

This change enhances maintainability and flexibility for future
modifications.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/platform/x86/intel/ifs/runtest.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 96b538c665f4..c6a4d6dcccf1 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -30,6 +30,11 @@ struct run_params {
 	union ifs_status status;
 };
 
+struct run_array_params {
+	struct ifs_data *ifsd;
+	union ifs_array *command;
+};
+
 /*
  * Number of TSC cycles that a logical CPU will wait for the other
  * logical CPU on the core in the WRMSR(ACTIVATE_SCAN).
@@ -302,10 +307,12 @@ static void ifs_test_core(int cpu, struct device *dev)
 
 static int do_array_test(void *data)
 {
-	union ifs_array *command = data;
+	struct run_array_params *params = data;
 	int cpu = smp_processor_id();
+	union ifs_array *command;
 	int first;
 
+	command = params->command;
 	wait_for_sibling_cpu(&array_cpus_in, NSEC_PER_SEC);
 
 	/*
@@ -324,12 +331,14 @@ static int do_array_test(void *data)
 
 static void ifs_array_test_core(int cpu, struct device *dev)
 {
+	struct run_array_params params;
 	union ifs_array command = {};
 	bool timed_out = false;
 	struct ifs_data *ifsd;
 	unsigned long timeout;
 
 	ifsd = ifs_get_data(dev);
+	params.ifsd = ifsd;
 
 	command.array_bitmask = ~0U;
 	timeout = jiffies + HZ / 2;
@@ -340,7 +349,8 @@ static void ifs_array_test_core(int cpu, struct device *dev)
 			break;
 		}
 		atomic_set(&array_cpus_in, 0);
-		stop_core_cpuslocked(cpu, do_array_test, &command);
+		params.command = &command;
+		stop_core_cpuslocked(cpu, do_array_test, &params);
 
 		if (command.ctrl_result)
 			break;
-- 
2.43.0

