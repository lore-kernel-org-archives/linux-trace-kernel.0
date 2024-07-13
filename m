Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852F4C76;
	Sat, 13 Jul 2024 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720831339; cv=none; b=PEXGfAk4sT2gL+RKxVkryX/Zo0mom9OisDEiRr2bBzX7iuvLk0whBfB1b0ry55sSzkvOzUKkly+uqlm8/2grbCS9002e1HcC5z6W6E5AgZ+Jw3dvUy768PNjsDhvseAUU+b4BUrURFtznT1xwwfwenf65mJHzdwPdAjmKhFEUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720831339; c=relaxed/simple;
	bh=RXaKncc9qrY7f2wWLJ3zg8RZK0znrRRR61c5rzFrKyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oDh/wHy2UYxhgLHtbhnPW3ovbhK8y3L0F8vGOZV21ucHBDSzECZ/VqH6mRi6PFdN702fPjABM2mZv6xPRf5oPnrupB/TeBclPs3m5svp6MJJoCEmz8nj5uvOXDBipkQlkIRueLwbD1SSElk9mjyf5DE2xI3Z8a0o1xPHsoLaQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0waRgTk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0waRgTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720831338; x=1752367338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RXaKncc9qrY7f2wWLJ3zg8RZK0znrRRR61c5rzFrKyg=;
  b=W0waRgTk0gXz6TvWmXS89nJsA3Mw41Pft+yf3FcMTP9bx2ur+E92zN9S
   juGmdAA8VEZ2+NfHfAVJWcOK8I9C+SKlgmsy5zKsWYSYQWsGSDysqYcLB
   nO2TDAgmkvXM03QmBWvMfC3rwZ7GeBYEMpeXJBUeXqHEN7lyS/BK6M/8d
   0hSSa14MYzpKo5fqGkQt3W7bJQcwhIECs7w4UaAbOgadlGRf5P8Zrd4z8
   dnuF8zOysOvDbtwuyFDqWCvcV0eiSRejwh0Mi6LqymKJqEQJMA2+jIsJN
   4+FsyF1q7xIe6YSYHt+2rU7nZV9rnpojBaQJLHkTMnp6+dkxo/lcNYDkY
   w==;
X-CSE-ConnectionGUID: LLnYAXkQS2edkyJhG3IqcA==
X-CSE-MsgGUID: POv6rHY9SgO2E/1wVO/egA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="35833371"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="35833371"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 17:42:17 -0700
X-CSE-ConnectionGUID: Am/rIOfoTi6hvjlsDHJqhA==
X-CSE-MsgGUID: VuuJVnZLSAWSlvZ7Vrdi0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="48955778"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 17:42:17 -0700
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
Subject: [PATCH v3 0/4] Add SBAF test to IFS
Date: Sat, 13 Jul 2024 00:39:57 +0000
Message-Id: <20240713004001.535159-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
 drivers/platform/x86/intel/ifs/load.c    |  39 ++--
 drivers/platform/x86/intel/ifs/runtest.c | 233 +++++++++++++++++++++++
 6 files changed, 411 insertions(+), 15 deletions(-)

-- 
2.25.1

