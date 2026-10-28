Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216227;
	b=I4XyWbUT1X2LiVBMg9YtfLeh/G6RN3fPTGYtLSUMrPtwZu/6wVsFFVBebN7haUyq3RI7
	 DYcjCqpP7sSRNMuN6oSlbOX96QyUW7pab/KqGTRFwp3gYr7DUM6KSviIExmBadXsb8quj
	 nVmd7Dz+Us7wHx9WS+DBGWE/Qf1E+a867cqLpfFKtEMkinduMDLEh0D85WxPW4LCz1c1v
	 nCMgEAJu9qr4R+vgggMW+5tmSJd0mueYtBRf/ZQGnJmG7riVWsia6KBY5GE3pnhjYOs+m
	 cydfUGO9Zp9Uk5MTlvu1Yrl6ytUS2EK828UyLjqpgaVOxK1heYuR9IyxCXQOZv223mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2yS6B1fdODzUh4XgV3Cebo3LhVzp5X0snjiUXq/0jiU=;
	b=lU4WZwrJCKBVB7Zc8+iKVvkmW99FYkz9iJBW3fbEtDvsw0lRMS685FCcvDMEavnw4/Rn
	 YUK8s7PzMdcirPB0WcJdz5od0vAJ4r2h10yStMWE7T/cKt+PA7joKR9TAfGUS1etDn671
	 eV3TeBFlyK8pbtNsYZ0W0EOc25HIn6JoVFGlXTO1lJp/PaDpoUU5oThua9xq4BzWkXy+y
	 OytiAfXTdx2SMIayVsGN+jBhO29IDlbXWb+GGkDuiZF6wOutciymHtfp0MTkP0HiqDI23
	 WtY+o81xKNjmhUC0QmyzebOt9I0mMEyfXuDaWiZw7fZuCaSC5M/3q4K1IOR9mzzqaHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kUTQlOEa;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEEA60A2600
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 19:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CEEA60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kUTQlOEa
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1055619f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793216225; x=1793821025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2yS6B1fdODzUh4XgV3Cebo3LhVzp5X0snjiUXq/0jiU=;
        b=kUTQlOEaEk4kKhvJEXcdd8ICHwy9lwjwxfP+jr0bFV9BQmeknLAEhDf/8mfHtqmy2r
         DsykJtGs9CyKxc77xokx9OZQXDgQIf23IM6rGMadOb1W7uqhF6ptzScJCZNQTGZDc+dn
         syHiN3JyCIq7lApRCP1A64puUwwsAZL3wu0bBJe7XdoVSv4GBT133LQ2eSpJy5/CPs97
         /BDrW2oGQE0MORQnqMOIY+zWb5n/lD6bSAG46kb0DBH9CmAMRGltBg1XfW/7yivMClub
         TOrpK079S79OgF6g0rlOA9nT81DTHaPniu5KlqkwxTW+r0M7CH+p7VM24yhxmUDwGTvq
         8txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793216225; x=1793821025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2yS6B1fdODzUh4XgV3Cebo3LhVzp5X0snjiUXq/0jiU=;
        b=PhhhenaU1xbpf4z5zNxFnMNxiHlt2JG8hUE5J/vO/9ZGn3+dvU6BYacU4pNUn+GC7t
         ntSJALY4SdqJQf3eXQZWaDVrR7QNB5QEsIm4rdxrivBUoo6aPDwH16/LX69QoJ029cKw
         UAaRnTBkFB15QnyS+d8oB8CsWO2fzrGJHpIV1FngnVrxa7eTfZ08t1Fgb9mNL8whjiLy
         wrUaDPTBct1ifVZdLcRhp6Q5Yz0oQHZeUI50t9ZrVEf6/yPm++gYn1FZWOqmWXQNkiCl
         gtJry/ZTG6Pb4KAlsO6+zIDejwvWnzpqXf017ugOhVgXJcjTcgJHh5OCLaqaZXwK8OKl
         Uihw==
X-Forwarded-Encrypted: i=1; AKwUvBzv6eiZ+mvYRwsLx3JM3yZyUueSbvEyHa8yrfr/UC+N5Lm4JeFtNZeJN0mTIIXyJJhNSYn8pczHNIJT81p8/muJYxo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/GUwst0xxhmDVPw+1hWlWswJxdzX/0JsUMlE6wo84PNnh8tpS
	u8VPxKXngcg3TekQGSuJIJ9rd8vdDUJ+1snFaGBWAmy/Dyimrfj38njDbosB7peVeVo=
X-Gm-Gg: AYBFou2KapbMIsFPG9G2bchi+BzRhQFP74T9/i/hIo01HW+qC8Wf+LxqDsBvUFKgIYI
	vfZIJFhl9c5bJHbo/qmXB8EyVlGAYD34PMAB6B+GAAxGAgss2MAw3EX+OasYR1I+v4UF2nFowNl
	dXZdUKjxOlmS5KEIlvuwqRQJQMJwkldqX/Rd7DuYokUZ6KmmoYs6ej4aMki5M2A3bWlHsR2EWHB
	Jo41ZQd1z8/LnnrOro7F0vmOtniOXVmJgAV2wZ4uZmU0FzLONf18VERl3EQ9oreUoH20DxX6SoI
	T/4AVyiZZaiZ/x6aO8C3Ch3LXoKb5IyP/2tw1Ri32AdUP34t1Xm6f61iOB1JhCtfro9UjwwI54p
	HOZXQhKRqHAMPEQ2kduGvz/x8hFbOy92MlUH5iIFgs3CwiBwItbxrjKm0mI0Ho17OsXwvp1IQXk
	gQjfnAGCg95n/iwuPTyQ3PgdjxYPkC3mARPWepoD14G+5OJFPD6lXZQ7jiI5SNN3RHpKYFcDOcx
	jF8xxpbjNSfLm9UgGDId1ku8PVGljqWtmJNK7ZyGrp8P5BzZlle+XneE83vR91WP7bGSWuNZ61K
	lw1Y0jW7aAWBG5ovxlc8Hf/xoquqHJS5GUV37qRjaNk018IXa7PKM1h4uz3ermrYJN2qV2HiFDH
	tLjcDBWt3HqT6iPc01OKn7n80p9TsEwpAkR/wY+qckmRCsYimt/aSbIjglFifdBvvIpxWd3dJA9
	4Ms4wpbBnXdCR3UMa7sRypbFxhGzNVUOKrQP0GyFJbXwbDfXbLtD+DayJNoA==
X-Received: by 2002:a5d:5f52:0:b0:48c:4658:602b with SMTP id ffacd0b85a97d-48e5d2e7375mr8599298f8f.10.1793216225566;
        Wed, 28 Oct 2026 12:37:05 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-3fca-2040-fad6-74df.rev.sfr.net. [2a02:8434:fda5:4201:3fca:2040:fad6:74df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3418sm27004611f8f.41.2026.10.28.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:37:05 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools/bootconfig: Quote command strings when applying ftrace settings
Date: Wed, 28 Oct 2026 20:36:24 +0100
Message-ID: <97454eceb5d56bf956740b8998972767bcfe6c70.1793216183.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793216183.git.edumucelli@gmail.com>
References: <cover.1793216183.git.edumucelli@gmail.com>
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

run_cmd() passes its command string to eval using an unquoted $*. The
shell performs field splitting and pathname expansion before eval can
parse the quotes in that string.

For example, an event filter prev_comm == "a  b" is applied as
prev_comm == "a b". A literal "*" surrounded by spaces inside a filter
can also expand to filenames in the current directory. The printed
command still contains the intended string, so --apply changes the
settings even though the preview looks correct.

Quote "$*" when passing it to eval to preserve the command string. This
fixes both per-event filters and histogram actions.

Fixes: 7e66ef0046cc ("tools/bootconfig: Add a script to generate ftrace shell-command from bootconfig")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested this with hand-written configs in a temporary tracefs instance
on my Ubuntu machine, running kernel 7.0.0-38-generic, with recording
disabled. I checked both event filters and histogram action filters.
The original helper collapsed repeated spaces and expanded a literal *
into filenames. With the fix, the strings were preserved. Ordinary
string and numeric filters worked in both versions.

 tools/bootconfig/scripts/bconf2ftrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index 7745c97e7abd..ea7b17d0d4d7 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -41,7 +41,7 @@ fi
 run_cmd() { # command
 	echo "$*"
 	if [ x"$APPLY" != x ]; then # apply command
-		eval $*
+		eval "$*"
 	fi
 }
 
-- 
2.53.0

