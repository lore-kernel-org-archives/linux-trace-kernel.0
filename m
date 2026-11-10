Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333980;
	b=r8iD3EIR7/8gyT6RT690F5z1FkV9r6t8uQzlwAFofG+WvLlmMhUJqqzJ8k+wFtrgDX0v
	 kavVBiEN9FoHRR1e2nUyTafnaEZMWQ37cXRugRzH6xu7r2KYCBqDyfeOz3gM8yqYlJxVa
	 dluIlkKiCRupwTamaQVd6PD2WcKiRWgkJOwRJ+aFPiupTDeOHdyayN7X+JVjKjigWhyFW
	 ZVPj12v3HdG2DLYuf7yD0lIMe+sUXse1RXwH8wqcuoA82d5XDtR2hm5Z9QiWSh0vgG1vv
	 pKmHeN4wFel6eFIqkIuYiBg0Xsze2K+gMF4OrRoEq/OI2NdS6MTSildayGHalJfy5Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=00/BW83UpDvF1/mIeyocfltqG8uBMs8V6+t3SsLg0/I=;
	b=IwcO4RsCXh5ipNAqur6NDuIVIKzwkiuD+0XWjCNbzgklzk3sTFC3knS45VrPLRCWC8c8
	 DznXMvawQYk5OMhi56jF028dpAmuvnu6nYpJbHoOI7peo8AhIJSbgv7w8p2yx2jSrU3Hl
	 1AOkHVVr1XaiV8t/Ryyeu/iCDiZP5jLVJl1Zq/1WIFkoMmejEId/Rj2W+E2zKFV8n3LVd
	 dqTzX3YZqmIFT0Y9HYLnyt+eLuJpxgAHE2yLSQl5noDrWoIQw2XVQ6tpYvD18HgJdRd8M
	 cbbFMxKlH3Ib9QGBN77n7K2DdGd67nYACcB2223Inzd5tLoyZ2cJ78dWptKra+6SXIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlT8q6DF;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E860A2603
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 18:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C7E860A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlT8q6DF
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so30951845e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 10:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333978; x=1794938778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00/BW83UpDvF1/mIeyocfltqG8uBMs8V6+t3SsLg0/I=;
        b=mlT8q6DF+G674IRGXyaNyQUROjSsnmYYRaeOqa1mQIUaSqt+D614CwlePIzJ4nq/dR
         kVblt0hPou+GpJFytetyijloE/wJFF+7xVgNqLlYD4R7T2kqzGi6kWOZ2gHpzghrPUht
         vXQNbj+K2baqzXd4WzfdOnCAsiLWoYZBjjZAjmuP6gMFs9l78fyVy9iWhqD8h1GdceFc
         XlLS/BsnBmORFMQ310W11phg5c2Lul6prVf2/jvjLc7ZOpkIjyaMMTOL6KjbqVxjox+K
         qe5zEDR5BPh0vsFODVhb++M1CMSzTWv4tb1RCNbz0RJPURQJNoPpiJPN+ul5Kutyq3rR
         /EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333978; x=1794938778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00/BW83UpDvF1/mIeyocfltqG8uBMs8V6+t3SsLg0/I=;
        b=Mx9xewXr0004YKTP5+Nh/MfHak0Sq6bCuMFDF7EWrPketFWgJi33eBE9A0unI2a6jK
         xTtNigEAqxZFAePE3z5VmPUi47pGZz7LWZvRVr6kssq6LaGnqaXOcbH8xEuJ2L4gZZOn
         7GCsOZSkuvvLDPMRL3WvhX3/rh0o0Qqw+230DIbAXL1fbDdxAVcpAgjY0n7z+tAm9a1x
         5OZOkMQLR37RW/1Co3xr2eSxX2aZyLbAS/JvR+J4ruaPXcQDMhUteu+DMWVL3TUaaXM6
         NImuz9hIoj3hqzYBaQjgyXpUonsPvVFCovkvqHtTewLk1MRw8Ip1XdKAuxLU0C3j/lGA
         B1GQ==
X-Forwarded-Encrypted: i=1; AL+hErHf06UskhXBpbYf3vsLfzcX1hR1cakv8gSM+Iple9Sd+HVyOJnk260qPPv4DQk+2MnhMdXKzCz4VhX62N75+DP+jcU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H+vgHzBNBMKwRtBQM43y+JYu040dGNYcdOBpF8r0xD32dtUqx
	dTqbV65VymkwGMX0Yl6SRV3IKzKEJEC1DX+X3Y9Z1DiP4m9BykvnrB9e
X-Gm-Gg: AYBFou1wUiRSeN0NIIXKHTZVXIG0bHqlMQlQbdb+EVSqsgRZNpWZy+18WHzoVRlosfD
	fSHLDVt2yxpgGYhlfQysrUdNDT/H65O3XTzSfdBZxrBtuVffllKHuYmhbz3zjtzvSpViuUByxPW
	zHnkdoik1PuU7ctu1nn53RCJecxjUjVxjDgngoK5nl0IMwECUMe3TOs+xSC6+pjLdpmOrPUeLSj
	jHElT2RN+zSZituWst6gddylnHTq6NMuiSUPsQGNEO27iMvE84dZZTUUQw2telUfBGPmzLhnl7/
	i5401qvFxmIunoF/RffFZb+Q5+PjVNcXiX6E5uZRnf8wd7MaG6jsKr50ZyR5BZhlvEna66TIXL9
	PRgaoV1mU4PXK79OWu6AWseoOVYP+cq17IvmOiLzaFKVN+WOXiGCpnpmk/nh2dQo6smOz357x9x
	xVrP752TBngnrklp0YNzL2LzQan9+jkVWv+iqCVNvGXSA4B3ODvTqF4DtpTopntdleRV6iqstsp
	q+zDH5d7Z+ukUOtVNDCwIU7itewiw4FnBpC12xBZntpj99ltbEqT0aex39EWl7R33/0jPOOebqC
	Epo+97+hS+HPcf7CuGGns+XnwZRVb9pMsTKo3gy3lWEna833sW7Q1dVtuJhs0T0WIFu5U2YSxiy
	BxmJ5/eE1hntdXM0E6fCMPjkneWcSYVP+s6XLB7txwgd+WeYsE0dmj5wd5wVTVb2HJzxOm4fYy4
	gabILrZuxniF82nCduX6X+CdGGTg5MeVU+fQGEAG+bgyAAyI6U78kpXsr/TWoyzY0FNDUtPBruE
	LmuO7DbfIzGdIKpZA==
X-Received: by 2002:a05:600c:1c0c:b0:4a2:150f:1607 with SMTP id 5b1f17b1804b1-4ba0233e877mr65665845e9.13.1794333978452;
        Tue, 10 Nov 2026 10:06:18 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-64a2-5e9b-f89e-f448.rev.sfr.net. [2a02:8434:fda5:4201:64a2:5e9b:f89e:f448])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c500asm6270450f8f.48.2026.11.10.10.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:06:18 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tools/bootconfig: Preserve values containing both types of quotes
Date: Tue, 10 Nov 2026 19:06:01 +0100
Message-ID: <3347694260715a039b799ddffcc0c1eb05e7ded1.1794333957.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794333957.git.edumucelli@gmail.com>
References: <cover.1794333957.git.edumucelli@gmail.com>
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
index 1bab0e685e2d..7042bb5fe280 100644
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

