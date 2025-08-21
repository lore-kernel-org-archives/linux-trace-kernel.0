Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD27A20B218;
	Thu, 21 Aug 2025 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739244; cv=none; b=VHkN7ihNVQoHbggsHficobsmxeW4jUO9HmQWh6ypMwV4X1sFHQ9iedQ3YI0aR9O/Lvk7iOR/KPc/peQJD7YqXhyXyngQ+PDDk/0mxgOHO6n/2FTAQMwFpl9O4hL1TSPnacAe5SC223aMb4qvy7G/yDgbOETWwC1TWHklempBM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739244; c=relaxed/simple;
	bh=2Im1gL2obdB62T9xMzICbbwLbV0tkLiYI+xcOqDcWHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P2XB2RQ9EVnq300Z8+7dExbrWxh0mVNDUiu1ryYvfVR8FC7jJj91dUFEP4/0h7hXz5tOTVDt5L5ps/wgBIGXmvrHAG+cegSiUfnobISMSbPt8b2F2vW61KuPtDwZv02FAcHiuIQgoOcw1O0s1T7Zg+LgIOh20rm6pFQPMK+tFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c6lms0bk3z2TTH7;
	Thu, 21 Aug 2025 09:17:49 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (unknown [7.202.181.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 0892A1A0171;
	Thu, 21 Aug 2025 09:20:39 +0800 (CST)
Received: from ultra.huawei.com (10.90.53.71) by
 kwepemh200013.china.huawei.com (7.202.181.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Aug 2025 09:20:38 +0800
From: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <dhowells@redhat.com>,
	<wsa@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] i2c: Fix OOB access in trace_event_raw_event_smbus_write
Date: Thu, 21 Aug 2025 01:23:12 +0000
Message-ID: <20250821012312.3591166-1-zhangxiaomeng13@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh200013.china.huawei.com (7.202.181.122)

The smbus_write tracepoint copies __entry->len bytes into a fixed
I2C_SMBUS_BLOCK_MAX + 2 buffer. Oversized lengths (e.g., 46)
exceed the destination and over-read the source buffer, triggering
OOB warning:

memcpy: detected field-spanning write (size 48) of single field
"entry->buf" at include/trace/events/smbus.h:60 (size 34)

Clamp the copy size to I2C_SMBUS_BLOCK_MAX + 2 before memcpy().
This only affects tracing and does not change I2C transfer behavior.

Fixes: 8a325997d95d ("i2c: Add message transfer tracepoints for SMBUS [ver #2]")
Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
---
 include/trace/events/smbus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
index 71a87edfc46d..e306d8b928c3 100644
--- a/include/trace/events/smbus.h
+++ b/include/trace/events/smbus.h
@@ -57,6 +57,8 @@ TRACE_EVENT_CONDITION(smbus_write,
 		case I2C_SMBUS_I2C_BLOCK_DATA:
 			__entry->len = data->block[0] + 1;
 		copy:
+			if (__entry->len > I2C_SMBUS_BLOCK_MAX + 2)
+				__entry->len = I2C_SMBUS_BLOCK_MAX + 2;
 			memcpy(__entry->buf, data->block, __entry->len);
 			break;
 		case I2C_SMBUS_QUICK:
-- 
2.34.1

