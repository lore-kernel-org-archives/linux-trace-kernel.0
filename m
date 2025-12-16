Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156C1BEF8A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893811; cv=none; b=lK3/ZdKEN51APcJTJCNEaHd0pUgqqJ5MijVXvcUAcbm0kmxcK8LxjikF5rUPeUIBPJmUmhT6Tx9h5C9FvaKmFj7SrvrwlZb2+cXpOEoCDtWX/d6zzVTRlF+O9xwLKZ07bm7SqUOGHVFqGs8bMgMSlPZzBb+5NXdD9O+b9sHyIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893811; c=relaxed/simple;
	bh=oCWfpu9rvsXOwRWe6BvX0AmDg0zv4bH8u26hjaPXmXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgB87jKNZ0+fN6QQrFeuT5brNSloHiZAq1mvPVV4g0FGFjnG9zmk/5tHzptQ0CwWU8wNRDYdLsSEV5OFuKqDQ9ShSJMbdAUARdi2BUpKpmCv3p0D0+JONShfqy1+4cN5VR8GjO7KXpLIqQU55sxjPwSL83ATbHkw2kKIwtQ4t/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bnjcpn99; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bnjcpn99"
Received: from LAPTOP-U3CCR7C6.corp.microsoft.com (unknown [40.68.199.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90FE0200D625;
	Tue, 16 Dec 2025 06:03:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90FE0200D625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765893806;
	bh=ESdp0QKInqUOJAUdSgLqUxfxTAswaee7nnyHp/EI2kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnjcpn99CN0FZBzx2pfhnThcNjtJfMvn23jLeWoEwgbE5AeJ4btjN7u7gQSieacEU
	 oO2t+9RyYwa3jkG+CSVwJoZrDmP+l+OroRB42+zF3CL54AzJlQWbWsMCLIZbvbfl11
	 L0q/w7bkWgpIPtxqOFSOOTBbEVYkesmF/1YHLf/k=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm: vmscan: add PID and cgroup ID to vmscan tracepoints
Date: Tue, 16 Dec 2025 06:02:50 -0800
Message-Id: <20251216140252.11864-1-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208181413.4722-1-tballasi@linux.microsoft.com>
References: <20251208181413.4722-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Swapped field entries to prevent a hole in the ring buffer

Link to v1:
https://lore.kernel.org/linux-trace-kernel/20251208181413.4722-1-tballasi@linux.microsoft.com/

Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>

Thomas Ballasi (2):
  mm: vmscan: add cgroup IDs to vmscan tracepoints
  mm: vmscan: add PIDs to vmscan tracepoints

 include/trace/events/vmscan.h | 77 +++++++++++++++++++++++------------
 mm/vmscan.c                   | 17 ++++----
 2 files changed, 60 insertions(+), 34 deletions(-)

-- 
2.33.8

