Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774190;
	b=nIo2vEH8xrqvQrKYDUTjcUN2+y9nzkIzbQEvKMWsGHWwFL990vmBt92PYuK2fS0SHCqI
	 R9+YJ4BJb2weDyKC6IIv1h7epL9qE3Ng8Pj8I62SwHfbtTL/650n53ED9h2VYA2d0ZXyD
	 mCOSDaZWOXe8um2wEYYVFz2rcgMk+PirMZHlz6HoxqagwNkGdn3t0yZXPdKjdN8r8YHQ5
	 quxHk1Ag63eMWhgxqcp1yncR/IlYSLDdAwHXQ45PoTMCpvM87MSSpdghs484Vv5gZA6RU
	 HGyVSq+UMOh1TL2DIye6WWvNHRutPDpsoeCxR7HvXrkdPxB268MbzxYs/SuZALKI/wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7Vb4K6lCtDHR01Edl6F0SYueAkiEMglg1Gv+jMy/ybY=;
	b=MeIGsnnASXfDRQCCnRP4MQD4aGr/PjXHb6twYsZ0EQWtxoNPfBa4Tq1ou6DyrddB0svX
	 9vTZV2Oj1v5UWXPXvBzv3NjABPXmCLzXxUYHzsQdB0eFeFcaP7E2SWfEX9ObzohPQOrL9
	 qQA0I2gnAAv0Ifuq1rOBhuX3Tg6sfwpBWa3snqy3LrGeub3D8kz7LpEI1dKoL0YOQRVpN
	 1SJguuRnzsmKkIvMr06yhqjKJHW5cPLL1My7JVOi9/MCnpmdGFpVPkvgAlb1LKoMoKt8p
	 NIaFx6t0OYF+QT+79a3ZJvBCCoyp703dtdVKwFh3rlKOp5Yq0RATptoDl5O/HD7wdtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=es1QKyVg;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15191606A31B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 06:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15191606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=es1QKyVg
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36661f953e4so428125eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 22:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793774189; x=1794378989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Vb4K6lCtDHR01Edl6F0SYueAkiEMglg1Gv+jMy/ybY=;
        b=es1QKyVgLVdeJdpHfl2DLSYjnqbpEtWTreULjpbKOP5nLHKYhfmRuh1uyO3RW18jVS
         AiVUriAz0sGax33LztX/WrrZKz8Ubfy0IeNq8wpmLOSKpeurtcFdb1rJ6WAYdsScxFw3
         KZBjY8oufy43J1zcAJIXJqW1f9DKNvrR5bmbPtdVv/ys6rNdLK9G0T1O+cSmZvB8KIKz
         6Eowa8erJFPyys3ma8H0lfs1er94qACqIwdHbaD6VV2Xbz8p2aqY7jJr2a2xrTgcpxtF
         2X4sRRVGPJbIt2Bg4VwqP/zj7HhoLNxUtVDR10JJuFa1eXTihHnPno43OIvpVx0brBUI
         CgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793774189; x=1794378989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Vb4K6lCtDHR01Edl6F0SYueAkiEMglg1Gv+jMy/ybY=;
        b=k2xhdluNJbYxlUvPHOrmtmFxS7J6+cmxxDNqUMseB6rl5NDEZNI6OFhny/xynt1Ofh
         UXcec35aT/Jr8Bx1fJOJ+VARSTWA8CI6aUpXMk/3ei6Ew34yK9+Ol64oxIeQugsnXd+g
         lYLjC3pnKxMfhUNYmTffLDDVBheXSAkD+yMlDIsad0WZlcNBUZc+95Q8PBSCwPVL1+Ig
         wR2lLnXLZUI7AYgmYcgjGA9q8bqEw0+97fNWHbqjxzQovQkZ8CWhpi01eMZZvIj6jtrX
         cCMY1nOLY5ac5FiTgPJZkvw0dp9CC5izwFqyw7RmzvbFqZf6UZDiq8pLvjZ0F893sCiC
         FS+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwPLptb2Uwy8kHIfKN17goNWQ+N/tJQdfUexckbY8y9a4AJhxiFn9oVHan9t3LQV7CLyaB8LqGXUMM5nmC0oBjHtMY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w6LlIvls98u6Ncs88QEkDDaA6NsslX7HU5jDHIp2DxqOjY75B
	OQjhMZJeiQ8EuHa4DJFRbtY3ATaoh1afOxpI0wXpxBc/BU7tPuvpOOKg
X-Gm-Gg: AYBFou3SX57Y8YU+dTOOa8qvhaf52xkCXHstBGne1DODfW1QttwijG+s6EeCEtdvUCD
	PjEhyxle4Q0nsHQ5tk+Wj0kuODp4d/E1Ofxa8id0ZoVqD2PgIs5wEE9NKjutMIid++QHhJXup2N
	EoDyqpGmXVusQUb5jwQ8OSnmyICLm9RKEehfIf+u7AOL/l2IVMee3ZcdcMbpwgiv69MJmElfnrb
	4Me20caRsM91wsTql0j1ZCDLRdZE0OYyS1Nq4Qz1ex1y12rQsG6manb4GOVXgxwQLVyLZEpzJL4
	VojXN98WUVcBnwziCaa0pnoeR6QroGW8MXx7W/DRbdQZHXBKgTP7mq1FQdUT12jk3S9lFQOw1g4
	0fPsKbr5hNycj+OVWf6svpYkoaJpMj0M6CotjilQwRi07QVLNtZ1QZNoUzZJCSw/j2ecGfiCdAt
	b3/2zLCs+jqktA3V9IP9iMot9szqCRQofwgbi8tGx/AT5VOIL7GomOBcb3NWNfDpg/zlKeuP9fV
	GKWJ9Mw5r/YNqzm25tMGDIZcVxBq9jYHCHzjskZ4qsW5AtHwI6dlfN3iM9Z/1ExlzmyvIrFJzGX
	h6TrEHaqO1z/pj1RgMx4lk+wx+8C
X-Received: by 2002:a05:7301:618a:b0:351:68e8:4646 with SMTP id 5a478bee46e88-36a424199bemr21354637eec.37.1793774189116;
        Tue, 03 Nov 2026 22:36:29 -0800 (PST)
Received: from localhost ([182.216.53.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3784f78sm5186141eec.2.2026.11.03.22.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:36:28 -0800 (PST)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Keep copying markers when one instance is stopped
Date: Wed,  4 Nov 2026 15:35:38 +0900
Message-ID: <20261104063552.28094-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103095019.6a88e783@gandalf.local.home>
References: <20261103005219.3236380-1-jaewon8868@gmail.com> <sashiko-outbox-194417@kernel.org> <20261103095019.6a88e783@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The copy_trace_marker documentation says:=0D
=0D
> If no instance has this option set, then a write will error with=0D
> the errno of ENODEV.=0D
=0D
With global copying disabled and another instance enabled, both versions=0D
record the marker in that instance, but the proposed change returns=0D
-ENODEV.=0D
=0D
This seems inconsistent with the documentation. Should we return the=0D
last write's result, as in v2?=0D
