Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745405;
	b=evPXPsz9yO3ZAxRE5zeneb8Y5lIJE3hk9Pt8CHbUW3F0IwrAVpYq8gbiBP5yoWCi2E91
	 loI8OFI7dzXarOIWGbf1/2kLDIS8K4Lfo+KWwinmHb7d4AuVZpa8qdOgHJJhox4cgmf0r
	 L/lB8ZsccSyNZDc3ogAaP0erSnOocGAIldxPdy7CK2mqqE+MuZqt85ASlIuSqc02xw7Z3
	 FnI9kG3L5i1sKidsIwBvIQyr73LByHzZUnhVcUemoPtr/CiQ8ru0pR1Y/dhRvjKOqNcb0
	 P01j+e/POUDX48efA28SfsPhUUvl92gg41m5+30Qr/BVKndk34ewP4gdy0nNH07lQ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4IKreVLwvzkycx/+a2vJ4WN6jd/0jq52BOWptHfX8BY=;
	b=eMmwyHyx/dfQwZM+QS5IgeJevFGIz6cVBDZlp9V0K0xUZ6FT/qYq0J0+zEP3EvDbXsRE
	 CH6xed4rz9Ux7vivYNwq2AwnO8rDmUp80iQnBlqEtPDk6zSYssXLvWLhKD/D07o/C0Ii8
	 +Tz2BZH5B4AaytuQUUrNqK6WKdj5XQD8iEM6+5OGgBBuaneD3HmEpM8PnMkQOeT4VGCaC
	 gfzjSm4e65mcee5e2/u1ocIH3SbsJvebbdfNfiaXUsyesUBToMp0Yo0fQ8a7oUUG7+LzR
	 ZVyYNSdh7uIQHFJZH72/+UGO8YNYmAvsWR24uu5D4WYcvelDCHJ8XNWnuxBcZC3NB3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zmua24I1;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405B606A31B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 08:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B405B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zmua24I1
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a20b122af8so5119255e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 01:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792745403; x=1793350203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4IKreVLwvzkycx/+a2vJ4WN6jd/0jq52BOWptHfX8BY=;
        b=Zmua24I1C61D5bHy7WsKoUzM57sQhaspfWR8TCfoLIJPXdT02lyt8tEMM3iDpe2QaP
         zOe8uTgLacHji1pZ5q7c2FULURO9xhO+rlR3ZX8bT5sHLcXuTIas8XTia4HVgRmn32Pn
         aukqB03YSmFwE7MwmM2MCnjy/VYTlUH5io8myHLpFy8QvDVHfLJs0lopj1A5z7Pc5qCz
         qugPebQd+wP7YV5x/80X1Yq8GlZzTmXhEtBrLseEHc2Go/XlUrLSUaIS7e9WkpY8CoQm
         k+DNdo/X6n7nJdhONpqlyV+L9PS7foBa1aSB3tDSj1S4VvmBzB0skW+gEb9ylc0cYTHp
         x7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792745403; x=1793350203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4IKreVLwvzkycx/+a2vJ4WN6jd/0jq52BOWptHfX8BY=;
        b=caWMnf0bAYSkEtIHlWToracowXQCMfL9IK+SDjfTqAOqmBb3d8hMhmc/KGFYa2wdJM
         ZY0zwQpjVloKmHjIqa0Xu1rwOBrTidJI+BFd9WbJdCjY5kXr6Xuww+Up/NUizevHCjms
         EVqHDa/bORZVyE/D/eQ6IVwP2CxC7PYarfLdpp8h7lnxHstHlBq63+JwSIj6mb3Y/X1c
         FOroWt6k1u+zeDjT/hUiRip684CFZ42NxLmn3hTXxx8pfcwxIM0CwUhHPFOplWzPdeGa
         iUJCvEWjkWwqEqruB/NnsY4zIodhOPgr4Vn8InJxqE1vaIfrqB4RBi5WTsmslNDDAGPy
         Oqrg==
X-Forwarded-Encrypted: i=1; AKwUvBwpE8m1EQLc0GmZc9oBrkoepTc2EtQJIrg+MBTS3QYUKymZl4Xa0O9yHVAGdIfgtbQAr0jPjq1m5mNgtRK+nlFz+yE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKR4VhQPNy3yRcFek5UcXRgiEb8NfFyr6Hi1IyEyT3EvwbsAumf
	+hZA69ufJ8Ujk3pIx7uAJWCvBoixt3t3nvmR+wmov1VbsM83uWwGqzm/
X-Gm-Gg: AYBFou0hewn+ENFK+WOiel/Ry5vq2qRdB0jhWqds/YXm/bQnu6ed7FnJDA/+ifAGCCJ
	VarsPK4YjH6MvHFehQsAlsRIF/zviKOj2Ke62Lq8FMS6Ua+knCGYla2NLvd2nYBDbxMJ1plbql4
	A8W2tTEIt9kJJYPrAy4gIuj2pwbv35fCJFe/F0JevzetY4V/4mLIvxd3XYwSFiYxkeuMVelJvtr
	iJ7jbDLrMoMjM6vrhDQCsIrkBSaQ5FV05heRRlrb2+0huJ3KoVz563agEV/2nGSzL6JFD4j5giI
	I58XkjaJVBTguxI9BzgDctoZysxDG4t09I8NbusbTIO/MOYDyyJNIIW/5Y30PuiIInpf81Q7klL
	hitwk/erQkvWvaiSI3ez+09/+EueTxzAIic+XJvvBxHd4sDHGG+DeEGsW5BvVpA/pr7vdLmyBF3
	oW1NoRsCew5iU/pK+77Ie2ygVf4tBuxs8HlWt7K+VAX/lkEoF0IbOnhYZCWrF1yX9MVQt2ptpGF
	fhIMMz5mc89QHoOx+K/huHsNT14rFoWRmV8w3h0pC9Ye3QBz2T6A7mGLKKhvFBRhpgMqXiXjFaH
	ib9ScLthUj2ly4rRZNZEeO7UmDao0JG5d+XpT0s3kL8zg76fbuWxeP9HokOxlxZ1JjMKbKdXlR5
	O9VnBgzUrIL8bMDkAFidn5VXrMxjKYu1xt/7j8npjKOOcY5/ZgNWgXv+1AfxnT3ehBafYymlTfs
	JAWWBg5FZJ
X-Received: by 2002:a05:600c:5394:b0:4a1:f7f4:7cf2 with SMTP id 5b1f17b1804b1-4a211ef97cemr22798745e9.17.1792745402825;
        Fri, 23 Oct 2026 01:50:02 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-1eca-2717-bf6d-b62d.rev.sfr.net. [2a02:8434:fda5:4201:1eca:2717:bf6d:b62d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21034d740sm65356115e9.4.2026.10.23.01.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:50:02 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/bootconfig: Preserve event trigger filters in ftrace2bconf.sh
Date: Fri, 23 Oct 2026 10:49:46 +0200
Message-ID: <20261023084947.3264289-1-edumucelli@gmail.com>
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

ftrace2bconf.sh reads each trigger line into "action active", keeping
only its first whitespace-separated word. For example, a histogram with
"if common_pid > 0" is exported without its filter. Reapplying that
configuration installs an unconditional histogram instead.

Read the whole trigger line and remove only the trailing histogram state
marker. Quote the resulting action so that whitespace in a filter is
preserved in the exported configuration.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
Hi Masami,

This is my third submission to the kernel. Feedback is welcome.

I tested this in a temporary tracefs instance on my Ubuntu machine,
running kernel 7.0.0-38-generic, with recording disabled. I installed
histograms with "if common_pid > 0" and 'if comm == "a b"', exported
them, then restored that instance's actions with bconf2ftrace.sh --apply.
The original exporter lost both filters. With this patch, both were
restored correctly. An unfiltered histogram worked in both cases.

Thanks,
Eduardo

 tools/bootconfig/scripts/ftrace2bconf.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index f8f288f90c..0a066094f5 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -115,8 +115,10 @@ per_event_options() { # event-dir
 		done
 		DEFINED_VARS="$DEFINED_VARS "`defined_vars $evdir`
 	fi
-	grep -v "^#" $evdir/trigger | while read action active; do
-		emit_kv $PREFIX.event.$group.$event.actions += \'$action\'
+	grep -v "^#" $evdir/trigger |
+		sed 's/ \[\(active\|paused\)\]$//' |
+		while IFS= read -r action; do
+		emit_kv $PREFIX.event.$group.$event.actions += "'$action'"
 	done
 
 	if [ $GROUP_ENABLED -eq 0 ] && event_is_enabled $evdir/enable; then

base-commit: 22ab3094befd6ef37135e4a252c0da9cd755f75a
-- 
2.53.0

