Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7216F288
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957507; cv=none; b=OxkvhRNybyBnuF32Abhi+tDX6HY+8l7vp47zATIvEs080rpN+wEfuKpA4akLLClbaxgfb/0pJUwfhcLmjlF+a9nMmsm4pI+sL4uV9TyCreV4xUsEqbog4y6SZIz+8Hl/ATX+Kmhb/feVah6bFmidDSu1cutNc8NfGjZQOx0gI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957507; c=relaxed/simple;
	bh=ma0OE6jc72wX99S3EDlOnhT41J21hCR55F44rTDbdMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=smIBMTqFpdleGjiP+b6WjCs00oTHwLOud42zgvph0vSUmfzkUbbzT3ch/6TcnDZw3xmTCSy86CKYzx1Om6ONHzNaL0BfuQNP3lzysVRRGvGOaWPpGndZFSQCUW7jGA7/AaIjfkyM5zvlrR2G+vOdDwudyFyuUHQ8iu4JVMQdjyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itQvQDLB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itQvQDLB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776957505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tfrr+HWsFGxr25q1lEOOcrWGfevT4jtMVgKE83pLNF0=;
	b=itQvQDLBz/YltExuT7ChU9q1c3LUzdbx1+4pivhTh+GQqfG+jx6e5xPXSO3PC+QzVNB4mp
	CIDcHSdcDX6eBE34QCY0HKSvHHn+kgeBaLMkr4kZt2Hqe0yGw3dtiWZbZoKKwCrLF2w/TV
	Z/onrBNstjLy8Oh+dqH+uqWhqznvI4Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-S-W2rFYJM32ZYdtYw1BbUQ-1; Thu,
 23 Apr 2026 11:18:21 -0400
X-MC-Unique: S-W2rFYJM32ZYdtYw1BbUQ-1
X-Mimecast-MFC-AGG-ID: S-W2rFYJM32ZYdtYw1BbUQ_1776957499
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B44618003FC;
	Thu, 23 Apr 2026 15:18:18 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.74.80.103])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 465391800348;
	Thu, 23 Apr 2026 15:18:09 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v3 1/3] perf evsel: don't set PERF_SAMPLE_IP for unprivileged tracepoints
Date: Thu, 23 Apr 2026 11:17:44 -0400
Message-ID: <20260423151746.16258-2-ashelat@redhat.com>
In-Reply-To: <20260423151746.16258-1-ashelat@redhat.com>
References: <20260423151746.16258-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: LOjZpTeFUb7QuJjTU4PoKpIXjGglDfBLQET0kwJW0M4_1776957499
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

For tracepoint events the IP is a static kernel address.
It doesn't vary by sample and provides no useful information for
unprivileged users. Skipping setting PERF_SAMPLE_IP for unprivileged
tracepoints avoids exposing a kernel address that reveals the KASLR base
offset and slightly reduces sample record size.

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/util/evsel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f59228c1a39e..a1091d937ff9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1503,7 +1503,9 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->write_backward = opts->overwrite ? 1 : 0;
 	attr->read_format   = PERF_FORMAT_LOST;
 
-	evsel__set_sample_bit(evsel, IP);
+	if (attr->type != PERF_TYPE_TRACEPOINT || perf_event_paranoid_check(1))
+		evsel__set_sample_bit(evsel, IP);
+
 	evsel__set_sample_bit(evsel, TID);
 
 	if (evsel->sample_read) {
-- 
2.53.0

