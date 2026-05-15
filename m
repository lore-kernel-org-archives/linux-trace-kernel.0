Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763993803DE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874131; cv=none; b=gUNEQ4mjPMvSx3kIGNdU3IA5WhAnidToEce0z65mvAQ5NUvbjr7jlR11NhgipEA/TUQoxoB0+QlLRPvdfg6H21E0DxeFKY3jwADeLCAaEtopA47Pj2rxGBJ71IwsjUl/gbht6C5xYOzwPRJYGSsA5xLhlA/JIJtntuRj0tOC6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874131; c=relaxed/simple;
	bh=GB7uYwlJ1jSkZyTTm42CbIZkwxhi7MhCoqEqceJHYZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=e43oGRd8qz7j3i/VI4ESNEVRaYPzOBTcFz8cjWIoAQ/fGgHXFMRXFbnilI1yP1KtO8WJj37JJoEdQbiDGjvPBHHaZNpEAwCw3BQUxW0Phq1WMKyXgEzkh4telmJ/yPT6B5EyBXm+KCcS50PTJt4rjjzY/s2AIy877iy/mJGzFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iB/DfYJs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iB/DfYJs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778874129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPYYWfo6YyDgCo6bIAWDHWB7M/pdv+lxEMFGgnS1HbA=;
	b=iB/DfYJssl1m8cIv4wRVXKQm+g59N4t85uDJRMMGWHXXNDrJPYe2ThX260yZEY88wzxKmp
	fFA97c8lpvtT3CVZ3Y2Ajg9KnZVE3YeLqxVEZC3pw9YGV1N6vowFUIAXSPRXccq+rFwGgO
	eVu8DEX2+wG2deYwb7g7q8YuIYvXqZE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-3XA6R_euOFqCIUw-X8MxTg-1; Fri,
 15 May 2026 15:42:07 -0400
X-MC-Unique: 3XA6R_euOFqCIUw-X8MxTg-1
X-Mimecast-MFC-AGG-ID: 3XA6R_euOFqCIUw-X8MxTg_1778874125
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 932B119560A7;
	Fri, 15 May 2026 19:42:05 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC8321956053;
	Fri, 15 May 2026 19:42:02 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v4 3/3] tracefs: make root directory world-traversable
Date: Fri, 15 May 2026 15:40:07 -0400
Message-ID: <20260515194010.93725-5-ashelat@redhat.com>
In-Reply-To: <20260515194010.93725-2-ashelat@redhat.com>
References: <20260515194010.93725-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: ZapTMiDzStVTgBGajqRtPxf5Wyr838FLojh78rzICF4_1778874125
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Change the default tracefs mount mode from 0700 to 0755. This allows
unprivileged users to access the eventfs directories underneath which
already use 0755.

Tracing data files use mode 0440 and 0640 so they are not exposed by
this change. Only the format and id files, which have been marked as
work-readable, become accessible.

Directory listings of kprobes and uprobes, which contain functions or
binaries, become visible to unprivileged users but do not contain kernel
addresses. Admins using probes can restore the previous behavior with
chmod or mount -o mode=700.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index f3d6188a3b7b..3a6a0c800a8b 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-#define TRACEFS_DEFAULT_MODE	0700
+#define TRACEFS_DEFAULT_MODE	0755
 static struct kmem_cache *tracefs_inode_cachep __ro_after_init;
 
 static struct vfsmount *tracefs_mount;
-- 
2.54.0

