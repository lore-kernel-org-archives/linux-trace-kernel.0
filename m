Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5FD1AC44D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748326753; cv=none; b=uGrjvrDSzN+E3UAqTM+nXzRvRKOkzzogEGAMxwi8KWrs2dNSCJoxngxw23NdGWPMrH4Y8RVjj+xGYiZtbtpKirSJKQIM8WAl5v4wu5kKdIg+CVtI7wv0dK83Oj+ySpCUfr8PaFzsTDRp37Musw6/cSC7M3ISnuW6fpt7kDEwb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748326753; c=relaxed/simple;
	bh=9YjYL/D5WD659JrEORf3GTCYoRum7YgcIs+QPawpLHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZubQvf03rlDrliPK/rOKALcd+YCjAxesI6zBIj27oFQjOkxVZ5gxem0Ik0cIYjHDQabh+k20kB1/RHUMbt69w/hsc3OnobRW/wiOgmtnD5RYa0dC8R+v0ixUBP9eGPwGTMJwzCJxnlzmQ1CFIC9XOSTDMsY9an9htnamZbF4us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b62X8219wzKHMjt
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 14:19:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B51C01A19CD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 14:19:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgBXul5UWTVo93uWNg--.23840S6;
	Tue, 27 May 2025 14:19:02 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	linux-trace-kernel@vger.kernel.org
Cc: yebin@huaweicloud.com,
	yebin10@huawei.com
Subject: [PATCH v2 2/2] ftrace: don't allocate ftrace module map if ftrace is disabled
Date: Tue, 27 May 2025 14:19:00 +0800
Message-Id: <20250527061900.1533462-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250527061900.1533462-1-yebin@huaweicloud.com>
References: <20250527061900.1533462-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul5UWTVo93uWNg--.23840S6
X-Coremail-Antispam: 1UD129KBjvdXoWruFykXr1rAFW3Cw47KF18AFb_yoWxZrg_ZF
	yUX3W8KryxCwn2vr4SvrZ7XF1UKw1UuF10kwn3tFW5J3WDXrn5G3W7C3sxCF42gFy8Wa9x
	ZFnFqa40gF13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbv8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUUApnJUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

If the ftrace is disabled, it is meaningless to allocate module map.
So add check in allocate_ftrace_mod_map().

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ff5d9d73a4a7..1cac568a031c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7626,6 +7626,9 @@ allocate_ftrace_mod_map(struct module *mod,
 {
 	struct ftrace_mod_map *mod_map;
 
+	if (ftrace_disabled)
+		return NULL;
+
 	mod_map = kmalloc(sizeof(*mod_map), GFP_KERNEL);
 	if (!mod_map)
 		return NULL;
-- 
2.34.1

