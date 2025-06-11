Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9887A2BD03E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Jun 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650251; cv=none; b=lclBJwh4rXPbfBYo7O9Ob4Ddub/sPF77XXSKl5cUwgLnGCd4bB5iI4mBLxMPfL6dTIzWe/IVnR4Y8EJxcq8qX6NH8jHsQ0zkEYGQTbOmaGfBzcjj8/fTacA4OGI9RkpVe61dvj6n3KTOj9EoEc4dROdyUbXyCZHrOx9w8QWX6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650251; c=relaxed/simple;
	bh=khl73MPmUq799HOT+UF9QQ+r9png3+sHIge1qd1A1WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeyxDyDu3OVeDtlPNFmK606TUroSkpMiJF36U6Olcn7LuGq/CSARx0g7QD2Jmg+PbYfVhEm5y3RUFCTcVAf3aFHmRe1tFOEB8vSwsLs3wGnhuJDQC6/UKRWJGoaCpHoKsHy+yt1zJghBNBz8NkSG9bGjmz8faeoipdPCUSJ8/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8+ut/kM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8+ut/kM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749650248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEiqq7isWZiK/FNjFSdCqNp6cYFEr/QW0LyfClcFOf0=;
	b=J8+ut/kM5jY+9LmpGoj9gyZaTXUcBbsJgvA1/inh1NmA8JYVPk+4Nt4v7orFZp5PESbL0U
	b2F3e3WbIwhWm7VROfmOIfHFwb3oDh8zrga9+g08cnHRWqQKn5qUyF/kRzK+f5c+0dzut+
	fDwpLgohRqCAyv7j5oNbB8TDMPZTd1g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-VWfa9s_eMZOLrscF2SJ2iA-1; Wed,
 11 Jun 2025 09:57:25 -0400
X-MC-Unique: VWfa9s_eMZOLrscF2SJ2iA-1
X-Mimecast-MFC-AGG-ID: VWfa9s_eMZOLrscF2SJ2iA_1749650244
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 302AB180AE03;
	Wed, 11 Jun 2025 13:57:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3D8E19560A3;
	Wed, 11 Jun 2025 13:57:20 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6/8] rtla/tests: Check rtla output with grep
Date: Wed, 11 Jun 2025 15:56:42 +0200
Message-ID: <20250611135644.219127-7-tglozar@redhat.com>
In-Reply-To: <20250611135644.219127-1-tglozar@redhat.com>
References: <20250611135644.219127-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add argument to the check command in the test suite that takes a regular
expression that the output of rtla command is checked against. This
allows testing for specific information in rtla output in addition
to checking the return value.

Two minor improvements are included: running rtla with "eval" so that
arguments with spaces can be passed to it via shell quotations, and
the stdout of pushd and popd is suppressed to clean up the test output.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/engine.sh | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index f2616a8e4179..64c5be4313de 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -11,7 +11,7 @@ test_begin() {
 reset_osnoise() {
 	# Reset osnoise options to default and remove any dangling instances created
 	# by improperly exited rtla runs.
-	pushd /sys/kernel/tracing || return 1
+	pushd /sys/kernel/tracing >/dev/null || return 1
 
 	# Remove dangling instances created by previous rtla run
 	echo 0 > tracing_thresh
@@ -35,11 +35,14 @@ reset_osnoise() {
 	echo 0 > stop_tracing_us
 	echo 1000 > timerlat_period_us
 
-	popd
+	popd >/dev/null
 }
 
 check() {
+	test_name=$0
+	tested_command=$1
 	expected_exitcode=${3:-0}
+	expected_output=$4
 	# Simple check: run rtla with given arguments and test exit code.
 	# If TEST_COUNT is set, run the test. Otherwise, just count.
 	ctr=$(($ctr + 1))
@@ -49,8 +52,16 @@ check() {
 		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
-		result=$(stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
-		if [ $exitcode -eq $expected_exitcode ]
+		result=$(eval stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
+		# Test if the results matches if requested
+		if [ -n "$expected_output" ]
+		then
+			grep -E "$expected_output" <<< "$result" > /dev/null; grep_result=$?
+		else
+			grep_result=0
+		fi
+
+		if [ $exitcode -eq $expected_exitcode ] && [ $grep_result -eq 0 ]
 		then
 			echo "ok $ctr - $1"
 		else
@@ -58,6 +69,8 @@ check() {
 			# Add rtla output and exit code as comments in case of failure
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
+			[ -n "$expected_output" ] && \
+				printf "# Output match failed: \"%s\"\n" "$expected_output"
 		fi
 	fi
 }
-- 
2.49.0

