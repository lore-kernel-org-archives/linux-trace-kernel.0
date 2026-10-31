Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442353;
	b=doMM5MipzMDwhHFjYqink3TlJAEblpeIYmnGVfMOEVEP0iKfjsiP+Iyf3FDN4hQHufvo
	 NaY2Tjt166i4jhlDDwFkcZZAhlSvJkCk27vDeu8hn7Yvbgx4U4UAd+cvMxF98Yz5XMrMR
	 rNYUsQIrvXMIILcccN/FaMQ6VTUR3Kz+ixPzlg4Cuab4Q5+PCroh1cO+bzfbuQPrFDK/J
	 8ppd5GiNdijPcRfTOig6Ct/vUkm6TDkgEZ+EJ6md3PAvzBLwHypDr2ZP3nQ7DcPfTbJfC
	 woa1ozKhDY0FYdqBgECqSO9A2koY66hcUDZLT2UJUBooAvEnT3WtGdk4wNsJCFOiyYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xC1Pndi3QD2rxB4U2UtHXjrmrtX3tvt+J7O1Ci09mUk=;
	b=fny/SF+GFMUlqLEBNK49JuYQC8dCfoRrboPw/Gx2vPSwKuHYssIspxunya4HVHBvOen6
	 b0apuY8pcRfknzBi7hsEc6/5nM/IOZfnZgvy6V5U8UGhI8pDHguvrSjx78GSlNsN1sGA7
	 1N7QxnYw5nKxVBGpV6l/n1a9oL9nKblCDwv8kVLAdFdkqVBewKKlW0kClyG9bVxSsZDPx
	 Knl1bLy1+Fmpa+1CRPYEUE7EaK+Q6+1rA2i04vmrRT9bJ/kwVh68BZOXY/WZeKDr5SMgG
	 2E28/S8a8mTpyqu2shDclJ1knu0LaIUqpjDW7bLcKQafZQ3PqEgrhn2LFEza4tEx8rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gsg3ejiv;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35BD606A329
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 10:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F35BD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gsg3ejiv
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so17081595e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442351; x=1794047151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xC1Pndi3QD2rxB4U2UtHXjrmrtX3tvt+J7O1Ci09mUk=;
        b=gsg3ejivSyTLdtK2LZzOiX4TodC/JqnFJyPLqdVQY34L03IF+PP3tZRZq7WmuI2b2I
         LTJU7jZ7HANyXrlIdNuqS2rwNx6ft5v9eA2X1csioEiDJo/rnSCT/dh7kWcj3o25lYCl
         mn7YvEqPsV5D+8MxZubYUglTqpwCZBMSkqmJc49jnmxOuwh8pSQmMNW+fSE7zW11VxmT
         7lS2RkqKzgt+amJu1VUbxjPmLXpdrVyZlAJNLnhltbjrNDi0XMR9ApbSxAzXgJXx5I7N
         8cHNoSMTrjI42t/7xfNqarEMvRt5XmxgAGg+R5UfjXohmEKo6r8k/rapktZy4LHCbEqK
         KZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442351; x=1794047151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xC1Pndi3QD2rxB4U2UtHXjrmrtX3tvt+J7O1Ci09mUk=;
        b=dpCnbMoe57QK+H4AoNTJs902gxKofHky+LTeiFdFw/mnqCCvaTn3bHLrNO0pQ2ADnn
         iqkWOUnDTvz4FtebLVG7hoJ00iZOB4v3WVrEvXdKNGnIiIVHumd1mljeydXOFXlzjUTr
         99XkeKRUOY06yXL1x3/OdHsJlCOqoHkIWKdpKX2UPKoUrlir7Oq6oq09+x9PY30KSTU6
         fQ7VUiD10WuIqPUlAa0UWs+D48X5wXg0hIRxjwFJyo6zHrczwxejQyzK15h6s0VJHRaS
         L4yy344Yv+fTwZVPOsib6JiRfmRJJ6dMeu2XnURjpipopYLZsH+Q+uSAGyx8ScgH8+2S
         a9ng==
X-Forwarded-Encrypted: i=1; AKwUvBw59CeBVvfKrAE5eKTsBTlYSdO8YY0+pqJd8GQUF4xX4y+uCF88/EakSUsJDFMZnWohj7kkZ0DjFRlzWJANKcq6UMU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLw2Zg0gF3UM8mqaXVW9GRyQ3NaaIAe9QnaPzgOca/zAJoDll8r
	pBDNZniZUJTdktEGxY89k304Hkob0Fc3VSngPFl9G0kYy9Kj4MMgBECy4s3voqvaU9addw==
X-Gm-Gg: AYBFou0suM+Bv9ZZvn6wP1pHOSm13uTw+h1VuyB4VYCkkFtqffaGYyDyh1+y3WZfrJM
	zDIK+03vr0VFbGm1H5lFrSt3YkZOZyFaF/YXj3rWy0FGVSrLMw94z8ZkmZ2uddYEkyPzQPhLxHQ
	2fTCRImV1PnWcAxv0GY1whLnpHgqqOcOJ47HjjQi56wAXd0x+aYHvPEcfkYu5dUryOlqDHrleZD
	K2hOhxoszCcTHBrkqHAQfuhjgQF9R1eEuabqcvh7pGGj+3AgsfxzxYn5S56XmWoZk5KsX1juKeB
	Zt6k/ldLZn8U+qVQDNc9I51V9MLI+lZq1rKSQ3fTti6mavnknB2bn0JsveFPOC8Oe7I30k2XoyG
	Msrtths40juaTeORhHg2Gq216ZmOtwkCUfEJeGZJObEglao340k7LwVsTHhB1V+J5+NYLHOr6nb
	ZdkSAvGfKvYfiin6Y5rx9bmFpsys/1wNZcsPuC0dXANUMIj8oyi8qxH6QLyAyimslPUPnRr/CWE
	3FGizuUkOP43EQvPx0xfIZQAfQvJFhtmgsa8Y2WOOLTSoTvUs+sEp2hbYlZY0sT5KiNrarqJRYd
	B6fLcna16ChTQ+kYa6GLsOamPpFRgSIKnxcVpPtBJ7r6iycwOy/LsAJ1eQfa/kCU6M6rhPWu+iD
	nDuuNhVrzPaKa6lbE7ZWv2XZWVnNPKjwyY2iHuamc/TymaFeJZj9C5a4r7TodLLO0mv8FKjjG/j
	RClEmUi9Ud0ms4K+lcKcvjZLXZeNxR/6UBsaqchLvt+YCIQn8J+kYS7Tv1uw==
X-Received: by 2002:a05:600c:8b2c:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4ac151a8c26mr111384845e9.3.1793442351329;
        Sat, 31 Oct 2026 03:25:51 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-994c-f615-42f0-2afb.rev.sfr.net. [2a02:8434:fda5:4201:994c:f615:42f0:2afb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm195363135e9.1.2026.10.31.03.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:25:50 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] tools/bootconfig: Export replayable event trigger counts
Date: Sat, 31 Oct 2026 11:25:32 +0100
Message-ID: <94b1ba8f2b3ee827211f1cfc33a1521303f2e118.1793442331.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793442331.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com> <cover.1793442331.git.edumucelli@gmail.com>
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

Tracefs displays generic event trigger counts as :unlimited or :count=N.
ftrace2bconf.sh copies these annotations into the exported action, but
the trigger input syntax requires an omitted count or :N. Replaying an
exported traceoff or enable_event action therefore fails.

Remove :unlimited and convert :count=N to :N in the command token before
emitting the action. Keep the filter text unchanged and leave histogram
commands alone, where count can be a variable name.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested traceoff with an unlimited count, traceoff:7 with a filter,
and enable_event with a finite count and filter in a temporary tracefs
instance on my Ubuntu machine, running kernel 7.0.0-38-generic, with
recording disabled.

The original exported count annotations were rejected during replay.
With the fix, the triggers and their filters were restored correctly.
A histogram defining a variable named count also worked unchanged.

 tools/bootconfig/scripts/ftrace2bconf.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 8f3edea79ca0..9100ebcd5af6 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -118,6 +118,15 @@ per_event_options() { # event-dir
 	grep -v "^#" $evdir/trigger |
 		sed -e 's/ \[active\]$//' -e 's/ \[paused\]$//' |
 		while IFS= read -r action; do
+		action_cmd=${action%% *}
+		action_rest=${action#"$action_cmd"}
+		case "$action_cmd" in
+		hist:*) ;;
+		*:unlimited)
+			action="${action_cmd%:unlimited}$action_rest";;
+		*:count=*)
+			action="${action_cmd%:count=*}:${action_cmd##*:count=}$action_rest";;
+		esac
 		emit_kv $PREFIX.event.$group.$event.actions += "'$action'"
 	done
 
-- 
2.53.0

