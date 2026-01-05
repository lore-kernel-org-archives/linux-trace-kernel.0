Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B9339B2F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Jan 2026 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629487; cv=none; b=iXu9lMXaqHutuKeVrse+hFLpirkZD1VRvykV3bEbWy4rUXO0wOdf+TEzd4pmVpgsRKgpmWyVBHDHjiVgZSB+J94BgBq9QCeDvyDexjh13OAMQqVg0l6Pfzkghxv0nnijvuz2a0pXiqBbijnfYVUCCJr804MzgDdkT+9H5V8Irb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629487; c=relaxed/simple;
	bh=Kd45uWErUMyj3Xbwd/cqPwAs6F2dk3Y4YJiyVUL2jwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e0yknC0MWk1ijcQOrat+qBBv4QypESvLRXTw1vtnr1oqZsjDDiet10x3WLCCnNSpb8Qld3+klMh9wvCEDstzlAXI1qiXZ7IRBMf7azdDY2soX0XX+UCjKcRSnILfuUZ2u1GKfDGTJNHpGEeuz8iYDGaboWecua7HMlrjC0G0yLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Oa/djvKF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Oa/djvKF"
Received: from LAPTOP-U3CCR7C6.corp.microsoft.com (unknown [108.142.230.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id A9CC0212539D;
	Mon,  5 Jan 2026 08:05:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9CC0212539D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767629114;
	bh=D3EQP30nopHZPddhWzpH8v9mca3JEQ17NQqU4AosWpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oa/djvKF8HsXMv/cBXOOeWFV7o+9EJjkm59K0Kce4TH2gEKvOaGXbTkXvHAIh37Ef
	 a8xFqIoJIWUsPdlFnrChHCodP4f5V+8iru1uCMHwp+n0AqVEF9xsPfA0MWRnToSlF8
	 E5pUymqzBIt6aLt0bUQJimQN0CvmCcKlgscAo7Xs=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: tballasi@linux.microsoft.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: [PATCH v3 0/2] mm: vmscan: add PID and cgroup ID to vmscan tracepoints
Date: Mon,  5 Jan 2026 08:04:21 -0800
Message-Id: <20260105160423.23708-1-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216140252.11864-1-tballasi@linux.microsoft.com>
References: <20251216140252.11864-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- Swapped multiple field entries to prevent a hole in the ring buffer
- Replaced in_task() with __event_in_irq
- Replaced mem_cgroup_id(memcg) with cgroup_id(memcg->css.cgroup)
- Rebased the tree to latest 6.18

Link to v2:
https://lore.kernel.org/linux-trace-kernel/20251216140252.11864-1-tballasi@linux.microsoft.com/

Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>

Thomas Ballasi (2):
  mm: vmscan: add cgroup IDs to vmscan tracepoints
  mm: vmscan: add PIDs to vmscan tracepoints

 include/trace/events/vmscan.h | 100 ++++++++++++++++++++++------------
 mm/shrinker.c                 |   2 +-
 mm/vmscan.c                   |  17 +++---
 3 files changed, 74 insertions(+), 45 deletions(-)

-- 
2.33.8

