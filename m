Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE885947;
	Mon, 13 Jan 2025 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736737633; cv=none; b=g/OoxZZZHOiREEm0TZyLbE5n2J3FtaPYigGBEQF1qGkJNCjG9lUgflRDkjciTDHLwMB9fCtjWSKvsGEKW+4MhOG32FkUl9qu9VZAGzObkDZLOcUuDFsKivibsRKmKvise8td0W4pMl4bDUjqU7nkEIQA701vzm7hCNIoZAccM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736737633; c=relaxed/simple;
	bh=D+ljmoBHFykd9plpdqvd09noH8HGVoQ5bj3mzOnaCMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhKpb/W6Atind5ChOCQnMBQ7bVGEPMrsKeztG1To27SQG1DXMzXcNJLEMM/UQsV5H37wUCqC//p1OYG0cxueRXphk3316GSIOwoVu4Viikw+2GpuVxvedykxUvdEWskwBzySbZdSMQtMBgyPOGRai9SAXxEre7C/HhjYY2dC0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAFN2PWA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAFN2PWA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21644b473ddso7316725ad.0;
        Sun, 12 Jan 2025 19:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736737632; x=1737342432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPXC9M6H1WCUFlmMOfkbZqE3JGlgWI1hOtqPKw92q2o=;
        b=aAFN2PWA001ZpTvlT5IFZtTkJi0EDKlfEewsnnolq+FpXhchj/r9kzbjoyTpem6AWz
         eae0hvR0UQ4CHmGEcPLav85JVnTcFwqbJC5moQ/JnLvJ4AQqExW0LdrNXqGqd+LdA75B
         92o7GvGNQcXpFdm5x9KToSE4n5Q3bSE4QLTtJ4buSWhH+c6sedu8Dlh3/4dHWb7+qdAR
         5IztEgrCkGzXGAIOVwvtdSFH+VtVYl67HjP/IsO/jL0ndTekubkvWey361RQbVKiaWPO
         1eBXrrGHORXHNw9U677+Drhi4zY2csUoYVuCV7Kf+TEgfZsz0MmZt/l+sQ7zKEQBVHjE
         DxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736737632; x=1737342432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPXC9M6H1WCUFlmMOfkbZqE3JGlgWI1hOtqPKw92q2o=;
        b=F9nzLFTGNFXsIbZNPuL7wflRnuJXIqlB/qPZGnrM8hFwV6KfhhVq3/P2vsc0HJCoRv
         l64x8d6upCgVHmUnYHCNPC+SifjFlbovtNUJu+ThYw3XOB6ow3xo3nNiyWlbgIHXNO/K
         zCILn/lAARevn3oABXP4NaPLIffC9h2A9ufNDVlMC8q+buFcgAx21nU3IjAlfBcDLQI2
         MSHow0TA2yunYL7IGaAA9rHXvkEiW74+kw0qLLLiVeGGOteTP69okWHwoZvTUAz34R2L
         x4317dfTO0MmX9UykYRfW1Ei2tIeAd/lAPrjIByhIu5GB2NOnp6AiWYBRMbOcsHOMF/5
         XZvw==
X-Forwarded-Encrypted: i=1; AJvYcCWFP4KeqorUVIe6WNc3wDGrYkmyqYgBfC0TXbxbxabkh4C37j1oAgNJK8jH3EFOC3QhzuvUuuzxaJEBpEFexY/SqHso@vger.kernel.org, AJvYcCXE8V8pqwfNq/a7PBE7LG8JUYgB1F6rS63TSIhfPbZbhSDQXkztSdfAxs5mi/AJ6Pr2MezBZ1QpbLhXy2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QUKBLI1/LEqkJKyQaLNIS6LMZZ8aRXeWHXYrtiX98JvnCXAl
	jgaM5Bbn7vMF3JK9egjAzBQw73qrHrWYOd1/tBLOmQlGgdX38BL/
X-Gm-Gg: ASbGncvw8H9zwVRHblJLgy08go+fn5++PNa//YlAWBJ4WNoYuwUXfR4BERKw1KEmXV3
	Rl/9razUUqZGf+WX/+9OwdQ921D/5aYPF7TOW/qEv0xkIXv18hOVv0AIZOHTQSLGRc3WqKL25dH
	3OE8qcuxI0qIq1nFx3Ia5wiGeXoBQG9i7qKIX5H7sKQEOOUzKedOV9C+FyKvQS7qhRZGS9uYv9u
	HZHZxydGMyUApjnbs9RzFp8bp4t/3KkqA0GdAw+QzM0CCXDztUeyR0oRcmc2ZjgcI7l/Hd/Kiq+
	RBpseFimqijiM9SYdM1MRILgH+6HIEJBFzulG4c=
X-Google-Smtp-Source: AGHT+IG5b6OhLzdHbJdJXEwxQ6DouYarrAWGsXZCvbCGviVG00oWuF3S2JAES2dB4BG/Cj7GxeW8og==
X-Received: by 2002:a17:902:c951:b0:215:a3e3:c857 with SMTP id d9443c01a7336-21a83f32d5emr110983345ad.3.1736737631637;
        Sun, 12 Jan 2025 19:07:11 -0800 (PST)
Received: from localhost.localdomain ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21bb2a5b2afsm16304635ad.28.2025.01.12.19.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 19:07:11 -0800 (PST)
From: zhuxiaohui <zhuxiaohui400@gmail.com>
X-Google-Original-From: zhuxiaohui <zhuxiaohui.400@bytedance.com>
To: muchun.song@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: lihongbo22@huawei.com,
	Xiaohui Zhu <zhuxiaohui.400@bytedance.com>
Subject: [PATCH] hugetlbfs: check dir in trace_hugetlbfs_alloc_inode
Date: Mon, 13 Jan 2025 11:07:02 +0800
Message-ID: <20250113030702.58502-1-zhuxiaohui.400@bytedance.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiaohui Zhu <zhuxiaohui.400@bytedance.com>

Anonymous huge page has no corresponding directory inode,
which cause a null pointer crash when access dir with the stack

  trace_hugetlbfs_alloc_inode
  hugetlbfs_get_inode
  hugetlb_file_setup
  ksys_mmap_pgoff

Signed-off-by: Xiaohui Zhu <zhuxiaohui.400@bytedance.com>
---
 include/trace/events/hugetlbfs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hugetlbfs.h
index 8331c904a9ba..5daa52053edc 100644
--- a/include/trace/events/hugetlbfs.h
+++ b/include/trace/events/hugetlbfs.h
@@ -23,7 +23,9 @@ TRACE_EVENT(hugetlbfs_alloc_inode,
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->ino		= inode->i_ino;
-		__entry->dir		= dir->i_ino;
+		__entry->dir		= 0;
+		if (dir)
+			__entry->dir	= dir->i_ino;
 		__entry->mode		= mode;
 	),
 
-- 
2.41.0

