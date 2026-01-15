Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C03235F8B1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480697; cv=none; b=Fq9ED0SRfrIKCZK/wXjB+Kfwrr5ewD8xnQuyL36eAXqvd7vF1E1A3iKtEexHDF00H+H6oarpzwIOSVjlZSoWG49iXQszwH0HrNk0oZ9ojsPjWGNliVAa8uYrih/XX4N7ear7RRqyS7KhaCVbb6PfcjEgb7McL+xvHQMfqJVrjBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480697; c=relaxed/simple;
	bh=G7JfoH2j8r80tEOkz5Nj7z4EIXidLp2ijo4kL4snrZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFohLSaUyNbJ1Qjx8AI6uyhWZ/kpKaoIeekhs9AVNPeGalOOESHHQegnC0LITsTaUe5bLUgWC7HTSSB7PTs3+FHz4rVmK7oNRwvDP/QFi+W8UiDpuSZTPLPt63OsjBEfo5CiuuX2XlbHkhQol3o952TpQeNLc4slxlJzSdB6DRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DSgDibXP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DSgDibXP"
Received: from LAPTOP-U3CCR7C6.corp.microsoft.com (unknown [20.107.46.209])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0C97E20B7165;
	Thu, 15 Jan 2026 04:38:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C97E20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768480695;
	bh=/X3PUJK8bO/rHUbOWXpMZonwXVf+p5xkBo4Y6OPvyC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DSgDibXP+0WR3RnuDrkkG/LV/dvpooHOvAbV1NZA4nu/UV98zXwQOyxl5I1RDdvDg
	 iA1eaaR7ZA81R8sJfYImspoLNBXLlDB7e4dCuwUkMgV43GOfW0VU/k6sqr0KaCrOuu
	 3rXtTdHl5dFwkuNHKwBenCeCf1W86oQ0OSB/1yGk=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: tballasi@linux.microsoft.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: [PATCH v4 0/3] mm: vmscan: add PID and cgroup ID to vmscan tracepoints
Date: Thu, 15 Jan 2026 04:38:06 -0800
Message-Id: <20260115123809.2257-1-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105160423.23708-1-tballasi@linux.microsoft.com>
References: <20260105160423.23708-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
- added Steven's patch for __even_in_*irq() calls
- moved back to mem_cgroup_id() following Shakeel's changes
- passed cgroup ID through trace calls for slab_* tracepoints
  instead of in vmscan.h directly
- changed memcg_id instances types from unsigned short to u64 and
  updated struct entries accordingly

Link to v3:
https://lore.kernel.org/linux-trace-kernel/20260105160423.23708-1-tballasi@linux.microsoft.com/

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

