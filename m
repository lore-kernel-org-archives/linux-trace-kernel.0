Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C348F848
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352829; cv=none; b=fO1iWGDSoqQf/SQ5FKwLGR39djQhA8013kYRAoIX/q/79kae0VxoKNAa5Wr+e6M8i34lmxUE+HRQZh96eKt8iGx9UnKh7Y1xlu8KKLIhbjWgwc/nl0kjJW2xRFLiXicFQwwmOdIQkXdC3OQ4nOCiNS59FcjEhSRPCr365s4a38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352829; c=relaxed/simple;
	bh=4ynCKSBrYH99EP9t5ZyjcuDEGLq+jBmn0qOkuGMRw38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YRlq/UQWkRQ/sqK5US32tuQ/7N1rRrPw1XCc82h8jPTD1Zt0rM+3fewgEpQKg0Mv5YGDTRaZn8YJNKSkVVw35of1MvvUTA7po5fjWTRxG9+RqGnvq+y6ypkG894Ji4q0c+Hkh72BsAke55neNex+IXG6nwl1R2NvCbDuUAoj9+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6hbk//7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6hbk//7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788352825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq6X9iHJwj0Z4++cseQ+WkYkIyZIsUxG0iOqqACkzfM=;
	b=H6hbk//7QEH3orCPmNaDX2EEAXBVzGFk6oS6OxaNufwZwszsl+QD0DrMkePHB00+u2H4oD
	qzgs3vMMcW1gI89oDiZzbY/H6Dj1zymV5b1gLeGfIRjA3EKaQyUWmfVrV2HTMV5rtbryaj
	/6lV6NeSPgQXfgRncVberaY5DX0LIRg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-TShCLYeGMgCq6KwHVgGDuQ-1; Wed,
 02 Sept 2026 08:40:22 -0400
X-MC-Unique: TShCLYeGMgCq6KwHVgGDuQ-1
X-Mimecast-MFC-AGG-ID: TShCLYeGMgCq6KwHVgGDuQ_1788352820
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E7D61953972;
	Wed,  2 Sep 2026 12:40:20 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.33.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB2B61955F7C;
	Wed,  2 Sep 2026 12:40:16 +0000 (UTC)
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
Subject: [PATCH v5 1/8] rtla/osnoise: Add IPI tracking cmdline option
Date: Wed,  2 Sep 2026 14:39:30 +0200
Message-ID: <20260902123942.695822-2-vschneid@redhat.com>
In-Reply-To: <20260902123942.695822-1-vschneid@redhat.com>
References: <20260902123942.695822-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: wL4Sr_1Q_XPR1IIp31-E-Xxyr5BYqR6nK-C-Md-qZQY_1788352820
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
index fb8c972c0746b..8c02b94ce4321 100644
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
index 661240d44ad9a..f2dd7c610093d 100644
--- a/tools/tracing/rtla/src/cli_p.h
+++ b/tools/tracing/rtla/src/cli_p.h
@@ -497,6 +497,9 @@ static int opt_filter_cb(const struct option *opt, const char *arg, int unset)
 #define OSNOISE_OPT_THRESHOLD RTLA_OPT_LLONG('T', "threshold", &params->threshold, "us", \
 	"the minimum delta to be considered a noise")
 
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

