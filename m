Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86924A04A;
	Thu, 11 Sep 2025 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564740; cv=none; b=htaXQhTnKS69JJKrkN2GIhSQ9IjxUEF/ta00adSXjgk98MiRtNXdlsHBV3cfejw2/k9Da50YGm24n4tHt42UwFIyc2BYqXLADrRnVobVaoI8FyYtsuGlzwRGtoOEoapZOF83InMNVCcbRHH7mVOwUkHisOd4Zl80FmqW3WViDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564740; c=relaxed/simple;
	bh=jZWB1p//ISIVh97qcAyBtmJJXK3oz2kT8G7DjODCOR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byyydchr3hbiIEtBe4ineq3Bn+NBC92kVff5h/bMne6RhW4lJ8iLMydzt9ai0VmBzrENHN21dxyFDQ0rOHZE85mT2jv3YKcT2NitDFRcdTAQEA8q2z48uCfq/YeSk7gEUD5ew486akq72WiUInCmDyXcpF6Rr3XcV82DiQuRiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8GjP8FT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8GjP8FT"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-25221fa3c9bso11370565ad.0;
        Wed, 10 Sep 2025 21:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757564738; x=1758169538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU89Xc9Cv0xX/7xLo9LGEng1r4NnOlTOyfnu4zvH4C0=;
        b=Y8GjP8FTgSjDRIc3nn5byfb3hojdO5klb0b3uhASwIl0/yE+v7/EHNd2wvosDC1UzZ
         hO+nbCqNJLDeS0AUmOzlehlPH6dLDxzbIzf8RJLNO6J1oMmfX1MudQuwpPEOGTbmAAvw
         2QTRftfNwfWGC8bqQgB2B0gc1lzUREilkEXxBLPoorUZC1HdNllMcFcrjUokX/oodg9+
         9QE7/dSOtVaShqVS5Li+UfZSB/ftKct3mEygOxXh/TrneuuiKOO1az2nuFwu+Oi913EQ
         BHFt+AWQsmKEXHs8EUqxAVojLs33bTb+G1gSg4gOb72LuqmDjvq+x1bsqF/jnhxEXOZq
         gVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757564738; x=1758169538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU89Xc9Cv0xX/7xLo9LGEng1r4NnOlTOyfnu4zvH4C0=;
        b=jwROwEF0FQXW/WKP7RhJqKONxyIiu0NrYVOYE0WBDB4sG5GmTkV6jEzqtxKG4t+V0+
         npVpWu9SUkRjtnddMJxJGP/h4oTVRfiXv0CUGJCKXzYU18h8zN2vVOCG0YHdkmTr1aP6
         9ZV3NU0jS5tGyqWCbZy9G3340VddU3r1KkrfQ2R7nhxRyGxaYigxmScKiy0zHjfrybtG
         FgO/gZifsJd+rwxFizxEBfcAG0S7vO5bd5JVJw1j/gdnaWRFJm0r1YjLxUfBhWRFEv91
         m06RE1kvIIuHZHGn2j4RpEXs+tprjpo0YyzkfX6OjTpkl5Q3NbxHx75NVS2TgqZcqgrT
         ypaw==
X-Forwarded-Encrypted: i=1; AJvYcCUFLvsE3FxlTutQf20+BnaqRxH8XE++2PyTgyFeg/R33XxPFpIP93orZMWSg0q2g42tHNPPzj8n0bo=@vger.kernel.org, AJvYcCW93YgXJm4lJWP/N0d6yL2opMHrGfMb0j23sceV9P1e9lvdC+/g2eBzudpRH2fXhzvnDk+JJvOHQS5KpEVCiy0MtQT4@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTU7irtCaWCOMdQYOqoiO+Ff11XrWKI+Ml4y4/u1IKZwiY1bS
	RmuhwNMAaUI9IDnnkjtP16/AjxxR2PqrPEwzMPE4LDMXscv9/H2SlY+O
X-Gm-Gg: ASbGncuCVM5OWns8rEb6wyhHsGSIY9NGtBFIcQOTTlLRluwlAzTBccU2z1gp1p9GKGY
	vd/e6A0MLMkhbC0ebVXG6IJjzeBzeNZ6zGOanIYbaGVajDzfmStMLBWz1GaCnILnA677X/vMnq6
	BcyRLzfFMgeoOYQE2cXJl3IRv5RVn7WhJmzRY9hmbLOI81aLndT8HVq92IuzDdSrKxafw4y+Rfz
	G4HQEjKDOC9NMI4zCIOW6UuxNp4LutdqaclImbn5j9gzZWIvWfC6wkb4wwrbTs2yT2CyNrMViKb
	010/bxEWz+2x27dBghOLA5SFqilnHyqKAfFNqc/B3ELjKBbKoqcp+tjU6RMLZ2aJJomjqMTqS6c
	3NZ6xJQnS2abFsOxXnDN6dTRjmw==
X-Google-Smtp-Source: AGHT+IHbS9cB5BACUix80S5lFEGDN0c9HkDKYow+/+wRkyV1CA17KHmwOoLnPeMBuOiW9pBwUbDVfw==
X-Received: by 2002:a17:903:2442:b0:231:d0da:5e1f with SMTP id d9443c01a7336-25bad5670b1mr20564335ad.21.1757564738271;
        Wed, 10 Sep 2025 21:25:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a62esm4148865ad.66.2025.09.10.21.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:25:36 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D4B8141BEA9C; Thu, 11 Sep 2025 11:25:30 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tom Zanussi <zanussi@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 5/5] Documentation: trace: histogram: Link to ftrace docs
Date: Thu, 11 Sep 2025 11:25:27 +0700
Message-ID: <20250911042527.22573-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911042527.22573-1-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=bagasdotme@gmail.com; h=from:subject; bh=jZWB1p//ISIVh97qcAyBtmJJXK3oz2kT8G7DjODCOR8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmH/C7wBhZHffl0yaDud05e5vp007M3c7Jd50XXHA+cM i+Hof9BRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZy9xgjw+snTy3TOQ6+N2d+ eMW7LNTVITpmcWh2jVRNMM+9qZscdBkZ1rZc1M/2c7mxMjj1qq5rknjL02xxlSP3ZwfMObl07tx yRgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

In brief "Extended error information" section, details on error
condition is referred to ftrace docs. Add the link to it.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index d158dadaa42447..340bcb5099e7a4 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -209,8 +209,8 @@ Documentation written by Tom Zanussi
 
   For some error conditions encountered when invoking a hist trigger
   command, extended error information is available via the
-  tracing/error_log file.  See Error Conditions in
-  :file:`Documentation/trace/ftrace.rst` for details.
+  tracing/error_log file.  See "Error conditions" section in
+  Documentation/trace/ftrace.rst for details.
 
 2.3. 'hist' trigger examples
 ----------------------------
-- 
An old man doll... just what I always wanted! - Clara

