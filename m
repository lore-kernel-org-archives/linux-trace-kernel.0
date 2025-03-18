Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF191598F4;
	Tue, 18 Mar 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297575; cv=none; b=qC5TgPzkGkcWhs3C3sreaLOtFp4xr+w8T4kPJu9WUuup2utZ4ZzwfeFuFWytZkr7XKN5aYxtm4VrEtTJV0BfhockASmyLLkyGEmOkv/epLfPGcU6rQLrucVr/9IyhuqB5BYpfe8IKI4tbTzwi5Zl5w2YfQPZ3CeZNYKXNtjwqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297575; c=relaxed/simple;
	bh=DOLg4qCV36A7TvJtJdyAix1jKsHX7JjPHQ2ArcXagQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jvc6zWiHbJeX90vS0O3V1wXRTvXH+IMiWmizTMu59zbNYtjSMgfFRJYcFLrQRE+e1LAj7EXqHcDaNLDbh66Z3+OE7SKNH22O7ihmHuZXy22iCe72coHj2JdjOcHOymvAVTZm9rrStufI/+iQiXBcKR0iAk2xOjZgPoWcuHIhHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wro0Y2o6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wro0Y2o6"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso5471192a91.1;
        Tue, 18 Mar 2025 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742297569; x=1742902369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llCyBpyuPyimvCR5J3EoIvDpQdWHHcfEhpAsJ9dqxHU=;
        b=Wro0Y2o60lKu2t8BsWuAzV8bMqztZtSKcDTZbJxEiyYYLZqOfjpVwfTK6yMpHBjz/s
         cWUL41Yu3eh2DJoYRZjC2yjwKC3ACRadVZ6ZlEVztaqa+GgP5aBgvqgDN0h+6VZu3S4f
         v1iNMjXpYZeMpIXSX6GQQpDfF/UDezXZPER0QrK108omi+axxJDHOov2BSZLAqEEWRrC
         mAYmNESoN2ix6dbyAZBRCOMyqk3d7PpfOwDZnY9wlce2YYJWzHQuKHeIFuxxXL58E9RO
         PLiC9kyAe8oIS6eRLMn8VBj3Xvg2nxadxa0MJ4YdivtXyxwl3GvpoO97oJQAp4S2b8Hb
         71JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742297569; x=1742902369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llCyBpyuPyimvCR5J3EoIvDpQdWHHcfEhpAsJ9dqxHU=;
        b=TqeIEqOKdYX1vbHarTBNh539waSfZh4+dxY/E6sbFuvLNLqQpd/BwHY3ECY0lsMGrM
         IxNDC5rbyMZVf5TZtrVV6uelAZ2XK5fAd3b8p3y/cIZePLIbST9KU9ZpOnaCC/RhSwEL
         ryp4MAbJRX9KDFoE2PheuqrJWe0lOSpfMH3Zf4y54Tgx+WCMaff72gxTeC4DOO4KXrnB
         i+5r2DjSK6CKWf1jpk6wU6zz6sHCI9bvL6uGXr8U08cbMHXwf/RnDAej2juPMs3Z4viA
         j/+v/5J+qpcH0QirHZpdJwj/eOBQEJ1j2hHCcRCsYiszQauFuOohciDOIHqG2EE0S/M4
         Oo0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBbTdoaGPjiQqHdW1qfQwmLG0PTradRigVDY4OUb6llhSwfkxRPiHGVdo0mgaMhQBW2GSxpTiNDMI=@vger.kernel.org, AJvYcCXMK66+zFSx4R4pU6gLsZAwSITkI16fzwNxtWvnTxv9Y2MHkMAFZc/GiMi8VNP6QN+dUrmaTknFMj8hKjkz+wOalgMN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3QRvv54sG9YFbtbNG/94BH0YqyPofpmEDNF3Q+MQpS67VhfEp
	ttuIiweM+W2RuaY9iWyjStWcwt0xvM6/ELbIck3eRObl5fP2SjLa
X-Gm-Gg: ASbGnctfNOvUkQJGAk8tWL6M5ukJD7Acm+aUuH3iJFFFFu63rxIQDiVD7FpJYC6mY4L
	7WzTOEm+JO+jdQl1AkenJjhOMTb4CZQZUUHKYgjrkslv//LYZ1PeSAbaPvkQ/YwYfiVly192/iZ
	cU/BsgjNzCEemwA3s0KQVpH9tzpOOtqW46QzTxY4kf2qN5ReixThNzKFcc57xSllxCtXr3SRtcb
	iG7m/Xtl0lw+SpuvrgFFotJOAZ7cUCbPM1AvGmt4kHWYVaYDdtS+CUwrMOifH8kzv3reYjSUY3e
	iX+0D/OGwvzwjzJDHl6OtwEBzViT4gTE1tXCt+Ui1l4VDRdgyeXzBbMRYBtLSJtWqf16cU9+ffg
	=
X-Google-Smtp-Source: AGHT+IFC4kGCuKFADzEYkuZqmtcTWDGH6kHXcC7o1xX775e+lgRcF41Lg5LZn6d0S5J2XICWin9wNg==
X-Received: by 2002:a17:90b:4a11:b0:2ef:31a9:95c6 with SMTP id 98e67ed59e1d1-301a5b13817mr3095801a91.14.1742297568976;
        Tue, 18 Mar 2025 04:32:48 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbec04sm91832555ad.191.2025.03.18.04.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:32:48 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH v4 1/2] docs: tracing: Reduce maxdepth in index.rst for clarity
Date: Tue, 18 Mar 2025 17:02:29 +0530
Message-Id: <20250318113230.24950-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce :maxdepth: from 2 to 1 in index.rst to simplify the table of
contents, showing only top-level document titles for better readability.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
V1 - https://lore.kernel.org/all/20250204133616.27694-1-purvayeshi550@gmail.com/
V2 - https://lore.kernel.org/lkml/20250206141453.139613-1-purvayeshi550@gmail.com/
V3 - https://lore.kernel.org/all/20250312124717.7208-1-purvayeshi550@gmail.com/
V4 - Reorder patches to apply the 'maxdepth' change first, then refactor
the index documentation to avoid introducing maxdepth: 2 only to modify
it in the next patch.

 Documentation/trace/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 2c991dc96..fecc4adf7 100644
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
2.34.1

