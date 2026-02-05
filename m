Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB23ED128
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299945; cv=none; b=N1RZZSd9C6ToaVyRzcZ+AEprHpVLenpj+kXXsf2u5pfmJRk6CCy7oR+0dM0rvtkFeTVl+EHQ9dbYkdW9L6SbXiDDlmA9HSzLCToNhIeSbpy8tjQ7q+ivksykaSyojsLw+N9GpVCS97yUJ7/L8yJp3Zz7wlczP8/6tF4/G/WnXBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299945; c=relaxed/simple;
	bh=dfSf90CX2fFuCBXs9FEXQJWwoweCuaJmCw5t3YHWiD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8psXRpAZYCUyItm8y1rCSwXB8jmnp9pQLuUpFADlq6vlBnmFgvSzIJL3Mp897obYQc7siReD9p9hLxYwPx33MsPt4yY+vXDK89SBGxacBe2SxBDbOkn/MXIhG39f/sgpkrP5ypgPQOxj6ylA2OJY+oFr94mpDb8vTB9wb8aGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lskdNJM1; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lskdNJM1"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c6a822068eso117396385a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770299944; x=1770904744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r25epDAJMQ/dj4/lD+Zndgkln/iNdOm3o/jXssTljSE=;
        b=lskdNJM1jt+SEUCstya50W8LVNRwAtMVYdQs7sHvrjiDN1OQXrp6FvMsTu42pEh5rL
         HEy8sl+69X39EDcfGL8HsKFl0ldYRqdPUvomviRo2FEv4d0Le3KKP2Eda1xXs44fsnqA
         Wpz4xGu3wCEuY+v9zvODzJ7wO8mBwuVnoYslN13S8xoA/g/tT75Gy4n2cb8dNccFm0Q5
         BPfk6CibcnI9Css3xJYm5h6Nrg+EzpmTB5HF5CCFfFiH/X25UZ2hoC6Oh3FGXOS4IfPr
         GOAnDbVkQ/AeWhyHMiKMTZ5jjoj2e6DVmjHPBP0MyDOBfeQXnmip4NlpWH5qh3ahzjxN
         ZF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299944; x=1770904744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r25epDAJMQ/dj4/lD+Zndgkln/iNdOm3o/jXssTljSE=;
        b=J9xNFFxsi9vx3NuHocHLYzGa1ktmOttxhDTqT3A+ybc/f3OnZnnG7p6QEsHKOR30OZ
         sJbDZgYKyHtUtVLYAFL40+woJCxHiGkqG2sXoTQXLxH+jPlws5OpK6gUnQKItE/UH2y5
         Ztt5M/aN5LVya07J3k1FqDeR5fR0LZhNmKP6OyBFhd86yTbu5fSQAOUPsGvBRrFLg8iD
         KU2BAC2RAETPlZ9CPqC0mwQr5JYrPXPwk42jUFvx/tu+07oJciDfx9K6f2p20tLb3QBL
         F5M0Fdkeegc18155y8Lbu0DZiXx4oiCWTN2SZRmq/ZwzYfWlfoLi2CzcdkpDqHN93wHv
         9DZA==
X-Forwarded-Encrypted: i=1; AJvYcCV7LJ8z7vMJ4U2WR2rII9Po0lcUfsGO+iC2TByzKM7CcUSameLhNjJ/q8AZtBISFxzR1UJS3Ula8LCwwUnvyzvWoTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeh+r3UhQH05dU8RMFpoUkQFGyTd4g65HCxdd+XAkldFo+0Sd3
	IAo2z2K2WGi6WBPTl/KQKewcGd/vEzb3A4NibaHK33llqB5kJ7zNwQQV
X-Gm-Gg: AZuq6aJAwSiwJXjUIe8OimR4P2ufzBKnePcGxydCYWJ1QDD5HcEGjviLVW4Skbmv/4/
	N3f9jLSzdKzt/U2c115RYhip6mWxdRzLKS3p/EhEf9wHPXflIdVEGCP2fn6VV+KgEUo/xKc4eO+
	Ac7DZnfDRKHayGtMww4FZdyoFC8sMOD7ZzTV+Z9L3XW89Jmv0vQ8uWUNCuXom0rMYz71n70k6b/
	Mc+xJTU280SxsAZNns3T9KGQ3yOeH8iCES4TYwrrNSuKGnRHiLAjFyLr8XO1bg1CGnl9wEHCoOw
	Q52Rls1B7Ca/5bSd7rkT0+9aE07ILKirZBE1Qh7y/LvFZqpzef6myvoHVGZp5T80y9Ws6ekNHRY
	zEO5zPpSmM7dliai2oTyQxvlXyu1pdv71ZpWnA350P8D2wRPNNqUCrlECg/c9+xldawORHW2n/d
	2hiFGxqQ7PmQlr0qj955JU4Iqt6jAbzNidbf8eprD3Yrv05RPLsso5qCcekONPcF/kt4E6PVQ=
X-Received: by 2002:a05:620a:4009:b0:8c7:1986:6b3e with SMTP id af79cd13be357-8ca2f83bdd4mr765898885a.32.1770299944301;
        Thu, 05 Feb 2026 05:59:04 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:87a6:ecbb:44f:b3c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd40f9asm404975985a.41.2026.02.05.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:59:03 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	corbet@lwn.net,
	shuah@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v6 3/4] docs: tracing/fprobe: Document list filters and :entry/:exit
Date: Thu,  5 Feb 2026 08:58:41 -0500
Message-ID: <20260205135842.20517-4-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
References: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update fprobe event documentation to describe comma-separated symbol lists,
exclusions, and explicit suffixes.

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 Documentation/trace/fprobetrace.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index b4c2ca3d02c1..bbcfd57f0005 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -25,14 +25,18 @@ Synopsis of fprobe-events
 -------------------------
 ::
 
-  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
-  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
+  f[:[GRP1/][EVENT1]] SYM[%return] [FETCHARGS]		    : Single function
+  f[:[GRP1/][EVENT1]] SYM[,[!]SYM[,...]][:entry|:exit] [FETCHARGS] :Multiple
+  function
   t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
 
  GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
  GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
  EVENT1         : Event name for fprobe. If omitted, the event name is
-                  "SYM__entry" or "SYM__exit".
+		  - For a single literal symbol, the event name is
+		    "SYM__entry" or "SYM__exit".
+		  - For a *list or any wildcard*, an explicit [GRP1/][EVENT1] is
+		    required; otherwise the parser rejects it.
  EVENT2         : Event name for tprobe. If omitted, the event name is
                   the same as "TRACEPOINT", but if the "TRACEPOINT" starts
                   with a digit character, "_TRACEPOINT" is used.
@@ -40,6 +44,13 @@ Synopsis of fprobe-events
                   can be probed simultaneously, or 0 for the default value
                   as defined in Documentation/trace/fprobe.rst
 
+ SYM		: Function name or comma-separated list of symbols.
+		  - SYM prefixed with "!" are exclusions.
+		  - ":entry" suffix means it probes entry of given symbols
+		    (default)
+		  - ":exit" suffix means it probes exit of given symbols.
+		  - "%return" suffix means it probes exit of SYM (single
+		    symbol).
  FETCHARGS      : Arguments. Each probe can have up to 128 args.
   ARG           : Fetch "ARG" function argument using BTF (only for function
                   entry or tracepoint.) (\*1)
-- 
2.43.0

