Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7D262B6;
	Thu, 11 Jul 2024 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720656168; cv=none; b=cQsAEUvYOegYZLF6KtJ1Tz7SNJUQFbL2K8DQb2zNmPP+G4ZFztwiC0phgHAVScUAL6SeW7JfRHnElShgvPoswkc8EOPtrbb8SlBHBJVG1LVrp7C4rKFmrSbIQPpCGKVRlTOqd6i+MDzBtFPrLLvMzQNJPq62WW4X0SVFdXjtsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720656168; c=relaxed/simple;
	bh=cuyxjV1A3pagPwWMlVL0Z0f21MocAdw285VBAeBfxUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=df83I5FcSJBMtXGAFjFw2uIWBLEvSyrmAMZ4iu5j0GvJ6z03f6h16B5slGM+5vwhPPRrPFQZa+NGOvVo4UDF8cKIJnRYK27x73u891pd8NMDcnYJTt1JQRd/R003+Bjnu6sXBNa8PdrrbPiZl8GpSb10y8oQPhaTcvREXXpmChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKxHSxaD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKxHSxaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720656166; x=1752192166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cuyxjV1A3pagPwWMlVL0Z0f21MocAdw285VBAeBfxUQ=;
  b=VKxHSxaDpeZFqdef5Uc2swO96D60KiP/gpHBlbjV3lyamHatwTlhGNKM
   E4+9vZTW+0wRSpN2lgQAiTcH9H9f6FP8BC7JCxYxhWNX1aMqUTpGkggef
   ZEZVEeT7zzI5HPZKuSkaR0dmh+lPvZxg938RjYSQk69+s+UQ3aEsJGKww
   +P6fJG5/co3fw40adEE4n+wW0JYil5PPmSj79ojap73ngmQ4Pos7MIiin
   X0AwVQfVYhVwsT1K3GTlTxxaW5te6xcwlVRETA/7US0eHp+5Dm/G50BGJ
   R4+fnvvfiOcsATcEfITukSPNm8ChCFSw5r3F+hm1l8WSuu9tVmg5nzRDe
   A==;
X-CSE-ConnectionGUID: ZlgfyCK+SIiSMCG9zaUYLQ==
X-CSE-MsgGUID: Z4HyalPaRLuG3WUCnlyWLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18153694"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18153694"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:02:46 -0700
X-CSE-ConnectionGUID: oa0LH8wYR3aLcwSVYH64Dg==
X-CSE-MsgGUID: mvFlfmyCQxCa3nGUz0QHSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48349887"
Received: from cmdeoliv-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.125.109.234])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:02:45 -0700
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
Subject: [PATCH v2 0/4] Add SBAF test to IFS
Date: Wed, 10 Jul 2024 17:02:29 -0700
Message-Id: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for Structural Based Functional Test at
Field (SBAF) in the IFS driver. SBAF is a new type of testing that
provides comprehensive core test coverage, complementing existing IFS
tests like Scan at Field (SAF) and ArrayBist. Granite Rapids (GNR) is
the first platform that supports SBAF.

SBAF mimics the manufacturing screening environment and leverages the
same test suite. It makes use of Design For Test (DFT) observation
sites and features to maximize coverage in minimum time.

Similar to the SAF test, SBAF isolates the core under test from the
rest of the system during execution. Upon completion, the core
seamlessly resets to its pre-test state and resumes normal operation.
Any machine checks or hangs encountered during the test are confined to
the isolated core, preventing disruption to the overall system. Like
SAF test, the SBAF test is also divided into multiple batches, and each
batch test can take hundreds of milliseconds (100-200 ms) to complete.
If such a lengthy interruption is undesirable, it is recommended to
relocate the time-sensitive applications to other cores for the
duration of the test.

Patch Details:

Patch 1/4: Refactors MSR usage in IFS image loading code to share the
           code between SBAF and SAF tests.
Patch 2/4: Leverages SAF image loading logic and adds SBAF image loading support.
Patch 3/4: Adds support for user to trigger SBAF test.
Patch 4/4: Adds trace support for SBAF tests.

This series is originally authored by Jithu Joseph. I have made cleanups
related to code reuse between the SBAF and SAF tests and resubmitting it for
review.

Changes since v1:
 * Addressed trace struct hole issue (Steven)
 * Fixed initialization issue in ifs_sbaf_test_core() (Ilpo)

Jithu Joseph (3):
  platform/x86/intel/ifs: Add SBAF test image loading support
  platform/x86/intel/ifs: Add SBAF test support
  trace: platform/x86/intel/ifs: Add SBAF trace support

Kuppuswamy Sathyanarayanan (1):
  platform/x86/intel/ifs: Refactor MSR usage in IFS test code

 arch/x86/include/asm/msr-index.h         |   2 +
 drivers/platform/x86/intel/ifs/ifs.h     |  92 ++++++++-
 include/trace/events/intel_ifs.h         |  27 +++
 drivers/platform/x86/intel/ifs/core.c    |  33 ++++
 drivers/platform/x86/intel/ifs/load.c    |  39 ++--
 drivers/platform/x86/intel/ifs/runtest.c | 235 +++++++++++++++++++++++
 6 files changed, 413 insertions(+), 15 deletions(-)

-- 
2.25.1

