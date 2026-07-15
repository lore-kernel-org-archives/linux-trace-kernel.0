Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2506420460
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130409; cv=none; b=Tj/BWD66GamIm70r1p8srLwUvlvS7oA6/XEhp3R3JA1dKFKDPrJ3nIFoemH7g9u64Ua3Qh/PVDn4ANdpMb+1ZXkuHv9gkzrr6a01+8TQahe2TTc2XdZjhCnxstcWAT0EsIfvR3ZtZBEd6J58PGy145C8jldATKLHoTFxnwra1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130409; c=relaxed/simple;
	bh=dQafBnijouqMjy3pJ+JGvQ3Lx38g2EjDegrTCOoR974=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Dnu45n0XN98ZdrGrUpE9Wbp/Ex5iNqPmS+PueLGhix2iCg42TL0+t26uqmBeLer++m8A+fmEc+woG+uNGdWMJB6NmS1EHvsRD0IMDl+YKvMfR0xZF0NElvsStlsdVL+Fsyl8KLvxWtXr3Rn7oNxhCduPQaMepkgADfJSRQyYy2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UW1r/LRe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UW1r/LRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784130406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqt3NijuaP9d9I1bY77shy06Tx7yDwPkFM7B3C4MGt4=;
	b=UW1r/LRe8co/xBqe1KjctbSbee5C51vugde4lD2/Xo7SitDZvLY2uFdcuV70p5tbXNyMxE
	tnhRWDl/zntSYRK39xGtx01lzdXBOXBFAoFIufotVhcUXNfg7JacnXH401cA62CsDQVnz9
	Qw8/tE09h7DfCVxtyeo5nfSsTPAHquU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-ppw5OaPSOIyQbEOdPlUfTw-1; Wed,
 15 Jul 2026 11:46:41 -0400
X-MC-Unique: ppw5OaPSOIyQbEOdPlUfTw-1
X-Mimecast-MFC-AGG-ID: ppw5OaPSOIyQbEOdPlUfTw_1784130400
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC0451956076;
	Wed, 15 Jul 2026 15:46:39 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.32.112])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B96E91800361;
	Wed, 15 Jul 2026 15:46:36 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 1/6] rtla/osnoise: Add IPI tracking cmdline option
Date: Wed, 15 Jul 2026 17:45:46 +0200
Message-ID: <20260715154553.2020891-2-vschneid@redhat.com>
In-Reply-To: <20260715154553.2020891-1-vschneid@redhat.com>
References: <20260715154553.2020891-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: qWDt-SAjW6bmwAacG25wVHKWW7dZ6bmoqrm10j_qPt0_1784130400
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Later commits will add IPI tracking to osnoise top. To avoid breaking
existing scripts, this new feature will be gated behind a new --ipi option.

Suggested-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/tools/rtla/rtla-osnoise-top.rst | 4 ++++
 tools/tracing/rtla/src/cli.c                  | 1 +
 tools/tracing/rtla/src/cli_p.h                | 3 +++
 tools/tracing/rtla/src/common.h               | 1 +
 4 files changed, 9 insertions(+)

diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index b91c02ac2bbe1..b948a813d45cb 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -28,6 +28,10 @@ OPTIONS
 =======
 .. include:: common_osnoise_options.txt
 
+**--ipi**
+
+	Track sources of IPIs.
+
 .. include:: common_top_options.txt
 
 .. include:: common_options.txt
diff --git a/tools/tracing/rtla/src/cli.c b/tools/tracing/rtla/src/cli.c
index c5279c9875310..eb1e76a6b0dea 100644
--- a/tools/tracing/rtla/src/cli.c
+++ b/tools/tracing/rtla/src/cli.c
@@ -78,6 +78,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		RTLA_OPT_STOP_TOTAL('S', "stop-total", "total sample"),
 		OSNOISE_OPT_THRESHOLD,
 		RTLA_OPT_TRACE_OUTPUT("osnoise", opt_osnoise_trace_output_cb),
+		OSNOISE_OPT_IPI,
 
 	OPT_GROUP("Event Configuration:"),
 		RTLA_OPT_EVENT,
diff --git a/tools/tracing/rtla/src/cli_p.h b/tools/tracing/rtla/src/cli_p.h
index 3c939de9abf02..d120fac424e30 100644
--- a/tools/tracing/rtla/src/cli_p.h
+++ b/tools/tracing/rtla/src/cli_p.h
@@ -305,6 +305,9 @@ static int opt_filter_cb(const struct option *opt, const char *arg, int unset)
 	"the minimum delta to be considered a noise", \
 	opt_llong_callback)
 
+#define OSNOISE_OPT_IPI OPT_BOOLEAN(0, "ipi", &params->common.ipi, \
+	"track sources of IPIs")
+
 /*
  * Callback functions for command line options for osnoise tools
  */
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 04b287a03f6d4..045253230fcf2 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -108,6 +108,7 @@ struct common_params {
 	bool			kernel_workload;
 	bool			user_data;
 	bool			aa_only;
+	bool			ipi;
 
 	struct actions		threshold_actions;
 	struct actions		end_actions;
-- 
2.55.0

