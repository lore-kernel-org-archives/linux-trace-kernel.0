Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7373D891B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791156; cv=none; b=dydAgzdfyTekKBdqPqWS935qVHU4sTtJ44P0BMOu5OEXY5+81iD7ANwPpo7QtKc57UAT3tq6vidwOA6AZQNd8JMYLVThoG+N1pZ6lbaisgVtS6kv5MOi+gPho37Pbj2kKAz3kTpBB8CCXlwmYtkchouvV+MOhuvv/jt0ZOrEq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791156; c=relaxed/simple;
	bh=1lebo1ZZSbWb0XCUHAcHOWaPRjZfxF8tiGeN/x4jemY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AZ0FIVnmRjGLsnlFUjRtPEi3aNTavnzCZKn3X6eJhUihnuVdkIRJKPIL3zKNeaOM0LPSZJwO6QgLLRg5pgGUc4wrtxXUYigKTa1KFywNBaXnV7YyvpqTeUVmLRVhGY1eYauqXge+0ppKUYB6nlLNcQR8cGgW91TunDYZ4FsIZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAOWHL4q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAOWHL4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779791154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBeWo07UPXoKGBeTwxhsU/V0kWVTmDaT2tSFNdjjH08=;
	b=UAOWHL4qP4+gY+CL7Jqltxv0HvcmIrDFd/R+Hwh1boGpALGftgPu9VgetoqAIFn6gshqb0
	cNcZi4+jJaig1x7BJRTG9aPM6QpP4EgqAnD1uO036SuflCoERN9NL8Xky3m+T0S4Jvh8Ld
	f+UIdH28qYYGpCFIaBi934KtCvLYOpA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-Q2eBACZONHK_o-dPYSNDkw-1; Tue,
 26 May 2026 06:25:50 -0400
X-MC-Unique: Q2eBACZONHK_o-dPYSNDkw-1
X-Mimecast-MFC-AGG-ID: Q2eBACZONHK_o-dPYSNDkw_1779791149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8BA619560AD;
	Tue, 26 May 2026 10:25:49 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C6F71956053;
	Tue, 26 May 2026 10:25:47 +0000 (UTC)
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
Subject: [PATCH 3/4] rtla/tests: Run runtime tests in temporary directory
Date: Tue, 26 May 2026 12:25:22 +0200
Message-ID: <20260526102523.2662391-3-tglozar@redhat.com>
In-Reply-To: <20260526102523.2662391-1-tglozar@redhat.com>
References: <20260526102523.2662391-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: nUurHxn78EWLasAY6Q8qJLKF_u-_MpbjNHShiP8EzHg_1779791149
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Create a temporary directory before each test case to serve as working
directory during the duration of the test.

This prevents littering of the original working directory as well as
allows tests to use it to avoid path conflicts.

In order not to break already existing tests, also add a new "testdir"
variable containing the directory where the test file is located. This
is then used to locate artifacts used during testing like BPF programs
and scripts for checking the tracer threads.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---

Depends on "rtla/tests: Extend runtime test coverage" patchset
- https://lore.kernel.org/linux-trace-kernel/20260423130558.882022-1-tglozar@redhat.com/

 tools/tracing/rtla/tests/engine.sh  | 12 ++++++++++++
 tools/tracing/rtla/tests/osnoise.t  |  8 ++++----
 tools/tracing/rtla/tests/timerlat.t | 16 ++++++++--------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index 27d92f19a322..5bf8453d354d 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -4,6 +4,9 @@ test_begin() {
 	# Count tests to allow the test harness to double-check if all were
 	# included correctly.
 	ctr=0
+	# Set test directory to the directory of the script
+	scriptfile=$(realpath "$0")
+	testdir=$(dirname "$scriptfile")
 	[ -z "$RTLA" ] && RTLA="./rtla"
 	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
 }
@@ -51,6 +54,11 @@ check() {
 	then
 		# Reset osnoise options before running test.
 		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
+
+		# Create a temporary directory to contain rtla output
+		tmpdir=$(mktemp -d)
+		pushd $tmpdir >/dev/null
+
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
 		result=$(eval stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
@@ -82,6 +90,10 @@ check() {
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
 		fi
+
+		# Remove temporary directory
+		popd >/dev/null
+		rm -r $tmpdir
 	fi
 }
 
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 06787471d0e8..9c2f84a4187d 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -16,15 +16,15 @@ check_top_q_hist "verify the --trace param" \
 
 # Thread tests
 check_top_q_hist "verify the --priority/-P param" \
-	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh SCHED_FIFO 1\"" \
+	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"$testdir/scripts/check-priority.sh SCHED_FIFO 1\"" \
 	2 "Priorities are set correctly"
 check_top_q_hist "verify the -C/--cgroup param" \
-	"osnoise TOOL -C -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"tests/scripts/check-cgroup-match.sh\"" \
+	"osnoise TOOL -C -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=\"$testdir/scripts/check-cgroup-match.sh\"" \
 	2 "cgroup matches for all workload PIDs"
 check_top_q_hist "verify the -c/--cpus param" \
-	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
+	"osnoise TOOL -P F:1 -c 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=$testdir/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 check_top_q_hist "verify the -H/--house-keeping param" \
-	"osnoise TOOL -P F:1 -H 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=tests/scripts/check-housekeeping-cpus.sh" 2 "^Affinity of threads: 0$"
+	"osnoise TOOL -P F:1 -H 0 -r 900000 -d 10s -S 1 --on-threshold shell,command=$testdir/scripts/check-housekeeping-cpus.sh" 2 "^Affinity of threads: 0$"
 
 # Histogram tests
 check "hist with -b/--bucket-size" \
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 3ebfe316b39e..f3e5f99e862b 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -41,19 +41,19 @@ check_top_hist "disable auto-analysis" \
 
 # Thread tests
 check_top_hist "verify -P/--priority" \
-	"timerlat TOOL -P F:1 -c 0 -d 10s -T 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh SCHED_FIFO 1\"" \
+	"timerlat TOOL -P F:1 -c 0 -d 10s -T 1 --on-threshold shell,command=\"$testdir/scripts/check-priority.sh SCHED_FIFO 1\"" \
 	2 "Priorities are set correctly"
 check_top_hist "verify -C/--cgroup" \
-	"timerlat TOOL -k -C -c 0 -d 10s -T 1 --on-threshold shell,command=\"tests/scripts/check-cgroup-match.sh\"" \
+	"timerlat TOOL -k -C -c 0 -d 10s -T 1 --on-threshold shell,command=\"$testdir/scripts/check-cgroup-match.sh\"" \
 	2 "cgroup matches for all workload PIDs"
 check_top_q_hist "verify -c/--cpus" \
-	"timerlat TOOL -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
+	"timerlat TOOL -c 0 -d 10s -T 1 --on-threshold shell,command=$testdir/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 check_top_q_hist "verify -H/--house-keeping" \
-	"timerlat TOOL -H 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-housekeeping-cpus.sh" 2 "^Affinity of threads: 0$"
+	"timerlat TOOL -H 0 -d 10s -T 1 --on-threshold shell,command=$testdir/scripts/check-housekeeping-cpus.sh" 2 "^Affinity of threads: 0$"
 check_top_q_hist "verify -k/--kernel-threads" \
-	"timerlat TOOL -k -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-user-kernel-threads.sh" 2 "1 kernel threads, 0 user threads"
+	"timerlat TOOL -k -c 0 -d 10s -T 1 --on-threshold shell,command=$testdir/scripts/check-user-kernel-threads.sh" 2 "1 kernel threads, 0 user threads"
 check_top_q_hist "verify -u/--user-threads" \
-	"timerlat TOOL -u -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-user-kernel-threads.sh" 2 "0 kernel threads, 1 user threads"
+	"timerlat TOOL -u -c 0 -d 10s -T 1 --on-threshold shell,command=$testdir/scripts/check-user-kernel-threads.sh" 2 "0 kernel threads, 1 user threads"
 
 # Histogram tests
 check "hist with -b/--bucket-size" \
@@ -103,12 +103,12 @@ then
 	# Test BPF action program properly in BPF mode
 	[ -z "$BPFTOOL" ] && BPFTOOL=bpftool
 	check_top_q_hist "with BPF action program (BPF mode)" \
-		"timerlat TOOL -T 2 --bpf-action tests/bpf/bpf_action_map.o --on-threshold shell,command='$BPFTOOL map dump name rtla_test_map'" \
+		"timerlat TOOL -T 2 --bpf-action $testdir/bpf/bpf_action_map.o --on-threshold shell,command='$BPFTOOL map dump name rtla_test_map'" \
 		2 '"value": 42'
 else
 	# Test BPF action program failure in non-BPF mode
 	check_top_q_hist "with BPF action program (non-BPF mode)" \
-		"timerlat TOOL -T 2 --bpf-action tests/bpf/bpf_action_map.o" \
+		"timerlat TOOL -T 2 --bpf-action $testdir/bpf/bpf_action_map.o" \
 		1 "BPF actions are not supported in tracefs-only mode"
 fi
 done
-- 
2.54.0

