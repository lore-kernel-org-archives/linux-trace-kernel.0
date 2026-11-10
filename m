Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337744;
	b=KqizIxn/P6JxBAl0oCIMQ+4ZLlaEz3f1O7+Px/iFqPCREM6osggmoY2lJ2D7WWWutMKr
	 BxFChFIqIjUeLo79qZhFaGqYkbP+bpK8/rGyQKz6esRDymFvv18XTaVkbGz2rdnCS4ZeR
	 U0YvIP5/ZCbheAImME1pxUorylfi2RodQBcVtwttIuhi+gmvuzvpG+LXkVrWsamv4r0Rv
	 Zxj+RHfStm0CIJgoS9R+PSniC+AleUhoRT2cZzMylpHPeg2k1tZYfgCgAL7Z6iExayNFH
	 UqdtyiDaqhd9CwAnuXsiCBSifxYAcEuiLxR2n3PI56xI5EKVpXJfCN7FVd8b5u0rs7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jkqdsLITYk8zKnoFddRh/o2WJGEOQO1+s840CvxG/Sc=;
	b=bxQQKndApe2Pxut2BaUE1v/gqLtwVT6i+nQA1Olp96Svq81Cpjv/Ij4oTeL/NM41rujj
	 /UKc8yXVjL0Xwddhy37CYaG3k8hlT6fdsRoEASgNJ/W3eOAh8niu6ywRvKWEvh4uXStIT
	 Q8XewssPz8dCqIFMMvqPb7kAfZjzRzsIA+E9mV80c83a3t2PiaXNmiwnAJ4+4XAWgRhxz
	 LYtglYR/r7lSZEZmiIAdcsFkVqzYW0Eiy4rrckNZTMw2K/1vm8CmDts9scrR5a8MCqCOg
	 CjjAf0PL46ncgSTedyfVEb2gBvIXf3Z/EkqkSx+6ZSfE7Yv1PRXA3GF/w8fFaVP7Kbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I8NdEG9H;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092460A2604
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 19:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D092460A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I8NdEG9H
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so25359855e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 11:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337742; x=1794942542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkqdsLITYk8zKnoFddRh/o2WJGEOQO1+s840CvxG/Sc=;
        b=I8NdEG9HiMKXwahr4pjd0R7bu3Z0N2HVz7YIXBo14wnGRo7lsv0CqGXftdCMtJckOC
         JO+bYEo1mIXTAGwE+8p1TAnH78yZPX1dem2Jkmipwq2UAXGPzEvyZgTkjGirSNSJLuRY
         TocCB2LoL++18hJZJPB4jfhBlAx6YiqGA/u+wxXUTj907YqEPX2ekKXnUHdfEvawQLVq
         7KekVHeeTXF+MsD7kZ51MDHvF0iATslCO718TD9ZrdrXjMld5mBkHtqA7caOXA5sE54D
         mjgV4cY8NNykhNnzy7Lk5LeMIzgclWV74e+wYByw4NXoUcoPpIDnj60cUu+AO1lwuAHb
         k+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337742; x=1794942542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkqdsLITYk8zKnoFddRh/o2WJGEOQO1+s840CvxG/Sc=;
        b=phMg2G+lYwrMNe2cmp8vgMnqa8IurlOtOM63fkLoL5oDdLe583BuGIvf3ingZyIvzt
         xC4l1e5gu32VKxoKZWArxx9rt2wCP2nkG2YtUvtixmoKCnryA+qerSDBYqWwW4F7ssXF
         4ejvGbSLVRPszQ1sPnbHAT/lgsnAFLXFsY+IUupjkVTK8JoXRwzAkL/X/LcLnSpM/RMu
         Z3ad01pTWads0vFGM6Boyid6EDMtJPtarmUQhvTddnBP92kZVdzHaUYmOZnGxUt9lOyi
         Axws3j4xIMJKaELWnnvafRUk4M0jrCpdMk/pyvbEsG02mDzR+YjEUwjz6uqW0ZTivsxU
         IFfA==
X-Forwarded-Encrypted: i=1; AL+hErEX49q4iiEBLz6ZSrpkC8H+RDRqfYcsPB0u04IEPzjUAFVGH3bNiH3cyPzx6OoG2JJQyjYJkakl7erY2YD5WxGtKH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nKs6wzlmiyPic2fiTpoMelUePcERpsNDudMAT4RFgCEk2Howj
	KTcmpIvpW/KjG5V8/i+ki/3mOOrFokEZeSOczP5qa5+29EgE73hKrTqY
X-Gm-Gg: AYBFou3CBQIdhCZ9wg/ZCE0ETF6S8fZaIt9Z0+MD4gQihM3LJXIL784YMT47AWXxJOY
	cdG4SezFw7BsV/2Sj6SI5ybY9vUSClz7dS+z8u8LIo3B9uBObXT/K4IevHV7p5U/hB/X09h61es
	m4kNvkHtRNHJDyJyRtKG9yyFpGLf8UaudfoLv3UXvBBvZJel2fcfcM3QrnrdiN2POBW4R4C4YbR
	H0VvmsKsqJwawkxwvLdSHgUf9U6A14txW5oYuo5G1pFUnYgoy/YbrFKA1kCn+Ppwj5vHH2+re9B
	LsMRhco9DqotOlYQqeyUBlLTtHvAQIJRflijtsUPjd2bnVHuXcjaUyRLk4OKY7nnY+EliH4o9m5
	kDo+AHbbaf4nI/w9ZyDSK7P/qRFdhBV5l13DfXiX1FYVUypqSjmGy5Trc6Ya+5vd3zuhKK3VP1+
	Mam9kGdzCoOO7I6u751a0N2BLqeDixeB4TWVQM0SDKhHF5jo2KaFkQ/de//v2WMnayXwBfmIJnz
	iFTc6ZvHYEc3X3e0tJpqgwy8X4GOhjGmcEQlni1OMBDUkvBomVJ34izgs7JN9rLFq0JCWgCH5i8
	BkQyzRYdoTtS19x6u59kp75GMWpbfKq2pyhYVUK2tk9ROH2itJcmHYoBqPChzo26U2ESf5jMx7U
	aE7FVRPAjbeuc341mlhlMIlj+BZnI/dz+/k/j/UeRqyPuAqf+tKd5XjZcbfF7iopoJwq4OIQII8
	rTvV7UraXxruQpQYlEDK+E59WzW8m/T06BAvZnK1OXPXffp8fRNquSg+Rfgu9TynVfd4lY1WxKj
	BgDEeOy0C9J4qDZCg==
X-Received: by 2002:a05:600c:b99:b0:4a2:150f:1607 with SMTP id 5b1f17b1804b1-4ba0938059dmr1127595e9.13.1794337742228;
        Tue, 10 Nov 2026 11:09:02 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-64a2-5e9b-f89e-f448.rev.sfr.net. [2a02:8434:fda5:4201:64a2:5e9b:f89e:f448])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08e35e44sm4309775e9.1.2026.11.10.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:09:01 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] bootconfig: Trim unquoted values at end of file
Date: Tue, 10 Nov 2026 20:08:46 +0100
Message-ID: <31f248f330e716b925add3a0ba76f62826527312.1794337724.git.edumucelli@gmail.com>
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

__xbc_parse_value() trims an unquoted value when it encounters a
delimiter, but leaves trailing whitespace intact when it reaches the end
of the input. Thus "key = value   " has a different value depending on
whether the file ends with a newline. The extra whitespace also reaches
the rendered kernel command line.

Trim unquoted values after the scan finishes, including at end of input.
Skip trimming after a closing quote so intentional whitespace in quoted
values remains unchanged. Add checks for scalars, arrays and quoted
values without a final newline.

Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested inputs ending in unquoted spaces, tabs and carriage returns,
including arrays and appended or overridden values. The checks compare
the parser's actual values and the tool's rendered kernel command line.
Quoted whitespace and inputs ending in delimiters are controls.

The original parser fails nine of the 18 focused checks. With the fix,
all 18 pass, independently and in the combined series. The full
bootconfig test suite also passes with the regression checks added.

 lib/bootconfig.c                    |  5 +++--
 tools/bootconfig/test-bootconfig.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 819685d6c68d..bd071c394c36 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -793,16 +793,17 @@ static int __init __xbc_parse_value(char **__v, char **__n)
 				return xbc_parse_error("No value delimiter", p);
 			if (*p)
 				p++;
-			break;
+			goto skip_trim;
 		}
 		if (strchr(",;\n#}", c)) {
 			*p++ = '\0';
-			v = strim(v);
 			break;
 		}
 	}
 	if (quotes)
 		return xbc_parse_error("No closing quotes", p);
+	v = strim(v);
+skip_trim:
 	if (c == '#') {
 		p = skip_comment(p);
 		c = '\n';	/* A comment must be treated as a newline */
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 530ce7e28d63..a2e8311d4d19 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -171,6 +171,24 @@ $BOOTCONF $INITRD > $OUTFILE
 xfail grep -q 'val[[:space:]]' $OUTFILE
 xpass grep -q 'val2[[:space:]]' $OUTFILE
 
+echo "Remove unquoted trailing whitespace at end of file"
+printf 'foo = val \t' > $TEMPCONF
+$BOOTCONF -l $TEMPCONF > $OUTFILE
+printf 'foo = "val"\n' > $TEMPCONF
+xpass cmp $TEMPCONF $OUTFILE
+
+echo "Remove trailing whitespace from the last array value at end of file"
+printf 'foo = first, last \t' > $TEMPCONF
+$BOOTCONF -l $TEMPCONF > $OUTFILE
+printf 'foo = "first", "last"\n' > $TEMPCONF
+xpass cmp $TEMPCONF $OUTFILE
+
+echo "Keep quoted trailing whitespace at end of file"
+printf 'foo = "val "' > $TEMPCONF
+$BOOTCONF -l $TEMPCONF > $OUTFILE
+printf 'foo = "val "\n' > $TEMPCONF
+xpass cmp $TEMPCONF $OUTFILE
+
 echo "Showing correct line:column of no closing brace"
 cat > $TEMPCONF << EOF
 foo {
-- 
2.53.0

