Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2362AF12
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Apr 2025 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743998312; cv=none; b=ijO1U6YLRxYJq7iEW+VrUGmad6H0Q3ZKEN3jtGocYZr4RIKq69mHhBv6mRECvk0m4LoqdqbbrEq6O+ycTvJJeA/kwOhxeJUwcW57jxtwRfbbcOU2GK2F5fOSVfM4ebWKuLVnCqU7vQWCyWgjjcDJmiZSQHhdhBMFO+P1GhVEnSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743998312; c=relaxed/simple;
	bh=BIlbZF3iV+QVpyMykufAeNj4wkuzozgFPne1hrPZnSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PgmvUKgMoMAS3m9gXQZnWw0W2ebWi3uv3z0wjlpoJFMElFOPLR1O2ZcCO6pORX3Ex5ezek6odPyQ4qV8xqsQMTvY3aILAoiNTORqyJNSUygZkqW/WV4F7y+szMrXU0yVyDxsmem+LDxnGxGL13YbZFuqsvrfX40hjlqUrHieY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CHgVBwLN; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CHgVBwLN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743998307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9Ar0FtEi34Mw+74zltwC/KGO/CzF9ZVivgvMAlfxGQ=;
	b=CHgVBwLNlMR6r7Y6PxEBInONVSz9QcamkCq9i4rz6RZLoEepPPmJZh+NpsnLwd+U7wZlZV
	2lS0dwoW/OXOw+CB/UA5I+S46YkZCiaR31dvDs5MyYec/HZVB2+xX0s6lEUAt+mosWlU5D
	1v0/KIL6aBXNWh+zXylUdR+7nOIoXB8=
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
Subject: [PATCH bpf-next v2 2/2] bpf: Check link_create parameter for multi_uprobe
Date: Mon,  7 Apr 2025 11:57:52 +0800
Message-Id: <20250407035752.1108927-2-chen.dylane@linux.dev>
In-Reply-To: <20250407035752.1108927-1-chen.dylane@linux.dev>
References: <20250407035752.1108927-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The flags in link_create no used in multi_uprobe, return -EINVAL if
they assigned, keep it same as other link attach apis. And the target_fd
sometimes will be initialized -1 such as probe_uprobe_multi_link in libbpf,
so do not check it at the current stage suggested by jiri.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5cd0af80f..0f4085e8d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3387,6 +3387,13 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	/* no support for 32bit archs yet */
 	if (sizeof(u64) != sizeof(void *))
 		return -EOPNOTSUPP;
+	/*
+	 * The target_fd sometimes will be initialized -1 such as
+	 * probe_uprobe_multi_link in libbpf, so do not check it at the
+	 * current stage suggested by jiri.
+	 */
+	if (attr->link_create.flags)
+		return -EINVAL;
 
 	if (!is_uprobe_multi(prog))
 		return -EINVAL;
-- 
2.43.0

