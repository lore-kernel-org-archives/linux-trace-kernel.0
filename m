Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9187256C6F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695373; cv=none; b=hF9YyvlgoZyNAghKcCeZmTa4E1xalLIkT5YEO3YnzXzAKUI4NvSHHlO0y5YSPUBO8anHEDylvyNrUwDWIurfrNjUPVPRKzEwBE+JqMHWui6kh9jFIYjK0pRth6fm0PFhME9UraO2uL46fy6aQBscsQzjbIRpO0a1iHzM2i6xhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695373; c=relaxed/simple;
	bh=ajRpq1GzQ56St4V4W5+oRTI7sM7spb1h4Gks2bZSyjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgNULTDsJGyx8CC/9Iy0TGeDndrM+nifvcGehQ1dxQ47J4cGP6A2svv4O2hbRPpGbkDdsq6pBZ83VZlW3j0d7tUBCC2wiDEo9a/RRXnaYlsZeHAhTRbn4Lul3z3Yk+hZKpU/FahK442z/1+2F8vZddRxPXRT8aJQxk24SPgWgcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4kvGmay; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4kvGmay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741695371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3jCJcIT33OrtEB+bgtXx62AywbCgyDFZf+0x9CO+24=;
	b=E4kvGmayqTWckSZhtLNWUjYFn6tF1Ys2U3SzABGw97O2HHO4sY1ZpfZEDQtuqe/cFt7414
	KfVlPoBUDZ+/0ZV0m0CGcLRV1cLz+fn9IwZoLHQhb7XjxhWnZjD6jZMTFTNPRJCign961w
	yAHzbeU8KWGFW4ZWoup5Tp6z4UBqGAk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-P3WkLnA3MF-a_3vaqUwjjg-1; Tue,
 11 Mar 2025 08:16:07 -0400
X-MC-Unique: P3WkLnA3MF-a_3vaqUwjjg-1
X-Mimecast-MFC-AGG-ID: P3WkLnA3MF-a_3vaqUwjjg_1741695366
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DCFF195608B;
	Tue, 11 Mar 2025 12:16:06 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 626AA1800944;
	Tue, 11 Mar 2025 12:16:04 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 4/4] Documentation/rtla: Include BPF sample collection
Date: Tue, 11 Mar 2025 12:49:36 +0100
Message-ID: <20250311114936.148012-5-tglozar@redhat.com>
In-Reply-To: <20250311114936.148012-1-tglozar@redhat.com>
References: <20250311114936.148012-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add dependencies needed to build rtla with BPF sample collection support
to README, and document both ways of sample collection in the manpages.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/common_timerlat_description.rst | 8 ++++++++
 tools/tracing/rtla/README.txt                            | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_description.rst b/Documentation/tools/rtla/common_timerlat_description.rst
index 8cd3e717baa8..49fcae3ffdec 100644
--- a/Documentation/tools/rtla/common_timerlat_description.rst
+++ b/Documentation/tools/rtla/common_timerlat_description.rst
@@ -8,3 +8,11 @@ The *timerlat* tracer outputs information in two ways. It periodically
 prints the timer latency at the timer *IRQ* handler and the *Thread*
 handler. It also enables the trace of the most relevant information via
 **osnoise:** tracepoints.
+
+The **rtla timerlat** tool sets the options of the *timerlat* tracer
+and collects and displays a summary of the results. By default,
+the collection is done synchronously in kernel space using a dedicated
+BPF program attached to the *timerlat* tracer. If either BPF or
+the **osnoise:timerlat_sample** tracepoint it attaches to is
+unavailable, the **rtla timerlat** tool falls back to using tracefs to
+process the data asynchronously in user space.
diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
index dd5621038c55..43e98311d10f 100644
--- a/tools/tracing/rtla/README.txt
+++ b/tools/tracing/rtla/README.txt
@@ -13,6 +13,13 @@ RTLA depends on the following libraries and tools:
  - libtraceevent
  - libcpupower (optional, for --deepest-idle-state)
 
+For BPF sample collection support, the following extra dependencies are
+required:
+
+ - libbpf 1.0.0 or later
+ - bpftool with skeleton support
+ - clang with BPF CO-RE support
+
 It also depends on python3-docutils to compile man pages.
 
 For development, we suggest the following steps for compiling rtla:
-- 
2.48.1

