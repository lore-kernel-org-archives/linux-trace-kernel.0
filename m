Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0C33C9;
	Sat, 18 Jan 2025 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737163454; cv=none; b=P2WwZFUNMvt/Z1WrIMfvxYoFWUa6DLRysRfyZwqS+Znj1Z60EcSRI+0cjbuE45SOhT+1/+XkUILMauxf4AyA08ifNQML1nf8+7V0IajxQtwUvns6qAf8UzyKYbFitcfPxzALw9vhC5jPR2Xr0PFWXOzdTkcwfaIRrgEXcV8fWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737163454; c=relaxed/simple;
	bh=yGio0A4ZgxzJ9F5pW26T0u7/d1FZn6Q1PqnU3t0vmSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pjt8AmH53UJDDa6YnXe757OtCxcUzNtZji5hCPFAUHxtMExXc3otO1uPtGF0XQ469QQjwy6X/hTRKrbCMOZPJHRjnP8CRVnZnbFFFKjFX05Py1bcHnYMBAulUeQ8r6Ssq1DdsUs+d5vhmTyK22SprSbiqFQiQ42vywxOSs5VsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLD/Dikz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLD/Dikz"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so3926749a91.2;
        Fri, 17 Jan 2025 17:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737163452; x=1737768252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBqd+dKo/II6selhXjyJcD8heAnchcHP4Pt54qB+7BY=;
        b=FLD/DikzFFPfAnav/k31uY+xfzZV0XCiJ3TuQmUHXF6FESWGDemuaQ4wTcxWzkLFMv
         aV0MG5lOZ1aov38FWydv9FMXC0fqORgIaCJCJib92tyofxsQA+SxYwg+14bDEKiqP96u
         GjyZ0tsSXfAGLU+zXgD7ubjW0aH+Xk1seePIDtEWqr1i2Gs24lVpoq4jmMIxQINVh0Iq
         W1tfZseaXbl9GIQZFO09b+I3+sF+BFnD5YC7jfuHXL9hU9QouppbaMt0JQEzkWhUQSE4
         83JtcYX46zrgk7pfGXDFjzLW6AF6Vf27+VYc2Ky4TmIM7Diziz1ZvIsstu9tQqvYFcgC
         afoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737163452; x=1737768252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBqd+dKo/II6selhXjyJcD8heAnchcHP4Pt54qB+7BY=;
        b=CzcUGTIBZlsbHEPf41AZvqPVLM4wl5/p84CNNwvg6UElJxjTeYm69Zy7OaYEfEW3PN
         tNU3TwWW2HqtzUZ+XyKI3wVRqVs5MjWsYI6X6rIlxz2gqV7RDOIkQYTifVmp4wUrK+Op
         IRua84QosLl88L+saFB5dJQVM2vDFyCR0LaeZ+6uD/GQ/NAjIhjSntMRbMacoU6OwuLR
         rCHgJmCpYKJ3/1vBFg3YfgdR2+p5/cUy9/eBqhHVEzxtIcsqH2liJyUrOK0XUxepVAT1
         m0cd3fDut7sdePAuhtqeupei2nr3cWbMCkUKqiQ2X9VRX0+Nbe4GuLSbC5QfrfycKKDk
         /Uzw==
X-Forwarded-Encrypted: i=1; AJvYcCVcVgAqd5GYv1DyRAa2Osu2V9JZeAr/u0Zz5MnRWgjXyNeBeNWr9VHMYMv4DE5p86+jRE2wYnbWAg8FLDQraIwqn4np@vger.kernel.org, AJvYcCXYcZXDQuHwel5hQL6E1yyOVedFObLbPxsAUf4c8VlH6DWkD/fre5NAv7hJz2Nib+IM1erhRBV4rLGwLZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9y7+9onI21Iz1M8hQxU/Z3aNLH1F0MACr8DEvoxr2jYi1eKU
	aLP0eyNAxEt4O+OOTmdvUdR9PDcHrcdbMrf1tW14MaGB+4pIT/6E
X-Gm-Gg: ASbGncszMaipauBZFYwi7Lb+milhHJqX3c9U29ucw35BvnIXC1Yv3WXyvigO5TZK3+b
	yndnw/EcWBdlK3iBsC2TdJxewcJzwaAndij4jUbOHujfjmeTojmRzx9V9Q/Y0t3BYc0w8NkzVmE
	7endr2XLukc7ZOsv8YlTlCPJJv/JKlcgJBIl2VnD5kF7EtjVSkap9QxkPej0g/ZSIHShe4Yb1Nv
	A0DCyDYQ5PuiEgWBnKr0BOtI9tuaLBElZD3p7goDmOUyP0Dsec8FNQhhEXQi/HOBJdTav0Vv4wn
	F8DWP4eeOU5TBalKEojyqTBCqWmFZZj9zYMojtZ1MxWcYaIc3w==
X-Google-Smtp-Source: AGHT+IFl6YM+dJRnN9CdkkV0IU1+GyGMmvrx+IB6oZD/rI9y7+B1LiCTObyfDZPxsV9dWkBruwNWmw==
X-Received: by 2002:a05:6a00:189a:b0:727:3ccc:25b0 with SMTP id d2e1a72fcca58-72dafa9b030mr8050406b3a.16.1737163452145;
        Fri, 17 Jan 2025 17:24:12 -0800 (PST)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba4956esm2560728b3a.128.2025.01.17.17.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 17:24:11 -0800 (PST)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] ring-buffer: fix typo in comment about header page pointer
Date: Sat, 18 Jan 2025 01:23:52 +0000
Message-Id: <20250118012352.3430519-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in comment about header page pointer in function
rb_get_reader_page.       
    
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>    
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 60210fb5b211..a0b1dd654496 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5321,7 +5321,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 * moving it. The page before the header page has the
 	 * flag bit '1' set if it is pointing to the page we want.
 	 * but if the writer is in the process of moving it
-	 * than it will be '2' or already moved '0'.
+	 * then it will be '2' or already moved '0'.
 	 */
 
 	ret = rb_head_page_replace(reader, cpu_buffer->reader_page);
-- 
2.25.1

