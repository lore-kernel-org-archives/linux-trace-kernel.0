Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BE39AD3B
	for <linux-trace-kernel@vger.kernel.org>; Sun,  4 Oct 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791133586; cv=none; b=XKlP+0j8+uHFY7U7OauIvWU9tBzz6xuvQEHfQnLGGZAfKN+L63xv4lmC0VhGsdD9PYN2XXTyVPJBXBDn1pxButFyoR+7qKgjnwkp5m7e2tqCHEbMTdfHX3MGePRtogC5XKUvnd36iCqcUMjjScVkreOWphKkXigIcxplCDyyQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791133586; c=relaxed/simple;
	bh=vEr4v5UzCxd7Q67cxL7C+j9r5X+UpcvxAXoDSa/XGrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OtpsMe9r4Jb9lGDoUW0DE930DRdU2AemBBUT6swscml3+Gh0SERoHyAGh3aRQaFnrcCo0It1tLoXleMOdF2E4Ci/A39hF6GoYFHzq8NuD1mW0BUA0IVPypkQBiIq8IN/B0cliWGxKmyXF+NgoS2HjQZj52sDja4nIeWDOOXp4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqlYikaO; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqlYikaO"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b2f02so89001fac.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 04 Oct 2026 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791133584; x=1791738384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vEr4v5UzCxd7Q67cxL7C+j9r5X+UpcvxAXoDSa/XGrU=;
        b=RqlYikaOnxkDd6DbFJrHXtch1lcBXpVJyZqO2aJ7xM2QOZKTmcygg2u40hZOZgfs1N
         Mbm4jgiuGdCfyBS0VDO47O0OdRYuxAorVMYwiaWGtLlHz7oyFoEvwXZ2SbQkrueHhCT1
         mTESKW+zVXxLk23BeLti6t0Ais8X6jGTdGD5HoGrnEQEHmBIBayZYgddExZopd0bJ/zD
         +hNqzxMW5p2aISIEsoR/fTHbyUpjVroqYb4ZBZZutAlqr4YRzH0fhWrV7S5mzMSMZWje
         DK3Bida6sorx1VAD5nQKGeqdzIar0Rakk9/I3C83446nIysUoNy1dGzGlFGJx8H0MMod
         seLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791133584; x=1791738384;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vEr4v5UzCxd7Q67cxL7C+j9r5X+UpcvxAXoDSa/XGrU=;
        b=iHEEUCctv63hZtEZlgOmlWojURHhgfQwxUdy5aQ2FxxanHsCyctMzks3lnmux9F9nl
         D8T/yEuWqUC4H37+Q95KTyfF+9fkM9SMFJ3kKquqgzqQrvE4Q+3GLxOw5HtZkn2iw/J4
         FALdvWFDc3cgcML/7ZaovdrpEm0ak0sa3gtqioK8sqrw61gaY6ks9pRWn8ds7xPvU+uT
         4+MJezYk+bS38Pybe2R4rxPhN5qWMVCR2j+AwHjbNucCmfHYdHgmvVT88g/HiVmbA3cO
         XfLBO7jHngFYjHmIYNnF70W/1oPo0IWBcHoCMtVIKPLqi1eKNhoM+Bl+vpmAnFHN7ckG
         yBJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmU46AKEZrBRcLKjBAqvynwtcgh/81VmJIf3feprjz9EMrYh5+g2n6lFoDtheyY4KtF68JDzmHalA+cwwB1Jv0h0w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKG3uXrT6s4na3cKQo+LN0lsjRXGVLTxN8aGnY++ckF9koEcKU3
	3aumzpGsdMSFXA+L8Ix9xjrgTh263Nxc0wDAaPoMP+3azoSTyeAQA2GM
X-Gm-Gg: AYBFou144tfFg1UKF58/cSfxQwCsyKa78Y6AfCeR93rl2R1ll05c3DyLdFH6bF9ODkK
	/YYku0iLxCrfR7dDF3bFsHipRr6aMgrxYruuQVLiGFKfnFVGuYRxZfIZsnsLG7GN6J96JtrIksc
	IKJdSDjUOnbtIjUaAzezl/JFrv8i8fiq90y1xtLimwRYAbykj6fHO7EedcuK5NeCGjEI4v/O8sX
	DeD40LYQNjXeg1xbjXOg815dPWDcCKN1y9mB/VBCcAmE6nZsJKxxaZgh/eLMbb2WMaAOsrBliyc
	P9Sy2cvlV9SNbzVLWN84nbhE5lLV3JPDTOMtL+6ZaRSNaXmYf4K94htUo0l0D9Cjmcxb1rDAFOu
	IxaaYvbmIscWRlSF2DDCdnA0nR25CAIQDaWW/3xrTQAaq3F44GwqbVg9ATznU5kkLSRz9Igw5EM
	VNEApt1P7hzZ+Jo0sbqjAczgoHmLvUf5O6NbkogX6qtNx611DArOlpjKr61C9zHTjE5PC+fxMmA
	3CncgXaf/5jbqNkwyXwqrA6a91DTPd59lZnvC+EQf9jlRVJxzGtlTLTvm7Pln3V3WBPqHD0R+7g
	geB7vt1fxw==
X-Received: by 2002:a05:6870:c115:b0:497:2e21:f7e5 with SMTP id 586e51a60fabf-49e15e91b0fmr5947738fac.25.1791133584217;
        Sun, 04 Oct 2026 10:06:24 -0700 (PDT)
Received: from starship.unifi.local (107-216-42-6.lightspeed.austtx.sbcglobal.net. [107.216.42.6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16545353sm7403626fac.0.2026.10.04.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:06:22 -0700 (PDT)
From: Lawrence Lin <deduce@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	linux-modules@vger.kernel.org,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Avoid quadratic symbol lookups in ftrace_module_enable()
Date: Sun,  4 Oct 2026 12:05:59 -0500
Message-ID: <20261004170600.1541723-2-deduce@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004100030.189b1c3d@pumpkin>
References: <20261003-ftrace-mod-bsearch-v1-1-92e2fd2d80ff@gmail.com> <20261004100030.189b1c3d@pumpkin>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 4 Oct 2026 10:00:30 +0100, David Laight wrote:
> Surely it would be better to add the sorted index as part of module load
> so that all symbol lookups could make use of it?

A sorted index used by every lookup is roughly what [1] tried, and its
review showed what that involves: aliases, livepatch's references into
the symbol table, and the lookups by name. I'd rather leave that to the
module maintainers.

For this problem, Steve's reply suggests something smaller. The weak
locations can be dropped once at module load, so ftrace no longer looks
up symbols per record, and no index is needed. I'm prototyping that now.
