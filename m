Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F77083C;
	Wed, 12 Mar 2025 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783690; cv=none; b=tQbj1fE9OqflQ6vZMw9uLplYT48vIA55y9LYjRmg7/y+NuB76u2Upn9kXRTW6jwmElDlYzUO45uQtw6s2/3jZabLWRBhNfTQlxwReglsk9mOtiweszohw+JUF3SL/C/WLzMZGTjM4jPiGnqPd079C3+bGgWiU1/eujhmmn9pBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783690; c=relaxed/simple;
	bh=isFALg6CXqDl8cu7cPP7y6ryoQs71iJg27uKq5QT0gM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D4P1fesp7Z14IUFrYASQoCGWyT/P8TEo/7u+PUE2SmUnlHARVp+giZ4mnqWiGL4FxikxJbLtygv1f2MdORrzr01tRfunSxGnRY6QDLnsSocZrBhBLc/f7xnUlmkJ66M29ii2KcLalJK/A22uNuIqtcjEp7yVWjPabdj9R8PWO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7gfbJYX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7gfbJYX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224191d92e4so116098345ad.3;
        Wed, 12 Mar 2025 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741783688; x=1742388488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKfNUEOjLl/LJnQn1CB92jCGeCH7231aksnRXVNSbLI=;
        b=D7gfbJYXnYYnGC7NlNFFkjvWM9gNLN/20CKb26f4b6WonuCraaPhbFp8EonLLZkgWm
         kseC86Dfdyl2A224p/Hqp7dBiRXU1u60c5kI69edhZaFO9bnq6QHGS7uRO1JiJ+wWqPU
         HpYnXhjvVK9oBOoYf4wRCeUJIHfsEphwM/xVGqlTkVaTIPgIzopDQtPh84gKIke3Y2Je
         cDYvGO0s3Ny223xeUSOwsBi1VjbNCwyfc7WxDpiGWzP8tYNVeTa6aOqqlrwaW++gV/Bo
         WpRkeL99bGOUjd0W5QOwQ52Yrhwovs3VW/aH8509Tg8Mwdz4K42pxwPsKCUOzlysYDHi
         xSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783688; x=1742388488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKfNUEOjLl/LJnQn1CB92jCGeCH7231aksnRXVNSbLI=;
        b=O5e+K4NZjYSEVPJr5En5cg3OBI17RoajJAopMZMhYpOS3N81iujE3FKULm0/e5Lkjc
         H3yd3jHMBoE/AGq3gs9CHH8zp0T25+HyEmWan4BJ0CD3f5ZbBwc3R+aOyoQWMFzjZbO0
         YjGqa33/8iuOPIx7X7eIn/TY+SGSTTwxLutnEQ+ijC+Zm6gxZU2sFA/UOtSKoJhKm5P8
         WLtXiRuNNg71jOans1zVTgDr238lPGDN5T0NY/zxK1zJCXpUVD13OMqmlTpy89KLo2JU
         eLwy5vTnb1FIaWVAC3c2d2whex8diPzibwNTmzbphpukGqevg/ZWRkIYlb4YuNGCMO/U
         upUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQvSQPIJLhcWX23OePCcjoXsRjcik/APNU3LvAAlfA5WH3quYKAWA6JWe8z2jkAZSqcp9tq/Zbsqs=@vger.kernel.org, AJvYcCW0E7YCBho2w2kAST0uGJraTgApZEki+CJDyDdWrG2I7abcL2SXCnYR20kgrHhQQzrQEsVwwxk9cw3pLkHlWT1Vk2+j@vger.kernel.org
X-Gm-Message-State: AOJu0YybjyGIe7afh7HXLinOgny3SKRdRUDVLez4xuuviLxwWcovXm75
	VUGVMnDvGu8L0GVU4iT6nUK3OWxyDv0NRNMhVIYM0huiwAtwtZdOxP3eE+E8Sa0=
X-Gm-Gg: ASbGncvHcxtx+X4odnpmNXhD4i6IGuTDPBmvdMs2RmytzBEiMws2r03K2Xk49VC6LLT
	LACdLad7Q5OF3qayIedj3nGRA+EWT/fcsLd8ZOxNrC5wF9BCPYXH1TNg6U1YPJfkXey4KvouRq6
	lgZZVkk1ai3YRQETkuRXw1r09do3SgD+br+GMsENLznv6FOPUXA/axnVrihaDCjXKgZ92vnmqG2
	CHl4EyRh3Q3sVd2hn1m5MBxTFIunL6IF5DzydNi6I7JpcY7Xe0ad86K6KjDwEIJWdXIRbyIOcCK
	jBr7wxIYw0wPv6L2Mj9swMsq7XeuNb5WFxFHrAqGsILHDpc52rS0Ue8aVgpRSHjkb9CUMxrldZw
	=
X-Google-Smtp-Source: AGHT+IFMdvZe1JJ6e2ro31UkmEH9oJC8nZ4v/iMUoD+Rt7YW/5s4APGKEYUsBzsiB6vMc+O0ttl4bQ==
X-Received: by 2002:a17:903:1a0e:b0:224:1c95:451e with SMTP id d9443c01a7336-22428c0568amr319909885ad.33.1741783687847;
        Wed, 12 Mar 2025 05:48:07 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a9dfbfsm115011535ad.209.2025.03.12.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:48:07 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH v3 1/2] docs: tracing: Refactor index.rst documentation
Date: Wed, 12 Mar 2025 18:17:44 +0530
Message-Id: <20250312124744.7234-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
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
V1 - https://lore.kernel.org/all/20250204133616.27694-1-purvayeshi550@gmail.com/
V2 - https://lore.kernel.org/lkml/20250206141453.139613-1-purvayeshi550@gmail.com/
V3 - Improve section grouping and refine descriptions.

 Documentation/trace/index.rst | 94 +++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 15 deletions(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 2c991dc96..6b268194f 100644
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
    :maxdepth: 2
 
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
+   :maxdepth: 2
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
+   :maxdepth: 2
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
+   :maxdepth: 2
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
+   :maxdepth: 2
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

