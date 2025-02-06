Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003C6125;
	Thu,  6 Feb 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851319; cv=none; b=qF6JRc5zgHsShPzr6O2Ju074bUsK+GraghyEsQ9YO/6zU2Pa3pPenr/iBwLBIWPeLygVXM5oGfSy+nFA4kW1TxtfIGs2KyUUlwIAYRnjzomJrieLEsH7cw+1ZMV+uNeYNnvXJw8ZKEOhwkhl64OyBu8zWfhI5WD++gKUuOrlmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851319; c=relaxed/simple;
	bh=jIaknoI46pH98XJg7IGd20sMvKBtXZc+OdbHliQJ2ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mIyiq+lWA+dMnAD3X3tPVEtav+1IsUm/E84V+fx8GemKIxO80qn0r1Nq+BoNXXC8i+TYFLB6f0vuIaHFW4knAyP/ewuXuGltgAqXYYZUI4CKHa409e/yawo+WizjjC3oS+vn4N6R+bSI1NbXRwZoHQyyOPhWy/SgTA0XVS3+9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2otohJ0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2otohJ0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f49837d36so2493675ad.3;
        Thu, 06 Feb 2025 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738851317; x=1739456117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4PtIoyen/3p+LgpeUZGdjWbDAFiF6GML9/9a6imyK+Q=;
        b=K2otohJ0+ZKakSP82UYNWMQeud8DpGpgcypYMpXo/tPLuz5gEMAmwCRQmoEMYnFqKs
         ucV1M//CxDgimTTksssjEzldvlnvPXotfwXcjYvYV/rlKqpP/ZQaAewKQM93ZGNeZ7pX
         dPdHYwPD4lsnE7XKdeXYq2uuEhqOFk0ToF53AmDVFCFSZVWKm82YOTTyO68JIRhC+una
         L89ccasSbqzX1KBhvaOG8FeBqQ7NHyFXLqu81cuB4ypYsrgSkYxPSVXFAJJvIdx5WbyD
         wcuCh6I23hA/nBkJl+aQn4MjjcnVRiRy1781FGZT73hS8vu4pIGoNyf8zy61JDw83bZ1
         Q9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851317; x=1739456117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PtIoyen/3p+LgpeUZGdjWbDAFiF6GML9/9a6imyK+Q=;
        b=mUvozYzDrAeZrbbdNA22PHYRmpGGGEnMEK7jieacPFS6uJba0weqUU/Rr9CXIFMOfC
         HA9eiOss6Dzj2evPQNDH9odpW1hR+tnq/konhLc9yB8uczckgZtt+fvL5i3jaqeG8pCE
         pMWJZUeOKg2utwqrw4u7WjFAND6bOVYcIkU6qXPWfiuGwRjMS6fCSPqkiGsLcQ/82jyf
         J3CKXUmh7B1OlepjUXKc82XmS1tELb7j0sq6J6wYg4oxSO/RWnfLw+yfydWqv2VpztE9
         zwvSzV6mZdQTcKmz8UgnrlBdZL7amrsMghSCwnywUxCbKhIBBSVQdbDi4GXue9f/EZti
         abQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9fnp7Ce6twb8419ov9PE+bp8jTz1hHVFjyBLsYbtsy9ivnBx5iqsz8tdztlX8q6qzYj3eYtY9wKE/LaET@vger.kernel.org, AJvYcCVLhi/aLifjcnAIFBev4VW//YqymrbyP6jpAr9E1V1rk0aQoBR5gv2+pvGFh66vU1S7BhKjvJmSWpJm/MzP7AvHmCVX@vger.kernel.org, AJvYcCWXG1/LGVSk4/Fv/iY5TQtmcD51KmhaxJm0D1qF8F+sDqUUnABRCgmKQkRG8SnLUIWZLD2L+TJ0S/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/uIR9SNvyLHei89prjH2SRWH/l+XeqUBXCcp+4XbWXkrWWxXp
	HJx7IouXn/ovDxEOLWA6dQVlp8z6tKKJ7TjoETqULdAD01+VUnNqRuRKhUZ9rKI=
X-Gm-Gg: ASbGncsBVNUDoCHsCWWRcEvVLAgPufl8AQhNWgCFgjMXMu+AnIz30csg0Pa7q0wKkGR
	fJTMCQQJkIUDrJR/2jhNN7pM3dVZZcQiMUIFn6LEeJ3V/kJhj5dwnZsSCYTLI+zhTpPii2TVTII
	+VUuM07+OVzKAmQbQ3FK4Vy33W3EQgS+N79CNpsUAjJe5fD/od1HI6Jqtrooazps2jm5JkmZ1R9
	NprNpJXu+OqFCZ1nakCxSZu7mUfjDLK0fUqju9OBBqQ43OFUwUgIRV8UhZEIeASA1XFa2DyXEBo
	jl3GVdYT4Io8MG2FI3Y1sclhhFyaqRAOxC2eN8+o1t4qJ5q6eg==
X-Google-Smtp-Source: AGHT+IFI6QxzMOyeIjRddoZIuBFLA2v8twGMenO5NobMxpp4M/GI/+e+PReJk4mZwPWLNrGNyhS8qA==
X-Received: by 2002:a17:902:c947:b0:21f:7bd:57f1 with SMTP id d9443c01a7336-21f17ee3e26mr132014365ad.53.1738851317116;
        Thu, 06 Feb 2025 06:15:17 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40c0:101d:c4fc:c1b6:678a:7bd4:c9a3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368cf415sm13045525ad.246.2025.02.06.06.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:15:16 -0800 (PST)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH v2] docs: trace: Refactor index documentation
Date: Thu,  6 Feb 2025 19:44:53 +0530
Message-Id: <20250206141453.139613-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactored Documentation/trace/index.rst to improve clarity, structure, 
and organization. Reformatted sections, added appropriate headings.

Background of Patch:
This patch is inspired by the maintainer's suggestion on the v1 patch to
bring the documentation into real order, similar to commit '270beb5b2aae'
from Linux 6.13, improving clarity, structure, and usability.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
V1 - https://lore.kernel.org/all/20250204133616.27694-1-purvayeshi550@gmail.com/
V2 - Refined formatting and improved section organization.

 Documentation/trace/index.rst | 86 ++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 11 deletions(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 2c991dc96..c4ff7e7de 100644
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
-   :maxdepth: 2
+   :maxdepth: 1
 
-   ftrace-design
+   debugging
+   tracepoints
    tracepoint-analysis
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
    hwlat_detector
    osnoise-tracer
    timerlat-tracer
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
    ring-buffer-design
    ring-buffer-map
    stm
    sys-t
    coresight/index
-   user_events
    rv/index
    hisi-ptt
+
+User-space Tracing
+------------------
+
+These tools allow tracing user-space applications and
+interactions.
+
+.. toctree::
+   :maxdepth: 1
+
+   user_events
+   mmiotrace
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

