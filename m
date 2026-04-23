Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572D3EFD11
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949586; cv=none; b=o38cfZnYBGuUkZTQ5INKP1+SkgJfe2LLdF5B6rEdmNu9+S5PzXzbymvepr7+tmel1S0yyr8KFbQR8VpBUQCwuh3oKMzy3tQlGAwkH/Tk8Qz0+7lgJGkbluQ2rHfPYVnLg8ngIFNyB/MVlLAxTCJ8yscCqcA9JMd4wZx4C1PbVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949586; c=relaxed/simple;
	bh=SxArN/A+LL2HxmSUWWsovdyBrGQkQw88quXpj3pj5IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YQud0nPlHCRUVprqg/Hp2iLoKHCpP+IhebFZ+OCxW501pybGNn1eb0OCYPDy+xlKvEpcXjQXc0wKSwpiv5bbxNgwlskuHdUMqWPVVZ6jM6SYgXGuMXxChGuaXA9keSyCSmnZmnY4jmwpwTgYnB2ctxmEuQ/brkE/2JjKFM6AhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4eb64CZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4eb64CZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIDgNATN1Zc5xyhfvqALgA2L927VPRoKeBObj8l0vWA=;
	b=h4eb64CZEnH9tmIYeM4nARGjSSURnmViuUwOGMU9UhS0ZiwsWrhsMKaoRMoCQWRbuXX7s6
	q29Tp/2Us3El8f3pHBO43qM9WPKZTnYOzuTNWcEm4eSreqS/rnvqztdHV2aJM4VEejWEsv
	RvbOlE/tu2btCo6+PMLsvkDRvIbX+eY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-Ww9VoVF_N8ynDbR5Km9JXA-1; Thu,
 23 Apr 2026 09:06:22 -0400
X-MC-Unique: Ww9VoVF_N8ynDbR5Km9JXA-1
X-Mimecast-MFC-AGG-ID: Ww9VoVF_N8ynDbR5Km9JXA_1776949581
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E52E193530B;
	Thu, 23 Apr 2026 13:06:21 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB84E1800370;
	Thu, 23 Apr 2026 13:06:18 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 6/9] rtla/tests: Cover all hist options in runtime tests
Date: Thu, 23 Apr 2026 15:05:55 +0200
Message-ID: <20260423130558.882022-7-tglozar@redhat.com>
In-Reply-To: <20260423130558.882022-1-tglozar@redhat.com>
References: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: H8JuSxER96mn2Yv1WQ9V9DCguNFQHD-77VFcw5BqJfU_1776949581
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Cover all options regarding histogram formatting for both
rtla-osnoise-hist and rtla-timerlat-hist tools. All options also have
output checking using positive or negative match, except for
-b/--bucket-size and -E/--entries, which cannot be tested in isolated
due to the output depending on the actual data collected.

Old -E/--entries test for rtla-osnoise was replaced with a new one
equivalent to the timerlat one.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t  | 18 ++++++++++++++++--
 tools/tracing/rtla/tests/timerlat.t | 20 ++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 5edffb23981b..773a46e2dc5f 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -16,11 +16,25 @@ check_top_q_hist "verify the --stop/-s param" \
 	"osnoise TOOL -s 30 -T 1" 2 "osnoise hit stop tracing"
 check_top_q_hist "verify the --trace param" \
 	"osnoise TOOL -s 30 -T 1 -t" 2 "Saving trace to osnoise_trace.txt"
-check "verify the --entries/-E param" \
-	"osnoise hist -P F:1 -c 0 -r 900000 -d 10s -b 10 -E 25"
 check_top_q_hist "verify the -c/--cpus param" \
 	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 
+# Histogram tests
+check "hist with -b/--bucket-size" \
+	"osnoise hist -b 1 -d 1s"
+check "hist with -E/--entries" \
+	"osnoise hist -E 10 -d 1s"
+check "hist with -E/--entries out of range" \
+	"osnoise hist -E 1 -d 1s" 1 "^Entries must be > 10 and < 9999999$"
+check "hist with --no-header" \
+	"osnoise hist --no-header -d 1s" 0 "" "RTLA osnoise histogram"
+check "hist with --with-zeros" \
+	"osnoise hist --with-zeros -b 100000 -E 21 -d 1s" 0 '^2000000\s+0\s+'
+check "hist with --no-index" \
+	"osnoise hist --no-index --with-zeros -d 1s" 0 "" "^count:"
+check "hist with --no-summary" \
+	"osnoise hist --no-summary -d 1s" 0 "" "^count:"
+
 # Test setting default period by putting an absurdly high period
 # and stopping on threshold.
 # If default period is not set, this will time out.
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 28c01d8b299d..a14d9ec32ede 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -44,6 +44,26 @@ check_top_hist "disable auto-analysis" \
 check_top_q_hist "verify -c/--cpus" \
 	"timerlat TOOL -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 
+# Histogram tests
+check "hist with -b/--bucket-size" \
+	"timerlat hist -b 1 -d 1s"
+check "hist with -E/--entries" \
+	"timerlat hist -E 10 -d 1s"
+check "hist with -E/--entries out of range" \
+	"timerlat hist -E 1 -d 1s" 1 "^Entries must be > 10 and < 9999999$"
+check "hist with --no-header" \
+	"timerlat hist --no-header -d 1s" 0 "" "RTLA timerlat histogram"
+check "hist with --with-zeros" \
+	"timerlat hist --with-zeros -b 100000 -E 21 -d 1s" 0 '^2000000\s+0\s+'
+check "hist with --no-index" \
+	"timerlat hist --no-index --with-zeros -d 1s" 0 "" "^count:"
+check "hist with --no-summary" \
+	"timerlat hist --no-summary -d 1s" 0 "" "^ALL:"
+check "hist with --no-irq" \
+	"timerlat hist --no-irq -d 1s" 0 "" "IRQ-"
+check "hist with --no-thread" \
+	"timerlat hist --no-thread -d 1s" 0 "" "Thr-"
+
 # Actions tests
 check_top_q_hist "trace output through -t" \
 	"timerlat TOOL -T 2 -t" 2 "^  Saving trace to timerlat_trace.txt$"
-- 
2.53.0

