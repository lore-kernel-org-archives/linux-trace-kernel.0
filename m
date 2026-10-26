Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039746;
	b=xhO9Qw8Tr5ZYKxilrcDQTzvEekBsi6qTkLq92PAwnmivIbApOvq3iWpsJEpcPBq6V5+l
	 PdvGPGqcUYlXztFMlT5GLg2TeC2NpMS7tDLcuwmhBhawACCBpTP4SAhtwGEbZlveQatbq
	 FzFuPhkU1cC1YTOs/YWtkdQqMn83wPYsqJkSXes0xkNGFOwq6w54h6uiZ6EXXEimFmf/H
	 t4EnYcUIii3b/CL+ZnYQbjDGj3f6I1qIPEvq7co3NNGVp3SwDM0bCentg3OjfzxOgJMwp
	 2DirAHrB4905PyvkyepR0NeZIvSNGgZYqIDfb4KYYHPeYmrWWD9bpeepj123W2LJEYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039746;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ySiA5fFqxAhh8L69VhHDbDcLTzzeYo68WNtjoNaQ2xE=;
	b=Q7WQ90wwdGxgN3z9mioqqNxY4mL5MSsvjIx+5BFL2gW7XydeRjtdzlz9D4ZDqM1MMgyc
	 lkoIRzBWLMf1WC8/sVSQhYEQfFlLxZ5Uu9DjIWO5wFjgH4AQidznOpont972r87eR1Pih
	 +imG9ZzxOalQHWxYCw+eQNRF6AK+cZ8VBBw6yruDN04jkQgR46d1XH0v/+WfPgBY0nhs1
	 5k0d9IN8sKNer4dqSTkWzStKyUji2ZxMmM2GSmewLCZujquvhq1DBnJlmIocFNoEpNlN1
	 Y9qypOe8uzr4zAB1lsCv9rdHAs4kcYcX8LeOm7oUY0HmEUs/+RAYAhlPaZVYG64W7uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=asiZziSk;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C8606A333;
	Mon, 26 Oct 2026 18:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A60C8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=asiZziSk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039740; x=1824575740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lIxvgry4fkojIZIEOUHj1IgRyt68lf8Emra+P0vnDyI=;
  b=asiZziSkJjqv96oWTeUzTFaB6XLfqshoId51A9DI7HRqpwrd1mCHLhiN
   5C2PSAs1QEXELAHZ4QR9c3/PNnsPH0X/f5q4tyENQVbeN29Vq9iQ7OXo6
   roY5fnJH3zsroqBJO9VbaAdMMPAWUxT55QMNjcixhoWdRPgp/sykqsKvR
   Uf379BtMLf8Lctzquk+dfVIMqeXGHk3RlYwDg3ZQzeNSkfXFMrE8NRsAJ
   HoosR+QFtJ6qCG543rNoqjWmoOGVqilHC9ZfZeslT633u9Gs3ikiV1cMD
   xN2NaSU/SOiF468IXFb5ynPHVlMx9s2gz2PnNeuzbiQTq4UNcWynXUZbg
   w==;
X-CSE-ConnectionGUID: OAa/xKPxSoCL4OTZIrhubQ==
X-CSE-MsgGUID: X1swMxv3R6O0avBmYEobQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731487"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731487"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:36 -0700
X-CSE-ConnectionGUID: PDMSBd/bQPmUX0T1h6YJwA==
X-CSE-MsgGUID: MtTuRcESS4OBaqjAUHjOBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293877"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:36 -0700
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
Subject: [PATCH 06/17] platform/x86/intel/ifs: Refactor Array BIST function interface
Date: Mon, 26 Oct 2026 11:38:09 -0700
Message-ID: <20261026183820.129459-7-ehab.ababneh@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026183820.129459-1-ehab.ababneh@intel.com>
References: <20261026183820.129459-1-ehab.ababneh@intel.com>
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

