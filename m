Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777969;
	b=uFZUL/0aM7GZDH4X/MrEZUav5eGOg9crgd52hxmN6LqJ/dpap8NjLnaybweKWGOHcAzd
	 39Ohk6LU6iO6j3EdT+XFKCW/SVHr55t64uzZ7E/ckzvqzpn70tyEiVkryjOgGJDp5E5QF
	 iRwGsrxuHabfDLQGinEtEp7Y3GbcX7g1z2wf3poAcx9vA8kulsgBIXDwT5v5H5FT9Rrat
	 cARNYIMVzbtaR1f6sB5SXpRg6oFlayU7O/omHFIOejP2v2cQfebjmlRUOAV/mgeajlLIT
	 H2jElDTaREwtK3kx8AE8DjQDFdIO6lbaSts+iQnMF3nc8LurXjOw6wfLyxOizMWgm8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9EAdgIQz4nvohbB3aPtkZzQ/pmklaWN6Bcgm+2iXAkI=;
	b=NNDxvfo1Eoarjnws3oHwprAVH53gc6xtL0VESbaRbisJOAXVw2iDYwSemXhWu8tKONwO
	 VVVw7NsbgYTmzptITB54+zZuBcCCoJ0Cc0U1OAt1HqjIZub8SZDjI9iTMsbp7eNUJE3Ih
	 hQBQg9eomGpaHTp91xrWqA6gsb71LfZquJCDwzOrQ+ud1VGf25oN4qRjnwZjZl/JVYZ1C
	 hdWYIYHpfgr4kA9MC02b3kDJkvgDPk6XG0mKPDYlkaiy4d8BuzTc1nWY+NttAzHyKIReX
	 wQIUWY9GI0v3CO4niSdTDVUX+jdhtReRYeh4eBYyHbNMN3XsbhtcwlKw+Xjk/BmmWxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T9ZKdorX;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B9606D808
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 07:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE7B9606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T9ZKdorX
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89ff475a152so179353b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 23:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793777968; x=1794382768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9EAdgIQz4nvohbB3aPtkZzQ/pmklaWN6Bcgm+2iXAkI=;
        b=T9ZKdorXcu2PN/Ts45n100OvbbaHHylreUNCC21E0+EHUysrwm/Ili6ngy+g8YhtXl
         NIs2c2uZAB075C2h2myPime20E88o3Noc8G7FSKFken20TJ0V0qo+1du7pSjvVmR7iFc
         wDlxIxmn1pjEvq4mgo/oitPQib34aRampzJPgdHewghlRBH529icz1zMmqqgPRGoQmf4
         28ftx2KAi/nheOw45yK9r65fkyZKP0CTVpcNOdUcoIm8uYahM7sC5ME+gg852Wavq8FD
         QjBm6w+/fUM8p0tPoqeyuyfEvrk1Fd951DkHhZ8icg02aRt98L4IfUcvL2sMxFnnMRuz
         PpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793777968; x=1794382768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9EAdgIQz4nvohbB3aPtkZzQ/pmklaWN6Bcgm+2iXAkI=;
        b=pjWwXZ09Cj5STE5929OpHrt8Ho2pzpC5/p68ZpiM30BggHKdnscVRwz66Dw/QkF/Tt
         9cBDOtHDl+C72EgGfGOF7hwOiLfY7SKFEpghA6/C75xrnBpMphGRfFauk9V7JYoV3QYk
         u8gr25Jf+VpZ+dNdasoIQKwc7yIFl1Y0YQinYPN0GQBwhdIXGOt236m4NxUVqTDDJfXs
         D72hrZcQk69ncZTOzU/vK/BZzw96FFsn53vpXFQtAitzM7e/dZcNbddNA4kdjcVdvnI1
         VhIaF5poQyqB+TsRPHcaojhHs51S/8Rsz8FpixWpGgP+IPA/gjnK/oq8VQd8v677qqE2
         +0SA==
X-Forwarded-Encrypted: i=1; AKwUvByH9WW6e6+KwBR0CiohmzHkzJFEjx/TC7hyGX6eHNKoahOLE7mU/YYh2ac77x7sCNSMxZKR2mKZonZIAAvOV9GO8Mw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9R4WYaqlk01myBbrJ/5hh7NRxr+LOmhKvXEvaXd+tjQ5/QECbV
	wu9YT0lc16vdiC8NV/zEM+t96wenhqMUqOsCfsZttRU/9ECq7xfyPv5X
X-Gm-Gg: AYBFou1gtZ3za44iKt7RweybanP59cYAUP4f+chbKFiASd80Eh1XJp/Zm1ZLCQZvp06
	NKbrxrefYbob0DFivMxc48kb3NduKOiOEfpCiZqSiqk7cHJwKyPHtMnaYqWkkRpROWZu3fgS7IJ
	D4NkdEC05FFsTkLZ95Tamf1TgRyZD0dRDa8Lpf9zeoilazOG0w59Ysqv0D3OMLX7T+wDyilSFt1
	IEJmQmqS3qD05aXOELMrow/EegU5eghxsQs3ourYvA5n1or9X0Tq4DGsvU//ugpXls1FwpxwJfO
	UncDzWMe2TOgVPctz+KIpMJ0wB6ICX0+mWvp6zLwlrs4L609Ndf3dopKnOjonfpGQhlioF3XjBx
	acyygGu6ENgmvPRmwRAKbe2jX9zh945SPBg4z3YdiqYjdfLpZmzITKKh7u/Ep40cchFLYIjKpRX
	ACHweq6MwKz93exCryl2FAtwr12G/V+SKfODkli6gzw61M/PMBE2uQLeCZY0diIcpYIS8wx7wZE
	yQzflYLHA/LQHDNnkP63rVCievr5bEbM+fWA8uTu2N/7vYB0InFSS5RYAwnlMtQsdC3Xk9K2uvR
	O8r+kt3NTdsg6qHQ+ptqr4R2kuMyv+PvwOwJ/nYK2hiLpktHiXmT/YuxUsLBCHoWuahwImjIsic
	Y9pnCYrktm2jRWHZki+xKVDE=
X-Received: by 2002:a05:6a00:4f8c:b0:874:705d:f63e with SMTP id d2e1a72fcca58-8a9bf0472a8mr12029053b3a.32.1793777967924;
        Tue, 03 Nov 2026 23:39:27 -0800 (PST)
Received: from localhost ([103.109.144.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09af91d32sm543783b3a.25.2026.11.03.23.39.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 23:39:27 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zhiqi Zhang <zhiqizhangg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools/bootconfig: Test listing keys at the maximum depth
Date: Wed,  4 Nov 2026 15:37:42 +0800
Message-ID: <20261104073742.21202-3-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104073742.21202-1-zhiqizhangg@gmail.com>
References: <20261104073742.21202-1-zhiqizhangg@gmail.com>
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

Check that a key with 16 components can be attached to an initrd and
listed in full, and that a key with 17 components is still rejected.
Compare the complete list output instead of relying on the tool's
exit status: a failed key composition currently stops listing without
changing that status.

The existing good sample checks exercise the compact tree renderer,
which does not use xbc_node_compose_key_after() and therefore misses
its depth boundary error.

I wrote and ran these regression tests after reviewing the fix.

Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
 tools/bootconfig/test-bootconfig.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 530ce7e28d63..d19747e47890 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -100,6 +100,16 @@ xpass $BOOTCONF -a $TEMPCONF $INITRD
 printf "badnode\n" >> $TEMPCONF
 xfail $BOOTCONF -a $TEMPCONF $INITRD
 
+echo "Max key depth check"
+
+printf 'a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p = "value"\n' > $TEMPCONF
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF -l $INITRD > $OUTFILE
+xpass cmp $TEMPCONF $OUTFILE
+
+printf 'a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p.q = "value"\n' > $TEMPCONF
+xfail $BOOTCONF -a $TEMPCONF $INITRD
+
 echo "Max filesize check"
 
 # Max size is 32767 (including terminal byte)
-- 
2.54.0 (Apple Git-157)

