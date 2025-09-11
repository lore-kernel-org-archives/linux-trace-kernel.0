Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F61DBB3A;
	Thu, 11 Sep 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597601; cv=none; b=atNew1/eG6B47Lzx0gTeFkG8UPP4Q2XOEoDywqC+HcLzcCysha5ggaWpHXPWW2u1NpY4rb7JYgdiuy+G6BYLQHZDzlOgqpUm/6X87hzNYhUS/e7wbDXIO2s4MlMFmfAaORTWNn/wlMjTr43BS3BjdxKaqZ2ZCb8sx2Z1pM47suI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597601; c=relaxed/simple;
	bh=Cl2c2Ku3bW6r/oowBj60vnKQlGGqzMdJrmr5OvMXlbo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ocxdckq8f/WoK4fSAkAKsy71qWl3588g5BlTkmiFQKc6/AeMtNfCc+ZOmZ/yyPSSJenjjyY1NlE4uvC/goc4vrSu4V/mJ/GdW2x85X9yiGVq4eZdtTDDI7wDq6cQO1yZdWi0z64M4Gbo71rkPk2MX6DQ9OL+mr/ZOoEcUPW3onU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaWu7NOA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaWu7NOA"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so240136f8f.1;
        Thu, 11 Sep 2025 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757597598; x=1758202398; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQonP28Qf4GXbrAft+wrCVK2Q1kbD5Du6O+xcWehdv8=;
        b=PaWu7NOAmwCTXmRkmkSIblUR/cGdW/ZhbSv844n3xyqhPCRhx9aiv2zGx8NZVTMZ2F
         tsaDtVrTVVDyv7v7fVgAB21li4ezX8qiyw0VjV9eREBNiHRmLbOCiZJ6QHjxryM0d4tc
         vop9Y/FC7PKwVLOgKrY8bKxmak6Kxn3JM2r1LNK27aDdISShooaBWinlsFOYJQhbNn/p
         /X6N0SG965vMnN1mm5koJvGI5N5HgKUHZd+enRx3ZI5pmN2f5so18VKLeOBi18LFLgt8
         mJEvUvJnSlALvU3PQkTqJodbVWflvuODmVx6VH9LVJlnFVafTEwqylG1OxmPH50tbQ5T
         JAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597598; x=1758202398;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQonP28Qf4GXbrAft+wrCVK2Q1kbD5Du6O+xcWehdv8=;
        b=KEHDt1wgioeDmW3s3KyhTXKjstLcgHvTtcw3D2+dtokfoHZfai6Ugz9bvCCUI14ucA
         BBBvv5rfQ37r5PzdjnajsUpybk/AwQ00OQF/LwUnVif0H7soGPfyijUHNXz1MBcwk8nV
         CUyNa1Cz6XCyBTc2oRJsBsrwtmPAhIJolcJIsrdxyXLI0OCRp6o5Q7DEU6yCwyEaLlOc
         Fata/gL2SXN2uV7gByAY0SHqghncPDPHcgRQnWRzTln1jYlKfwy188KeOoGGQzgZJW6E
         SsjsUztaOpjAOigM+sLMhFgunAsZt1QxEf+6JG+MvmBd3D1zrBxuu+tkxyv1e+YK8Uwf
         8xAw==
X-Forwarded-Encrypted: i=1; AJvYcCV5aQqu63oHegtYsrtawEQAw/g0SYHzmrTRthojq5rBPO7+IzikUV+Il9tWCgEfbVJ6oggcaStSr7MfNTBm+CxBrOIL@vger.kernel.org, AJvYcCViFsz2erEZ/wPFR89/VR3W7SjZkdvCT5ez25yUhy3oOyf2Qoky2tuAkod15S90mg+egmQK+Ei98WHzQGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyezdUWR0GPBPCUOQE/fFBC62SOeRl5j/r6QzbQBKqI70tzUd
	fSj2Al0OxhvAtXnGKacbJNIHSakOrpjzppotsfik1UO3g5yp8Apy3/g=
X-Gm-Gg: ASbGncsg/Ndy50DgRVjAf62BA1jiT3McL8EihFEtUo+c4ybL0zy5tBwBi4isAHC/HI7
	zxmnUCXYEyrt1Sulj2NI16m5Q8J0/prccE22vkW2Ut89CFdco/vz7xsLrZaWbV7SGI3FSrC32OL
	KZTdDrbykDKASVHWZf0hOzbHhdQMCtC6/MiDVGalm/uoGSYm+xAsQlDBdWFVDKdw62YZ6AIfSKI
	90lMPExGKYb0jcV3IR8Ry7XlogBNuM77FnsRXcnVkR7gO569SJ9YroLBSz+HA4Epwv3Ci21QfFX
	9tUkc88JzwDzlG6SiEdTMn9ArPOIAQA7eFhJdqyFPPOQKD5QdQy8QDXraoXF6irwVAZfWmSWBjV
	/srGdHeuKqUAuxsi7tYIzWTA=
X-Google-Smtp-Source: AGHT+IG0Jf3DIaAsfE5jtdY68bIMXDnn9jpMiHfyNoTXKb92RX/GDkKiDE0Sn0d5La9E6omJfgMWkg==
X-Received: by 2002:a05:6000:401e:b0:3d6:4596:8a3a with SMTP id ffacd0b85a97d-3e75e0ededbmr3420335f8f.17.1757597597937;
        Thu, 11 Sep 2025 06:33:17 -0700 (PDT)
Received: from vova-pc ([85.94.110.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786cddsm2588472f8f.14.2025.09.11.06.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:33:17 -0700 (PDT)
Date: Thu, 11 Sep 2025 15:33:15 +0200
From: Vladimir Riabchun <ferr.lambarginio@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: Fix softlockup in ftrace_module_enable
Message-ID: <aMLPm__QGrQCwz1t@vova-pc>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A soft lockup was observed when loading amdgpu module,
this is the same issue that was fixed in
commit d0b24b4e91fc ("ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY
kernels") and commit 42ea22e754ba ("ftrace: Add cond_resched() to
ftrace_graph_set_hash()").

Fix it the same way by adding cond_resched() in ftrace_module_enable.

Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
---
 kernel/trace/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a69067367c29..23c4d37c7bcd 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7526,6 +7526,9 @@ void ftrace_module_enable(struct module *mod)
 
 	do_for_each_ftrace_rec(pg, rec) {
 		int cnt;
+
+		cond_resched();
+
 		/*
 		 * do_for_each_ftrace_rec() is a double loop.
 		 * module text shares the pg. If a record is
-- 
2.43.0

