Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75022221DB9;
	Mon,  7 Apr 2025 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743998318; cv=none; b=ERa0epVzXELbn1QoHCP4eRWLmdXcOhH2tHbB8cCfmbfyDeMxRFE4Ow0JJfw5+O+PXoLJiIi8jhamtk6AzPzrge3M/F60nhyZ3qM6NRq3phu8P9E4VS/OzKqHrKybM3SmNE7gwydAw7/chtLoVdmkllx1ib2a+Xaq5aMF5j1JOls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743998318; c=relaxed/simple;
	bh=KHlz4rXnqQ+ecI/CPSK09l1Xo/uUS/AZmlEWjL33yxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ur5bFZpGc/oF4kjhlq8unD8sXwqkjSfpA8cLXjpxbL9SzS9qQMyA7jueM0TK9ss41YPQ/rU4WcHBFR7A7zfYY8k8wDkXWLL/O/RWPbfWeONlwG2PM1x0JdTDq88ZnfWkr8W2HhoNPy1emPCj2Yva3lsF3tnFUNe1jfQ3I+TlSrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=czGodIH4; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="czGodIH4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743998302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dsPS1ukzaRmmzRZaoJiWc+UdrLWIkrWTXCj5BDKYrtM=;
	b=czGodIH4P9ibT2cB4kOInm6jCe9DSn+W6ApATCSeTJUJiumLGtsJjqMZ9k3NXathJv0YFh
	z0PdHNU4m+cYTP7X4iQ8Fj4e2UtXvOvFTdXD9Y305xLCC8SGiTrlZNO0Y8uwwC/RvinoCT
	6+o7BPyczyS1DZ2GZc+VTgsTvsB+ASw=
From: Tao Chen <chen.dylane@linux.dev>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	laoar.shao@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 1/2] bpf: Check link_create parameter for multi_kprobe
Date: Mon,  7 Apr 2025 11:57:51 +0800
Message-Id: <20250407035752.1108927-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The flags in link_create no used in multi_kprobe, return -EINVAL if
they assigned, keep it same as other link attach apis. Perhaps due to
their usage habits, users may set the target_fd to -1. Therefore, no
check is carried out here, and it is kept consistent with the multi_uprobe.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

Change list:
- v1 -> v2:
    - remove target_fd check suggested by jiri.
- v1:
    https://lore.kernel.org/bpf/20250331094745.336010-1-chen.dylane@linux.dev/

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 13bef2462..5cd0af80f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2992,6 +2992,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	/* no support for 32bit archs yet */
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
+	/*
+	 * Perhaps due to their usage habits, users may set the target_fd to -1. Therefore,
+	 * no check is carried out here, and it is kept consistent with the multi_uprobe.
+	 */
+	if (attr->link_create.flags)
+		return -EINVAL;
 
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
-- 
2.43.0

