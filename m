Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7236998C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 19 Sep 2026 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789799311; cv=none; b=RiboeOc3zBDpq4BrAwjRniMDQz0mQtQfvMJQcAVPwfUEa8dxZbjSiZURaweYes8Yup2oY1fOG3llqSFHQVGxQSxE9RLbEQ+qia1yK+Y/iGMrVFOVshn1LEWfNUPK0LXT9EbifdhmsFVNh7bV2NYyN/Mte2uNJaVqGgAxKuqSe5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789799311; c=relaxed/simple;
	bh=4feiHQ57/ibjGi39NEVZWfdiETKxBDwvyUC7un7PKtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=MlSZmXuCkwYOqGmIw/OwUJ9N0UhM62gxmhqVNB3PUNcCdW/6RNHodclSu/SpGGkveLCr5prp82MLSbmkl4wzz9kBC1QSc7gzHqEII6f1two5T1VRWd//XOx2tmXPdJSbiNxTOm35hTk0z+03VQhs6YsWKNhSnlFNELMI+8i+9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hReVz2sr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hReVz2sr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789799308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4nhjO0o+t5/NlJ4n89tkmhDvH7VSJczgqAYdURxCU0=;
	b=hReVz2srytOJftKWeffDbtSm0MXMVcLwSdam1ZpJyEpWa2nCoHDem28uuDRJBqgXB7jzdB
	4oSCqLY+I4U6FgMUhDhN/4M+zhTwIU1qoBWYG9y5HzQQsBUFJGuAtfi7rOTk7Ywh8akkZD
	+n2iUbOEyj+ZqWWA2NAbrZ7BmDJiSMA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Xs4zhYq_NLy4IULlAoHzjw-1; Sat, 19 Sep 2026 02:28:26 -0400
X-MC-Unique: Xs4zhYq_NLy4IULlAoHzjw-1
X-Mimecast-MFC-AGG-ID: Xs4zhYq_NLy4IULlAoHzjw_1789799306
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93918756165so295387885a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 23:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789799306; x=1790404106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E4nhjO0o+t5/NlJ4n89tkmhDvH7VSJczgqAYdURxCU0=;
        b=rIXDnGxv1JhLbHKc9P+risG62YGjZPdyAQgvfvhXlNBM8TrXbvuK0xSqYaCpWt8n5M
         MUr4epxGWHesfGhNlbgawFHAdcgrh8o7lXqvnUQnL5wci+8thygtJ8ZxZxqduPqPC1s3
         kJegiPZ9cS7rrbf1tFcF2n6QrPZSqs3Sm/ZV7Pf6RfnG7RZteil2Puls4IKOx8pT6aao
         HD8C/6pp1ks50X1gKChZtCm7i0CZTZkNP3at4Yi99WETmxxa+OXVeApm8Aj8qRqw/3Y3
         0hHjX85OAfUpcKokQyOliKo0nFw/EY8yQF/5o9bOj39U67ovUTnjGgIwBbAIRbcPsJVd
         U89Q==
X-Forwarded-Encrypted: i=1; AKwUvBztwSeDaFW2QW6UXY4AoYB8Ki0w+PzZamcYGxAhGahAKQqG716z+PGqdttjpROK/RSgivzAnCWgKsgsmaQ0EkiN9Fg=@vger.kernel.org
X-Gm-Message-State: AFuF++l//4KfnPNbauywOYHf9In5HdzbDtAxUs9GWMpAFvIpiL5JNRML
	1jxTmv7zCIGQ/Oe7lXq5bUQxXgwSZQAEiIiN1Q0SSmFDOF5KpMJN+ECDgWgds/5mFP437WRGDTa
	mKTMmcy8Ksipml0DXYyD5KUhMUc0mT1h8W+XO9dF7mIlpHwfaM+q77Uygkt4wrVKchNpTh31Evw
	==
X-Gm-Gg: AYBFou3PHBZ3+N6CRRc9rvUAItvn75v1jhN3Vd2DV8QXbfwTN/oSjWL4/I0bl1mo/hF
	dGt0SKTHz8Cfg5WhutUjxkarlgvaNOp8pPLiAsqvvLK/ucHWL//nrvdeXczelMlSdgsJvew53DZ
	9V3FwCpY52grE6l6SLUtQAYOG1/auVd3wmo2DG3kFLk2BPzgoBUk4m0t8NNEIuwrTjhKu4cpQXx
	zVgibzP7eBMOF2f25UlbVzKbY3KRpJjKzHAHHTMZtHIfPmwDdg0EZB/mxcSdeQeMzvQT3exBa5d
	Qjx8iTvMdrcK6ULcVFEn8Xv9stIYRAQjfpM0es4xUj0YetICG5ty/jrNjS6vDwxlwY2AagcG60q
	OQY2Q3WzGmk3Z4UlQf1VkF346F6tlGwG0
X-Received: by 2002:a05:620a:6499:b0:93b:d79b:9a5f with SMTP id af79cd13be357-93bf579ea9bmr29228685a.64.1789799305906;
        Fri, 18 Sep 2026 23:28:25 -0700 (PDT)
X-Received: by 2002:a05:620a:6499:b0:93b:d79b:9a5f with SMTP id af79cd13be357-93bf579ea9bmr29226985a.64.1789799305356;
        Fri, 18 Sep 2026 23:28:25 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bedc103e7sm120834685a.18.2026.09.18.23.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:28:25 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 3/3] rtla/tests: Add $SUBTESTS and $STOPONFAIL
Date: Sat, 19 Sep 2026 01:27:56 -0500
Message-ID: <20260919062756.819701-4-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919062756.819701-1-crwood@redhat.com>
References: <20260919062756.819701-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: beoMy0Ry6Evgdn8eYvucavKVdJC1qVBUa-UDltp3jyE_1789799306
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Give the user more control over the test execution when the test scripts
are run directly (not through prove), in order to do things like run a
particular test repeatedly to diagnose an intermittent failure.

If $SUBTESTS is provided, then only tests whose number is on the list will
run.  For example:

  # SUBTESTS="14 133 4 $(seq 98 103) 9" bash ./tests/timerlat.t
  1..150
  ok 4 - top verify -s/--stack
  ok 9 - hist set the automatic trace mode
  ok 14 - top disable auto-analysis
  ok 98 - hist verify -H/--house-keeping
  ok 99 - top verify -k/--kernel-threads
  ok 100 - hist verify -k/--kernel-threads
  ok 101 - top verify -u/--user-threads
  ok 102 - hist verify -u/--user-threads
  ok 103 - apply default timerlat_period_us
  ok 133 - top trace output through --on-threshold trace

If $STOPONFAIL is set, then the script will exit with a non-zero exit code
on the first failure.  If the output directory is non-empty, it will be
preserved, and the location shown.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 tools/tracing/rtla/tests/engine.sh | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index ab4fa0a8ded7..395b472921a7 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -9,6 +9,12 @@ test_begin() {
 	testdir=$(dirname "$scriptfile")
 	[ -z "$RTLA" ] && RTLA="$(pwd)/rtla"
 	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
+
+	# Convert newlines to spaces so that seq can be used
+	unset subtests
+	if [ -n "$SUBTESTS" ]; then
+		subtests=$(echo "$SUBTESTS"|tr '\n' ' ')
+	fi
 }
 
 reset_osnoise() {
@@ -50,8 +56,7 @@ check() {
 	# Simple check: run rtla with given arguments and test exit code.
 	# If TEST_COUNT is set, run the test. Otherwise, just count.
 	ctr=$(($ctr + 1))
-	if [ -n "$TEST_COUNT" ]
-	then
+	if [[ -n "$TEST_COUNT" && ( -z "$subtests" || " $subtests " == *" $ctr "* ) ]]; then
 		# Reset osnoise options before running test.
 		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
 
@@ -62,6 +67,7 @@ check() {
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
 		result=$(eval stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
+		popd >/dev/null
 		failbuf=''
 		fail=0
 
@@ -90,10 +96,18 @@ check() {
 			echo -n "$failbuf"
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
+
+			if [ -n "$STOPONFAIL" ]; then
+				# If the directory is not empty, tell the user where
+				# to find the output
+				if ! rmdir $tmpdir; then
+					echo "# output dir: $tmpdir"
+				fi
+				exit 1
+			fi
 		fi
 
 		# Remove temporary directory
-		popd >/dev/null
 		rm -r $tmpdir
 	fi
 }
-- 
2.54.0

