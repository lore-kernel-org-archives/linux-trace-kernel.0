Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD4333431
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707268; cv=none; b=WLTA865+BqGdfX2KsAiHCjSwMS2ciE+avUaujn7A07F3XMFD+ZtKGy0jMbfEZeJWFEOrxZZK7XW1DQ17NwlPmIjKk7HHaCzamdckiy2cjhAiGCcJxqpxfqjScaM3NKSB8++xvpR6M3aRw9oyp0u/aZh0qSHu+2oRs7gB7u+noT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707268; c=relaxed/simple;
	bh=X0mhfphzyzLPUFjrtvGZjqO0h8g5+dpKSw/dmcSM54k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUcr9jvliWAFdd+zrGesRaRV4472Pt5cz24RzitSltH43VvSZq472UE9B+IY5HM3SmRMb1Hv1w88DGZsjrtgzKsEg6d+0bnUn/W56yVDiYK8sfqajayZytXocSG5qHehV4njfAA6vQ9gTerKFB/E4RH4MQZWf0bBi1gz1nFTBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFb09nl1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFb09nl1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2PckU0JC5Ea9d4GrF2OBPBlpYWIkdOC3Apu6J3z5gQ=;
	b=XFb09nl1K//YKAlsLVv/4x6I+ISVoBHN2Ng6rCNYR9xog7MsCwgWQ6Rs0KNAL8yc5v7ygq
	3mE3VdN1P1WjiwQY2W8Y8muhWDpFq/wSt09mZSi+GGnEST8uFdjI9tAh0TE1wdfCQUlNF9
	pP5TSjKgfrYm9q6tPBuMzXWNe/fPJ4U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-oRXwTd-_OTqtkSl4qfStLA-1; Tue,
 06 Jan 2026 08:47:44 -0500
X-MC-Unique: oRXwTd-_OTqtkSl4qfStLA-1
X-Mimecast-MFC-AGG-ID: oRXwTd-_OTqtkSl4qfStLA_1767707263
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D0191956068;
	Tue,  6 Jan 2026 13:47:43 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42DE21800667;
	Tue,  6 Jan 2026 13:47:39 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 16/18] rtla: Ensure null termination after read operations in utils.c
Date: Tue,  6 Jan 2026 08:49:52 -0300
Message-ID: <20260106133655.249887-17-wander@redhat.com>
In-Reply-To: <20260106133655.249887-1-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add explicit null termination and buffer initialization for read()
operations in procfs_is_workload_pid() and get_self_cgroup() functions.
The read() system call does not null-terminate the data it reads, and
when the buffer is filled to capacity, subsequent string operations
will read past the buffer boundary searching for a null terminator.

In procfs_is_workload_pid(), explicitly set buffer[MAX_PATH-1] to '\0'
to ensure the buffer is always null-terminated before passing it to
strncmp(). In get_self_cgroup(), use memset() to zero the path buffer
before reading, which ensures null termination when retval is less than
MAX_PATH. Additionally, set path[MAX_PATH-1] to '\0' after the read to
handle the case where the buffer is filled completely.

These defensive buffer handling practices prevent potential buffer
overruns and align with the ongoing buffer safety improvements across
the rtla codebase.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index e0f31e5cae844..508b8891acd86 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -317,6 +317,7 @@ static int procfs_is_workload_pid(const char *comm_prefix, struct dirent *proc_e
 	if (retval <= 0)
 		return 0;
 
+	buffer[MAX_PATH-1] = '\0';
 	retval = strncmp(comm_prefix, buffer, strlen(comm_prefix));
 	if (retval)
 		return 0;
@@ -750,6 +751,7 @@ static int get_self_cgroup(char *self_cg, int sizeof_self_cg)
 	if (fd < 0)
 		return 0;
 
+	memset(path, 0, sizeof(path));
 	retval = read(fd, path, MAX_PATH);
 
 	close(fd);
@@ -757,6 +759,7 @@ static int get_self_cgroup(char *self_cg, int sizeof_self_cg)
 	if (retval <= 0)
 		return 0;
 
+	path[MAX_PATH-1] = '\0';
 	start = path;
 
 	start = strstr(start, ":");
-- 
2.52.0

