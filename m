Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5B1598F4;
	Tue, 18 Mar 2025 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297580; cv=none; b=Kz22MQ/lwxBTA+4RRsWnFPoeFU3l13BSaMSj+/LAs4FjuWeln4qhU/QFm9LNUUKUK4G03Zx0OVY2lqAGw7fmE8IXYFCabZ5n0p1TYsp9KfxJU2UJt8tWgU5LGP3W49mEZ3BuusvH0hpQu+w3/By1AfwIKue/S/a2Mnm4K2ZNAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297580; c=relaxed/simple;
	bh=t3+jC4VJlxk7zq+3qZl0kMOIe8AnJdJUdZcI1datJuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOEq4gVXnDDoRh2RcVha2QjSAYt/GnUkOcEubknS/6/NgqojxQ10oHxM4vVQWqu/PdPNEnJARIsxSBjPbYrsxgUkwkNRXejmF1OHlBteaJoMD0eSOHt5GRWzNejbaPuS+XgWXab5HJv/vm2mMoRmxFIqrQf4b81lwxO64hGrDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8VOKcCb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8VOKcCb"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22403cbb47fso100069475ad.0;
        Tue, 18 Mar 2025 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742297578; x=1742902378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKBd9Bhy+gsBxPu8xslCpaBwZDvHZAfH/ojcsdhmdaA=;
        b=Z8VOKcCbLpVL2eRSLNNpc4idLj798IftjxcwOAj3OhoG62OpQ6YILL1Kwc03n6DzqS
         vzZzf0oUjU98XdT0MakxBo9l8vMuUpMifGKxp6Tm53LS3vWDYQQpVFm/Rz5MO6iytHEi
         0LC2vPxkNWWUJEZnt6GRZ4wKjSBj7ZY/YB8QLZCLeP/Hd833B46gmhx/nOubIndsC8hp
         OEOHN861CUeb0XZfb/3SdFmdO4H/fJ3Vymf3rhfQ0/XqaSAzmkl5NwA1jCIBetQnT4Hr
         EMyaAzFxuTImP9oN0HctrovObH1+/V68Or8miZr3jAE4tCikZtIf3nSw98aa85qysnjb
         T+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742297578; x=1742902378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKBd9Bhy+gsBxPu8xslCpaBwZDvHZAfH/ojcsdhmdaA=;
        b=srubSNdHDbxvbfocUe1gj4KRkHi+qk5Hzanz8hocZdvZ0imHwPA87BYvecuI0AY4Bq
         SYBT/ArOeBb5uCGzR9v9UIsKr5ttRj2o86Fu2vU2/1TrXuuE2UWw+XEmCFfVj2WUnOa4
         mpCfF909t6LCcHLKbQDKrz4WD/S7nw+d8csTqCgSxglOVX3Yu8F9RoQ1Tz1Vc+ubg7Li
         tp+TUf+fXbgIg6nrJJvPEOlFgEhdXctzVYBpc0koE3Uo67rxMujngr2HLtMYgsewko+9
         Gn+wzAXkyDvM/enHZAzXJRpMQob485JGzVT934obhNIb9Aohh3362liD/+NFH+3zKNXL
         W5sg==
X-Forwarded-Encrypted: i=1; AJvYcCUqAxNl8Riyzy4KFqufNrOiQsEpcX8wY5qdug4KoKcEBbw0DaXN1Y9yIyobBBVDvpJw5CVa9Ebp0eznGFynd1NTDSG1@vger.kernel.org, AJvYcCWyE2JCmYs6lYN0AAJhS4R2VWkkZzKYmVEvsIdbC4rVmxPT8Q6nkcaArWruC8FkjFCIxcMDFqrBllQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExlQDl59kN+IsaFgFPxbaZw8svZJ1LGXcXR085jISIE6L/HkT
	lZmXKXqiYd2wQcclYDSx3QJ3ufUpqVQ1vrxnue8xfMUPQC/fuDhT
X-Gm-Gg: ASbGncsgvUyQVNHUbZsFyIEn1oTjKmmqkbb/Lggx/xrg+ak6154ZjHCK85BqYmLMFEN
	TDwzIv5RpetBHxuP/DnQWrtQXQ980+lnBAH6nxdTcoddcZOVBJtLHHl113YN0enK9OObqP/+SLU
	YezzinuIg72l8Z6+mWDaAOWH+45iQHaUeyrpXmwwJet2aNOBszmqmpJvgJTdBe/kPEMJ/oekq1S
	H5IAS9L6+qHSlLUK1fmLqOypAOLcFiRDImP0VMkMTTJCAhNI01sZ4+xkj2YMkACX7FUJ+exdV6z
	6bg1rZHYIyWXT9PHSJSrZoqHCqBx1qeFFMxDwXGLxaWia51hXMqL8zfEUJD1DZuLynxd09fVlH4
	=
X-Google-Smtp-Source: AGHT+IHKPxw4IPJ8WJ6QMFC/eVf5/8iWBVOTDdkbkgmi38/bwkOr9z11nynP+PACUOHffHH69duOdg==
X-Received: by 2002:a17:903:22c8:b0:220:faa2:c917 with SMTP id d9443c01a7336-225e0af8c73mr239070955ad.34.1742297578151;
        Tue, 18 Mar 2025 04:32:58 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbec04sm91832555ad.191.2025.03.18.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:32:57 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH v4 2/2] docs: tracing: Refactor index.rst for clarity
Date: Tue, 18 Mar 2025 17:02:30 +0530
Message-Id: <20250318113230.24950-2-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318113230.24950-1-purvayeshi550@gmail.com>
References: <20250318113230.24950-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor Documentation/trace/index.rst to improve clarity, structure,
and organization. Reformat sections and add appropriate headings for
better readability.

Improve section grouping and refine descriptions for better usability.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 Documentation/trace/index.rst | 94 +++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 15 deletions(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index fecc4adf7..5ddd47ee7 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -1,39 +1,103 @@
-==========================
-Linux Tracing Technologies
-==========================
+================================
+Linux Tracing Technologies Guide
+================================
+
+Tracing in the Linux kernel is a powerful mechanism that allows
+developers and system administrators to analyze and debug system
+behavior. This guide provides documentation on various tracing
+frameworks and tools available in the Linux kernel.
+
+Introduction to Tracing
+-----------------------
+
+This section provides an overview of Linux tracing mechanisms
+and debugging approaches.
 
 .. toctree::
    :maxdepth: 1
 
-   ftrace-design
+   debugging
+   tracepoints
    tracepoint-analysis
+   ring-buffer-map
+
+Core Tracing Frameworks
+-----------------------
+
+The following are the primary tracing frameworks integrated into
+the Linux kernel.
+
+.. toctree::
+   :maxdepth: 1
+
    ftrace
+   ftrace-design
    ftrace-uses
-   fprobe
    kprobes
    kprobetrace
    uprobetracer
    fprobetrace
-   tracepoints
+   fprobe
+   ring-buffer-design
+
+Event Tracing and Analysis
+--------------------------
+
+A detailed explanation of event tracing mechanisms and their
+applications.
+
+.. toctree::
+   :maxdepth: 1
+
    events
    events-kmem
    events-power
    events-nmi
    events-msr
-   mmiotrace
+   boottime-trace
    histogram
    histogram-design
-   boottime-trace
-   debugging
-   hwlat_detector
-   osnoise-tracer
-   timerlat-tracer
+
+Hardware and Performance Tracing
+--------------------------------
+
+This section covers tracing features that monitor hardware
+interactions and system performance.
+
+.. toctree::
+   :maxdepth: 1
+
    intel_th
-   ring-buffer-design
-   ring-buffer-map
    stm
    sys-t
    coresight/index
-   user_events
    rv/index
    hisi-ptt
+   mmiotrace
+   hwlat_detector
+   osnoise-tracer
+   timerlat-tracer
+
+User-Space Tracing
+------------------
+
+These tools allow tracing user-space applications and
+interactions.
+
+.. toctree::
+   :maxdepth: 1
+
+   user_events
+
+Additional Resources
+--------------------
+
+For more details, refer to the respective documentation of each
+tracing tool and framework.
+
+.. only:: subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
\ No newline at end of file
-- 
2.34.1

