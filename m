Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356685;
	b=ypSFzTolTuTU+1kUnO5qozvkwve1CXyNaL+6xbjA/lqzCcNYmGKQcPYj7u8LT5gr8ljy
	 cRrCMc7SVFdPJoB/jlqn6OBtdieloySGVtW2O66Ijb8UmmHPh0Clc8C7UjsP1TrheO0ID
	 +krpYJAy1yQV0oGhhFL2U35DhqvcKxIN8x6d6ppAhG1qT6U0V4ivKZQrZCKE2JMyCPcZl
	 iFX4Snn1zo2O0Gd4k6WYcfMvxWjHqbj3qMwl2DefHmp/z5oNfD18uBqpctbAau5cMG03m
	 VYXUzZGjXGL6qEw7/r5d3Vt8DF4XaYo+uxRUOtMC/4UiZEwtMRWY0oYaH0oI7UL3bZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BIj6cyIw7o0lExSO+WDhODX0VMmE4esj3iFVgOr+pe0=;
	b=bTAiqYuz3P4Xn7BBccOHLY20H4aS5p3TD5UNAok/TSndHW0IDulYVtOfOwQNMvLfA+jb
	 IZNPSWgz313CCKzvwfTYGN+DOkcGSA7KIuL7hYXbqMqNEeE6GqfN9JJ4r2HtJtf+CzWUR
	 9Pu2KdKF2IEnM7XCbzdPHoLe+Fh1fPm1Bz+4G1dPBp7g8zc8rZ6S32fom5tEDKaqquF20
	 DI5/3C74hPj1yEfE0T3T3bx4a6GIa9B+T/dUUqokWMgWKdXq55bR9MQzp0JzasQJftCL/
	 VlfgRTd4swbqsT1P03clKPloV043E9MnzEuVp+jzg6DRU1L1CdX4GdnE0UktZvf1MRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0jwGHOWZ;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFD606A331
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 14:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FBFD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0jwGHOWZ
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so22860665e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 06:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795356683; x=1795961483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BIj6cyIw7o0lExSO+WDhODX0VMmE4esj3iFVgOr+pe0=;
        b=0jwGHOWZzEH0X56ysrOq2ZRHO+PYe11rMwhSGBf1pIASjoH+nSlcg8ZP444CZ9NwOn
         GyStv+ZRWbk1CJPl2sT85laMv45SqTG5H11tF3DQSDWLM+EYHhJL4NwhXuTQPe+H7pkP
         k3K4FibB9lpXKKLaO5B/5UufmGOLaO9ZbcegBYvmdTNJnyyRMVChxj5ECuma34nvAq9S
         3k7uNIMqmedlHHVFhHElk5Q00hlJN4YORg9XSaq/xb8UGRNlFr2/XAx/ULtxkS3QplkQ
         kFOj8cGIwmWg2ImknTZOqILS3GuX69YR+diaX365X6j35JUBAhEAzR6Z0947BIkY/QrM
         fXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795356683; x=1795961483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BIj6cyIw7o0lExSO+WDhODX0VMmE4esj3iFVgOr+pe0=;
        b=zbx6H9Hp7CtMXf5Oy342YfxL37IXQoXaJdq+2IU8HBfdpvH3nFvW2IfNL5qJKh7M2M
         GYlqmOZcqLw55HGs0RIwgs1xUdOn6PTNy3pbkMZ0pnvbfNhDrEwjfzafASPch9cf106R
         7b1lQPk5Ku7KCYUJsx+pU0uuJ0pAFGJK38dWcDcAb+N60AnuTjkTtZXG30a/n0hSj6/N
         aS7L6pmW0Nfk7GE1slZMdbN/HMiJhbA7RlHqPAM2pDg1Vi2aPhPg9iMJFJ8BONK16Dfn
         2fWdnL497Q1mM2tGJb1MGkuBV/eiY0ABCT2CA5vzIRnfqC5PWllwW5T1XIJ3GBvRJvRD
         tpTA==
X-Forwarded-Encrypted: i=1; AL+hErEmyqIaEbOOb8ajjRxW3JNI3uwrhm8AMx9cVzZS5kqIfDkU+Svd99TZGphn7jHAn9zCkxZckWZVLuyMxAIzeScNiuw=@vger.kernel.org
X-Gm-Message-State: APuU4Z877+sCLSWErXKbsXVpFskz3NOt95t7iaL0TYO3HIdR631wBK83
	FAbiR1EvRg0SVHcP2/+HJ/P+CxymHwVazB3ZHoUUhXoaV7bcM7Kcu9Z6sPT+5g==
X-Gm-Gg: AZFdTZfg7MCToY9ypJBBsN04OqdSVZPT/nL+v388RgUDBogYiHaDad/e8OdBm7legoV
	RSwbKFVJd55Awv5P54SP71nWdSJLzapN+vMQ+jMXH8wLE8RMw2UquoFgfwXVi1dVEpVSqMU59QJ
	GqeQ4oCN6I/jKgMGDvlo9P0lbfkmz8jJ9ND8CwdHxMZn/9yArZRv3Uo1o8Qxyhgc+0cd0tWYiBy
	PWuOSkE9/b3oWYXItzIDWoC0S2+TvYDn1j61m7vfPleMQsM0hQdiXk0pDpDa9r855sTlWsTEwXT
	GATzdUPTtrXEI137h8cwskvP6UHYZMicVYQ3PacehOlYhwl7/tweqC9LkQyOB/pgD2jFFIPMxMk
	wETQT5wF/NR9tSOCggdmoWOuI/q34/kjTHOSkT6de3SHF/ATv24yeMmWQMGkxGYrFN1jv7IRcJB
	NuSLZX3uO/wUYdq69QMEZ2ZVrr8NZb5hm2aKRPWCqu0o3X9EsUmuCLjC34yFI2XRfL0nG2BfdBh
	F8kRpqWmqmCpl7nywfNQEpSGb9M96TleePvOyTEYhl7zouT8czp7K/Dom5IZxnq+E0kPxQoX5Y2
	zR4bzY5g7xNGH5AKboR+apYT52d1LXgcYBXwABXdbZxNpekfE5bAE7dWs6AwjjayXZp7U6jPBKm
	nGxs6giDNPq4S/BM0p8RYMq2QLssKWvifii98wmWxdamtSszcdmDx6EbCLJupexyqrRDBUQsTdI
	5B/7GdXQdVHrn0e2AxDl5tLx+VtYKo5N/Q/FZ6um9ZerGVfIKUywjiuYlpH/auLT9J/3NJ8xV7t
	cEAHlIZwJbYj2Js7uQwmc5u5DnA4eekePBwVcI=
X-Received: by 2002:a05:600d:4:b0:4bb:8898:a591 with SMTP id 5b1f17b1804b1-4bb8898a596mr170586435e9.15.1795356683525;
        Sun, 22 Nov 2026 06:11:23 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-2025-a95f-1d53-595d.rev.sfr.net. [2a02:8434:fda5:4201:2025:a95f:1d53:595d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8d4f9aa8sm217481385e9.4.2026.11.22.06.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:11:23 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools/bootconfig: Preserve arrays starting with an empty value
Date: Sun, 22 Nov 2026 15:11:14 +0100
Message-ID: <e716b73c17e214705729996a0aa3bc45035a1a01.1795356673.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <undine-1795312940919368991-3e5277c17e0a1400@undined.local>
References: <undine-1795312940919368991-3e5277c17e0a1400@undined.local>
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

bootconfig -l treats an empty first value as a key without a value.
When the value is an array, this drops every subsequent entry from the
output. For example, 'key = "", "value"' is printed as 'key = ""'.
Reading the list output back loses the second entry.

Check for a child value node instead of checking the contents of the
first string. This lets xbc_show_value() print all the array entries
and keeps the existing output for keys without a value.

Add tests for direct arrays, appended values, nested keys, empty
scalars and keys without values. Exercise list output from both a
configuration file and a test initrd.

Fixes: e4f70b7badb4 ("tools/bootconfig: Add list option")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
Hi Masami,

Thanks for catching the test issue. The plain-file and initrd cases now
use the same original input and compare against a separate expected
output file. I reran the bootconfig test suite on my Ubuntu machine.

Thanks,
Eduardo

Changes in v2
- Keep the input file intact for the initrd case.
- Rebase onto the current bootconfig/fixes.

 tools/bootconfig/main.c             |  2 +-
 tools/bootconfig/test-bootconfig.sh | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index c32fb1e2140cf..256d2ba7523c8 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -170,7 +170,7 @@ static void xbc_show_list(void)
 			break;
 		}
 		printf("%s = ", key);
-		if (!val || val[0] == '\0') {
+		if (!val || !xbc_node_get_child(leaf)) {
 			printf("\"\"\n");
 			continue;
 		}
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index a93a40d11d278..1f41ccd9ed3b2 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -14,10 +14,11 @@ ALIGN=4
 INITRD=`mktemp ${TESTDIR}/initrd-XXXX`
 TEMPCONF=`mktemp ${TESTDIR}/temp-XXXX.bconf`
 OUTFILE=`mktemp ${TESTDIR}/tempout-XXXX`
+EXPECTED=`mktemp ${TESTDIR}/expected-XXXX`
 NG=0
 
 cleanup() {
-  rm -f $INITRD $TEMPCONF $OUTFILE
+  rm -f $INITRD $TEMPCONF $OUTFILE $EXPECTED
   exit $NG
 }
 
@@ -169,6 +170,30 @@ $BOOTCONF $INITRD > $TEMPCONF
 cat $TEMPCONF
 xpass grep \'\"string\"\' $TEMPCONF
 
+echo "List output preserves arrays starting with an empty value"
+cat > $TEMPCONF << EOF
+flag
+empty = ""
+array = "", "value", ""
+append = ""
+append += "value"
+nested.array = "", "value"
+EOF
+$BOOTCONF -l $TEMPCONF > $OUTFILE
+cat > $EXPECTED << EOF
+flag = ""
+empty = ""
+array = "", "value", ""
+append = "", "value"
+nested.array = "", "value"
+EOF
+xpass diff -u $EXPECTED $OUTFILE
+
+echo "List output preserves empty array values in an initrd"
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF -l $INITRD > $OUTFILE
+xpass diff -u $EXPECTED $OUTFILE
+
 echo "Repeat same-key tree"
 cat > $TEMPCONF << EOF
 foo

base-commit: 51934668ca98f1b23c51ce4edea3c61018da342c
-- 
2.53.0

