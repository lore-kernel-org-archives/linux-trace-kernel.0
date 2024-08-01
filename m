Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4670132114;
	Thu,  1 Aug 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722489649; cv=none; b=OY3z8ja+oTbVxfZ2GQ0NCDC0D34kjVywmQyxA85uVUAL3kBeBDaez37jj3d++ZZgSCcK37eqZIILTsUUDzhW+1SuNjPmELTc8ISoeJWTBjH33VPyD8uJ0XgXZ/gQ+07PVd+8rFwzTfi4q/KE6UT2tQzCVzJxU9cxgZ1hWXdbjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722489649; c=relaxed/simple;
	bh=YU/63FNruDeAFMPEDziJs8zsHHNVgZHddDQyLvPxjlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NElOGtziBLIkPsSBMrAxz3GEQbQeY7Qq/DKvmmnHqmxY3xezvc4IiRmaZBPfzhWA5Gr2YImhR0wVpAIxMHrEQYm80Ldy57yHDMpDhx4zKjC4llOcHtiy/XJrLmbDfwxGFAu5w+sYM50FTFNW1mKdYQKL/8hK2ogqohUTWwQ90Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNtAANL7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNtAANL7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722489648; x=1754025648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YU/63FNruDeAFMPEDziJs8zsHHNVgZHddDQyLvPxjlU=;
  b=bNtAANL7D/qVYdAUie5WTTxuEH4P8jZk5X4nVs0axv/YYlnUrOwOkHTb
   9VtEDScLLsCEvqF/AwgA/8PVDxu2pVKeC8o9k3htlMRAUMXgj+xqyHIV+
   bGFJXp2hYDRE4jH4WbvRqQHwdEhmU9WewdHdCHsnBe4aP9OGtWblXWMVA
   tj+5vHrtgAtOxvMMnJKUno2BICOywFh8t9DUtdpsS12DkTSmZY/HVrkBc
   pHz/yl0115WiBOcEByatP7haeXb5R8+bdJB5H7PWk5fMdXXQ42AlpX59a
   s2K8dPZcu7TmNWyiFo53EvXop/RBkk9e/r+w/6Wf0yGvki/se5xXVd9wv
   A==;
X-CSE-ConnectionGUID: jz/avY4oTK2SaFYqce16gA==
X-CSE-MsgGUID: GBLJlWMwQzyyUkLFVR+74g==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="12821721"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="12821721"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 22:20:46 -0700
X-CSE-ConnectionGUID: bOp73MO1TJKYTzo1pn40ag==
X-CSE-MsgGUID: joynoDV1R9areN3oEVhvkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59951363"
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
Subject: [PATCH v4 0/4] Add SBAF test to IFS
Date: Thu,  1 Aug 2024 05:18:10 +0000
Message-Id: <20240801051814.1935149-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes since v3:
 * Rebased on top of v6.11-rc1
 * Added missing error return value in validate_ifs_metadata().

Changes since v2:
 * Added Reviewed-by tags from Ilpo and Steven.
 * Fixed minor issues raised by Ilpo.

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
 drivers/platform/x86/intel/ifs/load.c    |  40 ++--
 drivers/platform/x86/intel/ifs/runtest.c | 233 +++++++++++++++++++++++
 6 files changed, 412 insertions(+), 15 deletions(-)

-- 
2.25.1

