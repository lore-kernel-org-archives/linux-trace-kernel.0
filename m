Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333979;
	b=JnUjsNcFXXPIwFv2OAODsKkEv1wWbHCCL8+RS61Gi6W9AB/f6k4bty2LGIenuem8S0Od
	 Dt0YvvoucLa6s+3pDShtIcPv6o3MocuhoMjAUJW7xb9B1ANV/6dnwt5cE1woj0nn3A9cY
	 8IbwiwoLQKu3ChF/ut7O91AlUw4Kl3S7gmWDe30unbWceiGXhbnQkkkWXGnTThYal7Dpp
	 5m5W4Edwq29hHZT63CoFpb3lyJs/iWpADqCl8biAQxUh6OB+eIi0qU48xbzPilW1M1J1s
	 Ci/c4ZcZwHb84B10E8qzGIArbwsRdKAZad7coce5fAJGpimlMouSUvdIBB8t8yoE2NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jkqdsLITYk8zKnoFddRh/o2WJGEOQO1+s840CvxG/Sc=;
	b=vhuxakyay0z++VT0qGBktoXjz+G01vBV9EjFjna+EZNcuDgaKBswVnbLY4DpFPR49pbr
	 08ZA9zEhcYyO3VCKmUjMwV48l9GvFi5n1W+XLasPmCF70jQGXzKvTLBHsgoP3pK5aBvdP
	 XMSW77Y27xQRBv8I1oSf1qY1RkVlhrLAKcTg+93VSFOZJoqgpoEKB2oxy5r2ditW+iNgm
	 sGUVG5q2LBZ/SQjW+7PoTW5b+KXkvAakZIhjNB1HA7DtAfvfztyyX7Sw9QBFNnefsVnoW
	 +MbreFr9Wx84hjj0ekyyVSNlUU9SIt5mOAaWTNuVG3ZCHKruUshMmDI3PpqRucQJHUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=amSO1ZbQ;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18B606A33E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 18:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB18B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=amSO1ZbQ
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so13747895e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 10:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333977; x=1794938777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkqdsLITYk8zKnoFddRh/o2WJGEOQO1+s840CvxG/Sc=;
        b=amSO1ZbQHtnTZxNAFRbohBeeOIU1DuaSBF2/upBYkRmkLbe3g2ZoiBDAmZ3CTIuvIe
         7RlKGDSph78lMZPCOW2urdlIjt/8FgOPfD2djcIfed72a8AyQN6kMo4Yvfi6hIcsp1hH
         7c0339aeiGRs08VRlZi6ZvmD3AAlzCfX9xH2HhJnOV4VOSaMv62CyTdsBEEaOnIFrHZf
         XlzC9ZkMVv8xmyFAZsePXZsU9zPnGz7jNd+53IMhbT5NxRg9wwMr13/w7zaoIXywBzwk
         MCRLevSNd9BlELR6ZaQpWskZZknx0MrSTDm80Iw576AhO2x/VJk/ezul0pstnj68Qwz4
         6FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333977; x=1794938777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkqdsLITYk8zKnoFddRh/o2WJGEOQO1+s840CvxG/Sc=;
        b=qi8owipJ+lCtwizuHvVzIqa171J2g7NuxzG0YwKA22PKppsbEewV0NNjkJgjX+Uxkh
         s9RsgcsBwx5XsUQxHV6smgZrp/VAkiEGRQubs/4tBgZPKO2BPcZO6Kn/I3JACZeC4A57
         gY0ciiJpD/UA/uDsdyRXV/DwQsx/jDEI/e0t/Ggu+Wt/3GgFE4kyC75gKvhnjCnOJX/1
         4DZCKXt/V4HLU1GHaQtqGWGcvzisVp/t5EuEB5dT4g4U6BcE5fwn/l7ksuyve0Lzxocl
         UyP3ExeB5JKgsaP77vSej2KGahTeNbm48T47gf8Y5MIyJOfvGA83Q3cIYkUDlMcwl7U1
         U0WQ==
X-Forwarded-Encrypted: i=1; AL+hErFt+nSFi3OR45QERteuxG2YP86MA33NPTXCxttIicL6mW1WgoiIGGySMSjUFiXZMHa3KtP9yZ4wgxwVCKUO/thcW9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QgLKmOMlzUpkqdvJUFOtTVmBv99cBHV8cYXqLXk2XXRbJX7Jl
	vR9dkdtmgcaw3cdcDlsacONS+4r2ov+Wtb2BJtsjZviKPCVaWWBthEup
X-Gm-Gg: AYBFou1tNn9wL5T/X8GTmjeuRAWEYMbLNnd/DjzcISihh4A9ei+5Ou+hiOLeQS3PPvY
	1TBDExLD8QwrhGCrGxz7zWk+8FqHWVWMNPYZzoUmdEKedV2i6Ky2yWIXPBlHADSgEmeKI5i/3aU
	pzhghgKB/H8qIxXBMe8hm/ThCiB2d7Xibg0aKz0MEAa65dzqBodDpuHP+oHKGRmu8AzDzew6qGI
	By1t3dqg/ca54D8HYMdu+Bs+1XpZcyR+jxVm1/ZsYVH2b+Xse7urF3ZJPu2UxVKBRHJmVu+MSND
	MSN/unZXTZwIYiWXdaCEKuzajzgwn4yCWM3nvX8zfkVVgmLJGb5bAx/BybQvBmf7TFvLxTn9sbS
	eUy7f1xs5l0YAZM5biXpUFhICcc91RXUE2i2Mt4wq9ZRUDFLYIx3RG5GUdyNIC7W1KFGQmQoYE7
	fawPv+3KiJccD9AnMpMBEIOoaAB2Bvi2YCF0cNQpY/y0wUgqDK+OR8Z9D9MWBJMmpUna8DMsWOn
	LPWeZtpmLS5Lr3srlJBsUJA38AiK6GNok8feb3mmbHuxtUHr6X9SMpAIAxgfSrTKM8N5VQA/UhP
	/aIc182MvZ0ir3G+rheAvntEHEFA4zs0iPnOsm3AHVpyl1EGhJs0JzOBrrc7n52AhlgPpYK55iR
	QnBNiX7MB7mErGflvBrlkvbPrcnRFr0Wc92R7A3w5wNopY/80cGJia65Qi8F2Tr8wzfig68HqZP
	G42p86rsRl3tjYag7Yh5dSmZxLJfDAnlLQFaAFIS2bYD654LEwF07ZzsLYfJ2TziFqfOdccY/Wd
	LCmXiS8S8H4Motgiw==
X-Received: by 2002:a05:600d:82e4:b0:4a7:9044:a87 with SMTP id 5b1f17b1804b1-4ba0234efc4mr66874305e9.27.1794333977040;
        Tue, 10 Nov 2026 10:06:17 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-64a2-5e9b-f89e-f448.rev.sfr.net. [2a02:8434:fda5:4201:64a2:5e9b:f89e:f448])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c500asm6270450f8f.48.2026.11.10.10.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:06:15 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] bootconfig: Trim unquoted values at end of file
Date: Tue, 10 Nov 2026 19:06:00 +0100
Message-ID: <4ca280f8050ab5313515a5e4e73025c0a9e0f2af.1794333957.git.edumucelli@gmail.com>
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

