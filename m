Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949753;
	b=y9w2J2g9M65if4qhfrZeSnJf8ek1B6FR5fGGb4wh62zhMi/b0yaLErgzEHgt/MSrxEYU
	 PMLtPtPj+Ym/rHZNAjc4nkXO/U80cGNka8Ol1S92Gr8eozmgFZYGW45KGN4PnDRDepT2j
	 VtgG8+2lVApD9Xno+ghrHfZkX4TimVY7MgVaBPMr6rtfK7hAUWlrTll/huFe9tEGdqTQJ
	 IaayrLmsyWZORkR2SWJx8dAEAy2+3srh5CBAUMiXJLh+CTdt4R8k3Z0A+tVmKxkiR0P9K
	 EC/O4u58AkDCAzFAotT21hZp3Fp+SHEuCrPoY7ngPC88fTI1QMBayh6cXho7Bn4TuNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nluO+KDJonnXvVPmQXImi9sjBFQpJ5/zuHQkNadSdV8=;
	b=E5K7oGfl9cdSiAbA92PgnuOee5gFNbTP+ErlI8K+j15HHKeFtptpKcU/CaOBqNN70I6Z
	 OOVHj/d0WOTHakHBUL3C1ifykNlwDpqOxTJFRNneoL6wh0KCPyoctp34lfo2fjSK9D8qC
	 PUu7oaZ2b3o2qQY0FCp1JVFb8YSayQEBm3BLpyujt54AOsCFf+hF0LX/L3rqIKyTeLPLj
	 VAkhGCiCGUeOjWOp5VEAr9/SbdPnltJNCkbqVtCGzYPQI3TRcorRqV9au/p5h/QpKpETG
	 3V5xsZzNR4g+IetTJns3PqN3PCZZujl7Og4vwbcElc1uHA7eMGTR1By1DUMgXJEGPaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="R+8/FDb5";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CBA606A332
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 17:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48CBA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R+8/FDb5
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48df8fe8513so2146397f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 10:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792949751; x=1793554551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nluO+KDJonnXvVPmQXImi9sjBFQpJ5/zuHQkNadSdV8=;
        b=R+8/FDb5fxrpNY+uCXHRxKSTrtMrCfHqll3y0cSL4iHIOGhtsL/5TE4O6C8OZl4I//
         XkOtwCviFy855IMbLA9RvrjezK41mwVyWqbe91M5UZFHufp66alXpDQKn9XzEGiLXC2x
         HhLFmlObZzsEEe33GqIDcVrovCEwB5JxdqNII0BzwHL87Bk1g7wPxF+DLmtKN6A5JUHO
         alJDec5mV9LJpyt2HhxAn07Lt8NG1wiGgtEr+zdtWReWQGDLkKIVlt7qy8LoJbyEErf3
         5Fr/Uthydv/NlrHrEl04evb+eatpZAvwnJ5gZVQRzgidJYz5IJoUhZcT5U+/qAH+BNyR
         5zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792949751; x=1793554551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nluO+KDJonnXvVPmQXImi9sjBFQpJ5/zuHQkNadSdV8=;
        b=sOy0budClbdEjY+qhurSJXbdyPszPDYJGCulvQqEOFKtRQq/MdqsIyv5J+lYEWJCNc
         w278dcf4cjmE4K1Xg3FEFb0Op0XX2kDqJ1pskZIcNiaG72sL5LCkz369Rt1I5kiBBjSc
         5Yfvnvn5SIirnF3jkS4k43tIxxW33PS4QDiN1GjA4fr2iCp3MgtDatfjJf4il+v9zMe5
         IrFoWgd6S+hdoWP7qms2H8wHVgD/0KEohlIrEkVxtcmfI3sdzQZ5NJElBsw3geRs3NVY
         pRp7p/WLaii85AvwAULTsnfVUMjDJlTonyznGFOnDmTxdgSaAiR1ydCi98+mCpBKJ+2m
         AL1g==
X-Forwarded-Encrypted: i=1; AKwUvBw/02Xt/8EAUynXNtgBLnrGpW9RrlRUQ8AKjt7oq4096nqTxSXcfv0LbiCBYUzDTJQhzX5k4UFI7OkqdG39Uhu5GaY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqZb6zP3adJ58Cv4+ZG5gbLJyXel4b0zEzc/SfBFKy7hmJMt0O
	uqpdy8/y7xP20VV7Rvi48T5pqYgWYrFROkMIYnUW3QcHlIwsAkSk05Z1
X-Gm-Gg: AYBFou0VIOgrgk0b4XwGn/empPOEAIP5T83LghqyyulIDkL81QLYs9NU2+aa2Txjico
	OnirUIwlvtvgtrlBm/bAZu4fZuV4Xg/5J3A2xhCwbeM8+l5fdsqSb046RlP02DzIv33C9nN4oVR
	7ozBxYD7uMT0bIB2476leljAFuYycVN96zu5YyL4nBXfo2gBCGDaHm80NCI3oPuISqB7sNyokAQ
	zmsVTOFHrQT45ePDlbfFL7Kkaze6lkMmvNcq38nUYFZM26qgx1mgYvE/ULvgfUO5DBOHCa6g1aa
	t22J3QD3pzBIAiYS/PdYDdClugGjv28kaXgATETSsx1VUM1yDTOqgvcfK1zSc83QnbZ6HjpOFj9
	ub0B18rALXG2gGxamznyXbWpjWyC+6JK2wY7tuOGLZqJuqFTxTufVeYDPZc0e8fBexffszPVv0f
	5gUtmP5FbQ0XQKDr4rxGyuTmZRpb8axUpzBy7GhgSUrlpepxDd/wZTlyIpK4VRPOnXK6H5sdouu
	NGIo9GkKHaRUJEZvTINAvK1862zaM/+QTGr46EA7nbK+x8CcxsnM15qvtbRgJHJvWZ58qIHed3H
	9iUGZcMSdpyjU0fndz1bif0AnTUOul5uD2Xvw/DMg3E0h6Fd2zrrEOHm83E42FwVIFacp0fNdKq
	nBJa481ngrniJmUYOgwU9gXBbKboZydM2f2iXgDv9Oz40YprYfzoVM/u7u4yc8KwDxMopu0BaYG
	BqiozuiBzB
X-Received: by 2002:a05:6000:430d:b0:48d:ffcb:28e1 with SMTP id ffacd0b85a97d-48e3eb780b0mr7726162f8f.11.1792949751568;
        Sun, 25 Oct 2026 10:35:51 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-ce3d-9b69-45b1-5da5.rev.sfr.net. [2a02:8434:fda5:4201:ce3d:9b69:45b1:5da5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb90dsm10234070f8f.22.2026.10.25.10.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:35:50 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] tools/bootconfig: Recognize underscores in histogram variables
Date: Sun, 25 Oct 2026 18:35:24 +0100
Message-ID: <6343726e630448ee14c091fe369d8ae5331a0345.1792949723.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792949723.git.edumucelli@gmail.com>
References: <undine-1792936915899334889-d965251e73c20670@undined.local> <cover.1792949723.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable dependency resolver in ftrace2bconf.sh only recognizes
letters and digits in histogram variable names. A reference such as
$start_ts is read as $start, and the start_ts definition is missed.
The consumer is repeatedly deferred and eventually omitted from the
export with an undefined-variable diagnostic.

Include underscores when matching both definitions and references so
that valid histogram variables are resolved and their consumers are
exported after the providers.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
The histogram-variable documentation even uses names such as wakeup_lat
and us_per_sec [1]. These are valid in tracefs, but the exporter cannot
resolve references to them and leaves out the dependent histogram.

I tested this in a temporary tracefs instance on my Ubuntu machine,
running kernel 7.0.0-38-generic, with recording disabled. I created a
provider histogram defining start_ts and a consumer using $start_ts.
The original exporter reported an undefined variable and left out the
consumer. With the fix, both were exported and restored correctly.
A separate pair using ts0 worked in both versions.

[1] https://docs.kernel.org/trace/histogram.html#histogram-variables

 tools/bootconfig/scripts/ftrace2bconf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 032ac5b10a4a..b01297217cf3 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -88,10 +88,10 @@ DEFINED_VARS=
 UNRESOLVED_EVENTS=
 
 defined_vars() { # event-dir
-	grep "^hist" $1/trigger | grep -o ':[a-zA-Z0-9]*='
+	grep "^hist" $1/trigger | grep -o ':[a-zA-Z0-9_]*='
 }
 referred_vars() {
-	grep "^hist" $1/trigger | grep -o '$[a-zA-Z0-9]*'
+	grep "^hist" $1/trigger | grep -o '$[a-zA-Z0-9_]*'
 }
 
 event_is_enabled() { # enable-file
-- 
2.53.0

