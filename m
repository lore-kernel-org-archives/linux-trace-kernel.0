Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA872192F3;
	Tue, 15 Apr 2025 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688787; cv=none; b=XZmRZqZSXp1elYIAd19lZ+wSjE5gufjUEn4YbmK5J3vfkcXya2PiBGmy9/8MOEaN0hPr/Jm6IlqvNu/psgERmmFoEwit/cSeWXza4qnoZEjy9uMP12W89184fxHFS3yhKETF3Dm4d0zilrY+3bdgjaSQ9s8RAaPVyv52CcIcWW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688787; c=relaxed/simple;
	bh=YYRrOvjgiKweiLMcWTs3WDiH09awtMkkv0V/WkX/ngQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXQ4E6ySHGfMW2re0E1+GX5Yh/V/WlkeMqDkg614rvbzpTxjntzFz/28O+HSI4OB5H1BcuGhW8cF9CBFyWeGORhpiE/JvRxWQwcDMMkUEaJBE7Ex6r2UFuEVOY1UZDJK69uJhTwm/MD9L+1G1j0MTV0H8fygMVB+gMIELnDdyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE8iZq5H; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE8iZq5H"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736b98acaadso4574510b3a.1;
        Mon, 14 Apr 2025 20:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744688785; x=1745293585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrkZtCriRccIxAXSOpwXoTdEGSPm5t/eG/+f02UBahQ=;
        b=YE8iZq5H9CAS4nhyXKvtApue/vIGm3X4J8yknNzNPX+QG6f04TJWuW2gfBSl97H43d
         9Qo4asy8Iety0dmVLXahv1D5HX6Aqj37Xdeg5670SBY5m/nwWBIx7RKSafj8oRZ+6nsV
         sUbXT7BuB6TjMV2IOf/FgXl6uPppdxbse6Uho+oMpSVFOr2Of8NEmYSWN2WUMcCvmSlx
         nNTJZJ734zNvZeZh6eJGrLlFY3VXAvESApoHXaDa4FjhKPT5sD4afqWx3LANDMNPhude
         ruWoK07InvxevVOj2asHcOO6bmcZYbY5ZeT/PoWISu1HumZY8HrsGd5h5x+ax9c7A3us
         PfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744688785; x=1745293585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrkZtCriRccIxAXSOpwXoTdEGSPm5t/eG/+f02UBahQ=;
        b=B9FoMxzCaH1jREEs5EYneTOh/pJNqqGONLnSFMoNFofnX7we7Z7CDZlByu+DQvf1Ah
         hI4LKAI7o4JK2dgusn1nEq38BsxH6D1oiJq+zYs0xqtj+dEcY9/2HOfn47qm3TMcpY5f
         DNDHm/gCJCqBQ8JXofGs7qbFBYelOj1fTRedCf8PcCADXFpqPoocFkSfM8Ln3RTNUJqU
         XuHbyK9SDTHTcIbMwj8dXyRqXA9nn2j1EoWhqAWJEC5Zwprcad+6T8gdlTDhCFcdHN5X
         ARVCMWWAX0IMkv/D4puamZcecZ3c+41CjLe2SVAHAR4mv1OCzLXNt7KD31F+ko9kA0Bh
         N9fw==
X-Forwarded-Encrypted: i=1; AJvYcCVzKY25SbJgDXkxx8DpyeiotJRsWgmKXVUVYorm2TjhG7q+CwCBR0kkSuvE4et1bmf9V/8XWkOhv9c=@vger.kernel.org, AJvYcCWeo5nGI/tK+JdHOlVwKr9gG8C6hpmxmDM3F23AcnhQQoEer6/uW8ZgmnyjM5+7aZLdwMahVqu67NDewtlcH1xPfxn9@vger.kernel.org
X-Gm-Message-State: AOJu0YycKqv0ge/21SkaVFMhMaqWHmISRULumtSP3tPc99m8WozYjSh6
	Yna+4POJHDXaTh9eHY+8C1UB7F+hBgS+Bh7x20y2ByzUtDMWFSQY
X-Gm-Gg: ASbGncv690zjJrPkop1bmjKtQE4XECDMWSTdi6PGXq4Vkj8niBzEA4GSyZ7EinWBb4v
	+DvRJu+x78EVmfar4H9lJ9WAre7L26xId58aop0Meoacm9IrborGAQMEYsFHFs1gzdTCtDMdpZr
	6U90vyQyvezM1u8HDl8+CNmu+WtfHFCLFMsskgXLEG5uGPp556vEOWBCo42DjXPRyfXsyh+j4zf
	9StZt+CnewdAulVnoLHNLZsCKBdW6amajQDt+newFC0XfjOIc6dkDaoMbtRHvbOlTGvH2FQANZn
	pu2fiZIkf9AeIvwrWGajrkqqApsx9l9N9De4Zfrv
X-Google-Smtp-Source: AGHT+IHlt3s1bNXF70pZDG3Huxb7B0xPxrqB/2waFTKpBK5Y7xvtmoAFELG4dQ5st2tD40r4EY/h3g==
X-Received: by 2002:a05:6a20:12d4:b0:1f5:591b:4f73 with SMTP id adf61e73a8af0-20179969b8amr23886618637.34.1744688784710;
        Mon, 14 Apr 2025 20:46:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a12c8ac4sm10100383a12.46.2025.04.14.20.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 20:46:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C40B74209E46; Tue, 15 Apr 2025 10:46:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH 1/2] Documentation: trace: Reduce toctree depth
Date: Tue, 15 Apr 2025 10:46:12 +0700
Message-ID: <20250415034613.21305-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415034613.21305-1-bagasdotme@gmail.com>
References: <20250415034613.21305-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=bagasdotme@gmail.com; h=from:subject; bh=Rd3o0sCpC2xXC5Pjq8gk+zddcwr8eplBuFqEp1EciuA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOl/r7Hd4FburH9lX59mu/X8o77EHKdbB2+utG/7tkRKf G2j0obEjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyk9RUjw1w+61z3GuMThiqi DgqeqpXuP594TVvML79ZSrS+XLzuDMP/SqMdjAcyJ2hW7tt1iyPzWJdNUe5uI+Z3f5ZJzt30RuA VGwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

From: Purva Yeshi <purvayeshi550@gmail.com>

Reduce toctree depth from 2 to 1 so that only docs titles are listed
in the toctree. Individual docs' table of contents can be shown on
sidebar by actually visiting the respective docs.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20250318113230.24950-1-purvayeshi550@gmail.com
[Bagas: massage commit message]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 2c991dc96ace60..fecc4adf70a830 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -3,7 +3,7 @@ Linux Tracing Technologies
 ==========================
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    ftrace-design
    tracepoint-analysis
-- 
An old man doll... just what I always wanted! - Clara

