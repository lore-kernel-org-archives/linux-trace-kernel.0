Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19AC3EBF34
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Feb 2026 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006550; cv=none; b=Ki5yPDMum/fuG8HPgu6QHOk2hlr5y9r7yE+ABEuN5ZZ5gOScMW8MPwag10QqA3pXGTlhojGr8lDok6bClO0G60MCkSsvzphEsz8qMPAWG/vvAAyGdknzC3Pfv/5YY0A4cvwlQbrJCPHmIeN4d5xxsJqtZlf0h9/DxhX0vOqjL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006550; c=relaxed/simple;
	bh=L2bagtrtmzQw8y9GCSxcHg3Xp0dc/LHji/0yjtyF2g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8/JihlbMkErmsNXxmTAvVYXoeB2HWGvCj/+5k7/e6W+BPKy3CZ1c45immW0AuckVnmOwAob0x+UoeHxL5Z//oUh1lx57864sJBahRIC5O8BeSCuB+7jyVYtBmDSLRW7yKC+2uPrVOxIn1vi1HJIf+Xilu/AJVxY3KY9B6VXaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eujRomCG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eujRomCG"
Received: from LAPTOP-U3CCR7C6.lan (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id A2BDD20B7165;
	Fri, 13 Feb 2026 10:15:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2BDD20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771006548;
	bh=eIWSUeA5jrXy2GEYqMyI4qiE4CqcAnCn+rGFRu1MjD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eujRomCGGvJ10SwXSjJwRAaEgWNw39PibhIQW9VyxbG7nZJCXPZ3+JdL1cNSj+3My
	 N7ZVwTIZ0XVs4s6ce+TRgjwEvlNXchGJWpsoj+ct5eOUNj1O8NQayLbxHTUo7MWLhw
	 JM+aZKZp0Q7+ofMKoNIEdhAYNG3tOIbxMOV/yXtM=
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
Subject: [PATCH v6 0/3] mm: vmscan: add PID and cgroup ID to vmscan tracepoints
Date: Fri, 13 Feb 2026 10:15:34 -0800
Message-Id: <20260213181537.54350-1-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122182510.2126-1-tballasi@linux.microsoft.com>
References: <20260122182510.2126-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v6:
- Updated Steven's patch with sign-off
- Passed memcg pointers as arguments in tracepoints instead of memcg_id

Link to v5:
https://lore.kernel.org/linux-trace-kernel/20260122182510.2126-1-tballasi@linux.microsoft.com/

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

