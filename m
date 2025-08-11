Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF452DA769;
	Mon, 11 Aug 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899300; cv=none; b=c2W1noUhoTUXEu2wosPk950Ak7FFsn+woEfFUebHymiD0tRYdMOcyyyFMDNRFdsnDzaqlMsvgsO5Ds1kC713mSgXnlM5Ls5B10VzJ3vaTOeMPwt3Q9+fJX820t5GnK8HwrBaNU4mcyu4dtytHJ3/UHiY3DptxcRAXCSiKxBumus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899300; c=relaxed/simple;
	bh=Lh5cUaZSdvKQ3a2QOUEXnA96+AwWHIMu+wH1lc4AguU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gS5t1yy/CiL0hzoBGen/YZFgQFo8GRuFi40E4xQySUC5223K1vLp0H+VYN9b93YIa6mBQ8NZiBybZAFyrAOR+3/UqYZ2uzOewVTdpTpaqRdbdz4mn+aZLy2/Ew0D2/G0pTQTo+i+7phfEYsxQ5YF2yxCAo//z0byyDnqiW/mcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] trace/hwlat: Add WARN_ON in move_to_next_cpu()
Date: Mon, 11 Aug 2025 16:01:09 +0800
Message-ID: <20250811080109.8417-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Add a WARN_ON check in move_to_next_cpu(). Next_cpu should
never be greater than or equal to nr_cpu_ids.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 kernel/trace/trace_hwlat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 2f7b94e98317..5024b0dcdbba 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -328,7 +328,7 @@ static void move_to_next_cpu(void)
 	next_cpu = cpumask_next_wrap(raw_smp_processor_id(), current_mask);
 	cpus_read_unlock();
 
-	if (next_cpu >= nr_cpu_ids) /* Shouldn't happen! */
+	if (WARN_ON(next_cpu >= nr_cpu_ids)) /* Shouldn't happen! */
 		goto change_mode;
 
 	cpumask_clear(current_mask);
-- 
2.36.1

