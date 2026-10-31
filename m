Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471757;
	b=zQgNvkrH/mjfdUa8Vc1+aMBW91gmLcIjEh/5yBADgZq9y8KAG+sp/EdXtqeU9yMWx4Gp
	 QRO5xngj48hoRCiSwPYwpvTzQFySHZFiijVAGComPirE+T5YpEkShCHaqXFkCLZtjM5zK
	 W4tAwRuurCmmpdkv0qZwOtCKLHEa18+cQ3tBYlUZLu6pOlnqIF7k8A/5CAu6xZplfvs0b
	 FApXz6wkKj+ak4AePmh8h89aXZlEiBR1WtRAzrqK6YzxngVoFmhM3uOq41SWUdcrCm8cL
	 M5URj0L+kSSQhH9g3wgehPgQn3Nk6bA7CFyrjqYt3IJkRcKzDqCW5iJpPk9ZHxXscKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ScNzawShXKrGXlogOPyfxSlb2G6dZe7SaUn4tH+A76o=;
	b=kvNpW4YzOTIymMkZ5PK18Ut+UwNpiAfYLeNSImMIQspY13Pe99C9IiIyTLU171RI9yr/
	 FcDQt+jjFzzWG+zw/QfFRZCwP4tH2XrU9z2bxssuKpFlaUiegEoA4euDGrT/uM19NMKmQ
	 X3NRCoi2H9juIt6qtxKjpyUpeGK6HMflSJbv29ptIS6LmypC58nu6nf3pkd5qRmzOGzAw
	 VFAGBLlrwDFt7yoUnTcNK9H34EH3+GafBU9sO0pgWegzczMpYtDnGV2n+Y99J/l+wyekW
	 AkIaPTIN8fJw5grVTAGbQUUT1HABeKcGjocXXkuT2t7Rfz+Ttr/a8B0f7IS8VMUjaGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mBvdOo+n;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551E606A32E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 18:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2551E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mBvdOo+n
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so11004215e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793471755; x=1794076555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ScNzawShXKrGXlogOPyfxSlb2G6dZe7SaUn4tH+A76o=;
        b=mBvdOo+n8cXHG28ipFe+13Gso+AWyV/hRigrGb5kWoswYk5R67XD/07LHKNsBoZXcB
         ow/YP6wVyfX0CjWwoFCxxirB44LWlwuzl+mye077n1u82LSfgKsR8KLtqZ9F3CZ0wbc8
         oK1f2rX/jSfzhVle1MjR/gSgN5Qhi9N5rgN278fwMsGgsIQhwpFOqLT6Kc5jFS6YEiEj
         fjGftOuE2z+FZKUfU41RU7lexSlWb7yz/nTuNsm8EHf3dj9FgKNRiUsxtoPrt41K5WPC
         6rUbaSOjGKgTv8D3J6FVwxRJnNzRn0ywh7EaR6SLmmT5p0vB87q55GAO/WQq94MyBBoX
         9Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793471755; x=1794076555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ScNzawShXKrGXlogOPyfxSlb2G6dZe7SaUn4tH+A76o=;
        b=JEO4ZPigsyIXJbzDjhN2zTTpOF2p2W+Z7e+qqKm7puMqPWSSMjNRpr5sjCJbvxA+2t
         Uax4vfFzdlqoBuJh6gI1l4AJX3+J6bHi3f6zVKNgItCy4KuDqHrbDyG38o4F9CHJOH41
         e4rTdvA3pl3PL1IzjEHLdu232RjFHeh5khxPb+suzY6rA9JOckOXU9kmTAGR8FAeztH/
         A4aSdyRHYvwmxXW5bY0VFHjdbShC73mGfrJibUjWLzsf/zFTSMCGbwHrYvEoRHfULRr3
         n9DMYVY7TzqamUxovCZ5IQWAaJWSk7L2edqbIJyxyL1SDZyo9v3C2q2ZRmE8c4LIfXPq
         MdvA==
X-Forwarded-Encrypted: i=1; AKwUvBw2KcaXQFSGvohJOijSOBB4Lxmw+zQ3pRaIlTY141rWwHyGHevhHw0EfRYLAdaFzkIRS948lmPtWctnGAP6FmFY3Uw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1DEvOh26ru8XLmcmDiYBO7mNokXTgotALY+YKmFMFcOkWP/Tm
	ej11/9znyi7P45jmXCMwCUHa7fBmX87RGExS4gl8PY4PnuTGSGzr7NpUCfD8qLOo+EnbIg==
X-Gm-Gg: AYBFou3nwRp33+EYOJy++ugyYaVhX8OsFIpWp5xKc/d2ih9CfwQiZz6f/5xmY1qWc5z
	Jos2zsDYeLtl7qYveyfzkJrMrFBdeWqsiFZEGU6q/7E47SaBPCYo01bExHN++ydnoEJw+lmbUg6
	PeLQlZMcKcJLTsrn2drG1QeBkFreNLe5Bdf79VyMbnthHODyc+cUjiz9wujkIKAPAqOAjaTlfrZ
	jXfadtroMX/8TvJ8jQtt5HIjkrRhrMVCzZ1wCWtSi0jJZSdvxbO22bKFMxvMMpWIqlyVb134+Xu
	n0XAqoUD62IlD6AJencYoWRBUe16SbvdDUcjO/ti09W0Fb9LHoFUUTbh1esHNslJsO/hRU0UGnd
	VE10V/zCoMjGRQfcSBHiSqRnA899DfwgRUWrgOgy2+8huqki7EkKQTrmzmt1Yz+eIOBxWmTEWe3
	rx/bmCB8yTkViZdWkdzPK519SxYb3Id0qwb+I5vBoS/HrULoy8nFtsTfOBE6vJ/SEFY/JcwnrsN
	e2FLVDCX9KxOO6ZAU+683ABjkjYjfPzj2ljANGtbFo+GaOE6b4L197jIWm5ATdk+61mazrOGk3t
	hBdYWbAjT9eL/d+k/fK/hU0xFwKM57lNJcX7YyQBVbgVLRgFFWDNIjANflK8v77sr0JBicxzt40
	g6JOIoso6pv4KkQmaRdDPdu5MmK18edgRFwsTeLhewezyHnXhQu+uSOKgLsBu2igcCzAHGspXtE
	CZUUpBAevcGrDqltCZDbtchQxYIVOclWDtVvljF3XZxL/YE1uWwrwTLlsHtjJYuphMfb5IinTBh
	napgbn8VFm24+T1
X-Received: by 2002:a05:600c:524c:b0:4a1:fcfa:2a07 with SMTP id 5b1f17b1804b1-4ac1960dd8dmr133921025e9.30.1793471755505;
        Sat, 31 Oct 2026 11:35:55 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-0247-bf06-1f38-d09d.rev.sfr.net. [2a02:8434:fda5:4201:247:bf06:1f38:d09d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm219745075e9.1.2026.10.31.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:35:55 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] tools/bootconfig: Match literal keys in tracing script helpers
Date: Sat, 31 Oct 2026 19:35:34 +0100
Message-ID: <694f66b67c017072c0246997a09e67a79ebee04f.1793471731.git.edumucelli@gmail.com>
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

The xbc shell helpers interpolate bootconfig keys into regular expressions.
Dots in keys consequently match arbitrary characters: asking for
ftrace.options can also return ftraceXoptions. Branch and subkey lookups
also match unrelated keys that merely share the requested prefix.

Compare complete keys literally and require a dot at descendant boundaries.
Keep the optional subkey pattern operating on the suffix only.

Fixes: 7e66ef0046cc ("tools/bootconfig: Add a script to generate ftrace shell-command from bootconfig")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
The helper checks cover literal dotted keys, missing keys, branch
boundaries and subkey selection. The original helpers passed one of
five checks; the fixed helpers pass all five. These checks also pass
when combined with the other fixes in this series.

 tools/bootconfig/scripts/xbc.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/bootconfig/scripts/xbc.sh b/tools/bootconfig/scripts/xbc.sh
index 1f0ebf50dd2d..16ee590661b4 100644
--- a/tools/bootconfig/scripts/xbc.sh
+++ b/tools/bootconfig/scripts/xbc.sh
@@ -36,21 +36,26 @@ xbc_get_val() { # key [maxnum]
 	if [ "$2" ]; then
 		MAXOPT="-L $2"
 	fi
-	grep "^$1 =" $XBC_TMPFILE | cut -d= -f2- | \
+	awk -v key="$1" '$1 == key && $2 == "="' "$XBC_TMPFILE" | cut -d= -f2- | \
 		sed -e 's/", /" /g' -e "s/',/' /g" | \
 		xargs $MAXOPT -n 1 echo
 }
 
 xbc_has_key() { # key
-	grep -q "^$1 =" $XBC_TMPFILE
+	awk -v key="$1" '$1 == key && $2 == "=" { found = 1 }
+		END { exit !found }' "$XBC_TMPFILE"
 }
 
 xbc_has_branch() { # prefix-key
-	grep -q "^$1" $XBC_TMPFILE
+	awk -v key="$1" '$1 == key || index($1, key ".") == 1 { found = 1 }
+		END { exit !found }' "$XBC_TMPFILE"
 }
 
 xbc_subkeys() { # prefix-key depth [subkey-pattern]
 	__keys=`echo $1 | sed "s/\./ /g"`
 	__s=`nr_args $__keys`
-	grep "^$1$3" $XBC_TMPFILE | cut -d= -f1| cut -d. -f$((__s + 1))-$((__s + $2)) | uniq
+	awk -v key="$1" -v pattern="$3" '
+		index($1, key ".") == 1 &&
+		substr($1, length(key) + 1) ~ ("^" pattern) { print $1 }
+	' "$XBC_TMPFILE" | cut -d. -f$((__s + 1))-$((__s + $2)) | uniq
 }
-- 
2.53.0

