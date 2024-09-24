Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D7482D8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171627; cv=none; b=O5ryPieSVihGxa04E+eMaO3EepefdowpBoGASrX81XpIADUf+/ezerj/U52ORItaG9aWxWn5ygl3I80uU7YYMyoCq2umQIUnYirX5+hyvuU0E2gYMlLama2z20ODl4/XrUkLEOATkdnvvNlN1XDwPDZT4H1X/oG+pguJ2DLsNfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171627; c=relaxed/simple;
	bh=42GKBYerDY1X45zKFCLgDMgy9yUUtBiuSa6LngSrzXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EhKW+6BVd45g8EijAKVf6DXES4a1B4cOVIu+sZAOs1wyhy4paCJraFlIKcjR2o/998JDQGwXeu6NXmuk98EqpIncSQqs8hjiZ8eOuynjyzKoZ5mInwnfwTBXAAiHBGwbaaNf7RJhjdA0IQd49woZW1ARl1+HuY6YYPNdd/VntEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XCZsz6FCfz2QTxP;
	Tue, 24 Sep 2024 17:52:55 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id ADD6E1A0188;
	Tue, 24 Sep 2024 17:53:41 +0800 (CST)
Received: from ubuntu-20-04.huawei.com (10.175.103.91) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Sep 2024 17:53:40 +0800
From: Wei Li <liwei391@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>
CC: <linux-trace-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>
Subject: [PATCH 0/5] tracing: Fix several deadlock/race issues in timerlat and hwlat tracer
Date: Tue, 24 Sep 2024 17:45:10 +0800
Message-ID: <20240924094515.3561410-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100024.china.huawei.com (7.221.188.41)

These issues are found in concurrent CPU-hotplug and tracer-toggling
testing, the test cases are as follows:

Background: *test_hotplug.sh*
```
#!/bin/sh

while true
do
	echo 0 > /sys/devices/system/cpu/cpu1/online
	echo 1 > /sys/devices/system/cpu/cpu1/online
done
```

Test 1: *test_timerlat.sh*
```
#!/bin/sh

while true
do
	echo timerlat > /sys/kernel/debug/tracing/current_tracer
	echo nop > /sys/kernel/debug/tracing/current_tracer
done
```

Test 2: *test_hwlat.sh*
```
#!/bin/sh

echo per-cpu > /sys/kernel/debug/tracing/hwlat_detector/mode
while true
do
	echo hwlat > /sys/kernel/debug/tracing/current_tracer
	echo nop > /sys/kernel/debug/tracing/current_tracer
done
```

Wei Li (5):
  tracing/timerlat: Fix duplicated kthread creation due to CPU
    online/offline
  tracing/timerlat: Drop interface_lock in stop_kthread()
  tracing/timerlat: Fix a race during cpuhp processing
  tracing/hwlat: Fix a race during cpuhp processing
  tracing/hwlat: Fix deadlock in cpuhp processing

 kernel/trace/trace_hwlat.c   |  5 ++++-
 kernel/trace/trace_osnoise.c | 22 +++++++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.25.1

