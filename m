Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0503179BC;
	Tue, 11 Mar 2025 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696876; cv=none; b=WReakUAkHYnwxfD3yr/pzd6cilUw1hKJnfJSu0irp4YJwzJbtIRn6YwxyD3fN2jR3GTKmINoz7O2ET/3NwuslS9cgVX0hdvVQS3P1CykuWV6S3tkcocfMQ4tA3bQrs9CANWih5kjX7Tjp2p8jS7SReG1ONIn8U8WnOgVQPEvrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696876; c=relaxed/simple;
	bh=yr2NeM5xZd+21Kz+8dbrA+63YokkKPeruGiWILIFWq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uYw0VGgPXA5wMumr8jOY40lP7Rv/4JMMxQ//5Z8v3hmBoapZW/bLH+1ageEJG/O0RbLLCR9YOEZr9x/JoAR9CrDJwRV3t3j7EzFNeEXh+20GgEj5eh0Xx1CrZgce70LNkFzWXPHTDnqy+pIv0f0VzpeqwVh/b7P1PZg17h1SPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGQHkBh5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGQHkBh5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22334203781so113184365ad.0;
        Tue, 11 Mar 2025 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741696874; x=1742301674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4M/3rcO0sPMe5Iql+QqO4QeWNUxz9DotePxQss5GMBg=;
        b=QGQHkBh58iYg92nHf4agc75f3pNI9dfDnSue90gseIs2jJj4I/jaR65YS4oyhf+D61
         nBHJLlOo9Ojiww0wvRS/6hw4AUcRpStxQD6OWO5Y1vD8Sd3FYVx0880PrtelGndBhFq0
         7qFC3vNjyjpcGW25LG9fDdijGAtWaylJzuYugto5xHWuesJBiO3aMz7ECs9pHPU2hFQ6
         H7OtdY3M41tn1oZ+KlRbiosUaZ2wk03lDWtdHz/BItjGzBsHp1sCQWo3ICQB9KHLsF2O
         pPsjbX8/HGtQxaP8WQhHem3xuN1jnCCOjoVvlI5/UZhKkg6Gtih8rGV9MNIYuytvTgYa
         W5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696874; x=1742301674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4M/3rcO0sPMe5Iql+QqO4QeWNUxz9DotePxQss5GMBg=;
        b=aTD6N9S0lOAxZ4MNxC9nDf1ZohHu5ratMoWpJB9gHz28NTrWqqdrTXjOIR6O+E+sB8
         sNAmHSxk88RpxsiQ2Mrf9QWG5FNfNC/SZbaB/EaEbzNHE07JMi5R1Ckeah/3PP2PkQI+
         Z1VnyBXQoIhGRPJfWb0bOU8U3FHZkL6IVxzHk1oFMVZjdyovmsCHrP1a+FuC8ISDIm7m
         U27ia12pYbO2vkjAuJJsnvHtH7PyD6qZnqyyreEEn5fz/ciUZTlw8c5Tt/zORex8ICxY
         nRlCZ0u7tTBMkSbMXOFO4EdvPqExtOSkhcVyf2qd1AJM3DNgBb3yAhavx0bDKzNfy5D+
         A6PA==
X-Forwarded-Encrypted: i=1; AJvYcCWAE1kfOdqL2wbdvnQa8Q/Wh3Kfk636FASukp7nQ+DgEa086cnBp31Z220U93u/D4oNdGuovZoxC6Y=@vger.kernel.org, AJvYcCXcdyDV3EbDs3D+qHQKQmaQda8euevp9G2Qn9ts+DZ6/JboXkPhAldOoR0z3jGOSpwIDOyiYF4jjocDcL2prfZXXRat@vger.kernel.org, AJvYcCXrkKh4c6TgKmHDFM6xlSxIoszIGme7X4ZXcwAjn5xFisK3QyXH5ZtJmEEXl1Submyxeis9wg/cbQhcZ/1I@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlo0jvhbXgcJDlKcaB49NS9YMRdp6ROPqGSW9xigSKe4kbL1lQ
	sZjwS1YC1PWloMuuB1LhEH2s7DTXXsWRYcpMEj2vImKd4V5PkCndKN/yWpH18V4=
X-Gm-Gg: ASbGncuHPF5Rcs2LbX6ufT3dkOJa8cWXp3Kah2A1btpr5Y83JRittOuGOQKz866L1CH
	aYT5lTc14AlAip4EVPhIJZibz6Zj8Je5Y4hUVlr4RDjp/Ev92elvtc68v9/ew/6iwANBnPY82s5
	2XdWuzf+SGLvym1WT+FzH4yZ+DWStxVae8KA4LsgNf/0l4VjXvS1f3AOx0UeufehgIT8S+G1qxk
	MdhZZQcDA4RHWOTWzDLLEHA+H+Aro/HnIiCGm7ExtcfUjFx/MyJHHLvbLXP7Jsj/ROsuXZswht0
	tl0mbFNHjadlGl2ePkWd1n6EZNtp4QOcMUtdfoDByH3Y+vsmjhx0QFV+8APVW3bkMEL0UEWKvBY
	=
X-Google-Smtp-Source: AGHT+IGbBt3MHqJzH5ZhEpirMtpUqWFE9g6anhi16GbPmNioXomk9deQYpDwtvN1C6fHqh6lIYRUtA==
X-Received: by 2002:a05:6a00:928f:b0:736:b923:5323 with SMTP id d2e1a72fcca58-736ec8d9671mr4402887b3a.10.1741696874095;
        Tue, 11 Mar 2025 05:41:14 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c005e7b7sm6689856b3a.107.2025.03.11.05.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:41:13 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH 1/3] docs: tracing: Reduce maxdepth in index documentation
Date: Tue, 11 Mar 2025 18:10:29 +0530
Message-Id: <20250311124029.22866-1-purvayeshi550@gmail.com>
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

