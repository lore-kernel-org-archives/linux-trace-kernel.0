Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337745;
	b=5oTadSlkEdowS2Cyg/uMx3lHWs6YJ+o3j0I5W9bNuGQUhU/osFm38vDM610gqJO/n0n4
	 roD1CCCuGanD0VO06qF8CFCuYCjzXMgLmZcoNo7pRQnsNY1Or8DyAE2/6pGc4562YcSm2
	 zZBzlwJ+yR8xA07/1gOWkJEHJpIYa6Z3kBZaIolcDDPjbKIRqSVERoApBjJrURMBFcHVI
	 4h/cy6pbfqbXU2UQ8Utu+Q4A73RPEv8DCu1faCK+UDYZlziZ1tvExnYg1Kdyd7aWE+jBx
	 /PR4JrynU5OBFUCHVdrpeF4c6tEGRpXNlWD31NeoqpJjWFE6M6CWq1ubiFVBV3jmD8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NO2sdAez8S6n83liUUR9377K8rTnW+Jzv2+weGto1Hs=;
	b=ZZ+RkPzqXEqj3Y/UUt0VhbnBw+QokUDoSQl9NuoXzO6TCRrwqdSJgbRgIC8pMqRVOQtJ
	 xPYCvfKZ9CgNS/0R0F+H0EllLbJsD3i80+pPd/DrLGpv2EP93sUErN6KOxVT37tDQmMef
	 3csMYX3rE0IGJdk/zKPa3mmmECaUb3JsAzU4cPjp4lMv/fsYZ+Edp+IuoyFBZW2VxIIgY
	 jArH8rRSmHZ5zh5YWCfsDr8u0DHm/GKhgnR1UNLn+5G9WnVYyZo9I6RoIYKFcjyKnwaWY
	 h90u4KekrIBP6SqqDC4k3q6CqWB82UAlfTSsDCRJm1pVf4f+14Ybg7YfGVEVtpCaxIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="d8O/6G9y";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723760A260F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 19:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2723760A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d8O/6G9y
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so27729955e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337743; x=1794942543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NO2sdAez8S6n83liUUR9377K8rTnW+Jzv2+weGto1Hs=;
        b=d8O/6G9yk4Q96PxRTmpH3fURC/KUFi7ptm0Vg270N59SiKN2q6kNgcFB1R9KGL7kZJ
         kswEhaDNNFR2HLx3TRnu9NaQ9Twkj16uunHvhd0ohq47FHKXLXuLEnb31WFNlofpsUKE
         vf3AHQgikKwXC4zGkpOOnT5Q+F1s+4evHm1lATUNcedREXf1T267XOHp/8L5QBA51+8B
         dWxCyK1qOMONxp8OsWTQd3LAzaVIFNfSOliol6GaqJRRXRT1oHeq8spzP8isW6xXeBSN
         ySX57FeaKZWNxRXN5XJWs2/XEEFnEWLSM8q8odPL4FpwGTYS+kCPkXo69Zv7SxHYbdDG
         ZjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337743; x=1794942543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NO2sdAez8S6n83liUUR9377K8rTnW+Jzv2+weGto1Hs=;
        b=mwBqpNrFHIwxmUb+4W/JuQo/5OyiZyce959zRHKOyvDNjBR7QjasIlMWHz/gvE3q3X
         PBAtl2MPjebJIazifi9niB1/0iePFf/bW2DkdGbhcOOaAa0TLNx0GX7xm+3hTTaTscjO
         yyGhtTvjjDA15jOMacnsmuo5Q8dS0a9fuMzKQpHUEml8VhGtdYp2M0x2LqVlrNydUdE+
         970YLunbqNRd52vQcMv97KAPWrxQhcCOdzy9SPrMk9BF9NXbcNfsTxu4n6mM4jwAuQDv
         KK8v06FxMmBREn9fyjXOVdHIpThIA4cHlfyRuz20GzKaX5RagE2uM1GQEjygRSvOWvpG
         ZfMQ==
X-Forwarded-Encrypted: i=1; AL+hErEhYpeUmK+K0Z20P6zFqmgDIZgKuJ/Ey0/NmQ01b3rP9mO/qOgw2hKxLbh7dmPk6bQ6UPvkA8B+biJPJrTjhM9oaxE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9OeSfaT4XgHFKh4ABnaHQWRZjkHiNhLcK2Os9wvp/3TIPNowB
	981qkXH8Ut2KNNoLr6QspCNMK6pRRWDJIIrDHQS+a18y2TzOQ5c5v4d1
X-Gm-Gg: AYBFou28fnbqDhuTChkSatYe2MdBRK9ji5zZxyqD7Q6KGDEfu+DfIE1YK4TW+fpyrei
	PTfq9osNWRqUc7ba3inpLTmDE2fMixfBh3LYFUgQmQfSqxZKoZUK2BCQq5IanmKQhSFeIP/3cQ7
	xdSmgkwxpefAgCoY0dPI2LiVlbdSgApGhZ7V3RNLimEZ09WEn0s9VS7/M0iMFHS9y+ANst27fEp
	qxbi/CviL8aU4bMulZdMJhHSsg2vrWNpJYgS2oiYPp/dpXi3lTI641UJKPbPfLXRmK6EF8YB7xP
	Eu32zubXfEs7LRZGHZ/bqZQamGPnMS6WXenV9CE5Gw1INfLRrWqyFcoy+arznRu9okl+N6D0NdD
	wSjj4Zh0ok+FjihfpCSGuJU8VAMKTSaKtZ20ndS2rtGo/Ik+NkhYcv20ev08/DUeQ6zjp7aOMGk
	QvKZeYd/x/JGRsGN8ds89l1xuqQD8kjj/NhgRGcFUgOn/0xjXNKIKaCQ0yWJPl3r14nnxc4Vzp6
	ZQA46Jl/SpxGAN5lDmdDICRfp1WEChDKWpyDEPbZq+QNajAQPj1mXIMGEsdwu3N86L247lgNBPv
	UkgWhx/i5OiyZma9tUbMbf2brA1GMSGvC/MPfJ7oYo0qff3VGrgspLG0KT/gIMtKa/7hg1wbFhj
	B70mMJij4SU51oswvZm/apFkW/ODpdGp/s3V/fkktOx4sHa26gPl6SFDcMmaf6iixdCL3nlw30t
	Xi2usorrdr1KUGg6I908U85E4FiZ2cbo0S6uGdeCd2D2K8BRLzHTKhLPRotG7TX5yEXnMCwAryW
	Ry3lNVpMVUkRY0Lpw==
X-Received: by 2002:a05:600c:4f81:b0:4a0:1c94:7042 with SMTP id 5b1f17b1804b1-4ba09377c5amr1349305e9.8.1794337743494;
        Tue, 10 Nov 2026 11:09:03 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-64a2-5e9b-f89e-f448.rev.sfr.net. [2a02:8434:fda5:4201:64a2:5e9b:f89e:f448])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08e35e44sm4309775e9.1.2026.11.10.11.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:09:03 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] tools/bootconfig: Preserve values containing both types of quotes
Date: Tue, 10 Nov 2026 20:08:47 +0100
Message-ID: <6ad95c1a6eb524143a38ef9a0d4fd87b92ef1daa.1794337724.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794337724.git.edumucelli@gmail.com>
References: <cover.1794333957.git.edumucelli@gmail.com> <cover.1794337724.git.edumucelli@gmail.com>
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

An unquoted bootconfig value can contain both single and double quote
characters, for example:

  message = He said "it's fine"

xbc_show_value() surrounds any value containing a double quote with
single quotes. If the value also contains a single quote, both compact
and list output become invalid bootconfig syntax and cannot be parsed
again.

Print values containing both quote types without outer quotes. Such
values can only come from unquoted input, so they do not contain the
delimiters that would require quoting. Keep using single or double
quotes for the other values. Add round-trip checks for compact and list
output, including an array containing the mixed-quote value.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
The parser accepts message = He said "it's fine", but the original tool
prints a value surrounded by single quotes. The apostrophe in "it's"
then makes that output invalid.

I checked scalar and array values through compact and list output,
including literal backslashes, quote controls, and a test initrd image.
With the fix, all 25 focused checks pass, independently and in the
combined series, and the parsed values survive those round trips.
The full bootconfig test suite also passes.

 tools/bootconfig/main.c             | 14 ++++++++------
 tools/bootconfig/test-bootconfig.sh | 11 +++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 75516e9e4ac3..e7513742fd2f 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -52,17 +52,19 @@ static int init_xbc_with_error(char *buf, int len)
 
 static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
-	const char *val, *eol;
-	char q;
+	const char *val, *eol, *q;
 	int i = 0;
 
 	eol = semicolon ? ";\n" : "\n";
 	xbc_array_for_each_value(node, val) {
-		if (strchr(val, '"'))
-			q = '\'';
+		if (!strchr(val, '"'))
+			q = "\"";
+		else if (!strchr(val, '\''))
+			q = "'";
 		else
-			q = '"';
-		printf("%c%s%c%s", q, val, q, xbc_node_is_array(node) ? ", " : eol);
+			/* Both types of quotes can only occur in unquoted values. */
+			q = "";
+		printf("%s%s%s%s", q, val, q, xbc_node_is_array(node) ? ", " : eol);
 		i++;
 	}
 	return i;
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index a2e8311d4d19..a0578013e731 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -146,6 +146,17 @@ $BOOTCONF $INITRD > $TEMPCONF
 cat $TEMPCONF
 xpass grep \'\"string\"\' $TEMPCONF
 
+echo "Round-trip values containing both types of quotes"
+cat > $TEMPCONF << 'EOF'
+key = "first", He said "it's fine", "last"
+EOF
+for mode in "" "-l"; do
+  $BOOTCONF $mode $TEMPCONF > $OUTFILE
+  xpass $BOOTCONF -a $OUTFILE $INITRD
+  $BOOTCONF -l $INITRD > $OUTFILE
+  xpass cmp $TEMPCONF $OUTFILE
+done
+
 echo "Repeat same-key tree"
 cat > $TEMPCONF << EOF
 foo
-- 
2.53.0

