Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567DF1547D2;
	Wed, 13 Aug 2025 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755052270; cv=none; b=sv6/7K1KhWYBoa0iLWBSTiNUfgWqqmN2sbkvp8EAMiPq37Yl6Q+zuwPf9X7yWtqIz0zOqFQlvz/SNRzuDQb1mD8bfNQGMJZ5iULN7MsSE1LKrssx3rimRCVyZkpQ7MepnixfFTd5haZ6MPfdobocV/OBj41tDPK/7hXGZseWneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755052270; c=relaxed/simple;
	bh=xJ7SzZ6tPkIImZS9Gq/kT8Rs6ex1QRx0V77c1zgP+ic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QqtBhfyKJ+CuXA2tQ1ylJZC1sDPNE4X60myfVWLM2oinf49mkP8IQ4mV4zg12B16mcObIs05mM+A/z5kS9GOk+gscdhSogliT/S95frIMHaCBXHpmyOhhlxRwgG0BGFpDenL4nPNSSAjUkSpNbrFRhGP5vZZE/vIPfhr/GlaKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1sn663KyzKHMlM;
	Wed, 13 Aug 2025 10:31:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 19BF91A0DD3;
	Wed, 13 Aug 2025 10:31:06 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgCXExTn+JtoJBUADg--.30982S2;
	Wed, 13 Aug 2025 10:31:05 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH -next 0/2] ftrace: Some minor fixes for set_ftrace_{notrace,filter} file handling
Date: Wed, 13 Aug 2025 02:30:42 +0000
Message-Id: <20250813023044.2121943-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExTn+JtoJBUADg--.30982S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrW3GFyfuF18GrW7tr18Krg_yoW3Krc_uF
	Wkta4DZw1UCas7ta93AF13AFyjkFWjqr4rZ3WktFyUJ345Jry5Ja1fJwnxX3W8XFWjqFyf
	JrsIvrs5Gw1ayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hello,

This patch series addresses two issues in the ftrace subsystem related
to the handling of set_ftrace_{notrace,filter} files.

Patch 1 removes an incorrect free_ftrace_hash call in ftrace_regex_open()
that could lead to use-after-free when seq_open fails.

Patch 2 fixes a potential use-after-free scenario that can occur during
concurrent read/write operations on the set_ftrace_{notrace,filter} files.

Both issues were reproducible. This patches aims to fix them.

Best regards,
Tengda

Tengda Wu (2):
  ftrace: Remove unnecessary free_ftrace_hash in ftrace_regex_open
  ftrace: Fix potential use-after-free for set_ftrace_{notrace,filter}
    files

 kernel/trace/ftrace.c | 28 ++++++++++++++++++++++++----
 kernel/trace/trace.h  |  2 ++
 2 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.34.1

