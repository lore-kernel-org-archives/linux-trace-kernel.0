Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039749;
	b=iD1quKvz+jtiB1aE5QRyRAB+9k3S2JPwWU2YOydr8dUnHLhXUc8PK6RI0y2Yy0zBfsL1
	 qWPtgAhRaaBIFTwd1VTcSNPFqEkvoLbN9gQKMnjzh2fbJkIoWow9mjLR9SLS48IIRw3cx
	 pu4l65Se2jB9jz+7Df37cEFj93BP0PZf5SkX4mEJ7WHFMMb023stJf1vn+T7G9Rujbvxm
	 V5BrpzwxFWAIHXGhO8vq4zPMTkGw8BXC4YmysmUVVGTWokhhfpG2s5Fr7p/OXl1MR23Oc
	 piHb5GPoHIBh5OxAbu3ao5INHeNXxUwCV+HZKayP69IMnglX0gP4W4vCorEdbULjw8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039749;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5KJKdWcW1AGlgJ2QyBBKQPh2tn3XV57QyU4D3euLNSE=;
	b=Ge5aBjezCAV5TneOaP83gJnrgqAuC1/Emg7b6kaxZDW9jYrzAWhto/EagaYHkriANw/d
	 SPrFBzLQgWbkIuipRthj7j/km+u2UAGo5g4zmvTNNBAzVBh3E5wevVd+FC078sjCfvH55
	 ktZ7OfdfPJ3O+tX7WtI1jjGCFEewwksbdz6MStpkNuXLn9NZMGk3QQaLUoaJbVXWAJEB4
	 IpEBLqook9RX8ZCDu4UIAWW/ng2fH1Ogpeosv945SLWaCnF/taX2N4FEiB+7z2wCj4jWb
	 QScbeO/gYDn0kMr0wYS7XacgoCRaZSD75Q99kMwJV/F1Twx1vRGN/KbGqiVGCCf9JQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="FslEB/Ip";
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70C60A382F;
	Mon, 26 Oct 2026 18:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E70C60A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FslEB/Ip
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039749; x=1824575749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5TaA3E2JV+LU7vcX4+NZP+hzzAsnCo2ZWn+5bqsgw4s=;
  b=FslEB/IpJene3EQauePFh4/BE4AOc+HdvBAEGNE19RegX8hZYPZ1qLZE
   pPsQByJnu5bkSWVXtZ9bxfRYxL3FkT3ZS+ar5e/42N5MWPyP4xqMgsAei
   Z2rbBM/9kvMrH5dbEMwASlREDbqlwQMacCxYH0ypkKZ4mFFZrAPgu2tMg
   jE/Vb8NEwsM7lv1mdVUabdNvBQEpYTScUPrWLZt0FK1aqqYw8Mxh8pgVY
   g2Uv6ZZoBD0u5y60hY+AX85mvdvoesKffPcEsPa/484uZ6RRlRUlV+C6M
   G4oUSHdtKw4Eb1Ua3B5WjQtqSy/a36Aduaf9jzY9fCuWCsJvIeJsbl+Hr
   A==;
X-CSE-ConnectionGUID: dJacUAb0RtiJYxXBnpS+Rg==
X-CSE-MsgGUID: PUrPZHXASu6sOjsElwdi2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731560"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:37 -0700
X-CSE-ConnectionGUID: x1GQxndYQDGgz+ZIyc+rsw==
X-CSE-MsgGUID: 4VuNTklgRlK3pplNAZ2Wbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293911"
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
Subject: [PATCH 15/17] platform/x86/intel/ifs: Remove limit on number of batch files
Date: Mon, 26 Oct 2026 11:38:18 -0700
Message-ID: <20261026183820.129459-16-ehab.ababneh@intel.com>
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

From: Tony Luck <tony.luck@intel.com>

Writing to the current_batch sysfs file rejects batch numbers above
0xff. That limit was expected to be enough, but Diamond Rapids needs
more than 256 IFS test image (batch) files.

Remove the limit check on the batch number supplied by the user.

[ Qiuxu: Update IFS ABI documentation to reflect the change. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-intel-ifs | 9 ++++++---
 drivers/platform/x86/intel/ifs/sysfs.c             | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
index 41b4d5b1e21c..76770648e63e 100644
--- a/Documentation/ABI/testing/sysfs-platform-intel-ifs
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -44,9 +44,12 @@ What:		/sys/devices/virtual/misc/intel_ifs_<N>/current_batch
 Date:		Nov 16 2022
 KernelVersion:	6.2
 Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
-Description:	Write a number less than or equal to 0xff to load an IFS test image.
-		The number written treated as the 2 digit suffix in the following file name:
-		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
+Description:	Write a number to load an IFS test image.
+		The number written is used as the <batch> suffix in the following file name:
+		/lib/firmware/intel/ifs_<N>/ff-mm-ss-<batch>.scan
+		where ff, mm and ss are the CPU family, model and stepping, and <batch> is
+		the number written, in lowercase hex, zero-padded to at least 2 digits
+		(e.g. 02, ff, 100).
 		Reading the file will provide the suffix of the currently loaded IFS test image.
 		This file is present only for device instances where a test image is applicable.
 Devices:	intel_ifs_0
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 3cbab2acca72..7b4c7f21000a 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -91,7 +91,7 @@ static ssize_t current_batch_store(struct device *dev,
 	int rc;
 
 	rc = kstrtouint(buf, 0, &cur_batch);
-	if (rc < 0 || cur_batch > 0xff)
+	if (rc < 0)
 		return -EINVAL;
 
 	if (down_interruptible(&ifs_sem))
-- 
2.43.0

