Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042998;
	b=3rdKEw7l262CpJdd0WSOUGcB6mFEWB/xOiw8H3zHRCk95Qr606vTFsf42+z3b05n2ok5
	 1qlBp4uEgHVgO+j+tsERAbqjETqCPVLRelmK7sMTxAy6d+GkEYHC6hpCUrwZrn9Np8tal
	 9zJvyeX+pd7fkK5cS5mr872pTcxvh8Yame3Z0o0GXhgMavOBuIKRNjzx0RurRUU7l/YjY
	 3VXPTOxhRnpB4CTaR6af/yFYCzg+K0wPttZDzDg1znRIagy71+dBLGMcQ+TBwBOjuMAvx
	 vJE2sc3aVyrur+wYpY3Pyxi6hXg/09hS2j5tJiyFLVoTS2odhCVcmKXQcl4A6FdeuUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0bFUqWyrVVHgbbYm8tQjpF1HSKbOC7uPXofdWERkqu4=;
	b=plQe8bqJUoIfsH+DkzTNVvq0meqgW9JUJid9yA5TIsc9jPcz8xjNxI7HIwrZPicJuH30
	 eWqtrANH0UY0eqNS+05dFsf+qyW7ifE1dMPFxNf7cZ6jBoGYWQXnM/eRjyUb/zi260I28
	 +q6fjCzNlugFhB1KKQ0ZoNqRcISWmhA/7Fl+93/cNNrPM3LWrh+/4JJ676tzp2B5cRNk1
	 ag8SWYCMQ9329AbUnp02G/vEGLipI2o3t43oWR+iVNL7S2Q4Knvc37976NoYl8nsfgWy4
	 +BAvmmAnxvHhZztMJbS3iu+NrWds3QZJefg7Cv2o3+JO/gYgjDHpEE4G9vnj/RLxsew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dh2cFrtF;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C82606A32A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 23:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C82606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dh2cFrtF
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so12021415e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 15:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795042996; x=1795647796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0bFUqWyrVVHgbbYm8tQjpF1HSKbOC7uPXofdWERkqu4=;
        b=Dh2cFrtFAJzh0Wq1ncHebviOUJHAQJ89+8ZQCMqAC3DD8exD152tT5fOtJOzrNDJwa
         2KDIIr7kkV5rJq32/9Ssw9kB78CuFudEHS5CmnH81c7+CM6QVr8cA3CDL1MGU5AZSsHu
         +wPGEG1q1h8HoUwsFxGnP9tym94YLbJkCjMycbre0b5vcPJr5CWFqI0fZ2zq6DSEsmQq
         PqxCS90k0aOgoDhvRuLf3Xvcsn32iRR/K2Bd5ZkyosPKLsOaVr4GbrgIebuYBiW5o1KM
         JbJn4eAUXepRbTXj13hG1dEiCzjfU10ojfXY6bJqfhoe78308M/rLL4fGG2le4Scosq0
         Gecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795042996; x=1795647796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0bFUqWyrVVHgbbYm8tQjpF1HSKbOC7uPXofdWERkqu4=;
        b=lcrHXpsA8Uj7B5e/VZoVQzgBYuVFjORkzeJyBJhnz/51mbUM3hW/pi1/8E+hZCTlME
         G7wmxf+gj08aBGbFAYfptAdo+9IKDnACZYmGXQEM172KM5isT0Uzb1I4sKFdhoij4oYW
         XLejEA0MVqDORdPZWVslIaR2CF/I4daFqA5PjBtRwijrAVf6OqPCJJV4xkFXfdlR//5k
         v+ZheBMM+iUsOJIcpfQjEGV90yBfWo5yFp6xZoXxP/56mMq0NO43EP90Ir/YzLN89b1h
         AuJf2vWoKUERiCsVeVfwEiwnG0fAFD/dYeF8PqrrcbKRgpU8i1hu+GPZeYoA7Fy2L0jK
         0SwA==
X-Forwarded-Encrypted: i=1; AL+hErGoFdP5XH16gjr1SNG+HLQr3t+VTpJIwH1yJOqHT8q7btJUtG/P5Vc8zmBr9IgvRSaq6s3+4/UHTtjbMKc7BELoobE=@vger.kernel.org
X-Gm-Message-State: APuU4Z95aObKqPP7ydDHmob3cYG+tBR+6YVX+qjmnBL56Te49hB9j0x/
	NuB3LGgCM8SW9HsxerpBexmbhPiUSeoUMsaFXlkf6AXE59Zb18Ika6xqEjFy+tvS
X-Gm-Gg: AYBFou0tlC7PQvAonnP1l/vdYUmmEPNSGamK5rLfGbzeveTKe7E5OEWKHz56LtYaoab
	Oq2Mn/ZB7MXg/SEMgdvryiL7asNlotO8JNU8I61udA6ZQ2hxNhmDjIBYHmCMrf5i3WNC61e5Nkq
	/MIUkcrvK6rcHMTu2pcB+5Z6nESkPE6FJ29/vpsqkVSZ5kUbgjIKQdOafXq/On25uGoPpDY3JnV
	SlYLm6ddAQ9nhgTH8Hve2K+UkrAYj0HH1WiFb15pFdYl5xWquVb1luXl94XofmTm+Z1cKeii9NY
	uGXCA9MCErxCS/+US0uwUcjSjdAFKP1s8q/RvS0h+G23kSCTV8+zBLSH6qEzFUcoQAqdpCbCwPL
	tlhbEMNZOWYUfjXHpfZPC45Mq1RpXFEOHiZD9QXoo5P5gtu6vnThoh/q9FDe5pHhd5/z6/dtKkO
	l+mu5eXQRQDXGKGsA3g5AAUs1D+7bo3rxLzo11N4uV1DjEd6X8biSoi1WsZmMpLc05xaF71WEe8
	GPbHsTVuMFu2ukpVTkcYXeea808MA9tAaeeVhDGmakCprO4EEJRG/oFwF6kOxUPWOfuuDNX3IxM
	TkWuIlHyoeezt4hS4U5ixi02zMwMoxYGjJP+ammxf+IjUI1oyhdb5xDlJwqdjKt4rU4BCTV1gcI
	jdwaQewXYRRFMQCHfU4efyZK6p81xqoV8sEfOK0rtsuLweD6ETVt87dSboMllWj6hTQ/ILBdtsd
	Bx1/1iT5T/tqT85evfJU3akXeEnvSaZbT4UFqHy8ECZH87gSLLk+UH9lYGvv+LMypKxFH0Cbirt
	360elSV3iScb0WH
X-Received: by 2002:a05:600c:c167:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4bb7da390b9mr78174065e9.25.1795042995856;
        Wed, 18 Nov 2026 15:03:15 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-b3f2-1adc-a486-075f.rev.sfr.net. [2a02:8434:fda5:4201:b3f2:1adc:a486:75f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb842f0941sm5232915e9.6.2026.11.18.15.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 15:03:15 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/bootconfig: Preserve structured histogram filter strings
Date: Thu, 19 Nov 2026 00:02:52 +0100
Message-ID: <1218ce4d98a4c6ab6df6279c34d973b9d033755e.1795042969.git.edumucelli@gmail.com>
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

print_one_histogram() expands the hist.filter value through an unquoted
command substitution. Field splitting collapses repeated whitespace in
quoted filter strings, and pathname expansion replaces literal wildcard
characters with filenames. The generated command is already incorrect
before run_cmd() evaluates it.

Print the filter with printf and a quoted command substitution so that
structured histogram filters reach the generated command unchanged.

Fixes: f134ebb28126 ("tools/bootconfig: Add histogram syntax support to bconf2ftrace.sh")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
Hi Masami,

Thanks for picking up the run_cmd() quoting fix. I had this small
follow-up ready in case that patch went in.

Here's the thread for that patch.
https://lore.kernel.org/all/97454eceb5d56bf956740b8998972767bcfe6c70.1793216183.git.edumucelli@gmail.com/

This uses the structured hist.filter option documented here:
https://docs.kernel.org/trace/boottime-trace.html#ftrace-histogram-options

I tested numbered and unnumbered histograms in a temporary tracefs
instance on my Ubuntu machine, running kernel 7.0.0-38-generic. Repeated
spaces and tabs were collapsed, and a wildcard expanded to filenames.
With the fix, the generated and installed filters matched the input.

The run_cmd() quoting fix was present in both versions of this test.
This additional change fixes the string while the histogram command is
being generated, before it reaches run_cmd().

Feedback is welcome.

Thanks,
Eduardo

 tools/bootconfig/scripts/bconf2ftrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index 6a3535a2c..0992e54c6 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -163,7 +163,7 @@ print_one_histogram() { # prefix
 	print_hist_actions ${1} "onmatch" "event"
 
 	if xbc_has_key "${1}.filter"; then
-		echo -n " if "`xbc_get_val ${1}.filter`
+		printf ' if %s' "$(xbc_get_val ${1}.filter)"
 	fi
 }
 

base-commit: 0ad31c3252d4c626a93ae6251340ef86b18342d0
-- 
2.53.0

