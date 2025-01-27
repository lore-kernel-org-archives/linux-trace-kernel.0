Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F31581E0;
	Mon, 27 Jan 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997383; cv=none; b=upwisiTslijR5KR1Sp6feczStcdsUbIcwlAJexdwlDCOtKLBJTCXJ7wrxMYIVJPLzAdHC6l1OqVTxUdtIFFgrYiOKekVzPqx7hLx+5YcLs3obgsxQA6en1UJb5AcxfnB1J3xIIdJgnyL7CphwJlIW0QBizmjM5+bXWGD/TXnAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997383; c=relaxed/simple;
	bh=HS0SPj8TCubRded9Tn07CsANjAT4f8orcHKuJIyrEq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aUp4jReMCK1mkuaqJNz7KKh/LyKCE1Vcd2h0I5evfk78RqAGlX9urs/qb77ShsxWJMqfG00OYZPr1G2V7xtWiPnIac2Kvpq9fS+wL0n+ycfpi9qLaUrvmFNRJ1ceRFdnxp4WV9tjMXrgw7tyQyvIWvHXWLGoRdcE8x9RFvrZ3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so2870214f8f.0;
        Mon, 27 Jan 2025 09:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737997380; x=1738602180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wIDq6jHajqbOM81mUyrX+vudw6vCZ/eRDhI4TSKbtI=;
        b=xN+wjz4FzJ6786JthIHJ8BqEs0TolJlgn8ZKR9r6wkinl6B+c7LaQAPpce1uXGGtab
         bkp/xWlcdreixjovaQFO91SjxR7kX/m+1hcg3MQDW2uKbi535OW5M9K73JUsVzCB7312
         IUrvucrJvhhKm7t5UHchBgYJdH+QfHOCingP9eOaS/WKAl5Yd5Pj5vnbz1HEqb5QzO2z
         is4TdLzpH0skced9nkjucducdtzbUQ13llS5eyesDJw1MrJGdx3w4IvOY+bZiXw5EURy
         BF18y81tLUd1z+cvY/GfftQf6EF5BvA+/5FQj/hCGg2lN+tAJ0m3givK4rcYtqixBd2O
         Zn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhRXxcaJv+1ZwNDXWaEkhwB/N+jbcHYkgEvZTNABJ9ZFtt5VOJnzrXwkwbj9u5g7dQTVvdm7NT4q17MJ4=@vger.kernel.org, AJvYcCXhZ6Jlj0yK4iC4/bw8gMC9JRM5UZIppfrr4FZ/jScrnPwHlS7HeVsbB1weGgulN8EdjsdWdB7jhEMS4JYcqIBEceHW@vger.kernel.org
X-Gm-Message-State: AOJu0YzIc6/dcbKxtpEO0Be+tyag3tb0KtPzkta5V0L6gM7Zl1BFpVAc
	C8djaaa1/kskS9Z4JAI8u6jjKFFZIpBzCfZdKoykPJkkJIwNZjs9G7bu6aJeIpQ=
X-Gm-Gg: ASbGnctRZUPbn9byvpsBpY/mmvJudtLXeSAetjOaGtXEN/lzD50aZbajX+M66+v189A
	RViFw5DTGU9XMYF7NQR8QL14Ya/+hGGe6p7loYm1YX1esZXJnERfPOJZLALQ6z/Ec2ynUx05AVZ
	sF6GyTrG6UziMzxiFzG1/g8E0s3NU9j7AJhHQyx/BdWwDDVIXyKpaKuYnB76sUyg3XBQIGmCz1D
	mo1c0I1n/pE9Urx8DdH/uUNIwNb9AKBM05q9mtNZOpx3f4guHVnBDoFIh0qjiZzOiagjBDgRhOM
	BRqCZPPZcmewUSRY560=
X-Google-Smtp-Source: AGHT+IEouoF0CD8SOHRkYlubIVqlhxvun5t9G8+ViZ43FM84zkvZheNzf/8paaOHRkvQibda4mG5PQ==
X-Received: by 2002:a05:6000:186b:b0:385:df17:2148 with SMTP id ffacd0b85a97d-38c49a63323mr30098f8f.20.1737997379670;
        Mon, 27 Jan 2025 09:02:59 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188bf5sm11789787f8f.50.2025.01.27.09.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 09:02:59 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] rtla: Save trace when option `--trace` is specified
Date: Mon, 27 Jan 2025 19:02:40 +0200
Message-ID: <20250127170251.744751-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rtla saves trace output only when option `--auto` or `--stop` is
specified. Single option `--trace` enables tracing, but doesn't save it.

Save trace output in any case.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c | 9 ++++-----
 tools/tracing/rtla/src/osnoise_top.c  | 9 ++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index b4930b835b0a1..38fd10b2a3488 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -981,12 +981,11 @@ int osnoise_hist_main(int argc, char *argv[])
 
 	return_value = 0;
 
-	if (osnoise_trace_is_off(tool, record)) {
+	if (osnoise_trace_is_off(tool, record))
 		printf("rtla osnoise hit stop tracing\n");
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+	if (params->trace_output) {
+		printf("  Saving trace to %s\n", params->trace_output);
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 4772677ac762c..0af639982b7c1 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -811,12 +811,11 @@ int osnoise_top_main(int argc, char **argv)
 
 	return_value = 0;
 
-	if (osnoise_trace_is_off(tool, record)) {
+	if (osnoise_trace_is_off(tool, record))
 		printf("osnoise hit stop tracing\n");
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+	if (params->trace_output) {
+		printf("  Saving trace to %s\n", params->trace_output);
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_top:
-- 
2.47.0

