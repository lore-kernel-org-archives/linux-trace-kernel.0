Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312119CC37
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 06:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748326747; cv=none; b=X+Szslqf1AV06DO+Py82vpQjXCf67SF8glQ8Xr03ksAFQkIVljaKSVYyP0WdPLULhAZAaXKrR/Zp9b1DNqQyoWuMTYpn8CzA3A3ASAIy+uSgkKaDxWYZeorJYUNIr0VJFD0ob/jouGipneKlwiqanir1ZEYYSOCixOSS54pP8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748326747; c=relaxed/simple;
	bh=wHa8RIR1T5MCA0tXtO7MKyUF2oPQzBNCztzgQ5LpaiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ibhdk3ets4VFAZ/4TJRYebfjMiaQWyyhFeKzv2OenqFUe8PwzxyhJ3dT/PWb/v2aeh3uQwzG49EisCgq36P4S64hX0bcEBiL9Pz2KW9SRTqLOhhiW9aZIDo5Gi4hYC22X8T/SnGKcHh9rkRS8UH2ebPMKArK8Aotyqr/P/2kYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b62X66HkZzYQtpC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 14:19:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 070A61A0359
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 14:19:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgBXul5UWTVo93uWNg--.23840S4;
	Tue, 27 May 2025 14:19:01 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	linux-trace-kernel@vger.kernel.org
Cc: yebin@huaweicloud.com,
	yebin10@huawei.com
Subject: [PATCH v2 0/2] fix UAF when lookup kallsym after ftrace disabled
Date: Tue, 27 May 2025 14:18:58 +0800
Message-Id: <20250527061900.1533462-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul5UWTVo93uWNg--.23840S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Diff v2 vs v1:
(1) Add description for PATCH[1/2];
(2) Move judgement from ftrace_free_mem() to allocate_ftrace_mod_map()

Ye Bin (2):
  ftrace: fix UAF when lookup kallsym after ftrace disabled
  ftrace: don't allocate ftrace module map if ftrace is disabled

 kernel/trace/ftrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

