Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075ED22488E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462747; cv=none; b=TsucP/YwJ+zFWrHFeIDDypbSVY73NWrQGlHEJS7MZHQmLICmbkq7TCrO53DwT9XwGsKIn09Ev+2yW1F0Q5YWrFsOqG/wrH6jHlaRCWE74kTLdpOQ1hppy30CZxNz7OLbtcKLgKRby5mt8/v4GFnWsGyW0o38G3GHNyClOKiIW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462747; c=relaxed/simple;
	bh=nxJBiLzczhFnBakyS21AFbLzppLXT/zMwnVUHhdHALc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI00CaQs44gfMMh7RIrrOPILOi8MGDYUT/zLG5GtsFjAqkoG6xUPxipLGAjaG228KsXvEKHvebqIdOrCEkJLRVGuCVPhUjOmKkE8p66MjE5sB3aTydgIoWb5T1jkIvKMZFmVLCUNH+f3NCpSVld1fDUgMIXODXcTRiDtEDceLkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXeBI1uz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXeBI1uz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742462744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlYKhEorVqLYcQtYVkQA5iU2P6/611obw/UuZKDRxAo=;
	b=GXeBI1uzehkEfvMfkoKbIp1l3MBMOIDSd0XyKJM+TcMTNCHSZoV8zjYH2qTDnPeIoDUJbW
	zn2JB/4hJzZGrnQ7waXd5qwyuaAVkcgMhPGcmBW+rr6a84ceunPGkFT4N1B0kLeN6M/E28
	oNWG1WmzfN5zy7kHqWUXIMH7JO+hw98=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-o6u0A1-oMdSYrrLbQTiphg-1; Thu,
 20 Mar 2025 05:25:41 -0400
X-MC-Unique: o6u0A1-oMdSYrrLbQTiphg-1
X-Mimecast-MFC-AGG-ID: o6u0A1-oMdSYrrLbQTiphg_1742462740
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 383981944F0A;
	Thu, 20 Mar 2025 09:25:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.73])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04E0719560AF;
	Thu, 20 Mar 2025 09:25:37 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/6] rtla/tests: Reset osnoise options before check
Date: Thu, 20 Mar 2025 10:24:59 +0100
Message-ID: <20250320092500.101385-6-tglozar@redhat.com>
In-Reply-To: <20250320092500.101385-1-tglozar@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Remove any dangling tracing instances from previous improperly exited
runs of rtla, and reset osnoise options to default before running a test
case.

This ensures that the test results are deterministic. Specific test
cases checked that rtla behaves correctly even when the tracer state is
not clean will be added later.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/engine.sh | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 64d0446dc28e..5db8aa4bc031 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -8,12 +8,44 @@ test_begin() {
 	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
 }
 
+reset_osnoise() {
+	# Reset osnoise options to default and remove any dangling instances created
+	# by improperly exited rtla runs.
+	pushd /sys/kernel/tracing || return 1
+
+	# Remove dangling instances created by previous rtla run
+	echo 0 > tracing_thresh
+	cd instances
+	for i in osnoise_top osnoise_hist timerlat_top timerlat_hist
+	do
+		[ ! -d "$i" ] && continue
+		rmdir "$i"
+	done
+
+	# Reset options to default
+	# Note: those are copied from the default values of osnoise_data
+	# in kernel/trace/trace_osnoise.c
+	cd ../osnoise
+	echo all > cpus
+	echo DEFAULTS > options
+	echo 1000000 > period_us
+	echo 0 > print_stack
+	echo 1000000 > runtime_us
+	echo 0 > stop_tracing_total_us
+	echo 0 > stop_tracing_us
+	echo 1000 > timerlat_period_us
+
+	popd
+}
+
 check() {
 	# Simple check: run rtla with given arguments and test exit code.
 	# If TEST_COUNT is set, run the test. Otherwise, just count.
 	ctr=$(($ctr + 1))
 	if [ -n "$TEST_COUNT" ]
 	then
+		# Reset osnoise options before running test.
+		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
 		result=$(stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
@@ -37,6 +69,14 @@ unset_timeout() {
 	unset TIMEOUT
 }
 
+set_no_reset_osnoise() {
+	NO_RESET_OSNOISE=1
+}
+
+unset_no_reset_osnoise() {
+	unset NO_RESET_OSNOISE
+}
+
 test_end() {
 	# If running without TEST_COUNT, tests are not actually run, just
 	# counted. In that case, re-run the test with the correct count.
-- 
2.48.1

