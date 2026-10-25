Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949745;
	b=tNiveXHaNJ1gqipgA5ZoAj2NaH/5bGIn5CHwT8pGFtgWPkY9o0EimiRGiGdcipyTmdCi
	 IsNM7sorjzN/JJbTdc1HGoRA43Jn52iqRPPfKaDtAZ4XRL9+x/TPwvYkPfbUzIK8iejMz
	 FOB38VMY1wh+DyZz1hUAlxo7asQSgbzNEQN2yv3adzv1zMZB6WtqP4euy4+mdD0MmJL/J
	 AZeV63qJV8+OaKVG6UCJb0spDuKvyM2KkyzqibrSL39QfMk9FtN0WNwjTQteuu1cJV8x+
	 UmK18ddAx/rJhO1sXExoHlvSUpAHJMOsFyfIE/kzy6MHS8QGKZezEQ8Ytu7HXZG7jGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FPp5aDGJYBPNBlpjfaSZ4eY2TIeatM+DHjVLUX8oeUw=;
	b=NnZ5GP5zvaDJPnDYC84A1zP6e93L5wRED9qAlYT3PpEcD5+m8bZaCibLnlR6gsRMENmP
	 RF04+ZPY7pHShXzXn/x3qNdGSLE+Kw5b7QZbZ3wCBXRe5n0bX0sPGEp4e0zNtB4iacYJF
	 igNR+1BYKRFBnga+8w4xHHUK2Da6MeZurc9Lf9TAcIguXsFZfigA2D/1Fb6pFSa+UrJ+S
	 TPBtZLu0Pqmd9FQoGclEhVb1bql8jgDuI5KO5NLvDmc4fj1ps3PmZer6V9sljfxGi6Y5+
	 esLF58LXJn7aE18h7z0mk0YPxH2+C8hcHRRZGcegCOVM61MNRsrxITvj/97AfDcUsiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BDBiTDGh;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2276606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 17:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2276606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BDBiTDGh
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1219528f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792949743; x=1793554543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FPp5aDGJYBPNBlpjfaSZ4eY2TIeatM+DHjVLUX8oeUw=;
        b=BDBiTDGhnT0TKGV10WD9+rpuzcQ6WzkABR2dKuZpyN7697g7r4hsCW/D886S6H+oJy
         zzEVVWKsPkQS1f4cDyXMA/Ylz0p1tcObYnXt596uSqDyYA3ccrcNiniCeklo6aMrWv3C
         qUkptRb5y3aJ004cX7jjHzUpZQa4J5uYP61Kuae5pM9MIkDgmhrLOiM0irL1AZmHLVue
         Zfe7nGtQ1bFKggmwYtgzWF95IXgcmnXnG0uK8Bw4dXdvpWEELdxBW93Kg6vPnGqmd7mQ
         unisXSTCq4c5u4orIZHuDnaQoGXNBF0sVl4pDVG2T4xCVfDd7FdKMY+wjyp1nQfofP1O
         1rBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792949743; x=1793554543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPp5aDGJYBPNBlpjfaSZ4eY2TIeatM+DHjVLUX8oeUw=;
        b=p0HmAcooAWi8F7HXxcjzVuTWSUfLb0V44QhjILEzOSLE+ssojBd9k10ne2JixhlUk4
         r3ONNcLW40jylB66IifWJdA64gxTLRSqG7GZdd2GBRj6hbSCnIZm9DxR7V5CSYkDm048
         oKwQheE5cYhzElR/vhk4aRyODlLxD+I8vA7IWEDgoXBc/rjNIQktBPorPBbnfXBH2iiH
         l83CrNVMwL5qtZWGRo3s/YzZP4/FJ7kYxoeOAr9aqvMfgLkX7714MVv20QnbeZwb/rQE
         0v5xhZ0eeCtwijM6vis0Yf9vDj2G1+aH66hl8oT71c5S6gA2wGx1DO/XY9z6hFeKNopR
         hZ1g==
X-Forwarded-Encrypted: i=1; AKwUvBxT1NW9uewl/IIUXHauvYCYm39WoRzswUybN/7fPIoAJC7qi8VXgf/oRwoJo9F2gftWzmp5fo8jEmHWe4WwtHqaw8A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiLkIOVg5aYgoP+9vU2pv6ZNGL5iVxL5inhSFDgWVMPiHrZB0J
	SYaKeWJWdA4+wGFKlXQJ/Fg4Ie+IubTHHA0cVIUa5YDeSpXe2jKwv30U
X-Gm-Gg: AYBFou1WwA3HiduC5ca5hC4rv5yyvDgEvFjnCSS7a1gMwiOhdhvjnA0d9muaNYJ4jnZ
	Xo9EIVCdlMT9WBVPu97rKTa56/b+x1s/D4UPXXInXU5a0Le/a9VweRyC8Lklw57A/sbVSOvOO48
	r7X8ZzA8gD8F5wzwiP3AJUUwVHSRySniMTAcgdNv/B3N35BuNaCZnD5UIfVTzQfrxtEDBAPUdJX
	CCnc5nakNVEIU+Up4aweWhJQcUGbytYA//CQi39YDuVrbL5LYxjiBbXK7VV5wCccn7yOOVpUS76
	GFLgHKGRxoIY5okkUcr7Y7H4LbR0cxWeH/lEzFRBmIyPxG+5bPLbC989nlxTDGMZJ0criOqkoGt
	9AjRLHcIHb2Dv0roqK4ILGtY44PssdVTAnBhEU+hJs3Vui9J90gP0Ddl24dZhfcXfd64flhLssI
	pXZSla594v5nADWza4vzN4yu9Ok4LRucBCnMe+5f3Iz0+XyjLmy4XexhzMC/jcHHzVQYDtNDCfd
	BxWOxlUw79s6eCxzWMGFtzwVyBBvLgMJI+yjvXZkcSUSQdPRCH0zP938vlZs5PNcZRMwoGk8jrA
	GKwQDsTC5BIYyu+kiiCmFxyXLZo0HG0mdLOR9CXwIAYqw4+lM0hrGU9M1/zn5PeQGTTyOaOBHiU
	aWJ/vwmjqwZRIOK4/I63xFHXCnYXaYW5Ks+v/5zL62dZZWhMN6NbWcSTC3Kq2omqMZjWsKR+yYj
	nxCfAUKY9l
X-Received: by 2002:a05:600c:a013:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4a35acb3e07mr86950245e9.23.1792949742997;
        Sun, 25 Oct 2026 10:35:42 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-ce3d-9b69-45b1-5da5.rev.sfr.net. [2a02:8434:fda5:4201:ce3d:9b69:45b1:5da5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb90dsm10234070f8f.22.2026.10.25.10.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:35:41 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] tools/bootconfig: Fix histogram filters and variable names
Date: Sun, 25 Oct 2026 18:35:22 +0100
Message-ID: <cover.1792949723.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <undine-1792936915899334889-d965251e73c20670@undined.local>
References: <undine-1792936915899334889-d965251e73c20670@undined.local>
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

Hi Masami,

Thanks for the review. I've combined the two fixes into a series and
used the two sed expressions you suggested.

The first patch keeps filters when exporting event triggers. The second
handles underscores in histogram variable names, so the exporter keeps
histograms that depend on them.

Changes in v2:
- Send the two previously separate patches as one series.
- Use separate sed -e expressions for [active] and [paused], avoiding
  GNU sed's alternation extension in patch 1.
- No code changes to patch 2.

The original submissions are here:
https://lore.kernel.org/all/20261023084947.3264289-1-edumucelli@gmail.com/
https://lore.kernel.org/all/20261024110837.696216-1-edumucelli@gmail.com/

Feedback is welcome.

Thanks,
Eduardo

Eduardo Mucelli Rezende Oliveira (2):
  tools/bootconfig: Preserve event trigger filters in ftrace2bconf.sh
  tools/bootconfig: Recognize underscores in histogram variables

 tools/bootconfig/scripts/ftrace2bconf.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)


base-commit: e28458ef30ad66ce7cd2299ec5ee8a8a016d67ff
-- 
2.53.0

