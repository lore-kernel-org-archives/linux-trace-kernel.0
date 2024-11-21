Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A324317E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732154748; cv=none; b=GPSt/PLvU47ktdG2sGSqy6olQT/li7BG7v1qFCkWzn2RtuWzLIQlxacN51O9tKNdWANsFpUjXVrQQhH/iojMkvppq4W/X11VGUCdY7Q8EgQfJw43n4kjmxDhUgA1yt2ORANmPpV1pBWaivguM36wIiaCHnT4UYpxLJWdf1Smq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732154748; c=relaxed/simple;
	bh=Wx+0sgDxigF1ZOZUI1gcvUxjN/kaDjNwtnqmoAfQQKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V98BT5PSVY8ToXFvbrP4AQ06zKeC+QJ5FvMhb8OnDYMEkBYOlt016ghdrycX2bYpo51uKZ9DjIXxxGea5wn6W6U6ycWJkXaoZ5S2gQ93hciKtSo4NzcQY8h2SgYKVUceJNZIODOAyedr1NgX2g5pVATs+0WpDbopNHd//ky3Z4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xv1jp31c5z1k0Df;
	Thu, 21 Nov 2024 10:03:42 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BA92180019;
	Thu, 21 Nov 2024 10:05:42 +0800 (CST)
Received: from ubuntu-20-04.huawei.com (10.175.103.91) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Nov 2024 10:05:41 +0800
From: Wei Li <liwei391@huawei.com>
To: <linux-trace-kernel@vger.kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<xiexiuqi@huawei.com>
Subject: [PATCH v2 0/2] tracing: Fix deadlock in hwlat tracer
Date: Thu, 21 Nov 2024 10:18:21 +0800
Message-ID: <20241121021823.1237741-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100024.china.huawei.com (7.221.188.41)

This patchset fixes a deadlock issue found in concurrent CPU-hotplug and
tracer-toggling testing:

Background: *test_hotplug.sh*
```
#!/bin/sh

while true
do
	echo 0 > /sys/devices/system/cpu/cpu1/online
	echo 1 > /sys/devices/system/cpu/cpu1/online
done
```

Test: *test_hwlat.sh*
```
#!/bin/sh

echo per-cpu > /sys/kernel/debug/tracing/hwlat_detector/mode
while true
do
	echo hwlat > /sys/kernel/debug/tracing/current_tracer
	echo nop > /sys/kernel/debug/tracing/current_tracer
done
```

v1 -> v2:
 - The previous solution try to make the mutex obtaining in kthread_fn()
 interruptible to fix this issue. To make the logic clearer, change to
 remove the mutex_lock in this version. 

Links:
 v1: https://lore.kernel.org/linux-trace-kernel/20240924094515.3561410-6-liwei391@huawei.com/

Wei Li (2):
  tracing: Allow custom read/write processing in
    trace_min_max_{write,read}()
  tracing/hwlat: Fix deadlock in cpuhp processing

 kernel/trace/trace.c       | 13 ++++++++++---
 kernel/trace/trace.h       |  2 ++
 kernel/trace/trace_hwlat.c | 15 +++++++++++----
 3 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.25.1

