Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216225;
	b=wNSjcoMVOjhAHYzEG6pB7LemJ2IE4dMTO1BFJY1oOfnJPoqORrwiIACztGSe/jSesgOJ
	 yjvMpqsVfEgimUj7vu5P1itaOmbySDLtW9GCnUrrkHq/xbaUyRm6KYYKrNQDDG6fJIQFZ
	 yg2v6vn9gVhR6vU463tTkKZJzeVXp7eJ1QcRlanTiouAz3db+MzCw2u0O9BZogcf+Ojh6
	 J4JyemBtvg+42Eo+YN3I2Kql16vN9XEQxOaKVJgTY7fGTCkaPyUsZWey5cm+RIuz1LCWe
	 sBRALz+aaTEcfnGTdshvdDYX9cQqt11m+cGANctzAcmZZyRpa39fd8e0lpwOAT9oyxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KAHDR/durFaCmnXZCSbDEqTD1WV/JZNcTJmjD7z7vr8=;
	b=HkTGvzNCRV7W/uUo1WiDkBVnSmfSdz1Kb33Cgu0OcE1KAP5y2sP2WNHDyenqwoeL++vR
	 Izf3ZqQ3gn1d6WLMP/36ZEx80glX5dcZhulq+oZb7GGWIXrBdwrN/Om63S1LTsNY+W0gH
	 gjsYDQzd/MRQLY2FjMOFQgF+5M8sTQOyugdMCStE57zbsEQ/n+5ChuQR77L3+ftxk4Foe
	 jsTqy9pidZ7ThdG5iPEHOwBKGCdw2M3gaKnc0A0x4BcglnMNlSi6on5Zz8pPc3l4wer4O
	 n1bnkZzP+X+4YldIwRKBtoiLp0njG4l2Pej1hF+YRD/5PlKaDeL4j0CPRCsmHNp7gJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZtT3Nmb;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C95606A333
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 19:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4C95606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZtT3Nmb
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1055594f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793216223; x=1793821023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KAHDR/durFaCmnXZCSbDEqTD1WV/JZNcTJmjD7z7vr8=;
        b=QZtT3NmbOEWA1FFBrpkAGLiZ1OpC5NOgVcG1N/pEP+Uy5PvPsEyJub0sgE0xDWgw4X
         nIRIzca3KeFlYGzEnHuZdzlUqc3wa1c7PQ/HtWqLJiJT349iQCppxk+Yp6R1GDzGk1Mk
         4BrsGfKzP3UGJo4y0qcePod4SEOu0LRIrGgDA36jrWJVDh+t7Tc+8OMgMebjECQe3n7m
         ZCBOe+1cKDabtkI3NSRLzvXpnZHQ2dG4pZnL0R9XVUz1KmJtsnQXGUSFUnihmqgibwHI
         MvvJ4mcVKGte0LnB5jUcFjmPj8QST7h/dVgIsykHIQXGkspKWMAthpN0VXDkUfAI/Cm9
         Dvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793216223; x=1793821023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KAHDR/durFaCmnXZCSbDEqTD1WV/JZNcTJmjD7z7vr8=;
        b=2tuu6wBUrJtznKfDKgxlY9g6c+sdBCLagp88dB28C0Wq5FEHrgvRT4coUV0oR07v9o
         yltDn3yhumP5dDe55VbISHkURqLyHMC+pIogdA4qEJXyjv2iDi5KA25GzrGXJn+/1yf/
         xfY10sqR5oVLJgns11fOQOJh5/KWefT6hbpMgx2xSlwYaasMaoYLydcpIps4rVYMmANP
         wzGZZn3l24NJ9khWHPWwWf3Z5+22dSH4ShPLoGjQseVA2HUHLCbJHirKW58JE5Ksf+6n
         xclX69CR8Z+UGoYmg07CFKLJCRPIrh+EkTfza+ojkRzixMeJmHlQH803saaF9DgT7lUp
         Ph6A==
X-Forwarded-Encrypted: i=1; AKwUvByh9tZBCgzSabER3AoSmOfVypCNpgNE8X/Bzb+s55CEmjn4e85EFh7TS3q4C5cbENkrSWt2t/7XU4l7mNkhPhxSMmM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxtkuXustHceoPDxmQbPkoHlTVQN+caFsYpzgYgP7Ar0fycFBy
	/Wf7YUSiQmvDCG7vo5gADqXzSVay0eaE7RDjQy+I3cMcUNHEzHdKZ93w
X-Gm-Gg: AYBFou32ZzqkGddm1wmxfbzo3ocp/jsQmCRsrpmTky3li7drnwqV8wLN4VcyqCLZtwy
	Y3dcPqHpP7dfvF0wkgYhIUkN1qvnVF0MuNstUpbJljVmuUQAMpFqNTfP5IbZLltFYVkAyExgP7F
	A1483YonPs6vfSimPqqqc1BM3OwskOj/OoNpm18pM5FHfF9iGwwDGGjkj0orAUkD+Do04kGBfcu
	DeLrlEbxkKaCLR//ybAaDUO3/pT0117ekuYSDTWRuYW3RQSYrtp+9UMmqjWZgjtPhskCm/u2iJ4
	rfEeGpTizq1frPyWcxwrCQP0Ob0gqVuoDYqwcinLaAsKlGud1I0+rg91ecSrn9SKZsXxoet5CZ2
	NRGyj7fh6ohK9Q+r4PjzVgioBXO6kUOvHApNlrBofG/YH7QswgxkwcNUrOk5zSh+VWgHG5tWnFf
	CAgaBQvTM5lPzEcRQ6H5kuXbRosy5/T3xD4c5fJWqjwou+SOe6X2ORXCb1KfMrwe8dInpF8rOzV
	TRggBbnawLn95ITMKPLQfxrB4moN6i37zoUVYwnVZILWcwGFe0kYR0DwqVbNSN6pPFDHhJfY2NV
	2fxJ1ujsBaNhqRsjThM+18WvA7IqWv/zxtTdImYvf7tjWLwIEhxeKT9yQ3zsOXsMDG74JZYMKTg
	chMggVdtT/JEpIpXcrMeRA0IsU9LznuJtZ5p2vQdjALE8E4ETA+Dc3uVvhoZGU9PjjMbBk/asE0
	R/tgKQh5IyUJYK3YbaEw/yMgt7/9xT02gD2ZI4AWAHunoFThjxybhXUwtHYPcTMgLewz8kC6Cm/
	zvX7OI=
X-Received: by 2002:a5d:5e86:0:b0:48e:21d:7265 with SMTP id ffacd0b85a97d-48e5d306296mr8258369f8f.34.1793216223127;
        Wed, 28 Oct 2026 12:37:03 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-3fca-2040-fad6-74df.rev.sfr.net. [2a02:8434:fda5:4201:3fca:2040:fad6:74df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3418sm27004611f8f.41.2026.10.28.12.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:37:02 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tools/bootconfig: Preserve filters when resetting histogram triggers
Date: Wed, 28 Oct 2026 20:36:23 +0100
Message-ID: <9653f7959268a03234c33ec5eb25d16294241fce.1793216183.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793216183.git.edumucelli@gmail.com>
References: <cover.1793216183.git.edumucelli@gmail.com>
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

reset_trigger_file() cuts a trigger line at its first '[' to discard the
histogram state suffix. A filter such as prev_comm ~ "[ab]" is truncated
inside its quoted string, producing an invalid removal command.

This also breaks the first pass that removes action histograms before
their variable providers. If an action histogram cannot be removed and
its provider is visited first in the second pass, the provider is busy
and remains installed after reset.

Remove only the trailing [active] or [paused] annotation. Quote the line
while extracting the command so that repeated spaces inside the filter
also survive, allowing the action histogram to match and be removed.

Fixes: 5675fd4ef51f ("tools/bootconfig: Add --init option for bconf2ftrace.sh")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested reset_trigger_file in a temporary tracefs instance on my Ubuntu
machine, running kernel 7.0.0-38-generic, with recording disabled.
With an action histogram depending on a provider that comes first in
the event-directory order, the original helper left the provider behind.
This happened with a bracketed filter and with repeated spaces inside
a string. The spaced-string case even returned success.

With the fix, both histograms were removed. I also checked active and
paused histograms, onmax actions, and ordinary filter controls.

 tools/bootconfig/scripts/ftrace.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace.sh b/tools/bootconfig/scripts/ftrace.sh
index cc5250c64699..c2b993f8e366 100644
--- a/tools/bootconfig/scripts/ftrace.sh
+++ b/tools/bootconfig/scripts/ftrace.sh
@@ -21,13 +21,13 @@ reset_trigger_file() {
     # remove action triggers first
     grep -H ':on[^:]*(' $@ |
     while read line; do
-        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	cmd=`echo "$line" | cut -f2- -d: | sed -e 's/ \[active\]$//' -e 's/ \[paused\]$//'`
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" >> $file
     done
     grep -Hv ^# $@ |
     while read line; do
-        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	cmd=`echo "$line" | cut -f2- -d: | sed -e 's/ \[active\]$//' -e 's/ \[paused\]$//'`
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" > $file
     done
-- 
2.53.0

