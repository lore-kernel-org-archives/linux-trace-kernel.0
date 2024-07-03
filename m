Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535E25760;
	Wed,  3 Jul 2024 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045514; cv=none; b=I4XoGgUn2ORPav3luNiXY/gmMQXWBF3uqsLQjozKo3qZZ9bXAYA0aplzb+9qfMTLXxYNQxj+j+hnnkgTUyX8k0OIKdX1htTZ67LWdYPD4LP3J9XDVzAhHNToIgImtqLMwBudgOMo+N/RgCQZl/pFxSUEKchDXhwz65npNyuj15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045514; c=relaxed/simple;
	bh=mndJpzadjQHtqifv93+XI+ba2fklxOnq9hJgR51FqBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kA7RQaaPFvLKAkLMi8Q7VQv06P0XeSB0nEM6j1hUbS1uuWjGgiX8aP1j7tsApUyOvZCm0MI6/QHpfxN2c/AScUcSfhQh2A1jPF0JVyt03XO5nqFlNtElzU2kPhuqrW43Ij69pcBFIfDn4yKMYfvho5oYawmHGkvZHCWLa9ZtNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D47YfF53; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D47YfF53"
Received: from CPC-beaub-VBQ1L.redmond.corp.microsoft.com (unknown [4.155.48.125])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3F50A20B7001;
	Wed,  3 Jul 2024 15:25:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F50A20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720045512;
	bh=DBFAmjPoKKil5K3tr8zF7LNFRV2BpYUjpp4KSM4D4Ps=;
	h=From:To:Cc:Subject:Date:From;
	b=D47YfF53o2beW8riTFQGkLDqsU+WczDxqodgwIN/oTWo07M5uHpi3l5zh0J08D3XW
	 SRtvDQrPpsDu+5d9Nn58x1/RRnesiFO7EeVGwkrpzfxasDU58efMzfRPtdY1ijeKeS
	 lsgrAolrmN3Un38599y6Xll3xVjX4WkVzmbBDG6o=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: Document user_events ioctl code
Date: Wed,  3 Jul 2024 22:25:01 +0000
Message-Id: <20240703222501.1547-1-beaub@linux.microsoft.com>
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

Add a line indicating user events as the owner of the 0x2A/'*' code and the
current sequence numbers that are in use (00-02).

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a141e8e65c5d..191609fe4593 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -97,6 +97,8 @@ Code  Seq#    Include File                                           Comments
 '%'   00-0F  include/uapi/linux/stm.h                                System Trace Module subsystem
                                                                      <mailto:alexander.shishkin@linux.intel.com>
 '&'   00-07  drivers/firewire/nosy-user.h
+'*'   00-02  uapi/linux/user_events.h                                User Events Subsystem
+                                                                     <mailto:linux-trace-kernel@vger.kernel.org>
 '1'   00-1F  linux/timepps.h                                         PPS kit from Ulrich Windl
                                                                      <ftp://ftp.de.kernel.org/pub/linux/daemons/ntp/PPS/>
 '2'   01-04  linux/i2o.h
-- 
2.34.1

