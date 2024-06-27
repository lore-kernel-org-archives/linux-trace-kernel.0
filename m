Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5CEBE71;
	Thu, 27 Jun 2024 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455866; cv=none; b=aLQPOksZd6iBvMpHZD5itSWxDkkznjXF6Tyqhbb5dPOFXquNepTm1zv9Ugo49iBDE+p1vRCf/jcA01MrfU+QEu3jQwkCHEJBpo5dExMUhSoLhsykHFgAQDKFlW0pq2HNwGYAGT1HXfUr/u/TjUASHUw3iDAyU8s5P7t/phv4Hrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455866; c=relaxed/simple;
	bh=IuCcbDB/n+U5EiqNgwFpeQz2q2hxzUvCkkb5mw99iII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZXhX05zbc3bkxQ9E1gUECm3KP1nJfaspxcYy+4O9/ZkQX0PvqCMGlJ/c6QvFnroBhYUfzqX16Ipm9Fiodek/GSKEBxg0tyT7b7TTYplLtHLIeKY+dQydaLrJcIsCttFj+Z1bKGiY33dp0BYJ95m8z1ySIuOjVl7ArgVyj7hKQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6j7ITdv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6j7ITdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719455865; x=1750991865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IuCcbDB/n+U5EiqNgwFpeQz2q2hxzUvCkkb5mw99iII=;
  b=E6j7ITdvIu+fkzi1QUQWcQz713Fol3kNMwiaUgs1nBNIH6kbeRNwCbcs
   03hv9N7guNTfGKGe5iFxvF50Sa5K340GFJV/foorvZR/LrxtVsmFhj8l0
   VZ7OcqfJzu/zmMAjGaRO3Gba0GETPREauq1HGH5VTR8Ugj4dFuDWPLzp+
   ZZm8thl2kvOD4jNL8GbRugy7czVyeE2wVVvRoI0uLzXD5EogIpdt0U1UW
   UyPf9VuLB4nqYwIK1uiDaNJ+dMYTNkGcGqIklbgG6giouAEr+yBrNVkoH
   wg3WMFMUmn8IiK1z1BgKN2MlaNk3fyr+TsRzIZUvW6cMcrpnKRr0t+rNW
   A==;
X-CSE-ConnectionGUID: H7DNCzksQK2bzLVfiMBs5Q==
X-CSE-MsgGUID: De+8ZzYsRa688Y44VO/w2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27959485"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="27959485"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:37:45 -0700
X-CSE-ConnectionGUID: ZDNEhOR9Sc2P0cYVlonUCA==
X-CSE-MsgGUID: +8zQGLyeQ3qaRvZ9Ak7bmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44052386"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:37:44 -0700
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
Subject: [PATCH v1 0/4] Add SBAF test to IFS
Date: Thu, 27 Jun 2024 02:35:12 +0000
Message-Id: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

