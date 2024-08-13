Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FFB194A6B;
	Tue, 13 Aug 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549614; cv=none; b=TO1ah8EuSrduF4R+l33t9E/6UmJRY5Vg/W12bXa0PES6QcQLWc6C2+m8/6IHzXqkvTpQKASwLjsoHbSKv6ZIjs479XaBM0p8Q1A6lPqjOMoLJOzdoUHu76vwlT+aoRcO7gU59Lfewj1jN0pYXW3mK+Ly299cJ9HVWuCARO8aDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549614; c=relaxed/simple;
	bh=MAmrxpD9wvZgKozC9uZnUlR3orbBDYiN6UzZ+jrxcKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FcBvJzPtEWe83XxrKE6i5zbOQ+IIfIAuVFjqoeha0i1vAztvbn0uglQ/kasElcN9SrID/7Rhwd20AcfnexYS+Mcm9FVPPaFHC49SinNgIwxYVp9ekt7Xut29dB9v7hRVHsBU/0rVc2NYoD8DzCMIr9BbIkiWuHP82W+T3kjjzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WjqHW2qntz20l3L;
	Tue, 13 Aug 2024 19:42:15 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B32E140134;
	Tue, 13 Aug 2024 19:46:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 13 Aug
 2024 19:46:47 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <naveen@kernel.org>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <mhiramat@kernel.org>, <kees@kernel.org>,
	<gustavoars@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 0/3] kprobes: Annotate structs with __counted_by()
Date: Tue, 13 Aug 2024 19:53:31 +0800
Message-ID: <20240813115334.3922580-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Annotate structs with __counted_by() for kprobe and do some cleanup.

Jinjie Ruan (3):
  kprobes: Annotate structs with __counted_by()
  kprobes: Cleanup the config comment
  kprobes: Cleanup collect_one_slot() and __disable_kprobe()

 kernel/kprobes.c | 87 ++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

-- 
2.34.1

