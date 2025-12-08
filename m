Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472F26E6F8
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Dec 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765217666; cv=none; b=j17KdPG1HPKCwZ/GVZWnfhXAgNqaRmpGvoDOLwGItyG1laiNS+JxiCZSzdcn9hEkJDR2G9qjboDlY/6xGm7ho5SQStbtG3QrrwXki87Z03v4OJWt1cySTz3XozGO9iJ+Vv++AWz+dYiwMp4bn6gm9rUat0RVdE0FIBNtiGSYqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765217666; c=relaxed/simple;
	bh=muc1mG2ERP/M3Zh1jlRCvBDhZAl34GyGTvjsUlOOb8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d4AIJxPxZmf4dquoG2O4T74xW9ABdHd34MmXLmkla0iD4cNimRrJsRF4JU+5ucal0RcwTRuiMNon+aUxYaEROFL5TdPzXaXQqIOq7pbsE7GyhmXxD3PEHtTU0v+jhUZrH5BYKbKtTJa+xA4/5UR45MAmImFXzMuB5LBflGrByJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i9+iKU6c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i9+iKU6c"
Received: from LAPTOP-U3CCR7C6.lan (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7680C2116040;
	Mon,  8 Dec 2025 10:14:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7680C2116040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765217664;
	bh=/mcwk57ne9/7uAszSiZB6wrrm5ildKtYBE6w8IXAufY=;
	h=From:To:Cc:Subject:Date:From;
	b=i9+iKU6cHJjd6p2aBNDXdIRN/EIuJOBu0JRmx2yOj0KmZcru0yu0x32gtWs2gMQBY
	 aX0Dx41D93OM56Q1VNzeg1vtn9laLwYJzHWt9Pbqq6UZX9EouqSJAh/KTaORSsHyzK
	 ZdVDtiaCxWvO/953AmlK+aHFnPQDVEOAYXa2AXjI=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm: vmscan: add PID and cgroup ID to vmscan tracepoints
Date: Mon,  8 Dec 2025 10:14:11 -0800
Message-Id: <20251208181413.4722-1-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attributing tracepoints to specific processes or cgroups might happen
to be challenging in some scenarios.  Implementing additional context
to these tracepoints with PIDs and cgroup IDs will help improve
analysis.

Signed-off-by: Thomas Ballasi <tballasi@linux.microsoft.com>

Thomas Ballasi (2):
  mm: vmscan: add cgroup IDs to vmscan tracepoints
  mm: vmscan: add PIDs to vmscan tracepoints

 include/trace/events/vmscan.h | 77 +++++++++++++++++++++++------------
 mm/vmscan.c                   | 17 ++++----
 2 files changed, 60 insertions(+), 34 deletions(-)

-- 
2.33.8

