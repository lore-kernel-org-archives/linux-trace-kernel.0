Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039749;
	b=PSyvcZYnOew5A90BoObq/m6U+qcEBhpxY0tqmY5ivf+8jnH2BFfs+D1/An/LM8uM104R
	 USaQB9uSOs40t8sFkIZ+DeHNj5h5uIYPJU0za6Qc6pDKekgFkSeIxGMsKuHoL1RwCvAeT
	 jcd7kBH4VqxtgFGg4rUoNGGawJ1xCmSlPRn0HUmL2Rv+biffpxxJy5K3AVLYgfrz22mHw
	 65EvynPwIl4tW3VIbhspcdpHLdZqGpqa1IAidjeTkeEAMLKxw6lvg5t7nRXBn5P22POc/
	 7zsDyQll43DkVWLeojvHKKiS80L9mtZnpdoghOSSMnIR5a05kgT1GanFPhu2BJSRupQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039749;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VY4S6XqzeJd1nV36a3GhSgm+0RUF2ptpUJyLY1aOC4w=;
	b=20iX72UgzwJLz5dfmU7fIlzxYSjkjr5ci3YCSXa2wx1ygOdQ8jOQgHOopxLJZcns5r4A
	 8MeUcW9HFjTVehzVVFVVVTtE6PPibrlZisP91e1W3hVaKgCL87jpYoK/0mc8TKR5MDSvI
	 GkUECOMp+QG02BZpAPp2c3lNLN2Yn1WfY94yuP4P4lZFJCVMoYCaqV9Em2N2s1mLPVWk9
	 I4Lhk0uZKvblNi+DH4hg1gOl39N1XTH1ikX2SW4/GfNNfcKyXtcmEcGFaOmO4ilVQ7Xo9
	 U/72FJxiaTt4HlIolcHs7n0eg02IlBBAE9cuoCPNaDOVu5j0NAkh3D2ZFPH2TMVwsww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KNLlPvnU;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113E60A382C;
	Mon, 26 Oct 2026 18:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3113E60A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KNLlPvnU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039748; x=1824575748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U6d9oWhyjY75grNTBmgvbaiekqnx/QBMCHxHLaYHuqg=;
  b=KNLlPvnUWljVau3cLUNIMKNIvKtU9knhIl3q3UvKhT1aekEtUs/mZg8v
   T2IWOYhunUY3NSZ3C6EQ0AfsP8MmXtLoLNQtV7qg84gyhI4QoQGAUvu4b
   O5JuIgGU92sfv1dGhzfZcEHp4FWH/xFigK4g22uDktDnBrvbumAqwFef9
   pFi2i5+nDTLiLu9zxHPmIGwNyf4nFltUfJwEF7tkES9MGifz/0mNPmVaB
   tTMSYTUt6b3QpkwShTKiCjiQIkyDgX3V9OMlgodtg7amhLEPDFmyNb1oT
   Fhal3vxFfAA+5MAd/kzulliAkEib5vwZ6mnkkNXtdmK/Lzf6B44hVl0mT
   Q==;
X-CSE-ConnectionGUID: G/9WRGj2QH6pwwwF1Iv0dQ==
X-CSE-MsgGUID: ZD3u5EztRXGffyryIR++rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731548"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731548"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:37 -0700
X-CSE-ConnectionGUID: smNBSkO9TRajyAmm9OuwcA==
X-CSE-MsgGUID: c9MVEepIQCOE14wKzcKpxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293908"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:38 -0700
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
Subject: [PATCH 14/17] platform/x86/intel/ifs: Add Intel Diamond Rapids server support
Date: Mon, 26 Oct 2026 11:38:17 -0700
Message-ID: <20261026183820.129459-15-ehab.ababneh@intel.com>
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

Intel Diamond Rapids CPU is a Dual-Core Module (DCM) based system
where two cores in a module form a group that must simultaneously
run the In-Field Scan (IFS) testing. The intel_ifs driver already
supports IFS for this type of DCM-based system. Add the Diamond
Rapids CPU model ID for IFS support.

[ Qiuxu: wrote the commit message. ]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 drivers/platform/x86/intel/ifs/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 08a3e519749b..5c9c86e04837 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -24,6 +24,7 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 	X86_MATCH(INTEL_GRANITERAPIDS_D, ARRAY_GEN0),
 	X86_MATCH(INTEL_ATOM_CRESTMONT_X, ARRAY_GEN1),
 	X86_MATCH(INTEL_ATOM_DARKMONT_X, ARRAY_GEN1),
+	X86_MATCH(INTEL_DIAMONDRAPIDS_X, ARRAY_GEN0),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
-- 
2.43.0

