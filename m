Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471752;
	b=mTK/rNI+8Bgpyua4ht96LU8HWCq/uGBtjVVrmz136j+FvTvs4mxGMeWkNH+QE5KnxIbF
	 S6rpSBi3U8PHa2Di6uyZ0XY2agx0JSRG0ZWVC8feY1Z1AJCPXOSUvrfu9keS7BRgg9jFU
	 mDEjz6OptxmXF3Ma4igFeol5VtijGKcpzGYIqqFt+5d9lvseLUAZ/wQTw87vj4EdQUh4i
	 +NXU8oJS72t8j4mnFQsXUtsMS0nl1ksfM2IT+p/S0q3lG3+/nrTirvvx83fmJQWUtZSht
	 mQhNwVsc1gR+1C/TQ03uIzbDHdRCPtLS2cMWertdAk1RHXEkiEcpfIDa5dBgoP9UqXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JAt4SPXJ+lKuay4IHak8A5/kcoQw3e1/rqWqojGsCrw=;
	b=PKJWbnWqlYDgim2Lfy8dIbZTVJYjrrMukKdhJItrzUdyZs1DLDiEuO5z8XzNJzGIfDfk
	 bnJr9wtUpmPTyocaqQ4uFhwuRKzJbA6IDfYM0wcFeeORJ8Eciflo1Zdo8NwKHqlk1LAQ1
	 lukd/UQEomAuNb3FO21vVKVja2XOn3xlKQInDP51Ii0T6hNR+Xd2PYCIkBgrJ54eDYisT
	 t9+ZJEzdMe3yJ7Lqo/+irqklD+WNr6zW4ubjo9uUTmsLz5NptZ0ovxCXG9GYWRSIhS6PB
	 Adtq8XZKKJZ9cP8REHEtzcFmgli//1t3uWhV17wdEk+JmjrMrX32yS6cfy2TFGIEQVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jeqcFHv1;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB2606A31F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 18:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7FB2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jeqcFHv1
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so10141005e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 11:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793471750; x=1794076550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JAt4SPXJ+lKuay4IHak8A5/kcoQw3e1/rqWqojGsCrw=;
        b=jeqcFHv1r8xRToqNdx1IV/wfpY0Y6MP2B854gUElWGldGwiAM7WfH21ScCepG1JPsn
         SkKcPCSpJi9ZjOLAkcMzx5RCoVEZojxk5NyrqaCr/wUHh6uXra2QF10x3cBcKNAxpSpc
         a6ZNhjmTqqTqM4sB6s9DZQD0KL+0ghG8btd5gtvf/rbdHk3NP3byIObwHYf58M2IXEW8
         DOQy463BGS40G33xa0pfWAud1RUa9XGHWtIugN/MiiItmgBIJNj9Pw6ifJ18RZEC0O4u
         UZkfAnO15aYDJHjKN3FkUPFSAOqWiFhDYMpfIdebusbeEfZVKUY4zwjfWFTLRiru5SDe
         /Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793471750; x=1794076550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JAt4SPXJ+lKuay4IHak8A5/kcoQw3e1/rqWqojGsCrw=;
        b=QZR83zISN6KHhteMWiZvtsDmOzsk892GTYJw9Kvsgh++EpUbVeiAJl8PGfKR2enOwa
         4QzZJtTmtBwGy0va3asDx3CfpLlwHmPuq17miZqt8QctAjNvh4+zNOADv7fDnFuh3bUn
         AARXDc0ushzb4KNyRX0sdcXezRSmeOks/HNswmVhYioDbyY8TvKHwN/ZgPzW6tzqlcUJ
         vqbyPlUf5vpiiCED0+46PmkBHGUHypbL1dOkYXoljVZc/MEwgS3g+DCPXZ/C3FIr6P5B
         omdzHKVIYmomi8lKoGMjShE4qEdpxECATmAKPHLzLrqYG6ekgUZILAhr+reiq4kVmqgF
         aEWg==
X-Forwarded-Encrypted: i=1; AKwUvBypuILYjAiqIG2uzR5qXmzDnCxuy/ZEcCqjt5+7wFofX75yrFR1ECL5ksfATcWnVHiiNonIpurELD5hSfXLwJhFuq4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTbxmxKWtkYiXud8dUvj44A7isIs7m0TEJ0snJ4f0V+X9ZoDtb
	aPTZPrWxiBZlCEGIAg5ip7MHdZchLUCacLA/1pw02+N08JZBt2UvmhIP
X-Gm-Gg: AYBFou0mp9gyQnVA9JPcFG765/flY3rsDUIEllHJ7qdTqNwIfSfHXVpOoxYaRSTAoWA
	+/T2HiLi6HbaPcanBgM7SL53kuRAVf+DvjgpGkHyBvstOFa1i8NdEfOIi3IFNjX/asYsnf7YGXj
	dpO6wWVo/mUNg6b5HRWRny1TDIFkwYHJ/fnN/acKRuNGCzgkWFUlF/mZ419uRDWERcQIJf0H7ta
	xthZsT30nKdueeRaMXderDxHK8Kc0jTYoaqy+NoexrEYNXJ66rEF9QyL43oiHBu31xD2Qf1cw3u
	vPTdxAeQ0P9+6h7KgWEejDEuerjNQADBrNMuDQzHSi+mvbZaQNW5r4ikv+FeowvVskLbYkm/pVx
	vt+aOJP0O+ryuCKwlO1EtLvPQm/ZXP/1YWufCEmDilfj/A8Ha3LcsECUzD9xdOrxZONh/F0Ovw2
	a7avxz82dythBzgrvlxfo0cukMzUx1e40hucX3xxoHmGb/5OXSnA+pQGf4qURSJyD4Ojp545Wgg
	Nz+bTCF4avKnjHkgdOjucYQjFCht+2l5XK8KHV/W8CB3+dIudu13iEKyHSOIkXEVyCM4qxLUu1v
	mdhJl83ST/3ocNOAH6PrTVajgABHudeGr3CcfDF361hCtWJrlZSVq4BnwOfEp7ht2teKQKkuxvN
	7fxJPt2m166pqDNd3yHRF17MF5IiQSXAbz5wFWPvM4nUSjaKi3/xEKteAUvcxSJDH9FbJpy0Ot9
	8TC2QIuCiTgLsMUpB/+zSAYPCVba5hWII4ooKnVUIWzwfF7+Q1Ob4XdhBjodLgzUHT4QHHzwRcK
	kj4W9BoUkTdoGL1
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4ac1970b9f7mr135013365e9.34.1793471750166;
        Sat, 31 Oct 2026 11:35:50 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-0247-bf06-1f38-d09d.rev.sfr.net. [2a02:8434:fda5:4201:247:bf06:1f38:d09d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm219745075e9.1.2026.10.31.11.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:35:49 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] tools/bootconfig: Preserve quotes in exported event actions
Date: Sat, 31 Oct 2026 19:35:31 +0100
Message-ID: <001ad0e960ea349b3a5de670944c28853224c0ec.1793471731.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793471731.git.edumucelli@gmail.com>
References: <cover.1793471731.git.edumucelli@gmail.com>
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

Reading complete trigger lines preserves filters that can contain single
quotes. Enclosing every action in single bootconfig quotes then produces
invalid output for a valid trigger such as traceoff if prev_comm == 'abc'.

Use double quotes for actions containing only single quotes. Actions with
both quote types can be emitted without enclosing quotes when they have
no bootconfig delimiters. Warn and skip unrepresentable actions containing
both quote types and delimiters, following the event-filter handling.

Fixes: 6a5740440c47 ("tools/bootconfig: Preserve event trigger filters in ftrace2bconf.sh")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I reproduced this with valid traceoff triggers using single-quoted
filters in a temporary tracefs instance on my Ubuntu machine, running
kernel 7.0.0-38-generic, with recording disabled.

The original export failed bootconfig parsing. With the fix, supported
single-quoted actions parsed and their decoded commands could be
restored unchanged to tracefs. Unrepresentable mixed-quote actions
produced a warning and were skipped. Mixed quotes without delimiters
and ordinary double-quoted filters were checked as well.

 tools/bootconfig/scripts/ftrace2bconf.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 31702be0c68d..77ec17c94a17 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -126,7 +126,22 @@ per_event_options() { # event-dir
 		*:count=*)
 			action="${action_cmd%:count=*}:${action_cmd##*:count=}$action_rest";;
 		esac
-		emit_kv $PREFIX.event.$group.$event.actions += "'$action'"
+		case "$action" in
+		*\'*)
+			case "$action" in
+			*\"*)
+				case "$action" in
+				*[,\;\#\}]*)
+					cat 1>&2 << EOF
+# WARN: $PREFIX.event.$group.$event.actions cannot be quoted for bootconfig. Skip it.
+EOF
+					continue;;
+				esac;;
+			*) action="\"$action\"";;
+			esac;;
+		*) action="'$action'";;
+		esac
+		emit_kv $PREFIX.event.$group.$event.actions += "$action"
 	done
 
 	if [ $GROUP_ENABLED -eq 0 ] && event_is_enabled $evdir/enable; then
-- 
2.53.0

