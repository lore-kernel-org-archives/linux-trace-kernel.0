Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072E3B5312
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428833; cv=none; b=XpToMaJcu2JWgQipe1mBPTpFWF5PB4mEqouM4CVme8uoGmJmYTZJ+wRjSfVkEh8Ny4n+2O7oCEBff8hFeMfFHpt2cjpez6tUR2w3Wwt5hMQW7mlZIAkUwu+wySP1etQoAWH3FJQw74l0iSsFsOS83ujVKlbfwDSRK5V7t5R067U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428833; c=relaxed/simple;
	bh=IZqAGizxkk9ErROuOBGZmrieBz1ow5xW+bA7VsOBVFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJL8ebsXbvdWr9X2eDLwS4Luo7x1QCwvpPLIHkoc3QxZfk2dK6gMx6KG7Tfjaxlz2YhhONocEC45xP4eqLDE52hNrvnX5NneXcksPc9Ulubnw6AFPp1An4iqe8u9bBgSfovph2GDqlDXjjzd37HJ/mt84lVA/ea3HviHD/tFLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO4tddO7; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO4tddO7"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c53198a65fso32048685a.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428827; x=1769033627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXFVdIECi6ilyP/TUQ5Ud/VbVwJbO6QDA7pbbRj1oPg=;
        b=WO4tddO7xAYYTf9hDsF5hBYqWylnDKYCtVCM3g5Bu2Ww9Xv17G0AZ3RiMCeQwCSxhU
         8kaIqew1Cj+bgucV+m8L8PZirehadkRbtJqDSRXPk6rEmt4UXf5ZLqLsN8FjeHxc2ucX
         rFRcPDiPwEPOQNe8SIkaXBwBbgvZJ7+vJ5fSAPZTG9rZ2gnmlRdiJ+kSSgGcfToaxhzH
         Efftzc2YdIxe+P/RPDi1LM553BI1MzUamD99yYorWtKzygvlAiqb3RSrYdqJeFvjy4og
         gTm3gpiSpRgyPK1krhxxxZE3LdXKsVKfVMiyPoamSL+EEuLS3ioJgR1gA/jh5qHQBMEU
         4hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428827; x=1769033627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WXFVdIECi6ilyP/TUQ5Ud/VbVwJbO6QDA7pbbRj1oPg=;
        b=WEwS5+iiZi2SbBinjodBXnXpz5vhpmwjPy6pRXYQfWEmunJtyS/m4GbJIIdsRhJrAJ
         wINGaMy9ff3lcbizjDHU1jsQRBcK/hgH5utMBEoqNkgfQFWd8bfm62PXzsfDPCMDcQ+X
         EEn3NlN+X2oJGsF/19dr3dJo4iRwOdX+UZDIpc5FlETHkCQhBjV6DJpNn+Ir6S8Bs+7R
         euQpSKppFgl6uFnaFG3GQQkVSdjP3JCQ+Yab0YuaHJuYUsJzPnwfpiTwlbQF0rUno8m/
         0pqltDMf/favT5PiEDToMYoPL7YEUurGblrtJh8niMeHiA7l8FNu2c2ls8QyDhXqQ+89
         ZuDw==
X-Forwarded-Encrypted: i=1; AJvYcCX2hjOxzHs5yo8ZP7snEPPUXwKlv9OiteqUtvU6I7UpUyKbqVvacJknjPMufW2cbtkRiaE2gHZBguApASiJj3zm2zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqR/mzD3ABE5XOCQqQ/vDEQe5++A7qfLaAqIwTklDt4mcPdIB5
	yxHQC9OzhfsHJ6ohNuhw9fUNMxyNrDD76ikbR4zvdy4lZFd54/zkyGSU
X-Gm-Gg: AY/fxX5mSUnSH0lahDbP6gBScN/ie/81CW/RsXej4Nb3xWDwS5mOzxhWRNpcASbkDya
	QHtDUMVzYIhQAZ97hu6doeC+lSLrTt5i93uvg4SRAx59FJ4VY8kG/gMVPCwmZUbQX8ntKN1fjf5
	i/HSLFm9SsdnqYtWfYDGqsTMR4s2xJEnAZP8p20erNUD0D4R0Qfv7RJiIskJmiUi2wDWzhGdMW3
	MC85wIDyUw7DSxqP7Lj5mq3oTVT//QWXK67IMNlF8nqlppmFi81rgK2Dh8G/1RzJhKW90MzvFym
	5/qgp0Qooznd3TY5xGYOKETmr5HAl6uFrpIulfrZ/PgghPq9ZXLdULZcTjoSrqomxdbUxaAmTCQ
	AglWHX/q+IirmtSVzH3f278gMeLfaLPzN866xuSFNvm+8nnnwCNV8D3hHb251CElUsGerOhaqpY
	0S78vl+KMbH5Ko/vlav8R4LQ3EpgE0E4T5CUeJMmeEEykztR9rgjwtGd8PvYTBLoI0bThrtAU=
X-Received: by 2002:a05:620a:29cc:b0:8b2:e1fa:6eab with SMTP id af79cd13be357-8c52fbb918bmr575020685a.62.1768428827000;
        Wed, 14 Jan 2026 14:13:47 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:c1bc:6046:8762:e96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530bb685fsm250007785a.44.2026.01.14.14.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:13:46 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v5 2/3] docs: tracing/fprobe: Document list filters and :entry/:exit
Date: Wed, 14 Jan 2026 17:13:39 -0500
Message-ID: <20260114221341.128038-3-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114221341.128038-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
 <20260114221341.128038-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 Documentation/trace/fprobetrace.rst | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index b4c2ca3d02c1..5efd9c374365 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -25,14 +25,19 @@ Synopsis of fprobe-events
 -------------------------
 ::
 
-  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
-  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
+  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]			: Probe on function entry
+  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS] : Probe on function exit
+  f[:[GRP1/][EVENT1] SYM[,[!]SYM[,...][:entry|:exit] [FETCHARGS] : Probe on
+  list/wildcard
   t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
 
  GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
  GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
  EVENT1         : Event name for fprobe. If omitted, the event name is
-                  "SYM__entry" or "SYM__exit".
+          - For a single literal symbol, the event name is
+            "SYM__entry" or "SYM__exit".
+          - For a *list or any wildcard*, an explicit [GRP1/][EVENT1] is
+            required.
  EVENT2         : Event name for tprobe. If omitted, the event name is
                   the same as "TRACEPOINT", but if the "TRACEPOINT" starts
                   with a digit character, "_TRACEPOINT" is used.
@@ -40,6 +45,13 @@ Synopsis of fprobe-events
                   can be probed simultaneously, or 0 for the default value
                   as defined in Documentation/trace/fprobe.rst
 
+ SYM        : Function name or comma-separated list of symbols.
+          - SYM prefixed with "!" are exclusions.
+          - ":entry" suffix means it probes entry of given symbols
+            (default)
+          - ":exit" suffix means it probes exit of given symbols.
+          - "%return" suffix means it probes exit of SYM (single
+            symbol).
  FETCHARGS      : Arguments. Each probe can have up to 128 args.
   ARG           : Fetch "ARG" function argument using BTF (only for function
                   entry or tracepoint.) (\*1)
-- 
2.43.0

