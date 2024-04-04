Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567EA4400
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Apr 2024 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712193014; cv=none; b=hmwAbqIaMgxSob4uuWzdqKCTDTUDcVfCrI+EQ9LdXF0J6TFjAjH2vqIq/0DujqsW9l1BxKqj1uP54TqCCaviIuzjx8PhFBjYptc+dDdqgDisSeKgpfjIPvGeQnHertXbLr3QlElGOzCKjLrANGdiGmpPAfgNoa9n+i8A9NaHAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712193014; c=relaxed/simple;
	bh=kC+TSppxAO7zUiJZpluSvGxhmErQAeqtY77z7J8nBmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ersbB3g9kpbzCG3qN7msWzDbktaS7/9kTqWppVQv9TNHLF90P7GxPOTBL7uaDgvl1OGp+NCX9Mxa/+PUTRnNVkxtcIqEyH666X/omQmP2xUqepCmtgEIuJQ627Ra6OPx3knGHRzZSxOXc1w+v+BOD0vGGsbaoAt4DNr79T/1Nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNV+GggG; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNV+GggG"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-369f4fd7bd8so19465ab.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Apr 2024 18:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712193011; x=1712797811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0WgnYpbpUKZo8YR8XcwNLrT1//n68QLqGA5DCAOQeg=;
        b=cNV+GggGtUynK0+YkmH/OlBPqkQXb6oKs0MLX1b7Dn+K/gSI6P0LVn+/8eiDZSoWDu
         GHug5VrK5wc11iYWucLjGnrdzczr8gbBRNmRr+qjnIpMsvwhbV9alqwRUAk12yirPwfd
         +NyE+b6VP+P4bC/YefIATBjQIV28TJSedbJZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712193011; x=1712797811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0WgnYpbpUKZo8YR8XcwNLrT1//n68QLqGA5DCAOQeg=;
        b=aw9CSQ/0tD0Nt0uBIV+00hAedZTF3BG+Og04whzTG6gijr/l4xnazq0qfZ8Z23N03/
         hUpt+oGJvGB7ufpJqPepoTYACOiiFuFBOTpi3JIxMymRiJKHCsZnno3DIy+1BNMwOgXY
         ZZHxzcKd8leS1if7+ePCVWoyUR2LIoa22ZczKoJ/swIbCaL5KRug/jAVAHyv9M8NHi/i
         jZNS1Gkffwf+bigDjFehKK2i7PRfz9JfteoWpAQtpKzOXnU08NwUV8z1x9j33w508Rrj
         ASm5isK0hFCOFy1yMUxdouIl5Yb6kJKLdUyDrxQfP4ALExYbQfTcRKxdZGXnpxo9u86e
         0JcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf+uyVXuVRPFVY9QI8Mo0ffCbVr/E+3S/D0E66WSC9nJ+SteO9b2/nAQtU64XR5vd63v5LuN+bT37YTAXIhMnxpkGQRx9QTr+cMDkYZtW9i4wr
X-Gm-Message-State: AOJu0YxTKIz9MQmr8NDQoQynTfTxgO/qDyfVB4fA1GX/rMAcNdGMTRhT
	75im+d8nVflfvTnu2MMmNy8cCJUhSBUyiHTamDE2I5XXLDNksYl4sT/UKUUnyBo=
X-Google-Smtp-Source: AGHT+IGzizUjyNsbrnkvaQ7qsQvHTiJIY9NENu4M2M4viBs1Ni39iIZIhvmOUKjjtTlqii+B3auNoQ==
X-Received: by 2002:a92:d0d2:0:b0:369:bf80:e367 with SMTP id y18-20020a92d0d2000000b00369bf80e367mr1379949ila.3.1712193011377;
        Wed, 03 Apr 2024 18:10:11 -0700 (PDT)
Received: from shuah-tx13.internal ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b11-20020a056e02048b00b00369ed8bb1ffsm797178ils.7.2024.04.03.18.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 18:10:11 -0700 (PDT)
From: Shuah Khan <skhan@linuxfoundation.org>
To: rostedt@goodmis.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tools/latency-collector: fix -Wformat-security compile warns
Date: Wed,  3 Apr 2024 19:10:09 -0600
Message-Id: <20240404011009.32945-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following -Wformat-security compile warnings adding missing
format arguments:

latency-collector.c: In function ‘show_available’:
latency-collector.c:938:17: warning: format not a string literal and
no format arguments [-Wformat-security]
  938 |                 warnx(no_tracer_msg);
      |                 ^~~~~

latency-collector.c:943:17: warning: format not a string literal and
no format arguments [-Wformat-security]
  943 |                 warnx(no_latency_tr_msg);
      |                 ^~~~~

latency-collector.c: In function ‘find_default_tracer’:
latency-collector.c:986:25: warning: format not a string literal and
no format arguments [-Wformat-security]
  986 |                         errx(EXIT_FAILURE, no_tracer_msg);
      |
                         ^~~~
latency-collector.c: In function ‘scan_arguments’:
latency-collector.c:1881:33: warning: format not a string literal and
no format arguments [-Wformat-security]
 1881 |                                 errx(EXIT_FAILURE, no_tracer_msg);
      |                                 ^~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/tracing/latency/latency-collector.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 0fd9c747d396..cf263fe9deaf 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -935,12 +935,12 @@ static void show_available(void)
 	}
 
 	if (!tracers) {
-		warnx(no_tracer_msg);
+		warnx("%s", no_tracer_msg);
 		return;
 	}
 
 	if (!found) {
-		warnx(no_latency_tr_msg);
+		warnx("%s", no_latency_tr_msg);
 		tracefs_list_free(tracers);
 		return;
 	}
@@ -983,7 +983,7 @@ static const char *find_default_tracer(void)
 	for (i = 0; relevant_tracers[i]; i++) {
 		valid = tracer_valid(relevant_tracers[i], &notracer);
 		if (notracer)
-			errx(EXIT_FAILURE, no_tracer_msg);
+			errx(EXIT_FAILURE, "%s", no_tracer_msg);
 		if (valid)
 			return relevant_tracers[i];
 	}
@@ -1878,7 +1878,7 @@ static void scan_arguments(int argc, char *argv[])
 			}
 			valid = tracer_valid(current_tracer, &notracer);
 			if (notracer)
-				errx(EXIT_FAILURE, no_tracer_msg);
+				errx(EXIT_FAILURE, "%s", no_tracer_msg);
 			if (!valid)
 				errx(EXIT_FAILURE,
 "The tracer %s is not supported by your kernel!\n", current_tracer);
-- 
2.40.1

