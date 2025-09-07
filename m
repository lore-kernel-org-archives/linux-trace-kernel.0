Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596401A9B58
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Sep 2025 02:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757211835; cv=none; b=ELnDe+6UXLCJImZsc0Dr0bkLEYleYHGRh1d0k7zJ/boJrm+YAaQNt5dk1bad1DN0gug/dZWnBw5lxc8u1bdYw8SdR7k6KOsvJIepUhLtXxdTzTmPwP2Kx0W5ryhXfJMfeqzYP3Bnmqf/cekVcugxyt7JlmSixEjJANDRprzvjto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757211835; c=relaxed/simple;
	bh=TJqGNl3PkldLOc6OXk64ANwPqHabyvULtWJNbuvaeLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=o1Ln5bOAMH2WuLF1Pd9HoNJxraFNuyfM4bqOXckhdW88b16e1oVXe7l+wlzl/Ca8pXEJExB8evyqq8hi5uu0aV4YvMTLQbeHwQLWvBpBt7XmSUbOlB3WV+74BqOk5JY971I8h4UEz02Rv9PRrVw+TCofNfl5nD9YFPQITnZC/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyjGyKxw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyjGyKxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757211832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXLhqyev/UIO4j1rZ0TCobapjF225R1The+COq6QMOc=;
	b=CyjGyKxwqO6mtlbfKDt9qS2h4eWfN0ctDDcwzr/O+LOJU56lyvYphooI9LpEwbIjqD+oqL
	P8uu/tQRhHwVWh7Y/ojdrPpCp2pOerUvx+IHIpko80DkErcEYrYO/BlDpkAno6MeswiKXp
	cRXabgIMLPVr6AQjCOsHri/WNiCOf1M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-W12JUtvtPEiy4QfLuJ3CEQ-1; Sat, 06 Sep 2025 22:23:51 -0400
X-MC-Unique: W12JUtvtPEiy4QfLuJ3CEQ-1
X-Mimecast-MFC-AGG-ID: W12JUtvtPEiy4QfLuJ3CEQ_1757211831
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2f9e8dca6so83360421cf.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 06 Sep 2025 19:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757211831; x=1757816631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXLhqyev/UIO4j1rZ0TCobapjF225R1The+COq6QMOc=;
        b=QllBkUYj9hEUJ+1xwjaHGSQh9RBHvCMy2Oey9KYOyc94iw3ugeGk4KTvGjHT6nH/B2
         13OSqOcjbQBLnI1wIMga0GgGCTtcpxLaPeod16L1nGzXm2riZ1vK5iUXPTSSYBX81zuN
         EG/xWi8lJRWtUKmc3xdRmN+OkcysnZKJkEbeUHHdunHIjeGuzS5/7S3MvQenulCnajbI
         sVcHxQwA+uLusNl+C5HzGgPiw7KdIttF1O4xkigGQQnVKVKX9HAE7lpmauLHPaonIYUM
         mMtxunenUdCarZErUvtNRSehJYGpCXtdyZ7wTbzNPARmLHDjDYGfAAdwj1pv7/8lBXuL
         JL1w==
X-Gm-Message-State: AOJu0Yx0Ik8IbH7vfiK0zlv2SA+4i0pa+7je1pcidz7PQQIptjb5C+FF
	U1FBxCijjscAnFy71YVNOJSbuJFJOnvgQgjGFbN/LoRaIh09/446Bzz27YzYcH3h85cOhOBZDSo
	zw7cvYLzjhUQQ85p/oBMRAHS+8AkEyUy0r7VN+8X3nfQ+h0tzJuZzIpP4tjiRsTs9rdOx2KD3DA
	==
X-Gm-Gg: ASbGncu+TDyOBew4kf+hf1XwZPKphfgholrULzBjO9OyDtd68zs75TxP5RjiiL5kIm4
	/0awJFhMZEqT/t1cYxDbDhMhkyHzdTwQJWwM907AldE32W9O77XGysPstZtpKABm6ny3w5DJHDy
	1WXJR7bFwWbvp+X/Z4xyeolKMsLczFtKb+oejUsjfLnBQmLM3Md96V4yZ/+PUw+MpzHxQ8fTFWF
	DwSvCxEA//Wf0E+4P9QLmnV6ynT+jN+VQS0CXwx7SzI5KLryLEc7wsDzMg0SNgcHfqRHIU4KtTM
	xiolsUQ11KJsSlGZSVappknGNcQ+wpgqLbSplTEfZIU0aKBpdGjtyBhLJlFZT39tcYEkIlk=
X-Received: by 2002:a05:622a:1aa0:b0:4b5:f6fa:83c6 with SMTP id d75a77b69052e-4b5f83c8afcmr36349611cf.20.1757211830790;
        Sat, 06 Sep 2025 19:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiIkQkxcK7aeczhcqHPwQcVxzXAW/+bQxncTjfA9UigzbqVRwh5WeKaQ3V6VQv6PrqBSS66g==
X-Received: by 2002:a05:622a:1aa0:b0:4b5:f6fa:83c6 with SMTP id d75a77b69052e-4b5f83c8afcmr36349481cf.20.1757211830410;
        Sat, 06 Sep 2025 19:23:50 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f673fecsm71105401cf.21.2025.09.06.19.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 19:23:50 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 6/7] tools/rtla: Add test engine support for unexpected output
Date: Sat,  6 Sep 2025 21:23:24 -0500
Message-ID: <20250907022325.243930-7-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250907022325.243930-1-crwood@redhat.com>
References: <20250907022325.243930-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e75Jquvy76rJjHzVS87xcaV2gqXSGDOVIHzoy6HsMZg_1757211831
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a check() parameter to indicate which text must not appear in the
output.

Simplify the code so that we can print failures as they happen rather
than trying to figure out what went wrong after printing "not ok".  This
also means that "not ok" gets printed after the info rather than before,
which seems more intuitive anyway.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: Preserved the original ordering of "not ok" versus diagnostics as per
convention
---
 tools/tracing/rtla/tests/engine.sh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index a97d644ead99..c7de3d6ed6a8 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -43,6 +43,7 @@ check() {
 	tested_command=$1
 	expected_exitcode=${3:-0}
 	expected_output=$4
+	unexpected_output=$5
 	# Simple check: run rtla with given arguments and test exit code.
 	# If TEST_COUNT is set, run the test. Otherwise, just count.
 	ctr=$(($ctr + 1))
@@ -53,24 +54,33 @@ check() {
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
 		result=$(eval stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
+		failbuf=''
+		fail=0
+
 		# Test if the results matches if requested
-		if [ -n "$expected_output" ]
+		if [ -n "$expected_output" ] && ! grep -qE "$expected_output" <<< "$result"
 		then
-			grep -E "$expected_output" <<< "$result" > /dev/null; grep_result=$?
-		else
-			grep_result=0
+			fail=1
+			failbuf+=$(printf "# Output match failed: \"%s\"" "$expected_output")
+			failbuf+=$'\n'
 		fi
 
-		if [ $exitcode -eq $expected_exitcode ] && [ $grep_result -eq 0 ]
+		if [ -n "$unexpected_output" ] && grep -qE "$unexpected_output" <<< "$result"
+		then
+			fail=1
+			failbuf+=$(printf "# Output non-match failed: \"%s\"" "$unexpected_output")
+			failbuf+=$'\n'
+		fi
+
+		if [ $exitcode -eq $expected_exitcode ] && [ $fail -eq 0 ]
 		then
 			echo "ok $ctr - $1"
 		else
-			echo "not ok $ctr - $1"
 			# Add rtla output and exit code as comments in case of failure
+			echo "not ok $ctr - $1"
+			echo -n "$failbuf"
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
-			[ -n "$expected_output" ] && [ $grep_result -ne 0 ] && \
-				printf "# Output match failed: \"%s\"\n" "$expected_output"
 		fi
 	fi
 }
-- 
2.48.1

