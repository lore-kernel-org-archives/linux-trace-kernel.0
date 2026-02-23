Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA0832ED58
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866950; cv=none; b=i+qBgqjo3eIQ1p7A22CaZHqnJ+ThodxuR8jBREAUcaMVi/3W5p/wfnrUZz4EJQomBrbC3/iRYvC5oD9MwOaqrYCdsDnykhXmZ2oaya1VaqHsMzRRWe1ock1xsjAIccT6gr7cwT5KEbeVBLfWuMZLGZaha45WxiDfOM0vl/st8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866950; c=relaxed/simple;
	bh=sTA+/Qj4y4bkMfMX6GKIlRULy+6TsQB5JrA1uMNZwOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3pwwfWmGZUW32uUxdMPbwFQ7/PLbQFsafSmKyfvWleitUMpouG6yuniqbflMno4kGk2jyMB/tnpKkwfWXZpWK/ALeDPeDt8I41cqbUlI64JekxAulUAwsAtL1akZXaJbn2QR+vyaVoOkKJo6QtauG4w9H1CtyDCnXESnDb4FrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G4AnjSCv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G4AnjSCv"
Received: from LAPTOP-U3CCR7C6.lan (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B10220B6F00;
	Mon, 23 Feb 2026 09:15:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B10220B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771866948;
	bh=TEmmWiaUSN6agFOfmjMt3TuPh72lriTqjOKcZSmRRGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4AnjSCvhK+QilqO6lHm9BE5gW327yQdZFGR5MnNZjx88Ctx3k9JhpRvpgWk+kSSN
	 8+WgBm1+sioqh+0+poPZunyr0xgOIDDuvPGs4/rbYleoqdBzXwa9QfcfG1X3bV6nSy
	 zxSGxUJJHdGB5V03MsBlEzqVMtdrfD8WXgb0wl0I=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: tballasi@linux.microsoft.com
Cc: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	david@kernel.org,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhiramat@kernel.org,
	mhocko@kernel.org,
	rostedt@goodmis.org,
	shakeel.butt@linux.dev,
	weixugc@google.com,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com
Subject: [PATCH v7 0/3] mm: vmscan: add PID and cgroup ID to vmscan tracepoints
Date: Mon, 23 Feb 2026 09:15:41 -0800
Message-Id: <20260223171544.4750-1-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213181537.54350-1-tballasi@linux.microsoft.com>
References: <20260213181537.54350-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v6:
- Edited __entry_in_irq() to __event_in_irq() in corresponding commit
  message
- Restore an entry that was removed inadvertently

Link to v6:
https://lore.kernel.org/linux-trace-kernel/20260213181537.54350-1-tballasi@linux.microsoft.com/

Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>

Steven Rostedt (1):
  tracing: Add __event_in_*irq() helpers

Thomas Ballasi (2):
  mm: vmscan: add cgroup IDs to vmscan tracepoints
  mm: vmscan: add PIDs to vmscan tracepoints

 include/trace/events/vmscan.h              | 103 +++++++++++++--------
 include/trace/stages/stage3_trace_output.h |   8 ++
 include/trace/stages/stage7_class_define.h |  19 ++++
 mm/shrinker.c                              |   6 +-
 mm/vmscan.c                                |  17 ++--
 5 files changed, 106 insertions(+), 47 deletions(-)

-- 
2.33.8

