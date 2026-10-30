Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364730;
	b=KcrqZN2k25OTlrhCcn10iyEmw0YurvggB/Gz3/mapk3LgBLOiXiC/+3kaBDRT8O430QV
	 azyfpoJ4V7Cw3WXZsrER7XJqjgOZRlPSHW4p7W28ElFF+q/rm8ca7B9QwEE0lghR1EXwP
	 upZVFoZU6oWmxfXHz4PVvXSy/u7OEperGHbxlHJkKCedqCZyR3ZkdI+ttafnUmlVJNhu6
	 x4hjSeX0687cn+4Y75tJXsXaaG4NqtqY8ewLHM9tdLP9DrvtUVnW+rOnKhQmh4VfMXNOJ
	 kMTC3+RgC3CJbU29ylbEk8lkdaroflLHVGIjxosUvgPFuHeQUzMQ2R9WF3DsTPbFSBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=73NnDYgtRRq+RR5ApFnv+ewgHDtuK4aFIM31WIpoV/0=;
	b=1edv6lpZQY+k4UKcTyY0TBao2dHRIUPpAad9YrR7gJsadq8whhksQSy6lFcjWMO8nv26
	 JMrAB7CiIDxHg4MtiCu5NqLvkkCfJC0Iiex2z8opxY62tvKLjg9/h7vlehvm8bnXs/2tq
	 ra043pVnWDRcl7amwVCljazbK82MSQ1m6RFeDwPLehA6ldojL9CBuXXuWZ8GkfAcHG3su
	 Pjz0qBW43lIhUIZLx/Ak0j8RglmtaS4+h2XFAlDnA+80eZ9/tKhfiqKVGoYrr0cjH8jPx
	 nryTen2BU8ly96JkWufWstyMzC0sKNicv0eQArk+VV8ezcMtWeV0gs06mjImX6EBOEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6GBc0nF;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A459606A323
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 12:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A459606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w6GBc0nF
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df8fe8513so608687f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793364728; x=1793969528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=73NnDYgtRRq+RR5ApFnv+ewgHDtuK4aFIM31WIpoV/0=;
        b=w6GBc0nFTcH1bU9gFpNJz4jKHzL2LRKnugmQjv4u+E2EwJCeko9qkHrdOWIcl6H2xc
         aRdfXuCNVh3dNTF5f20ryGz/vi8a8ZHMHHf0zd8KiVjCaJlHeYqvFv0AprRX7KFLtStv
         yhyycR9X/RwtJIPcf3f4AStCSZ+IUnxMgmVd5G20SRnsSJJ0YdNQYl4SdKttPXreOk5I
         EAHLiUPCp7R536SddUo7wSXkXDyGObo/ptlqbr0AbOek5+CWuNdSOlCTv6/5q44AqE+V
         o/3Yrd8lzZQLQFzRvzt1Kt3oOhYw36JS39XMPhw8ay5J5BLUAUMLuBrfZmVZtlZVR/Z8
         T6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364728; x=1793969528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=73NnDYgtRRq+RR5ApFnv+ewgHDtuK4aFIM31WIpoV/0=;
        b=NpeJOmn0L9bGjs+Bh/En+NLy+gz4FQ3iRGlZy+RIMhcUUVjIULmEWWnBV6mSuonnM5
         N6vUsi1fYX2lPQ0KmCOqu4L3o3wMxnsI0DYPu/8JDwsdaALPwqbGSFFNqM+OmrzeEN5Q
         VXpRmJoarmpoevOxpJjtKEfwfsHE/g4zswQi9OJKTfamjAdtOGD7cZCCekT6UBMCxoaB
         ODlqOBkLTrVmaXsWu3ixc3ffEaHaVhJIdj8I5ZZJXiFt7GEdsOjHHBdDyVdAUHNat2fe
         U2H4ixbDHWX1fN9UUw/xy5e4aUP8sFaUfqL5xNOe9cmNYyNPkbamhDPvm7kC5tBiESMI
         36tA==
X-Forwarded-Encrypted: i=1; AKwUvByVDozqbALYwWChrKtFz8kOdsloUYZACcRMvD6nTl1AQcDCMuDLDVrM3llDL3FGV73PtsOJtx8SsQ77rdgGdZ6vhJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvkyyFg22q0UE8Hexu5gg3MUNH9+rCu7byUDL7lnyQ3l7f449p
	93/7ln5Xjtx6aZ2jpRpsi2QIIUb83ttiHuufFaWXdeXBsaFUFauSVzUVs+F2fDx5f21KLg==
X-Gm-Gg: AYBFou2IuC3PXVuPVtVP7qItvH/vGQdzRaUQn3eRWZMlFkncARokgEpPMtPnM/5df8n
	DQ9vcat4Qp5vCSK6/mP52iZfZjh0eiTCJRnwCdSBeJKDxJfzhzACWKdwr4LoCKTPueY4KI2h1Zd
	nV5q1pM19o8d0d3+Evfhy9Q8Vl80LzFMCUstbGcmo0bCC9bQyV7CklqWo6UTzyycB9cSceN3OH9
	F9WH6e8hbt6yJFmtFihDYOA/Ys/IwpH10BTfcPLEO7kY1FKSOAHvkVXAwMyWxPlfRzkyGwYzMrj
	zfcoMCPQaRIzMV/PoluAJd8dfWtOmzQaYe/IcxZl038P8vxaKGAQEZu0n+xFvTUxeYZRi38dZeC
	Z94OAOKxmyHUkZrDy850uwXzgOkzwKWsHrmqy7hv9aahuzFFOt6rGk99wKdQGj2XXs16KhOqlha
	B+RE+KRxtrTNBHvB/A6XoZSg2Ro1aU9Jst3exMFSkLOIOH7GicmjkgMm7wC6F8m6WeEAJDjiAvd
	x2pLzlVnq2wu+Q5YxQEbZWItjUVVbZG7lJkuaJy2UnG+wuufrwNIPp5RLtvI9oGuCPmsXgpcV9V
	O9inX4l48ffDgyybRms77TFMiO49/coWvJXOZeV1jmdp6OPzKEfV8UFjQTLN5lWPf4c5f3xrAFc
	GAjAtsq6bBTRxc2sEt4HRNvZyLdNp2KmWNJtmR2glDpziMejG9zLIXzi5aUSxJgygxlmNrGP2qK
	BLkq7ffFaG9UcDnbLfTtBqLsSYHQRGGmxdMrFhOkMP328ZyhNHwVbT2xRp6g==
X-Received: by 2002:a05:6000:2884:b0:48e:6eb1:3d02 with SMTP id ffacd0b85a97d-48e6eb13d20mr4529254f8f.0.1793364728190;
        Fri, 30 Oct 2026 05:52:08 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-a479-65ed-4521-39bf.rev.sfr.net. [2a02:8434:fda5:4201:a479:65ed:4521:39bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723cdsm3170047f8f.12.2026.10.30.05.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:52:07 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] tools/bootconfig: Preserve tracing settings during export
Date: Fri, 30 Oct 2026 13:51:47 +0100
Message-ID: <cover.1793364709.git.edumucelli@gmail.com>
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

Hi Masami,

Here are four more fixes for ftrace2bconf.sh, based on bootconfig/fixes.
They address settings that change or fail to restore after export:

- Event filters containing punctuation are quoted as one bootconfig value.
- Generic trigger counts are written in the syntax accepted by tracefs.
- Histogram variable tracking starts fresh for each tracing instance.
- Paused histograms keep their paused state when restored.

The base includes the trigger-filter and underscore fixes you picked up.
The new sed expression also uses POSIX syntax, following your feedback.

I tested each fix and the full series in temporary tracefs instances on
my Ubuntu machine, running kernel 7.0.0-38-generic, with recording
disabled. The patch emails include the individual reproduction details.
The fixture checks also cover each step of the series.

Feedback is welcome.

Thanks,
Eduardo

Eduardo Mucelli Rezende Oliveira (4):
  tools/bootconfig: Quote event filters in ftrace2bconf.sh
  tools/bootconfig: Export replayable event trigger counts
  tools/bootconfig: Reset histogram variable tracking for each instance
  tools/bootconfig: Preserve paused histograms in ftrace2bconf.sh

 tools/bootconfig/scripts/ftrace2bconf.sh | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)


base-commit: 1dc6d173c43e10a1d0ee36b43d0d2f371f4d262a
-- 
2.53.0

