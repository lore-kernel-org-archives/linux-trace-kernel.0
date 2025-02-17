Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD820217670;
	Mon, 17 Feb 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791287; cv=none; b=kpGmiaFCk1XvBAl3lC7FSPsWHSqjId48+UKraBQsAEMST1H86Pt1Sd9OpoBsV+jXaiacl2RiUr2eWKnadS5g7xxuA37SNf9h/7J9qhfyuNSfl7UWFAWZWNIjweA9VxsEkFf+LIIp2vw2Gs74X/Ivy/ad8TPzvSmesE7i+V5NXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791287; c=relaxed/simple;
	bh=yr2NeM5xZd+21Kz+8dbrA+63YokkKPeruGiWILIFWq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k6AJQ7Vk6I/RIAVNZz86FoOOc1Oxn1Ng4wa2CUOGaluZ/eHoqT5pwP4fsp4VXvIpMozKKNWF7iSm5c88iItWbLNgwokUwMlKfwUd7QiQYpW+IiKBYgWMm1M8pJ8kvlFyIVsLB7StinvmYN4YUq+7bvdOY3py78m7o7OzKu8Xats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+pVS7yh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+pVS7yh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220ec47991aso39053095ad.1;
        Mon, 17 Feb 2025 03:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739791285; x=1740396085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4M/3rcO0sPMe5Iql+QqO4QeWNUxz9DotePxQss5GMBg=;
        b=P+pVS7yhSBFvnOdUrCY/VK/bK8jcWogO3EKgnvRouaq7tG8eM1uKYZfLX8iseiF8E3
         G1NIedXG+PkgNtuxwxcuFKRGiqQUlyOtgYuIpgqnn6Zb27raRC1YYBQn9bZ7t1vOUn/k
         IScBAiylishlfD5e08VbIOo/CMY0P+VCIZBDfUfX1CsaUefwCvEO9eJgrUMviLWUh4qI
         ZvKHMZnd46phf5VPfTV4GRXWryWqXI/1PK08xYNBEGEKnM1xrzm8ygYcW//mu2JJEIDP
         xuxpm8vMR/j3OgGn3adwb0vunneR/fsKnoSVTnWbjJMVC4uqYW18auuYh/96nyS1aQ+D
         sEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739791285; x=1740396085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4M/3rcO0sPMe5Iql+QqO4QeWNUxz9DotePxQss5GMBg=;
        b=KV1uJHVRmivuo8szCR6dfAkvvkwopKsstaOWMMBDFufwp/hs4B4m12MZsCNU2PHwEQ
         9JN3thW4idPQ6dRl3jwYV/EPHbyWucnqQCW29YQsG2XIAUayZODFbjAZrMa3uzQ0URFM
         NvGVips38cqUyDz7HXMbG/KtsB/M5hAFPqWwCyMnAhAnLQrZAiJfn+5GiEpNpmwK/GIG
         3bne5nV8/X2spaMxI6Sbea/q0o6Wj7u0T2wEddV3CgTVpAgNfYEtxICBXM7k8Wv9a4Cl
         01w5JMgvvgFqzg8KeJwKrkJVzUsP/Vr9gCGTQ9klkfMrH8USkUPk9VOgeHeodxqVsoN2
         Ha5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCwfF9Ag7/16RKfjejGLQgLAZnEAF0DLr17nUi6QCXZZBFp0uogd/IoUKQuhQjxkGwJOYBbIgVmDY=@vger.kernel.org, AJvYcCVtzhwXXSnKhTOKwly6B/B8+j7fW9K3dRglf5YrhO1LD/cEoH1kzjEn1TrYgzCZr7StRZ2GPqPdH9svU0cT@vger.kernel.org, AJvYcCVziIk+0mzIyQRKVj+t0gzgyFPutiZwD0r58u6wAL8Gj4Rac39D6rhaHo7drM89Eb+xMsPod3G8IfW2Rhz9MvKAtyDC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5GyC6Y1DQS2uMzodenY8cncaRQ1+F97Z6LNMBm4LIPVR1UFz
	JcScGHy0hyEw5cEwpw5Xt5MG9Jsh5620dy7FT0yrJtb1y8P+Bv8gkWhMDg==
X-Gm-Gg: ASbGncsAY1d3egd5Uz1RA7YfbOcTVwtAVvbx+Mcp5R+7ES/0EYkYBxH94BEPxPKgfPZ
	8aSp258om6ODcvHfRONOpMyBONy4QwDon0ZyzA+wUci3iIGPr2xpvfvcjoQ31dMEw9ZlOOvYSsn
	XF2ob53XV/NegPZDhGVu4IZxyIc+6Hq4hghxXGARBfE0Y2W75hMgIHDRw7xDuIsG0P7O10TEWLe
	B119cEG+fw/NF6jccJ+pHfcjdc6r76uJsf8D+as2wyWvYGvJ2AkF/2ZiXtajdpVglpi3JSKbWm1
	ppOnRZKyYvrfjVcg7EL0HMaTdcTjc8VyieOy5bLgJMW/9kur
X-Google-Smtp-Source: AGHT+IG2wp6SxvUYLH3QY8NUObd+LCQ2SCD1wbP8i0JO2n92euCaJ/7zCXgTIegWz9F/1IB6d+NQ+w==
X-Received: by 2002:a05:6a00:1a8f:b0:730:76a1:3935 with SMTP id d2e1a72fcca58-732617999f1mr14087951b3a.6.1739791284967;
        Mon, 17 Feb 2025 03:21:24 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40c0:1035:b6f:a7b9:b8b1:950d:8c7b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73270de9b7asm3109685b3a.90.2025.02.17.03.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:21:24 -0800 (PST)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] docs: tracing: Reduce maxdepth in index documentation
Date: Mon, 17 Feb 2025 16:51:09 +0530
Message-Id: <20250217112109.7734-1-purvayeshi550@gmail.com>
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

