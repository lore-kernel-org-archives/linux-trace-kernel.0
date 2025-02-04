Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1F20E002;
	Tue,  4 Feb 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676205; cv=none; b=XDYVedL+exzf4v/h5H7AFQCAN5tIcynMmQ/W3vpTqxvAZ0K6/3BQ3WsrvWqerx4WEvGPjI3fhCCRNbzpNmANTQMp6KZVloaXrA/jORgxSqWaWqrnnCUN5g8t+koL5GvfymOsdlN8cvvsLoJhl7RgQ/pEc8Q+uHpuBttaaASaCrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676205; c=relaxed/simple;
	bh=yKG+Kh3LCX2coRRjlATN9kLMjakFXxnDXk9LJECQwHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AnM2cHH2ADuRp3PwPr0p+Wf0MRBtuWoj+wfgGb1s2YpxA7epOCJQrnn66grEOu8rVnBnt5QSi2K81/bFItDw3gExn0NFCdaJjrNowCyvql0yNtkex5gTFV+cTFWXwaTmfnxS/B/uaFt0tV9XDns+w8WSXMYVCNo/4JZdczAnHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo/k7WMy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo/k7WMy"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216281bc30fso33340305ad.0;
        Tue, 04 Feb 2025 05:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738676203; x=1739281003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCkewTQJuhYEa+h+muT5dYEg0dFSuvRXFKJuYGApdac=;
        b=Yo/k7WMytwZovlcKJJRHfWFWF/Qp66epjEYCHj9Ur9zeoDCAFtbhNBEMysORWnEHbz
         PlTFyjhEROhf8kgnirXeW+jEiR40YU8ZWYr1muaLVkjyfx65skycQwQ9l5FJgfseNFFR
         dFBwgJ6DzXCxV/gTEfe85M9QUKIKNYKObDsmuUA+iEy0mLNLrA/5xOhaq4GKrxRYXsQx
         ss2KrN/NqqBha9B/UQyJfDGFCYtH+9SJdZdDFve5vFj1lqf1Rz4QcfM8DtmKrAcc2mAU
         oMC0IRTb0DqfCviIqSAW/0bAFdHcgYTUzqoOroainv0W6CG1DgVK9/NF1Qxb1gE+FACw
         8Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738676203; x=1739281003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCkewTQJuhYEa+h+muT5dYEg0dFSuvRXFKJuYGApdac=;
        b=u+/cJvP/tO8VRjNYXVLpzmpsP7EDvEcv77VM1YCICACryOvN+z+kKSVGX1je6w2Ngt
         HQ01wTMfqDiEDt5sVDJMfiqz//XCUqtkRJQFDSf4uyqY+eOFvHWeGsS+q5Jb/aRuHuIa
         M8+jsek2hGiASa9+msIw42T08ER4Vt4GNkUh3YLID2F7YRHfjDkYsdJKk+4KPREDk0YL
         Ec8D8eAC1Rn5bOO0Btv5EFmhcEIe0zQm2WiFMyul5IuLIjB8yylik8E1D0SV2ap+Vdas
         bJ+KbmOYk/ZQzC7CNV8SKNn+x7bjmTWbSCDf9OZB8jNZf5lxbxSE8zD6pCCUUQ3AZji4
         3uvg==
X-Forwarded-Encrypted: i=1; AJvYcCUrwoVeYxdNyflcASecUUcaCipo8nr61BNTTGylYmCbRkvc9IBkq7OhxtanWzvUB7oiryGpXkvurec=@vger.kernel.org, AJvYcCV30tx7XzoS1TWDjINUH7s0Bup8Rmj6MkTYzKmz+qnbfLvn0q1bNgr7HSEiDq0Aedwzs5Al7roc1TPtYkws@vger.kernel.org, AJvYcCVLvh+qs3al7iw6bQqGFH2EptdlzzrQm9I1H+kidPJfOkMwVLvjx6IWraBqM+aZK6N5dhiADSq1cuVszWAYuQ11Zmy/@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUoALaRxsnV0KVKAj6RHZ1zIUzC6Qr0a9DKb68uI/RQXFU7wZ
	8iHn/lQsSwcL+qugna0ruz7mdoxogCAahXHDr7aVpsd/f7z2nKt5a156iCboHeg=
X-Gm-Gg: ASbGncuZGOJfBQdwx/k6U3Z+JdZR84tlWZQLByoO33jHcZSulrPaSgrh3eH/vP9IcxJ
	P86Z0ZBQKAsaguEN6Ch6OkDVhDJnX7Qh8XkuV4rRebrhzVMlByIQrqSq4Jjo/59bPIgksiDJVSf
	q+yKXpF+KpnFk7ekorhhpneoA1Ix6tXk36hleyE7BYMrMEZS8fX+KpUXcILP/8DPUsoyuiNypyS
	dnl1Sh8LjFUKZXPUyswn0vZLm9JkfiXZ6U8lltTyN6sEO/yPiqM/YzTaAlavI2YIaaBf//gh/+9
	MWITGH7a4zx/TUxc0wtvGhRbJXnMrwedMPfRgQi5jn7Thw==
X-Google-Smtp-Source: AGHT+IGChSpbGPTDbRle+kQGysFDTF9DE2JUiD6iHp+djrVdIMO/Ks+sKSRFiqF0rokGFKGZ6wzHmw==
X-Received: by 2002:a17:902:f64b:b0:215:8d29:af2d with SMTP id d9443c01a7336-21dd7dccfb4mr496889665ad.38.1738676203082;
        Tue, 04 Feb 2025 05:36:43 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40c0:1019:6a4a:7b6:abc:27dd:e5f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31fcd3esm95542015ad.104.2025.02.04.05.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 05:36:42 -0800 (PST)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: skhan@linuxfoundation.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] docs: Move "debugging" section to the top in index.rst  
Date: Tue,  4 Feb 2025 19:06:16 +0530
Message-Id: <20250204133616.27694-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the "debugging" entry to the top in Documentation/trace/index.rst.
Turn index.rst into a good starting point for people wanting to learn 
about tracing. Make it the first document users see, as it serves as a
tracing tutorial

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 Documentation/trace/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 2c991dc96ace..f3d235c8438b 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -5,6 +5,7 @@ Linux Tracing Technologies
 .. toctree::
    :maxdepth: 2
 
+   debugging
    ftrace-design
    tracepoint-analysis
    ftrace
@@ -24,7 +25,6 @@ Linux Tracing Technologies
    histogram
    histogram-design
    boottime-trace
-   debugging
    hwlat_detector
    osnoise-tracer
    timerlat-tracer
-- 
2.34.1

