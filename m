Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC5022258C;
	Fri, 23 May 2025 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747989598; cv=none; b=u4ufNv0PO24WFpBCLXZ5FH0nXr+Uhq35lu34eaz35DB5ZDEwqczZh/FZkZnPcbT28KRS0oGbpYYowD0Eu90hmURB2Q4NIyzA0FRxCLdO2nzwJBFoQ/nacJ6HFx6JL6AvWPtVopUaf98nv4tAvBCpaXPFdS3zdlQJsCJCbBXYq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747989598; c=relaxed/simple;
	bh=XrxlGZ2vZWMG1BomZUUYV+LNs6CaeKQykd9TeLO2bP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPIRQFGD8hUMzJSuTEduuv0DISXiOghZScQDPqdhF0TnUDzGDG7NiFq43b7QpW8thp6Ngoef9fYUMxTjPF4d8tXmIEHRL28SEPS5WyurpZ35rjvbVnhZxUGseD9YOZ5S24VHoDIy2oSP6E5enBzhYa0Sb0FcwjbuQZbgbFE0huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b3dqs3Cqpz4f3lDG;
	Fri, 23 May 2025 16:39:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 121FC1A0FEE;
	Fri, 23 May 2025 16:39:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgAXe19RNDBohGAJNQ--.35755S6;
	Fri, 23 May 2025 16:39:47 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yebin10@huawei.com
Subject: [PATCH 2/2] ftrace: don't allocate  ftrace module map
Date: Fri, 23 May 2025 16:39:45 +0800
Message-Id: <20250523083945.3390587-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523083945.3390587-1-yebin@huaweicloud.com>
References: <20250523083945.3390587-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe19RNDBohGAJNQ--.35755S6
X-Coremail-Antispam: 1UD129KBjvdXoWruFykXr13Cw4UGr47GF45KFg_yoW3Zrc_X3
	WkXwn5Gr1xCwnayrs3AFZ3Za4vg3ykWF10y3W2yFW5Aa4UZrn5Ja4fJ3sxGrs8ZFW8Was3
	Xr13WFy0gF13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrw
	CF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
	LvtUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

If the ftrace is disabled, it is meaningless to allocate  module map.
So add check in ftrace_free_mem().

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/ftrace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ff5d9d73a4a7..56adf45de92e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7824,6 +7824,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 
 	mutex_lock(&ftrace_lock);
 
+	if (ftrace_disabled || (mod && !mod->num_ftrace_callsites)) {
+		mutex_unlock(&ftrace_lock);
+		return;
+	}
+
 	/*
 	 * If we are freeing module init memory, then check if
 	 * any tracer is active. If so, we need to save a mapping of
-- 
2.34.1

