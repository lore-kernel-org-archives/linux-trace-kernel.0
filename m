Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698063;
	b=ttM5wTp1zXN57ft62oycrctw5yPtyvrdxb6MV0SOucnNAKU6ew9YlyskkOFofX7OzsXI
	 MLpqOsWuWu7LbkMxuPwu5MzYo/3GHSpJHvJcz8ASH/Bhs7AberJlUvb6Rjw2Soy/lBEHn
	 SFIIrhs8MgLItc5rzVO4/2npz+yUHcxayE8Hin1S1lY7GZbccCmduvjtZJ0iv5n2ni/8U
	 TDmVBbYdo2nHQzHvcJl1VwOCEURHAOL4tO2fzR9TMG57k5K5tV58RVpXdRCQZ/n3WFYZX
	 oGLIBnzjBNWBzHoj+IehqOy/JmCMG18Fa/Q23iAS81eSOZtGnSUeYl7vRnVu13MyZOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698063;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=2TuYN3pP/IAzKqWS/FNEppG7GioCEjQUwDIqKAyfFfU=;
	b=A2nMciVCU7Dhe6BmbK8IdTEiVriZBSXULI1erPmRHA+JVlunf5qCWAsSLxbvtLwOoGxH
	 TBNX3NfUXzLyKYIQ9j98FlgHcLDY2OFbwT+C7nb/18QA+kJ2R6IDUTRY/HZQ+Nr5H5Ey+
	 Udbk9wzn5GLc3gMtIEIWES+Wef7wvfzZJy76gCPnpLWXPYdqaTeLbmxLpfT53IkMZqRlz
	 Na1d2E+1+pt+SDmMAf/slFlIzpRItN1JSM1Dqps/zC7YLZm34iJTo8UFgrAI1iZ/3fveh
	 jE7FNnyWabnMwTfoYtksIxr+tIdEcoym98QlXHnB5F95A8q2O04cluNamxU45RK4h3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SGGOCNqw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E5606A331
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 238E5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SGGOCNqw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TuYN3pP/IAzKqWS/FNEppG7GioCEjQUwDIqKAyfFfU=;
	b=SGGOCNqwXNoou5NWJIgsuqd7XrdDTO4maUoxNainOdkfM50DbMvvfy//hMvx+B0RcjTx0q
	Pj2VXLLPiHulQMx3ij7VK8UXYYSoh4/oYKDT3j66Hll9EDPC5WeR7yrb+jyYID8oVKcpyG
	4Z5ypLPGrtMaSW3ooh85tvuF+hVss50=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-VEPcXDOpOhuyzlggLXn4Vw-1; Thu,
 26 Nov 2026 13:00:57 +0000
X-MC-Unique: VEPcXDOpOhuyzlggLXn4Vw-1
X-Mimecast-MFC-AGG-ID: VEPcXDOpOhuyzlggLXn4Vw_1795698055
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ECBE1800651;
	Thu, 26 Nov 2026 13:00:55 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 317CB1800543;
	Thu, 26 Nov 2026 13:00:51 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 06/18] tools/build: Add a feature test for bpftool-btf
Date: Thu, 26 Nov 2026 13:59:52 +0100
Message-ID: <20261126130004.127155-7-gmonaco@redhat.com>
In-Reply-To: <20261126130004.127155-1-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: -o4ne4BI5L0yvzJJDZjs1N08JhkP4SvStmdaQysQzqA_1795698055
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

RV can run bpf monitors and also build them, only the latter requires
the vmlinux.h from bpftool btf.

Add a feature so that RV can be built with BPF support without having to
build in-tree BPF monitors if not supported on the system.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/build/Makefile.feature | 1 +
 tools/build/feature/Makefile | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index c010049d9720..79e08fc62bb5 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -129,6 +129,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libdebuginfod			\
          clang-bpf-co-re		\
          bpftool-skeletons		\
+         bpftool-btf			\
          libunwind			\
          libunwind-debug-frame		\
          $(foreach arch,$(LIBUNWIND_ARCHS),libunwind-$(arch) libunwind-debug-frame-$(arch))
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 359da8b98bc5..e021846fb662 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -71,7 +71,8 @@ FILES=                                          \
          test-libpfm4.bin			\
          test-rust.bin				\
          test-libopenssl.bin			\
-         test-bpftool-skeletons.bin
+         test-bpftool-skeletons.bin		\
+         test-bpftool-btf.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -370,6 +371,10 @@ $(OUTPUT)test-bpftool-skeletons.bin:
 	{ $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons'; } \
 		> $(@:.bin=.make.output) 2>&1 && touch $@
 
+$(OUTPUT)test-bpftool-btf.bin:
+	$(SYSTEM_BPFTOOL) btf help \
+		> $(@:.bin=.make.output) 2>&1 && touch $@
+
 # Testing Rust is special: we don't compile anything, it's enough to check the
 # compiler presence. Compiling a test code for this purposes is problematic,
 # because Rust will emit a dependency file without any external references,
-- 
2.56.1

