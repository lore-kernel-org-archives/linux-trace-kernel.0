Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB239A7E1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789612727; cv=none; b=H3Z4/Zf7u8e1G3w4swI1S9KO/jUxND/MJRG4PkKh67BRH4x8Xx9KHqHSO+5xnuinoe0BLpZ8d+gDYPG6RwAVIPc5kvWwIl7+Y3Xk65O05rzHsGB3HvT2bxJ0hCDIr9skr6tYp4cAt8m2GqhymAm09Tc4AuhytIcjvWWvhW57DE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789612727; c=relaxed/simple;
	bh=SPJ8vYFXxs81oCoPiGRKiXQOHnvvwao8NAhit+FTgnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=noaQ54hF4tqFSPn+8IoIM+R195Eq7L/OQNQg0ohx+E0Q52hL2Oww1fpzfF2HqRhE7FCvm6OhPnGdyfSJ0TbBeys8siFSYr93srWvgAY/s6YmWvgsPzGAfYUmzLRtzxJNM3A0v7RPdzROrawQCdKgayHsb/RmQotmjWu9l7zerpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PViV9wQS; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PViV9wQS"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b2e1d7so254798b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789612722; x=1790217522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qtIXBwZucUITj0nDXUGS9AW/hdtRHC7e/xSPUpvvawk=;
        b=PViV9wQSnJxfYg58moSrxWpl2dHav7NebmaDRJHobwlE6VTtH2FdihEemOq3RI+9se
         XJrfenYd6/busoOM58bmojeDY1dgz3nZHooIpZmIqybwuZ4K56st2VZTHP+82HjdU7be
         gnjnpyHEQmsdx8cnuetn6UnefI7uEO0q99FDBEARsnmWphbE3D5fUK430+mlM/B1OvNn
         cyP2oBRI/B/sHCywF5vdUOnbOOKB+utJeMfawWz30HTPL/JZECdhTpxnW8jSaEQB8Z/a
         loYV/1xccQweA+UrTXdk2dzwfpbgnS4eFvIdXEVi9yX2KMtZ8n6rY07DZnPmlPISObEW
         Eo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789612722; x=1790217522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qtIXBwZucUITj0nDXUGS9AW/hdtRHC7e/xSPUpvvawk=;
        b=exxd88XLygMHyCzoKbqVbelLq6BQgpfKw9SLfqBqPOWeiRJ3OaRSV/iA5RlLx5A9V3
         153FjKXYgXxux2X4y/zynxdB4jcMLcKQyHPLkqFg4LcS8my1dsTyujk13hktoLNu6Ax3
         yNZUbZWUPOzuZXqHGKiofP/Cjy5GSa06+Y8N8LisO0FV8t814+HMvIM5GHpRuFxIlv9u
         nzUPKjlFhGe5oCoYfrnWM9dc4X95RBZWu4G/L/aaVQuL/9BQCJNNd7PFyKtc0yEm1OBR
         PC9P14MGpCSQjTDReBJvLPxJTMSo4EvYjFJu3TKAYh4HJVaHzMS4kefTwlhkY8po1240
         etEg==
X-Forwarded-Encrypted: i=1; AKwUvBwdcPDeDntUYjVJXcy/++QpliONJG2exu+5TfgttcGoc4zaypfKmp3QFtfNbGVkTTugxNpOEXuBVUX3NpeDB66qgkc=@vger.kernel.org
X-Gm-Message-State: AFuF++njHJENjqwVuxht72rmQDkuSlYX0iIMfvZJGT9xVresKnnA2VM7
	HkyDESRrVAfpAZh4WO9Z4I4OWpcV0lNchSpklpH0yCfrbcdEKy/RG1zTi/v3pQ0/vA==
X-Gm-Gg: AYBFou1b7Wco33tuSE2D2DsGNHh56TDIeSCysbYzOyo6f5XEZS7PWcNtpyYTmNcWM28
	jaFhKq6rjFv+ZIdh59yovzy7mu5jlbcIAFpUIDvHFpDOL13NWwcJZyFqu4Zlu2zQoO2UYwYvmBf
	4LctCnSqSX9BEuqIXLllWcB3gXmgjl+8Ix+9GK9NepR/ZhU2CPik51Yr2sPKHcuoI+hHaduzVhv
	cpMeqZkoAyzZ2+EZMznRkux0FqMERTdp9+bLGYDntIhnCafjbvCJNO+264NfvpTZN3dy+/O9/qS
	HMpGnxX6Y4iIYfzG6KgNpUTVVSMNyt5IdC/gHRFW/0VShI3RzX2+AzTUYUMu9n8f0TjDBCtNgkg
	iUPuJujULtgg/3cofDC3XFZ5TQjM3uMFA+N4Hge8JbaxUt9e3tj8Q0V7bpcXYMvV6fmkfKEIqzf
	5lculOIkml+K7aJZTzhg+hxvX1hLsuL/p2bH0x0rhekUDjoTnU4Ci7vMs0s63XoLvvxH5m1pIYS
	nKSts/dZs9/7APg9INr1zFBsVA=
X-Received: by 2002:a05:6a00:b43:b0:857:72ba:ff0b with SMTP id d2e1a72fcca58-8723919dfeemr10247005b3a.19.1789612721914;
        Wed, 16 Sep 2026 19:38:41 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b6f9:c198:e14b:34c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201d1b275sm2007843b3a.51.2026.09.16.19.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 19:38:41 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	namhyung@kernel.org,
	zanussi@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH v2] tracing: Compute the log2 histogram bucket in 64 bits
Date: Thu, 17 Sep 2026 11:38:34 +0900
Message-ID: <20260917023834.216893-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .log2 key modifier files a value under its base-2 order:

  # echo 'hist:keys=bytes_req.log2' > events/kmem/kmalloc/trigger

hist_field_log2() is handed a u64 and computes that order as
ilog2(roundup_pow_of_two(val)). Both helpers take an unsigned long, so
the bucket is wrong wherever the value does not survive the conversion.

The out-of-line roundup_pow_of_two() is

	return 1UL << fls_long(n - 1);

which shifts by BITS_PER_LONG when n is 0, where n - 1 wraps to
ULONG_MAX, and when n is above 2^(BITS_PER_LONG-1). Both are ordinary
keys, because the field fetch hands every value over as a u64. On
x86_64, keying on a u64 field and passing 2^63+1 and U64_MAX puts both
in bucket 0, and with CONFIG_UBSAN_SHIFT=y the shift is reported:

  UBSAN: shift-out-of-bounds in include/linux/log2.h:57:13
  shift exponent 64 is too large for 64-bit type 'long unsigned int'

On a 32-bit kernel the conversion drops the upper half of the value
before any of that runs. Keying on common_timestamp.log2 six seconds
into boot, where the timestamp needs 33 bits, one build of each gives

  x86_64  { common_timestamp: ~ 2^33 }
  i386    { common_timestamp: ~ 2^0  }

hist_field_timestamp() returns the u64 unchanged, so hist_field_log2()
is the only narrowing in that path.

Compute the order from the u64. ilog2() selects __ilog2_u64() for an
eight-byte argument, so ilog2(val - 1) + 1 for val above 1, and 0 below
it, is order_base_2() evaluated without narrowing. It returns what the
old expression returned on every input the old one was defined for.
Where it was not, 0 stays in bucket 0, and the values an unsigned long
could not hold move to the bucket their magnitude asks for.

Cc: stable@vger.kernel.org
Fixes: 4b94f5b7b4a5 ("tracing: Add hist trigger 'log2' modifier")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260914054614.82A9B1F000FF@smtp.kernel.org/
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Changes since v1
(https://lore.kernel.org/all/20260916002735.808520-1-donggeunyoo.kernel@gmail.com/):
- v1 used order_base_2(), which also takes an unsigned long and so fixed
  only the 64-bit half.  Compute from the u64 instead.
- Added Reported-by/Closes: the 32-bit half is claim (a) of that report,
  which v1 did not fix.

QEMU, v7.3-rc3-82-g238650ef6c7c, CONFIG_UBSAN_SHIFT=y, one kernel per arm
per arch.  A user_events record carries a u64 field; each value is keyed
with .log2 under its own id, so no two share a row.

  value               x86_64 before  i386 before  after, both
  0 1 2 3 4 5 2^31    correct        correct      unchanged
  0x100000000         2^32           2^0          2^32
  0x100000001         2^33           2^0          2^33
  0x123456789abc      2^45           2^31         2^45
  0x8000000000000001  2^0            2^0          2^64
  0xffffffffffffffff  2^0            2^0          2^64
  0xffffffffffffff9c  2^0            2^0          2^64

One UBSAN shift report per arch before, none after.

The i386 column needs "tracing: Fix 64-bit and signed histogram fields on
32-bit kernels" applied; without it the field fetch truncates first and
nothing in that column is attributable to this function.  The
common_timestamp figures above the --- do not need it.

The build-tree prefix was trimmed from the UBSAN path above.

 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..86f5767dbb81 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -289,7 +289,7 @@ static u64 hist_field_log2(struct hist_field *hist_field,
 
 	u64 val = hist_fn_call(operand, elt, buffer, rbe, event);
 
-	return (u64) ilog2(roundup_pow_of_two(val));
+	return val > 1 ? ilog2(val - 1) + 1 : 0;
 }
 
 static u64 hist_field_bucket(struct hist_field *hist_field,
-- 
2.53.0

