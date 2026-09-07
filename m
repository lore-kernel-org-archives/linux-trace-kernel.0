Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D94EA396
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796263; cv=none; b=mr5clSKnaYBjiUwOLfKWWicqfBe1PzUFtbtoH4oVyIWOD/Z15tH5omX0Q98pEKGK9ymFED50Upc7Meiq8PIW6hqGNFtCcXphW3BpO05fm0fjMD9pTb/o2s50DF+bYXaEq++7Ie/FwY5EdSAagK0fBwSBBUUiP8Q7/3nK2nSD3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796263; c=relaxed/simple;
	bh=DhiBgG7xnL08u0x0FTkYm6cczKwYmCOp1xitilaqnUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is3ZSeCc7sgqjViy5NuknjVssycelv5w3yLJQevKEY8nhStcSf9E7pnWavVpltQQ41nmiFQn42mPyVqNgRI2VBxQUJYQxmJaZ14QiKpSgscw4TW/7tgvKOkR6zh1TiNpMUd3+mJ/12lkiGfEeLS82x1aiC1VRTca+ybtJdd7GY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLl16i1H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLl16i1H"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cace91f112so29857425ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788796258; x=1789401058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEKj5eE4ZkqVaXrVpceSXQRZCzNc8P/mNmuBsDFjR7I=;
        b=LLl16i1H7jds4lCauJc5qlUPdeYVj/+PycqL1V7Rwdnvn5owCzXfjyPGniQh+vazkR
         +3GTsKQJjNKPbfNBSrzLjlhOeSOaJVd17g7+ekmP5LMMQGNpHy0dKyBSQ0+bYCDzF6fJ
         MEQwrYAACFGs6QYHfeVS/qFYSOs5SnFC2fTSbHOcmT+1Hao8/VWdNwIPLovLrhtSvEln
         NTclDu0wf27AQ+5Hs95/BPPZZzAWbHLn1B6frDGEhsbT0g1mLo0ZV9TlVsXPSdQV0c56
         i0n9U40O+y9yJNUCUol3kZBp0g5wl4rwk+ypT85pHRxnYapuDumLcqeCVaqlYIXk1D/v
         tSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796258; x=1789401058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CEKj5eE4ZkqVaXrVpceSXQRZCzNc8P/mNmuBsDFjR7I=;
        b=BYNF3pL1JMbmt8YiqLnb8Zzo6UWHLAtichqq/bVVateKyHwDKGPBWVa8hJz9eN0/Ds
         BJPd91FqD9bUc9Wp8jYUMv6z0COpnmg1gbuUn5a6oiCp6ShL1+lS2cGu4J219tomextV
         MM642UeplrWinPv1oSXxlx/xcXaMWznRb2EYjd7Sa2WvCNUpPa3ddu0NvUdXC2rlxB4L
         2R7vNq/kDtBR0pACwPkvPPT630RfE3xkaD7tpuj9CM/rj4M6pFt9o+BP96UX83rk+2Q2
         XVUbJgRdzdifWqT+iUG6LpngrgaU7gj4HvvJtx9CZzLRliNDuWucmZGNoC9lR9BrOm8h
         DRXQ==
X-Gm-Message-State: AFuF++mmdMUsDnB9hCe6N14R20W9Darj2mlbujD5gxV4a3NYICZS4rTq
	//sslKLcXe5fd/OiwVGaz0/q1vkyTr8NhZ9/Zjz8+YmlNev1XlxjvAw=
X-Gm-Gg: AYBFou1sD9eJGj0KYnc7IHq6WeA+S86WJyHq3rBKm6VEaUs5bAAFipa3iyQ5JgS1m+/
	1I67AR+rjTet+yy+bC/kv8Cng9gfNMk3Q5QqfPs2v8stcCHA3enXxU8x2kgCwNU0qqaPom+bZh5
	1uy9YYtiQUL7YHyGDYdRohNmBMftwR5aqfNTzH2HsiDud8owZE8i9A+O4amqK0QxxjV4KGtegWZ
	DEiZufJyIw51gy4ozkdi0ApVQkN3UK3lr2/jNYOrnk3bohktBZ2cNYZdZk36D8QsXMEXC5zLE2a
	59CayYe20Ow5gAbt1SBDdMHkNYmEScmpZUTQWXg74lVviXCzRkDgevVPR30z7wGMSyPINPlEaxT
	z4Af1x/6IxONoqfOauHTHX0TNUwknBsT/HUG2dkT1S9IV+jkOddlt91txzCeMHjaJ1qiZh2EvJJ
	jvKBq1lrdl94JwuxPiosEwIqXu+hKV63sfgjLD00mQ4+/9FnArOFiWq/KJ975Py3KjSeMWZBN76
	iF+4zqn91J8xRW3
X-Received: by 2002:a17:903:3c24:b0:2db:479a:5127 with SMTP id d9443c01a7336-2db479a55c8mr128165285ad.19.1788796258200;
        Mon, 07 Sep 2026 08:50:58 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c3b80sm47265405ad.63.2026.09.07.08.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:50:57 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] tracing: Fix memory corruption from a "STACKTRACE" histogram key
Date: Tue,  8 Sep 2026 00:50:45 +0900
Message-ID: <20260907155045.692664-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907155045.692664-1-donggeunyoo.kernel@gmail.com>
References: <20260907155045.692664-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"cpu", "CPU", "stacktrace" and "STACKTRACE" are generic fields, defined
with an offset and a size of zero so that the filter code can match them
by name. parse_field() maps them onto their common_* equivalents for
backward compatibility, but unlike the common_* names it hands the
placeholder back to the caller instead of NULL.

create_hist_field() takes a non-NULL field as a promise that the record
carries a stacktrace and picks HIST_FIELD_FN_STACK, so the __data_loc
word is read from offset 0, that is from common_type, and its low 16
bits are followed as an offset into the record. What is found there
becomes the length of an unbounded memcpy. Pick an event whose id is
small enough that the offset stays inside its own record and the length
is a kernel text address:

  # cd /sys/kernel/tracing
  # echo 'hist:keys=STACKTRACE' > events/ftrace/print/trigger
  # echo hello > trace_marker

  Oops: general protection fault, probably for non-canonical address
  RIP: 0010:rb_next+0x23/0x60
   </IRQ>
  RIP: 0010:memcpy+0xc/0x30
   event_hist_trigger+0x2e7/0x12c0
  Kernel panic - not syncing: Fatal exception in interrupt

Leave the field NULL, which is what the comment above the branch says
the code does and what common_stacktrace already does. FILTER_CPU and
FILTER_COMM are left alone, their create_hist_field() branches never
look at the field.

Fixes: 4b512860bdbd ("tracing: Rename stacktrace field to common_stacktrace")
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
'hist:keys=STACKTRACE' now reads back as 'hist:keys=common_stacktrace'
rather than 'hist:keys=STACKTRACE.stacktrace', since hist_field->field
is what the print side keys off.

 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 620a74fc62e4..eabe95419b97 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2417,6 +2417,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 				*flags |= HIST_FIELD_FL_CPU;
 			} else if (field && field->filter_type == FILTER_STACKTRACE) {
 				*flags |= HIST_FIELD_FL_STACKTRACE;
+				field = NULL;
 			} else if (field && field->filter_type == FILTER_COMM) {
 				*flags |= HIST_FIELD_FL_COMM | HIST_FIELD_FL_STRING;
 			} else {
-- 
2.53.0

