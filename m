Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D5192B81;
	Wed, 16 Apr 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744771273; cv=none; b=TifaKWe+A2sqIRJL2BNtLBU4cQgG+kUr9ywtELT2JbKDqHn4SDXodZFdX5h91lXNWR76W3napoq2FY9T3P1Eps9aR3cY+uLTH0oTnoJMAPCQT3ZKR/PlKeiHzmV8m0W/+Ugs3bVehqqQMBdIfxvmLUCW93lM32bzTSozZs3P2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744771273; c=relaxed/simple;
	bh=3N6LOgb+H6Wv1hBOR5DLmBDu8H4gL1D6nPVmVQPsQZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqYznXZ0eMXDDwK8JKyBZ+BaUhSL3adkJ88Mfho7wCyN4Fqib75OALHq0JjNAXWKrTn+b80NRgbxwjHQXr4BOCVWIwOUl2lFvYte2MdFzTsoBkBxoe3pAztMu4ddOZyAvvUoDZ+xqjw2W2a//U6GOHAaYV1+z8mH/E+zUhjAPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiRakAuq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiRakAuq"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3031354f134so4433112a91.3;
        Tue, 15 Apr 2025 19:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744771271; x=1745376071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlJ+/PGtOiF9gFcTY5+kwgIcGH7q9DioFYewJ5RrqTA=;
        b=WiRakAuqpaDOfVhAj0RQbVUQKEURwtw7QzqP4NfCFI8kLdk5hMRXpknkMQ36jeJshF
         8LW1ABF1nZSBD8ZQuuzxTaDbwMw/nAACagaD4FAY4R+4Hn4bP612z40PW5RHt53bc9KA
         txwwJMLxg2ktIDs9iN1wEbDUVUW1bZswJlQsEeX2bSrHBY+UdkbsBK78CUaiumLKT1Ec
         mpWOFJCSLos8ANgRq/cYDFpsJZ1SHmYicz0FDv1BCFPebm9nEh7zvUB2O1pJQtE+WYGV
         6ia3Ncg0HPnv3xABreXMRuJzdCYHOPt2vOylebCK0UNTLXHrKtx8EuzfqkreCtwg9Wv5
         w7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744771271; x=1745376071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlJ+/PGtOiF9gFcTY5+kwgIcGH7q9DioFYewJ5RrqTA=;
        b=Ahf4vCHuVzp1jwvLisN9LvDqYZodGYEvA7h8HG4mRRNo91WMDwrmGdlD5w1svk+lJn
         k5/SqlyaXMauj+AB5sxS7i/pYctIpUEyhnXMwZIcrHCVl2B5/ZDHB+VTQ0IsNLAmbOUm
         ZYDR+kWG2//qoWTudj3fDkRh03zAh5WB6KOme70YJb6OpxW562Wt2tA9OK9/fg5ORviu
         iSbap/zGyZzDa890D/hMomkFzGAj8dTi/n6YlKgkzfos7/oQ9aGO/FMzyMROXhyuCvdM
         M4KFLxLf6hEndQfnxn2rz5tSd9BFd+OvCNBJMgPRtxzcFoHm9VGuOn26iSFsy4rO14Sk
         UitA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Roi7ImZKCNPtavcmcpe49SBn2BA4XO/YzX/MBH1C+NLapL8S03ZYPeCv1qg9ZqM0Gy6ZoL2yXaU=@vger.kernel.org, AJvYcCXDqNyHxCf454WvjE2cEMPyHMzKmWPfdbb1/UbAD2WBObluD0I3JdSUfeiMgZudrui4VJP8RDv0Zeosyd8VVmMlT7gx@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMRAT6Q8bJ0Zl3hyNOpCzADKZjx9d5lfY7qdhCboEwYfCrRrC
	VNNHtDJ6Td4ly2/gtrBkOyDlBk4clywVHIj2ZwHxGauDWi3KS4US
X-Gm-Gg: ASbGnctP4w/D0rZ8mbqg4BF0H/Ro1RsR5CmH884Up1LCyWfirO56PAfratR/SDpq8KN
	OJNgfgDVRS8rqUZErBQSimFAdYMKxpQNf5TiGyHi229nmkCdCZTcuX1E3RV6TDZykC6CgcRthC7
	xo040eFUz8cA3bLXj/pqeZINXl8eHudWgjZw2xS5vuuYqTHRaSvmTwUizL/Ofec00+Tbiokj1P7
	Dxx073R7Kch6OAjAJNHeZ94/4R7QiZEyAFDTO2UUVb9RkwDHGodvUExy2RLvbBlHZ5oVPzEAtsE
	vBCar0b/rdhvSt/OtDoCKbgW5e/kPIe9WAQFGM3S
X-Google-Smtp-Source: AGHT+IGs7StLpAeQXpRdujwOrHWYpmgZEUDMU/HZ6kEXLhuq593Vf/X0ERNeVa4Yq7rEFbJBwC8qiA==
X-Received: by 2002:a17:90b:2d10:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-30863f18c46mr96636a91.12.1744771270668;
        Tue, 15 Apr 2025 19:41:10 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613b3903sm352502a91.39.2025.04.15.19.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:41:10 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 239564209E42; Wed, 16 Apr 2025 09:41:08 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 0/2] Table of contents refactoring for tracing docs
Date: Wed, 16 Apr 2025 09:40:48 +0700
Message-ID: <20250416024050.19735-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=bagasdotme@gmail.com; h=from:subject; bh=3N6LOgb+H6Wv1hBOR5DLmBDu8H4gL1D6nPVmVQPsQZQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOn/xX+fdl9nrplxLdbYsfbJkTetntduva7Sevm7kE9R+ 08Wb4diRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACay7DLDP/VLG1Wy0rh1Hy62 8X12YoUla7v1vt+X5BXzeKqumhfsamf4p1w1VZFPZ777g+V2U0qYbDI23z2Yadn6R/ZD0bbazzM fcgAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

The trace toctree refactoring series [1] didn't make it through 6.15
merge window previously, so I forwarded it targeting 6.16 via
docs-next tree instead.

Enjoy!

Changes since v1 [2]:

  - Remove mention of individual docs' toctree as the generated sidebar
    toctree don't include them ([patch 1/2])
  - Move uprobetracer to user-space tracing section (Steven, [patch 2/2])

[1]: https://lore.kernel.org/linux-doc/20250318113230.24950-1-purvayeshi550@gmail.com/T/#u
[2]: https://lore.kernel.org/linux-doc/20250415034613.21305-1-bagasdotme@gmail.com/

Purva Yeshi (2):
  Documentation: trace: Reduce toctree depth
  Documentation: trace: Refactor toctree

 Documentation/trace/index.rst | 98 +++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 17 deletions(-)


base-commit: 43e9076a00b17cf8115b4bd4d3b2be33a44245ca
-- 
An old man doll... just what I always wanted! - Clara

