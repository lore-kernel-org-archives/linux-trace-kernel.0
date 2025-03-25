Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB025D539;
	Tue, 25 Mar 2025 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926381; cv=none; b=Q4D3MpgNT3+uOfVvoFXrReMF/cvvK5KX+c4WEuNfT++eUxM4nk4m6QcCQwClpA+4WyeQpBaLRcGB1mczn3/PvsgjRD9d45Tq33m1pRiA1+hE3I4oQCo2k0QogdVTBivKoE4bwXf0cP14YISRonWG/+jupsEl46Z/0Jl2H0k+azc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926381; c=relaxed/simple;
	bh=Of251HQ2q5cxsY/TsYis8iQx6GfJSkMigkv74PfR3CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sI4u1u+N4GhKejXWalLCEj5fizZicF7CG6HaNB7uJz+Hovh6mVWA7rTtH5DREaO1Md748gLSa2X2f7jGFA5U226r9eIJDJ1MJ3bFmoXBf8MGdJxNw4sI4/RPzNoS/Nj2Dsc035e2OAFd5xqESNi5nl1s0KdhwxQBxxKXroBDebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPIrSC4Z; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPIrSC4Z"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-227914acd20so1541245ad.1;
        Tue, 25 Mar 2025 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742926379; x=1743531179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7kBM0Q+fmEzW4RYLW8fg9ad2QLsCRCJ5pUcxYAi3GFI=;
        b=fPIrSC4ZzXmvfIXTCpKrnkWIHLFnzWJjLXR7A9EI2wNla2GQaHMeiqJ7CYgwHO5K2/
         /s4MkF44vOba6DADjh43TlZFAI+zHtWKw4iWITCtCYw0go+9Qryn4bjYGDOUMdRcLSok
         MJKtDqDu9sm5BGxYmo7XyZb5nw1uKV/xqbpUVeI55fAE6hJB8F5He4HlBVpP5Q97zr9W
         u8o2QiInEqCEKW5FvpkTzlOYZtO7xyJEXqc5Q8Brwb/IaTQp3F3nfSfFrV5evmqqypvV
         jN/OIx5r1GF6KweD4gbsYD/ceBVEFF50Y2crrrlT7xufQtMPnDoMmDGjhQGZN+rZ7xy7
         xSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926379; x=1743531179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kBM0Q+fmEzW4RYLW8fg9ad2QLsCRCJ5pUcxYAi3GFI=;
        b=FvqjfUYw+KJ/nrwQpzYS+Uo5a5wgi84/NfHp53MttXTs3djAcLZP+xOgzVTkvPi90g
         AVbMJr0ES25RwPgbRLNZId2TAP0v8NV6HSfXzxV9bbnFJSfCbLjm0e6uzZZ7QnLWZG+d
         eyrQY91rxxxJZ/5MLN9LpS6cdM094GZmswi5gXSyxEXM6608kRzHcuvVk99oAhsuK3z8
         m4xc98JFRSpHK50EbfdP+NeOCF694DwhvTf13YaIg4VnkBSr6RyEy65Wa6E6OP02px7z
         gTAqV2lg3woz7OFcIlwsAkLBudf+b1IGbVtJ0u25UA/omqiP4HeLR9mcmA8OpOOUoYpd
         fdsg==
X-Forwarded-Encrypted: i=1; AJvYcCVWM7QmLYMNDcpEnk6vLta7qr42nCNFUanD0HdB/lklalRqSH33qLAHy4Pr290bRGKMQMXbpaDGSTQERaI=@vger.kernel.org, AJvYcCVX1GRKdbhtmrLbhKfhxm6VaCmoDGRjgCcqgar3GKIEzkS5Vdu3WcjqOr1z8NxYXPyONOnsLaQtLIk5wQw/b4CJs6cy@vger.kernel.org
X-Gm-Message-State: AOJu0YzkauzoiqRMLbaE1jUPc8dXhRgpI319sowVU0Tqi7mqTghxpT+s
	OrwKqtTckJ+AQ58MwfYr9xQGdvtJq3A6BNv57jBfHtPB+UqFbZ+XBUMauiPu
X-Gm-Gg: ASbGncsbGc0CaaQNMEQw1XKXcS1oS7IeYzvhGo4eGtQuczLC2MMc02qliykFC69S9ir
	IyOKQrRSc5GjSqjd+mn72QliXKpIKCUGLYLu7hv/oyQxNkzGRghNZtfwASkNAoFi/BqLNyDGxwN
	E8YYUnT9hHo2RLLtwAtHM46JLmYQ3bsgAqGjEJtnDnQrYya3FIihRl7BsGrh4JRgMi8Qv1gAdGH
	BHvB0MvMWiUReV+twD7CCgWOt22Rh9mMcYDJexWwrWuzfvN2Sk4urq3V323ii3mSyuYMNJh+xeP
	8sUHP+775dd3h5T1WA2mIwGNHz/qouAiCbYZJ8oTErxVYCEgsSM4Jf8aCTChroj1FgCbcH9JePQ
	=
X-Google-Smtp-Source: AGHT+IGFMrc9fy6MGw4jUYCBi024LtAKv0RGaW9FtoMkZZKy6OaOQNNbGkhf5zAaY6BH5S8JxJ6RXQ==
X-Received: by 2002:a05:6a20:9d94:b0:1ee:5f21:6720 with SMTP id adf61e73a8af0-1fe938f0d44mr1154958637.16.1742926378546;
        Tue, 25 Mar 2025 11:12:58 -0700 (PDT)
Received: from sid-Inspiron-15-3525.. ([106.222.230.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a29177sm9418237a12.62.2025.03.25.11.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:12:58 -0700 (PDT)
From: Siddarth G <siddarthsgml@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Siddarth G <siddarthsgml@gmail.com>
Subject: [PATCH] tracing: Replace strncpy with memcpy for fixed-length substring copy
Date: Tue, 25 Mar 2025 23:42:32 +0530
Message-ID: <20250325181232.38284-1-siddarthsgml@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl reports the following warning:
WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy
(see: https://github.com/KSPP/linux/issues/90)

In synth_field_string_size(), replace strncpy() with memcpy() to copy 'len'
characters from 'start' to 'buf'. The code manually adds a NUL terminator
after the copy, making memcpy safe here.

Signed-off-by: Siddarth G <siddarthsgml@gmail.com>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e3f7d09e5512..1aaa9a5e2aca 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -207,7 +207,7 @@ static int synth_field_string_size(char *type)
 	if (len == 0)
 		return 0; /* variable-length string */
 
-	strncpy(buf, start, len);
+	memcpy(buf, start, len);
 	buf[len] = '\0';
 
 	err = kstrtouint(buf, 0, &size);
-- 
2.43.0

