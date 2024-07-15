Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D5954670;
	Mon, 15 Jul 2024 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067270; cv=none; b=rt/osF3CNhRYmEMfYV3MC0s333lK6ZFw523ylWnvPBnUngh08KzAvCOeZGwhhv1MFtuVYL/Ll0I3PjRuB+575U+g8jc8m1fXO+xE1ez9Fy/ObUIAQcEnnQSh/dzvByGZ27I+zAHALIk4YNqG8DEkcEkaGzIOWpbWJyfX1rw+xXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067270; c=relaxed/simple;
	bh=Vst/VQ3nh42dO0+xMguh5P+lia20vLXcic79o+sw9M0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JfV73kMeqriy6+EIBtvJzhrg5rnHxSR9hcyQwxuHlgCtNJ4/iVKuJjaUwHIK6lzlEU0uriX5Opvvu+XKlQJ7/ZNMOdHSMkm5M23Rgm0hcdhcqqq5QPcyk1ubOBlCP/fKdXV6ev4laBkTDntHoq4x/evSLhIACxa0akQGkyjzU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JG39VngA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JG39VngA"
Received: from CPC-beaub-VBQ1L.redmond.corp.microsoft.com (unknown [4.155.48.126])
	by linux.microsoft.com (Postfix) with ESMTPSA id 58B8620B7177;
	Mon, 15 Jul 2024 11:14:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58B8620B7177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721067263;
	bh=cn0VFPnkmYUn1zOQLdurhEoYBVivIcxYhlAZ1gbroHA=;
	h=From:To:Cc:Subject:Date:From;
	b=JG39VngAye0J7UD0qu40eimfKRgTREWqIKntTvLhpgaHub8usVRbYtcqnTwiPzO45
	 zaKTzmYrOV+H1eWL1AHVo2nooVUXCj/gPe7jp256Lfxzt74GsbQSs/jjFB6nFNDvoe
	 i1ZUV0K7a9lgFexjGCX6/Hn+wvTj8pejWh0ZdUdg=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] Documentation: Document user_events ioctl code
Date: Mon, 15 Jul 2024 18:14:13 +0000
Message-Id: <20240715181413.1157-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user events trace subsystem uses the 0x2A/'*' code for ioctls. These
are published via the uapi/linux/user_events.h header file.

Add a line indicating user events as the owner of the 0x2A/'*' code and
reserve the first 32 sequence numbers.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 V2 Changes: Reserved first 32 sequence numbers for growth.

 Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a141e8e65c5d..d953549f0b2b 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -97,6 +97,8 @@ Code  Seq#    Include File                                           Comments
 '%'   00-0F  include/uapi/linux/stm.h                                System Trace Module subsystem
                                                                      <mailto:alexander.shishkin@linux.intel.com>
 '&'   00-07  drivers/firewire/nosy-user.h
+'*'   00-1F  uapi/linux/user_events.h                                User Events Subsystem
+                                                                     <mailto:linux-trace-kernel@vger.kernel.org>
 '1'   00-1F  linux/timepps.h                                         PPS kit from Ulrich Windl
                                                                      <ftp://ftp.de.kernel.org/pub/linux/daemons/ntp/PPS/>
 '2'   01-04  linux/i2o.h
-- 
2.34.1

