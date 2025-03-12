Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F6192D96;
	Wed, 12 Mar 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783652; cv=none; b=H72QR2XyG51PxC4I14xAw1MCJwnq8aG4O9hIJ8xj0A8mii9QJrzmBa7JsM+fLNb+mDGYQASLyfaCQkIhuo4H3rCg/ou9lJl3QGHrcO88C7QEdXUQyJUnze5ZiHh3vsdf0Kog0V34lrxG6YuWFj7fNbQ/byd60OMvQpcIdy+Exe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783652; c=relaxed/simple;
	bh=yr2NeM5xZd+21Kz+8dbrA+63YokkKPeruGiWILIFWq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S8CVpYZeTUxkUiBLN5jXGN6oL8lAEcyISEOawEGlz03B+HavmYARhk2eHw8POjdZnPsBFUUZkKTxBHWgB63MtVkpI5bR07ELqCfCo5006ElsA02EeAVkH0njmUSiSuRgJ1yTLDQx/eSaiwzWNjmkiTqlauhPbNH+oqVmPN8nRfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTbPWsFa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTbPWsFa"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso9752082a91.0;
        Wed, 12 Mar 2025 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741783651; x=1742388451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4M/3rcO0sPMe5Iql+QqO4QeWNUxz9DotePxQss5GMBg=;
        b=LTbPWsFatOWLpppfA5AsktsfLfTgtMvZnCj1DJTCdJO9bQz85BULJyRT/Ot+QtyVRJ
         C25yYtHSvnZySxeUGBl18ySyN1uRK2+TnzVDZBcczrgsLry+9W5cVYVEgMzcSHPv+qHs
         l3BmRhmfLrw3UKmpNFnPCCPUjK6UQrTJFrPxEPnKlvTOX/qeIgLbH5g3waaBN1dKGFei
         m1PgCJOUjfngZyC439DLYjRGIBTzKjXK9vZG4dIyWie6+nl5C00qiBtAyV8Y6u1T8GR1
         wVOrN514qgL9w9Y6GJVwLHpgCMMsUMQfYRPNq2d8qevYIakVMOE4rx2ActGvbok3t6F8
         tksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783651; x=1742388451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4M/3rcO0sPMe5Iql+QqO4QeWNUxz9DotePxQss5GMBg=;
        b=WGIbv8dDDsI+DZFq9GwKyj3Jr+47KIz3FtSZyJuqG3WevXLlNwUhlx93wyckh0rTnB
         LrwA480jgcUpbYiEfvbEgn3Q5Vu+fsAU54UrlAqmUv54+4Tow8mIsX30+Jl/72Cp6pls
         oZUtMXUocrvZXLaMLNvBWBW2ltujXWdsZNyhkSatCslWcE0X8/Iso38W1krFSSDCvkdh
         zoOwYP7R377WKVu91q1z4qULMVdSLFhLK1J7ExdMZ1vt5Gp+1XtDhVietsdkmP1eGGcs
         NnpFwR1+ludarrCAf9Trgxa68Pog6+HJ+yUN9fLAm0eQ+aQkM18CxZdoFSJ9St1ACgR4
         bxIA==
X-Forwarded-Encrypted: i=1; AJvYcCVusvrDob3Xaj4r5OD3OpaPEPA7zZbiohiHgfCQAx4NYCc6BupGFJgEetNw4ya+88YgrR5ISS8PUuUyhvz7LYVu4skz@vger.kernel.org, AJvYcCWZ/0ajGVBu1FAPTYH59vPx2OCDHyb0/8mmGjJ0wwHGkHb15z6ziMKMMwfT9ofcnl/6TeplNwO/ecA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwobKM5Ob630FQ8R/e/bXDaPK68tWEdF+fLLpTZh5K26iP1C9Mg
	2FT6lSj2OaXCZkUJmlheBbf6fIj6GtrgN7mSCe7/oApeoyoD9t4G
X-Gm-Gg: ASbGncseWo5N23sVJpRDRZHnhRqSGR7+LHFoxaLECWv8ZZ2K4ypwqy4Rek6UqqcqSXr
	8fkCvPpL04SB87VZYyT3q8sIHp3jEyf0B9sbUazijvTDHn80O0U73g0RZRF4KX/2WDTeJIsptTp
	vtwUXgFoGjE0wpgodoQzOxSWlLxuWYxie7T1D6lX8+qcSq6n+vYjNC5H7owvm32sxa2C9PfT9vy
	VMENZTJTNgweBOlLO6BAM9ztx8Xotqk6Ayb0RMphQKfNVD86oeKqiYnBax7x9Mse5ACBFJs7ABU
	Pi1OZ4P0n4+NWWsXlDjTNygf/DlHtfwTAj7YrsX8FZGEpRRxxWggIrwXECgfgbwplwXyUBWmLrQ
	=
X-Google-Smtp-Source: AGHT+IFWbvxz8UDjRoEtUCmgLDLjxbFxdBLMGus6HijIkfSeWRHuo3KliLRdNinI/I608X/mH2aLrQ==
X-Received: by 2002:a17:90b:4b11:b0:2ff:5c4e:5ac2 with SMTP id 98e67ed59e1d1-2ff7ce59533mr29967704a91.6.1741783650701;
        Wed, 12 Mar 2025 05:47:30 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301191cb1f7sm1638141a91.43.2025.03.12.05.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:47:30 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH v3 2/2] docs: tracing: Reduce maxdepth in index documentation
Date: Wed, 12 Mar 2025 18:17:17 +0530
Message-Id: <20250312124717.7208-1-purvayeshi550@gmail.com>
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
 Documentation/trace/index.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 6b268194f..5ddd47ee7 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -14,7 +14,7 @@ This section provides an overview of Linux tracing mechanisms
 and debugging approaches.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    debugging
    tracepoints
@@ -28,7 +28,7 @@ The following are the primary tracing frameworks integrated into
 the Linux kernel.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    ftrace
    ftrace-design
@@ -47,7 +47,7 @@ A detailed explanation of event tracing mechanisms and their
 applications.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    events
    events-kmem
@@ -65,7 +65,7 @@ This section covers tracing features that monitor hardware
 interactions and system performance.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    intel_th
    stm
@@ -85,7 +85,7 @@ These tools allow tracing user-space applications and
 interactions.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    user_events
 
-- 
2.34.1

