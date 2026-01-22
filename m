Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AFE378839
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106341; cv=none; b=puavy6NPxRvIY8DSqBNo9K0qy7ggGmL7s1JTxWb+rjjRWj0wz/4ykr/qh+0Rjb59WcnEWjmNxaKf7fKOZ8IyCZYZ75qKHVOEvm/ENGaSMaZBdHaAcbcpvfRuVnc6LDpG7LG9QyvYjX28VbOcIDsXSFYbjXtYBxin7sGFzb4JKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106341; c=relaxed/simple;
	bh=gYCidIS1J6tuGTo5rYC2Xaglmlp2QqVQSRVHRuQ3AQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcIBI9CXkqTQyv4XnF0paxo4RZGL5j1EIzb7th3/9h4gMCh5CegGRaTdr+TYdC+9d0OhGaFjGEDAE+Ol8EZUcgjwZASMCMHtABsp7FhynszjqJR+4Tu4JIty3Snos//XqUsciTW4hsC6rHbptlv2FdjkwkjUsi/sMAgY5Nwcy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ooW1EZck; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ooW1EZck"
Received: from LAPTOP-U3CCR7C6.corp.microsoft.com (unknown [4.255.188.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2EA1620B7167;
	Thu, 22 Jan 2026 10:25:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EA1620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769106333;
	bh=jZETjoYZbv6JfxnRbJWK8oZQNrR2Aq71AMGCJB3jsHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ooW1EZckW1rmHEyEmWmj+I5OXtJOTq7SP3vw5gZ9tKf1qeBy3T7a17mvPkT/kq4WS
	 nWhWHhcZeBBZxmNat4c75ZBC3ocwdxZx26hkYfofLccdXnJITbV+TMmC4ZzlWltGiI
	 ysp6/QTq3Xt/0p+L4oqnbTiU843AUsrVMGhbZGjA=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: tballasi@linux.microsoft.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: [PATCH v5 0/3] mm: vmscan: add PID and cgroup ID to vmscan tracepoints
Date: Thu, 22 Jan 2026 10:25:07 -0800
Message-Id: <20260122182510.2126-1-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115123809.2257-1-tballasi@linux.microsoft.com>
References: <20260115123809.2257-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
- Fixed a small quirk that added extra +'s at (in-irq) warnings

Link to v4:
https://lore.kernel.org/linux-trace-kernel/20260115123809.2257-1-tballasi@linux.microsoft.com/

Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>

Steven Rostedt (1):
  tracing: Add __event_in_*irq() helpers

Thomas Ballasi (2):
  mm: vmscan: add cgroup IDs to vmscan tracepoints
  mm: vmscan: add PIDs to vmscan tracepoints

 include/trace/events/vmscan.h              | 104 +++++++++++++--------
 include/trace/stages/stage3_trace_output.h |   8 ++
 include/trace/stages/stage7_class_define.h |  19 ++++
 mm/shrinker.c                              |   6 +-
 mm/vmscan.c                                |  17 ++--
 5 files changed, 106 insertions(+), 48 deletions(-)

-- 
2.33.8

