Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376E1A7264
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748713; cv=none; b=C4pypzCIaYYMEYcZRCH38Fd4u+1F1mGq8jo4dz7q7wMY5WYT0oLEyvUcKHYTwGErZdJwB/hoTwjtCZCFuHhJ0cFdoZ3Yyd1oE2TCQH5ZfEoVKVs9J02O27PRweVL1FyiqVeRz6pfajLQP3xkruAlsttasIIEEaDNdawmRfP+W1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748713; c=relaxed/simple;
	bh=NM87bN8YvYUPni3yHksXpoPE9+QFCA8dBrfX7EmhLWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=G2qVve6oZ8xsQjt8DHlt89AXheLI2E1I7SPg2el1wlj94zH4uovDJUCctyReI9Wg0dti0VZsIKuYPl809/3QnUgQHphaN5ZpYn+CAuFSVbosg6Jg9k3QZUo9Wd5kxpGQJZ7xRHDMSdhKHFOXhK1fbJk3tZI0MPJtC28fYj2cS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTwaU+nw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTwaU+nw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755748710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xM8qtFNN5+x1kmaWnRZihKX8eycVHQoqXVovqxJWU3I=;
	b=BTwaU+nwPlUWBf7vCNFAT4WEbPc2ucuofdhsCVdgkYbsQqDxcDs10aj2friyzM7/a7S8Bn
	W+/LMmycJzTCbZUuoz6A77cHpehWeFWT15IVyfBbf4R8yjErLORSIjM/nnHkSoyNuzrqdU
	s6uE285+TZJx8o51npYyEUzeJR1G1Gk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-j0d33H4-OzqF8fil6qAvdA-1; Wed, 20 Aug 2025 23:58:29 -0400
X-MC-Unique: j0d33H4-OzqF8fil6qAvdA-1
X-Mimecast-MFC-AGG-ID: j0d33H4-OzqF8fil6qAvdA_1755748708
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e9500a4ca5cso974449276.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755748708; x=1756353508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM8qtFNN5+x1kmaWnRZihKX8eycVHQoqXVovqxJWU3I=;
        b=tNXXSvYBqeJ9rJNHp7NYkctmeDnTrNomoJEZsXOu6oN9S8tqoGVDrs6dJr3WK5nNx/
         OG2YlXbtvdqJlzWyZDKfLzNqMvhavWS9yIML3qwVEHEfBLOwY04NOaLEAoZetTFRtl5H
         6L5hZoFeBq7gPO25PcB5P/btXNnbklPc3skxzVwmnYzn4cjAT8q6a+c5vGe8KYLIbvDt
         6wFgPCpGLI2I6w54ITQ2/dYS9nOTLu0EQchIfyHRUEMtyXstzXYZ/JBNBQHk6hHYNg+/
         gDSJqtMI6zx0pGhhRQWhgHqT92H+LTNfad26Pth2xax7sHvUSCWGzuM5h2WsIX212YHG
         /AXg==
X-Gm-Message-State: AOJu0YxCy++c9gkdYHuaaIGoGLgvykQkrUMzkcwkvlovLy/ACrAQab0X
	7bPVbqcaquLZKWxWGyKfxNLW+yv9Hne/Z14aSjpoRLO7R85CfhBJqPuncCL0EaRfDhXx9OsNqPQ
	bMg3yma7EBEsbkws2p/VI3yTP/sTSrLWV9L2a4xtZfMiFpTPiKKs2f+P5Oao27ofEidM+8Bq/Bg
	==
X-Gm-Gg: ASbGncts1DVS+NtKgbkdo8w6eAq+AL53S6bA9rDPsg6vYwJHD5OCNaTVBB6MNnOU+N/
	TcoENcf1VjRJpcGcHwTrzpcDPz5QUey2TloHZeeLjfD4QuRykxqB8bmbluGQ1Lx5lUGr9bzAW1W
	F8ku0HiSfA+khMlAv7RRxRd3qK9j2wLHGrd4HgrTz0XnTYqp5Qd4oMuEFckunggJKLMlQFv1cTm
	u8EclZTetL/I9zQfb9QPo9RgzhmZmgEsqNONSq5n3J6GmivexkruWn8CE/Tpb3R4ojzQjNa0FRt
	V4xyet+IeAZrE8c8O9OVEalQ/HyFJa4W+56hPHioq69BkE1NKXOVLrzrhqYNIUjDfovN1mY=
X-Received: by 2002:a05:6902:2a81:b0:e94:e1e5:930c with SMTP id 3f1490d57ef6-e9509bda490mr992140276.52.1755748708422;
        Wed, 20 Aug 2025 20:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqm60pvQ2tmER22BuJBVg349UR3lgB5v+QtnEg39uxzRCUuclXeSaGBAQ5ksvNMPUtCy6M9Q==
X-Received: by 2002:a05:6902:2a81:b0:e94:e1e5:930c with SMTP id 3f1490d57ef6-e9509bda490mr992128276.52.1755748708112;
        Wed, 20 Aug 2025 20:58:28 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e95078a1bdasm385457276.34.2025.08.20.20.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:58:27 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 6/7] tools/rtla: Add test engine support for unexpected output
Date: Wed, 20 Aug 2025 22:57:18 -0500
Message-ID: <20250821035719.137161-7-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250821035719.137161-1-crwood@redhat.com>
References: <20250821035719.137161-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p1QAKN4WWeJFpoJERw981sYNfFfPDvRbldNySWR3X8c_1755748708
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
 tools/tracing/rtla/tests/engine.sh | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index a97d644ead99..25cf0822eee5 100644
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
@@ -53,24 +54,29 @@ check() {
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
 		result=$(eval stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
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
+			printf "# Output match failed: \"%s\"\n" "$expected_output"
 		fi
 
-		if [ $exitcode -eq $expected_exitcode ] && [ $grep_result -eq 0 ]
+		if [ -n "$unexpected_output" ] && grep -qE "$unexpected_output" <<< "$result"
+		then
+			fail=1
+			printf "# Output non-match failed: \"%s\"\n" "$unexpected_output"
+		fi
+
+		if [ $exitcode -eq $expected_exitcode ] && [ $fail -eq 0 ]
 		then
 			echo "ok $ctr - $1"
 		else
-			echo "not ok $ctr - $1"
 			# Add rtla output and exit code as comments in case of failure
 			echo "$result" | col -b | while read line; do echo "# $line"; done
 			printf "#\n# exit code %s\n" $exitcode
-			[ -n "$expected_output" ] && [ $grep_result -ne 0 ] && \
-				printf "# Output match failed: \"%s\"\n" "$expected_output"
+			echo "not ok $ctr - $1"
 		fi
 	fi
 }
-- 
2.48.1

