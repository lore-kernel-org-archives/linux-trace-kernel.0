Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6334071C8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702310; cv=none; b=Bd2IC6y4wiHpcQ8uyzI00ceRbNvG3LNcdOoWMqJ0w53mCs5Gc3+QYIyDiI8NfQAuJpangdrOlEsIpDJfbtVbqQkwUBXDaGwAhd2Jl6lIIrFlFWDzOoaZswWUCa5kjvWP5IjFAjKnZpUPAwvOB4YbYjTLPbIcnB8q/gdSzB5yTTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702310; c=relaxed/simple;
	bh=Udjufc2bed10yNfKtsSRhoX3WH8FSyVq52CXC5bsOHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Cq0UplTn5mvl0iqIRuc6/LvAyWMs1Xln2PXdv1gcnMF+nqy2zdZMTyOpZ3yWaTEK3IUrnAZk+g3MTag8e042r1tXJ/aXyS0E2MGV2sxAsxEcoopW5AE1yhUdsu0fTRiKsb1fp9YP6ZxGZ/OFIjimriasEGrppjaJDqqKsLOxpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHC2E+dC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHC2E+dC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781702308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAh+dCKUC1UKSSxE9PTcAU4OR07xfNGTTy3ua00L/Ek=;
	b=HHC2E+dCT24OQF7PIJ4qiTZQRW5gtl48Hr/jj0/x5Dl2Djz54W3wJ2bie8pNvRL5KVorTF
	kxnGvoVLgudm9okRmFtH5DAPdSBRH6Kewmtutz3ha1L2grLL/tOHjDu2LGLyCDXWOdVDfJ
	+OZ4crTLyLbe+Mq4NGvvKSNJW6/K64s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-ba9zDCIBNSGoJV3LkC7dEg-1; Wed,
 17 Jun 2026 09:18:26 -0400
X-MC-Unique: ba9zDCIBNSGoJV3LkC7dEg-1
X-Mimecast-MFC-AGG-ID: ba9zDCIBNSGoJV3LkC7dEg_1781702305
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 490111955F2D;
	Wed, 17 Jun 2026 13:18:25 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.34.165])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E2EA1800661;
	Wed, 17 Jun 2026 13:18:21 +0000 (UTC)
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
Subject: [RFC PATCH v2 1/4] rtla/osnoise: Add IPI tracking cmdline option
Date: Wed, 17 Jun 2026 15:17:56 +0200
Message-ID: <20260617131803.2988989-2-vschneid@redhat.com>
In-Reply-To: <20260617131803.2988989-1-vschneid@redhat.com>
References: <20260617131803.2988989-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 92NsPrO4hi2lrLGdU5X5JQKqk3nkCHdiNNOdzQh24SY_1781702305
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Later commits will add IPI tracking to osnoise top. To avoid breaking
existing scripts, this new feature will be gated behind a new -i option.

Suggested-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/tools/rtla/rtla-osnoise-top.rst | 4 ++++
 tools/tracing/rtla/src/cli.c                  | 1 +
 tools/tracing/rtla/src/cli_p.h                | 3 +++
 tools/tracing/rtla/src/common.h               | 1 +
 4 files changed, 9 insertions(+)

diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index b91c02ac2bbe1..98f77f8971a69 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -28,6 +28,10 @@ OPTIONS
 =======
 .. include:: common_osnoise_options.txt
 
+**-i**, **--ipi**
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
index 3c939de9abf02..7d3f982cfabdb 100644
--- a/tools/tracing/rtla/src/cli_p.h
+++ b/tools/tracing/rtla/src/cli_p.h
@@ -305,6 +305,9 @@ static int opt_filter_cb(const struct option *opt, const char *arg, int unset)
 	"the minimum delta to be considered a noise", \
 	opt_llong_callback)
 
+#define OSNOISE_OPT_IPI OPT_BOOLEAN('i', "ipi", &params->common.ipi, \
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
2.54.0

