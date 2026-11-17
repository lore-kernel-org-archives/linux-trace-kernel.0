Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956916;
	b=zAYROwM4rUHnfSTRr/Kk2VkVYXZNez4FMnHvZK2pyZ8mtdOXKZv1DEWevj9Jv3DerIGO
	 2fiPLuNWPdvF1QRLaK2giFwZVGV7zL6pn072rsfbUKk2FKSj68BDpu4Y8ZPSHSlaKbo0T
	 eGdgVVc9OPvvxZYWqhlirR3Gzbssryzz1wpRGBJy+6NBaQQrTy4oC33OASvnaxRspGEVE
	 t2lsLEk+zgLQo2NzbtRultPMtZ1D51OiDAOv10ZP8P7UwziF+H/K9fikadkD5xgEgz311
	 SI/4SMxXaAWgb3MiA4JH88O3MskosanGq4WjX4+YtmPiXFX3RJnaxUMiioZzKWtrd1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BAFETjYWf1VFzL4l+fLb4qA1VxTBf2Ld8d6fUb/j8RA=;
	b=E9FbkVF9jeLoAurLrXtJdbZNCRWkvwRjnIOZngCNecHmS7VF8+ar+dJS8HzoJjX4Uwga
	 b8okI4xXVe0KndGwB3EuZ0yW6DA12IGlAJHSzj2fSj4eXuu+7W6b6vw4rX1DCOBd27fv4
	 ZSQJIunmQVt2cRmkLnbGC0sM8ro5hbC1kruoa21o2278IIik9S25kBdKn03udGeDLOJsl
	 GYNvTgruI8EUmZEvoMXDVwhpvi4E7vJkZl/0iAH5Sx75/W6mEIOzKnYstxtcOkJs/0fPU
	 Zr4vRFQC629SOFj5FsHPHd86/e2IwJSd0Szff6VT3ya72wN3SqezBjCScl2u8+JVrqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="my/N7DPR";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C5606A32A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 23:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F25C5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=my/N7DPR
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so2767205e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 15:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794956913; x=1795561713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BAFETjYWf1VFzL4l+fLb4qA1VxTBf2Ld8d6fUb/j8RA=;
        b=my/N7DPRUmWh2NaKdSk7weEVnpTfHpgewqlC7azozwuyH6lkDswzvUvfHm2iqtQGGz
         85XR1ThKMhq9IaR9YC3U6N06rWOdq0ro8uCpGKZsHyFG8pQlSiKNIrfLF3oONmrkF99z
         FH6bHjqX+bwDkuNZD7EiEwuwBC6CVfKmAgeZ1pNgmbNHPCc+qzQc/22NFmG2JxhhQLiA
         XQHUVZPlTOEXjUjQld7N9S9hnbTlWdTrjEoW5IFlmqzMAnqSii2kfmYSPzbbnaw9G5SW
         xQwCtYjBuTIpczn4W1FXUaO+KD5Z/pc+reZA8yX5T49oirH0rjJGONvob+IheNsnQyET
         P8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956913; x=1795561713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BAFETjYWf1VFzL4l+fLb4qA1VxTBf2Ld8d6fUb/j8RA=;
        b=wAhb1xBZqc1h0amz/3ds8j6GP7QQz9iaXvYF1sxReEuxx9nTjhAwD1sNmIIdESqhYY
         ELgXqsV3xXJ1p4x6T6ejOyJNPHc7/mO4Ir6G8iE2su1504rrsHDY9hsr07bK5X+A+O2t
         O8oAg7K+lnIakvJjdb/fF+v77VLZo+d1sXGPbgyHMxGolwswTS0i6WigRPPobT50K+28
         cqVU/m1GbAXP+xH/QOziyzqR0dOHdEQY/B+EhgULrkhKc+dbIQCz3Ui11INKrso5vEvi
         etrpOhlEGpZfDqY0/OTv7JBX8ewMqiqH8jFE5vn90Q1xTyUH6G6nH9d0gAndAPYdT/7g
         3B5A==
X-Forwarded-Encrypted: i=1; AL+hErF5DybZ4JX4+TQnCK/1UMD6k9fm/eAHkRm3XBjWaUK5ztpCaXQJWu7ED7BYvzwhI4eV/1e5eB4G1v2/SgU9y2KEHUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hxQaVaSCQmYwjCum5MJzvmF0vLJlxy+M5HLrVjZRV6ujPMtig
	o3At/THtvhuDVjzDRElJTVvsRqHk7DB2IltThp0/e+mRqDUNLWoX7dy6
X-Gm-Gg: AYBFou2Plmkh9RfSCkOM4BnOeZrsBTprhK3a8c5vd5VZsTRguMcAGhuCwIHFsZE+Re8
	nd8rKvKvQE74LhOoU/WlvO4xbSHW6kUyWixe3M1ifx4BcroVEm60wPxxW4fKHvv7TdQ6DzgjuAl
	lWtbTD4Mza2v/gAS65RLLSFmGsUR07J2gO0enNVANb5t7kkppeZ8hQxJGCc1YhEo+MhJSiKhS7P
	rzMmB5/SSzC1XVQTlPNLBI6YSYIDXUS5wYyFj9IJFDj6Q4hQXsq3NWbob2MQj8QCpZB94x79qF+
	5g3py6vUScR35bCHOefaVefWSODmVabYFTa/UV8VRsd32U2QpNGK1GdFEKuC++jfBuYo7fDWMF2
	TVASwm0VEErqhfTpi1IDMJy+/8iEH/qdD7+U97KEAlVAJjnXIpvvsIYV/HHyieTrGoTuYH0boww
	IeC/XKa5RICfapTtZKdgb6g8b023uszInZmMhz9IFbguHiWvuXTI75uSODJEl+k73GcOh7t19ps
	kIXV1eKGtwnxSdzM3b9jAD1EBMmn/l6cNb12mt2J03jv83IB0RUc53TtL0GaS7B/0K4RpCL6k/n
	BDU94ayUiW5riBwuocKQFcbbHpen+5sii9WZxGYR9eaKNmzYxd2NXkHrM6ZiFSpES0e9r593UIq
	ejEmk/U4RXspRie668egGxERRJFXKkuPBXq/WXJ+9CIKVgkZNUnnpJfYTz4An4BzixBzwp6VJrD
	aYoxv6ydZYNRsB0a2uKbjCgZ8Wzl/y2MfNYf97TPRVRdlP5O9kKIvmFnhykjV+PQdxfbvDBcziW
	UGNI/Dwl4u7Chpc
X-Received: by 2002:a05:600c:4f4e:b0:4bb:7033:c92f with SMTP id 5b1f17b1804b1-4bb7da0f671mr15204455e9.11.1794956913230;
        Tue, 17 Nov 2026 15:08:33 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-1756-489a-0fe0-4acc.rev.sfr.net. [2a02:8434:fda5:4201:1756:489a:fe0:4acc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7e577acfsm1934435e9.1.2026.11.17.15.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:08:32 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/bootconfig: Preserve arrays starting with an empty value
Date: Wed, 18 Nov 2026 00:07:57 +0100
Message-ID: <e40c6adf42ba4b90cd16d9ca955f38c6c4783eb1.1794956874.git.edumucelli@gmail.com>
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

Thanks again for reviewing the earlier bootconfig fixes.

I tested the list output on my Ubuntu machine using plain bootconfig
files and a temporary initrd image. The two new output comparisons fail
on the original tool and pass with this change. The full bootconfig
test suite also passes with the patch applied.

Thanks,
Eduardo

 tools/bootconfig/main.c             |  2 +-
 tools/bootconfig/test-bootconfig.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index d3f840c5adce..b189ca0935b9 100644
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
index f584f7637e12..85d56b7e4ac7 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -156,6 +156,30 @@ $BOOTCONF $INITRD > $TEMPCONF
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
+cat > $TEMPCONF << EOF
+flag = ""
+empty = ""
+array = "", "value", ""
+append = "", "value"
+nested.array = "", "value"
+EOF
+xpass diff -u $TEMPCONF $OUTFILE
+
+echo "List output preserves empty array values in an initrd"
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF -l $INITRD > $OUTFILE
+xpass diff -u $TEMPCONF $OUTFILE
+
 echo "Repeat same-key tree"
 cat > $TEMPCONF << EOF
 foo

base-commit: 381b391bfaa3f10d52da4740529804b0b6b8160d
-- 
2.53.0

