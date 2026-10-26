Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039181;
	b=Hir1XLOX/8dPA2IAQF8GziKIjtsAHy2zMMhxuaj7tDdFkO0VRyT7Ggezrmcppyd8xgAr
	 hOYkJsXgF6s76sX7VpzA/PTARno2s2HYeA5gBbO93pkZqBzytkaakicNDbkuwkd/HafMg
	 fBJ4DAtJlcF+RGyOqKwCHiuhQpTrp4TWMwbgQGqk8X50ZSK/65oTxNYtO5VjDKABzKFLp
	 ZWj9OYYAgz3oo0Iq9yHWPGym9NFO9/E2yr9ylYJbY8xHLpljqGW5tx9+p9DnvreORZFDs
	 VeH1O31W863MBD+sQkJxCHrJGvFU0B1rBJYweuMz1jeSdGwcOMN19Rx8I0eFaHL2NeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0FLF73cEf8/8Xru0kju449oktMHuGEexwCe5j4yh0Bs=;
	b=IOYKY5U7Z6zjXVACvbf8KiepoX49Il3S1Sq8Fpb9EZ6x7HTxURHc+PoVt9ZjRrvOE9I5
	 jV0zpztra2zOqb+OnGw3D/XkfKIwEMTGQkctZsBpH86CJ5yQuoZqlWeZzMkXTn2nnhWkJ
	 ZVfgwTwoskaxpcCQHZD6KZJn73ezPiRTDM4Wvt6JEj3mHRFK0rhVnlFLA88AIVX6cMBhw
	 AevV/4ymfx56jnfPdZbNVsgb+h47MUKvn+t1Uiw+imA9g4tVSs+PiBvyECMKJ6fYbX0jf
	 o0dwccztcpxWltXzoGRSPmnl0XwhRHK1Ffam8s8qjyn+gcjKh6lTDWpiKF66tRpHqDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eBIe5Wv8;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD53606A31D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 18:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD53606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eBIe5Wv8
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so153721f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793039179; x=1793643979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0FLF73cEf8/8Xru0kju449oktMHuGEexwCe5j4yh0Bs=;
        b=eBIe5Wv8Hfc++gVv2BMFtDPfGc/EDixc28n1u1h1AnUh8ozSwUpIKJo4HufwkvGJuq
         8Typ5y5yGHCHUxl1vACgzJiLUP9A1OU20qxFsyeNHd5L+Mq4rg4xhdlIHtPEoq8mt2oQ
         8DoGkyQKiCiEyhoWbmtkuVIRd6kQYTppY5rVtHjPwmpCwLoAny17IQ9lupq4Cyp4UW8Y
         /6Lx3v2/B5nRePc0hL5f+pb0K5QsvuZCisHZJsKpw7rEM2ps+euxDjeTNv5zXFhdjzPI
         uuTClIDnNFe1dWQyCTsBQj2vze1O6xy/I3BCdzuzrE7aOuYkJBkATCLv301Ts/n/FRr0
         b5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039179; x=1793643979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0FLF73cEf8/8Xru0kju449oktMHuGEexwCe5j4yh0Bs=;
        b=Al/NQcnSSdDmh0hu/bH9flwJ30w324U6Bt5YtmhPDpgTZq7gC++RCNb20ZyIgN4GAd
         WB225JIypOnEjpQX4VCNM91PRcTa88ilp7gFILmXaTCpW/8wecFEFnmO3vnrIbe6vMxC
         u4M7TtRxDiV0oHFfjKGpYTwqKqCNDi68uj2zybIxahlQuLFz8gwUV1xEu2/2AK1Ikurf
         5B0SGdigtcYbTTuRZo2mkd/MTu3L3djSQRC7wEqcS7siRYSM3uKGgqMqRGLMQl+7YLjT
         T+t98+VreCKlfYlWoAf00ICOMr73wBBLIlZv2junjJ/oTdp4OZc3bt3fHsKJ+46/jhBW
         BkEg==
X-Forwarded-Encrypted: i=1; AKwUvBwm1FORnyybwJPZ31nl4E7gBczWyIqf6m7bWOqKKEWOMSf8jIxw3DsT0VW/j6qswCYwbCmHPzMW78VMznlz687QoPw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEqLiK83R2VNLY3pONKU3mzDNUwhyrabUcF6gaDii4SWlzxjXm
	z8MQhJ/uugvNIBjpcrsE+SWk9QI2yzSyzNdzZeM1oBdMXPb/s82SdRTK
X-Gm-Gg: AYBFou17iUuQbfsJqvppOskSFrIUJPXsGRRlk2jg0L0ifY8E+h6VAeg5x0t8yndZvw3
	gbEEb3haEtnd54xK/jq2uLPzpQtyA9IA+E0mgJCmPdbcttWtNlHVEAq5I3H0vDzyp2n/ZBBVBIN
	KcMXW2odQ3t65Y6Sn9skSgD2CuAxafNbT0aM/yOoRhv3096cupFNZ9II4xU6P672WKFi63tcTE1
	AEalTXCZrsGYRfQ9lAjGaBnN4NTksw3H/dRH8ThYxIthpX1G4qNTet2DNpyeZCS9U0Zf9acXUqq
	5BBb/U18chIq3ZsXFasMAISN586k3VSo5mYaUXI5EMYBsVnjRVOHKkifFI+T8VOcWEGh9kAKON0
	bhjBrWRfjxllsaQWC4HDYcObIAZ2vzldz4mUHe6CCB052EaokipNl0dAARlQsOUtulb8wXXR+Jl
	6UH5f7N0Hq/1Mhbnq0kHLwGxYZDinnTqKzrY4TJX4WuELb9BT/a3IzKR0V/v+G/nkV0jyaf8d41
	8OGDs4du4u+LnYZoHdyKSB6wJU9f4lzY33EJiS8zgZ/6Fci7DoCz5zIwS8asOBFsv7ufs8/E8EB
	cctMsZfirEQcgLVjtXHh4Z6qaAQ=
X-Received: by 2002:a05:6000:e4f:b0:48e:39b0:ed84 with SMTP id ffacd0b85a97d-48e55a45541mr800284f8f.19.1793039179518;
        Mon, 26 Oct 2026 11:26:19 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e4806e208sm12830907f8f.40.2026.10.26.11.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:26:18 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v1] ftrace: Fix lost recursion records in ftrace_record_recursion()
Date: Mon, 26 Oct 2026 19:25:52 +0100
Message-ID: <20261026182553.221141-1-parri.andrea@gmail.com>
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

cached_function is set to the current ip before the cmpxchg() that
claims a slot in recursed_functions[]. When that cmpxchg() loses a
race for the same slot, the code bumps index and retries via "goto
again", but the retry immediately matches its own cached_function
write and returns without ever reaching the bumped-index cmpxchg().

Concretely, for two writers racing on the same index:

  CPU 0 (ip = A)                    CPU 1 (ip = B)
  --------------                    --------------
                                     cmpxchg(&recursed_functions[index].ip,
                                             0, B);      // succeeds
  cached_function = A;
  cmpxchg(&recursed_functions[index].ip,
          0, A);
    // fails, old == B
  index++;
  goto again;
  if (A == cached_function)         // true: matches A's own store
          return;                   // A is dropped, not retried

Once dropped this way, cached_function stays set to A, so every later
recursion of A also hits the fast path and returns before reaching the
retry, until some unrelated ip overwrites the cache.

Set cached_function only after the cmpxchg() has claimed the slot. The
retry path then leaves the cache untouched and no longer matches its
own store. When the cmpxchg() finds ip already present, the writer
that installed it sets the cache.

The bug was found with the help of an LLM.

Fixes: 773c16705058e ("ftrace: Add recording of functions that caused recursion")
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
Changes since RFC:
- Drop the cached_function update in the old == ip branch, as suggested
  by Steve, and adjust the changelog and the cached_function comment.
- Drop the stale "(use i for the next index)" remark.
- Drop the Assisted-by tag, which Documentation/process no longer
  documents since commit 1e035297ffdad ("docs: remove Assisted-by
  references"), and note in the changelog that an LLM found the bug.
- Rebase onto 6b4b543fa1875.

RFC: https://lore.kernel.org/r/20260917090217.6738-1-parri.andrea@gmail.com

Tested on x86_64 in a virtme-ng guest (4 CPUs) with a reproducer that
releases two kthreads to record distinct ips concurrently and checks that
both show up in recursed_functions: the base commit fails within a few
iterations, this patch passes 500 of 500.

The smp_mb__after_atomic() usage discussed on the RFC is left for a
separate patch.

 kernel/trace/trace_recursion_record.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_recursion_record.c b/kernel/trace/trace_recursion_record.c
index bac4bc844ccd8..4f63bec052fca 100644
--- a/kernel/trace/trace_recursion_record.c
+++ b/kernel/trace/trace_recursion_record.c
@@ -17,8 +17,8 @@ static struct recursed_functions recursed_functions[CONFIG_FTRACE_RECORD_RECURSI
 static atomic_t nr_records;
 
 /*
- * Cache the last found function. Yes, updates to this is racey, but
- * so is memory cache ;-)
+ * Cache the last function found in or added to recursed_functions[].
+ * Updates to this are racy, but this is only a best-effort cache.
  */
 static unsigned long cached_function;
 
@@ -67,24 +67,25 @@ void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip)
 		}
 	}
 
-	cached_function = ip;
-
 	/*
 	 * We only want to add a function if it hasn't been added before.
-	 * Add to the current location before incrementing the count.
-	 * If it fails to add, then increment the index (save in i)
-	 * and try again.
+	 * Claim the current slot before incrementing the count. If the slot
+	 * is occupied by another function, advance to the next slot and retry.
+	 *
+	 * Do not update cached_function until ip is known to be present;
+	 * otherwise the retry would match its own cache update.
 	 */
 	old = cmpxchg(&recursed_functions[index].ip, 0, ip);
 	if (old != 0) {
 		/* Did something else already added this for us? */
 		if (old == ip)
 			return;
-		/* Try the next location (use i for the next index) */
+		/* Try the next location */
 		index++;
 		goto again;
 	}
 
+	cached_function = ip;
 	recursed_functions[index].parent_ip = parent_ip;
 
 	/*

base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
-- 
2.53.0

