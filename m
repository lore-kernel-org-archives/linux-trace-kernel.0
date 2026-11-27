Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793589;
	b=ESkv/t9FoGDarZ4adOlIQ3zpUBWZl1/EvOKyNkOmp35C8jf2hMK3+QrG7SjSVU/HzvlG
	 aJZNmB8JfLBGr4bg0NKgLk33RCfBDwlhHfUurWbkDVXtfUAenMEgIJc03AE92bPSWK1mb
	 vHoYO/1OswhaPuwKRsuSMfGiHD6pAYHhVcR9/+d6I/4SvBmDeC6qdUVFJDqqX7oT7v38j
	 JvsStQ5BCq7FYsKwiBfwycmydabte7ZK37CdTmuDs4KUn5ePUAY5cw0gGOmWQNd68+VYZ
	 dZ/8uoaS4Y53uZt+8OktP2lCWe7UG3cnHfiUH2i/ESbAGlPVexKAZZWfOAjOGCnsmRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793589;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=lDrWR4nk1Ahx1KPdGiztJP2GpSZyY5pRJ1EmBYhSUCU=;
	b=l0QvX754oP4e7BMNXikjg2gt9soLF1y+2YAgC9sfK6XfNOyI3DXTPygpEh6n7anQDN8e
	 sRnQ0U0bB5J82NBaJ4DuimoyBQavNr7y5bEqTRtqyGmlALMR3g4zUBILBztrxGl8qOstn
	 wF/b1bzo+jiKYShuZfkNyDn5JtgPvH9WvFaI0V0F5l07RbCEDNuP33msSpKjxBKhLKyDx
	 6Ww6vyGQgDTTW9xpPWQqd5OVNAThgHt66grhgP/sBoQcUjsjHAU+P+zshQTJAFNUQC9IC
	 CkBS6r/5VfJWF5PUAem8WhccMzLshh/ndQ/Qc2uP18S7NPlsip4R5VIJTpBt6b0dLUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SMotyPOU;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ABD606A327
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4ABD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SMotyPOU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDrWR4nk1Ahx1KPdGiztJP2GpSZyY5pRJ1EmBYhSUCU=;
	b=SMotyPOUuOY5Q2l2coZaOI1Z4JJQOthONo7Cq9KUxZT4i7WkDfZK1/A23Msn1pvpjTabMm
	2qoU/GHFJd4G/3FUSH30hBnU9wG5XJmok5nuxh7WMvWT5xSwDwoWnGoqA55Ag1KTCtm6/1
	dVrrXxA8VCNrWB+L4cOpusMLSPPNaLg=
X-MC-Rep: binary re single
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-7e-4JdGtMJaRtP2mAN2bpg-1; Fri,
 27 Nov 2026 15:33:05 +0000
X-MC-Unique: 7e-4JdGtMJaRtP2mAN2bpg-1
X-Mimecast-MFC-AGG-ID: 7e-4JdGtMJaRtP2mAN2bpg_1795793584
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C376E1801331;
	Fri, 27 Nov 2026 15:33:04 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B01C41955F76;
	Fri, 27 Nov 2026 15:33:02 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 03/10] rtla/tests: Add runtime tests for aa action
Date: Fri, 27 Nov 2026 16:31:59 +0100
Message-ID: <20261127153206.134322-4-tglozar@redhat.com>
In-Reply-To: <20261127153206.134322-1-tglozar@redhat.com>
References: <20261127153206.134322-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: roG9LOa-3EgkxYyMFhWPD9tI1peLoyfC3PTC4P87jtY_1795793584
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Cover auto-analysis action with runtime tests: the base case,
repeated auto-analysis with continue action, and combination of
auto-analysis action with --aa-only.

Verify that the aa action is correctly rejected for osnoise tools, as
osnoise does not currently support auto-analysis.

Also, separate the action test cases into blocks to make them more
readable, as they have grown into a quite long list.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t  |  4 ++++
 tools/tracing/rtla/tests/timerlat.t | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 352b302372453..d0173fe20caa5 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -100,5 +100,9 @@ check_top_hist "with trace output at end" \
 	"osnoise TOOL -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
 check_top_q_hist "action with no threshold" \
 	"osnoise TOOL -d 1s --on-threshold shell,command='echo BAD'" 0 "" "BAD"
+check_top_hist "reject aa action on threshold" \
+	"osnoise TOOL --on-threshold aa" 1 "auto-analysis action is not supported with osnoise tools"
+check_top_hist "reject aa action on end" \
+	"osnoise TOOL --on-end aa" 1 "auto-analysis action is not supported with osnoise tools"
 
 test_end
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index aab026ead6c55..2ebd1858be0bb 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -122,18 +122,31 @@ check_top_q_hist "trace output through --on-threshold trace" \
 	"timerlat TOOL -T 2 --on-threshold trace" 2 "^  Saving trace to timerlat_trace.txt$"
 check_top_q_hist "trace output through --on-threshold trace with custom filename" \
 	"timerlat TOOL -T 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+
 check_top_q_hist "exec command" \
 	"timerlat TOOL -T 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
+
+check_top_hist "aa action" \
+	"timerlat TOOL -T 2 -d 3s --on-threshold aa" 2 "analyzing it"
+check_top_hist "aa action at end" \
+	"timerlat TOOL -T 2 -d 3s --on-end aa" 2 "analyzing it"
+check_top_hist "aa action with continue" \
+	"timerlat TOOL -T 2 -d 3s --on-threshold aa --on-threshold continue" 0 "analyzing it"
+check "aa action with --aa-only" \
+	"timerlat top -d 3s --aa-only 2 --on-threshold aa --on-threshold continue" 0 "analyzing it" "Timer Latency"
+
 check_top_q_hist "multiple actions" \
 	"timerlat TOOL -T 2 --on-threshold shell,command='echo -n 1' --on-threshold shell,command='echo 2'" 2 "^12$"
 check "hist stop at failed action" \
 	"timerlat hist -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1# RTLA timerlat histogram$"
 check "top stop at failed action" \
 	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
+
 check_top_q_hist "with continue" \
 	"timerlat TOOL -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check_top_q_hist "with conditional continue" \
 	"timerlat TOOL -T 2 --on-threshold shell,command='if [ -f a ]; then echo 2; exit 1; else echo -n 1; touch a; fi' --on-threshold continue" 2 "^12$" "^2$"
+
 check_top_hist "with trace output at end" \
 	"timerlat TOOL -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
 check_top_q_hist "action with no threshold" \
-- 
2.56.1

