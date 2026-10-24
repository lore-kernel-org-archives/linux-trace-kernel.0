Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840135;
	b=Bqs0XTFmKeShPxyY8CDLAjgMHRljXeA9ivmCtgkIQWOu+pPoiaoxPwQiETxt352cZnSz
	 /rYnBqvFiBy5FI5C083Xhc+9qdzBt902Ruj44Fx7Un3uxR0uBxOsnOBzyL8M7rUw+J0K0
	 VJbXZvnxlNWpTE0IU82iwPGc6ebe4jzhXszVg0Eq/4vDSnpxrpwlKp1kLMDn+oFaRlq/l
	 Cqz4Wu5837jV2JICvSfuVH+1FV3tWONhipqio2BTRD+qAxO3BV7nH5Gr6ShkcIRcIn/p4
	 /8KJVG/YSSjy8XjpfHlfjngwN6gmst296d+10aRH/tZlaAHKkuR+MRloGhbR/wSpfHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DBxoGKJYSm5y6zQZcrOzfKzML+4D53ES05aRi6R6CCw=;
	b=kOoabYRPjWI+NgjFGPUK3HNvw+4v9wHotz/5BgZeovw2Om1ZqPc8b88WJWr10UHYS/Mw
	 ZBRmTMQcfu37iACYjIuma9X5lF/V8bKvv08WJtXOUmOmb3kaztS1sNoWj7M2/qCcB8GZB
	 NrPPBdhWKeymwt+h9OWwypUOQkGqKhg3t/GfLrU3cT0pFSQtQ1xaEhTrkSwB2HeCiZUaa
	 B2E7ZLbOHJRsHEDexBBtRQoSUlrpEynHAZHY/5iCdc4V33PBT4ymZ68F4FlmJUaxqzlBH
	 Fu+F9+iRooH7kGV+hmqeT3ln1fv6S6n9/kxH06AZKW2bWEF5Xb7mCrnIckS7jcnCISQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SARMD6Wz;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE17F606A31B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 11:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE17F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SARMD6Wz
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df54150dfso870975f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 04:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792840133; x=1793444933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DBxoGKJYSm5y6zQZcrOzfKzML+4D53ES05aRi6R6CCw=;
        b=SARMD6Wz2rx8Vsv8nE+p00dE5vyQzy8CodLwc2r2gAKZ3GKNHqLSwYe29oWTtRohti
         avI1p/H1Ljrdmb/1IIb/GbPuwfabK3idcGF8tc3Sr1nARkFW3EP+/z4flvPHPU+uBMx0
         H0EEa5Yk4RoFs+sU4cvdrMHB7Ma1vGGas4DJqlMGCxkljFNGRMOf5exAJDC618AvY5e3
         JZJxc28IDZH+uPXkZcOiTV+v4X6iuHfRbB/MU04wFiQaLXK4RD6OVgLLInUfqh1S0nxO
         XnxeiMgQFbI25QZlUHRh8VnUJrkL5VqN+rjoYinv5v2UChyxfSKanHkIViuvOtjFIOy7
         2aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792840133; x=1793444933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DBxoGKJYSm5y6zQZcrOzfKzML+4D53ES05aRi6R6CCw=;
        b=eq4RTDbpepBSBg9NoeTLohVEpip3lFxrP9EGdYTOMHwK8TbpqY6UWIXl4hRQ9yi/0s
         LXNzszvXIaBrPnSEHcygZLcgfeUo7m8AEWZ55Nf2xdQoEMCyZkQUmMQjef0a/HXeaPF3
         2Wzpxagky0FEJca5SqXFJDK0L+xYdPek3J4YYSy82UgSKXYVOnNgd1NM+JQ3AMXNz6al
         c8hyyrqPOZRmgs4H+WLhKpeze8wgMPE5o9mVk8oEQxzg5IrGyjlnfpJHQPp1F4BwbMt8
         vUQw6ljpwHhliD+MzX66+22Ra9V0uv6Kw7m/j5/agMoRCtukYB9ec3gedS4cbAKScf6v
         yBBw==
X-Forwarded-Encrypted: i=1; AKwUvBxtsVXDHny/x6k7Zxr+vnLAMiYjqr01namXVZYBeLfqsJuAkZaihd5nlxlJuXmxgwJOWbttBX58+bRbcOskpU5xYYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIS+XJsu2bKyd9a8p88BkEFbCIPUEAyU1iju8IsFeGw2AU75OY5
	8WTr1ifRiFGAa2RCAZ/WtK1N7gprhEZMAmcj7STrjjnQBq6ktVchDiGj
X-Gm-Gg: AYBFou00FrueKN3agxKdsd24Dbh1EtlCA484xx3aKH4n3VYHAxWL6ahPb1iwkzeKg7c
	szwXGkTJrygZerTtaIcvDwxeECnSSPyx4qwQStWFBxBeijSSUDD65xBW+qSeTdHcM2el7AAQ3eO
	fG5aAvFNrL0+gUp+QMyVlaqWyS3P12F+rh0m18lSeRfDgZcQH/MMhg1+w65o0g3Mlc1bWc4V+8T
	ryJrH1yM9NOJ0Omi8xjeH6+AVY7IxDB+9ipkRpqR5a1VqxMYiAH2TKng06U03DGPGu4oSIrKas1
	A0MSk2eqY834SYZjn/rphIJVpi9B1EnJrOxd0E6CRCe6+741C8yePihhKkgZABbk1N6/+b8xSAR
	pQNqGoPnQ+7yqrJLuBzxFBtCw7mh0vwdGErSoIAlCyuXUS4bJ8T0XW0FrJCFgrPpuyhnMx29Ixo
	VpW140p+UNLoIwLd6jI5XAeFJEfzbasHepBNQHc2SL+9POA/U6jTtU595ZJC1soHoTr2TbVPyuk
	PQluTTQR/woAJhLeVdeROA+1s8EpZJ18ByL48AiOlFaZEDJELL/HkLnr2AxOU02Sk3wPOnAmdyC
	ijXLPg/PlrQWqHM5Ym8bBZiy5JEY6YrgGwf4/4I6+4h0SHlnjPSVu5brxfgVo1+25YfR6isbfyI
	7HvZryi50cW6RM3+CYOwWbTV51q4CNGyd8wNeJFKa+zX/BOtOX4GR6wsi156PLaHoqBgaSvzPPW
	rO6q9iv4wE
X-Received: by 2002:a5d:4642:0:b0:487:2777:6354 with SMTP id ffacd0b85a97d-48e3eba05b5mr1690355f8f.48.1792840132867;
        Sat, 24 Oct 2026 04:08:52 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-2477-70a4-825f-3684.rev.sfr.net. [2a02:8434:fda5:4201:2477:70a4:825f:3684])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3555sm3575035f8f.42.2026.10.24.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:08:52 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/bootconfig: Recognize underscores in histogram variables
Date: Sat, 24 Oct 2026 13:08:37 +0200
Message-ID: <20261024110837.696216-1-edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Hi Masami,

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

Feedback is welcome.

Thanks,
Eduardo

 tools/bootconfig/scripts/ftrace2bconf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index f8f288f90c74..de1d387a8efd 100755
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

base-commit: 22ab3094befd6ef37135e4a252c0da9cd755f75a
-- 
2.53.0

