Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E524887E
	for <linux-trace-kernel@vger.kernel.org>; Sat,  2 May 2026 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777744070; cv=none; b=pKjKNPg2FelIFzDz5nhzcMEyjjar8Hdl9G6YPYuwPla1WWhgthSXiPn2R0Fn4JttLC161d2PRuc7wy3S9Wm7on7qEZM/n+FTLK/PAoo/Zswhkn9KZk5cvO9aKgQru58uWVAIj7Jrq0+lX0S6rOtgqiTXX+70+4+QzLUGFis04jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777744070; c=relaxed/simple;
	bh=unxdEHaAwd7HByHuT8F9clSv+/VfkMhXYoe6NbskxGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfLYD5DB+B833W5QbG0hF5PKYbpsTVh7NwSxrb28VuNyQJ3Xs/ReVFeHm1LWiQR8wkHFe7HoF/rmDy6Y+qeoF9iMcFAsrtLXwjmHlnmdLqMuzhjrvpNwXOmpdysc/V9nETUVSInLoSWxEP6lEYUUOQ7lMNOfNTAYk/2MNp5j7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIBAt4sk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIBAt4sk"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36523acb0c1so125524a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 02 May 2026 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777744068; x=1778348868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Sdq3JzLsc9tOiGCfNLlG328lVE4YzzkQ7bmxmR1Wfc=;
        b=OIBAt4skyeL/a9TzD+W6nE/TtVknuv+ut5m4mzRFXncIzgswS0mPzKaGss2D9sxnVn
         rDmqAvdip5T1EhOeJQAAMd0sG2AHpCzoS9T2kGwZURFt/vZAT7wPpxWRLQr4EBlggf+c
         VtaLwc85tmK0XR+CxQCGR1fA+mylKdwBrOseF9hMtk/U8ip69C0fNq0QkKZXsFp/bd2z
         o0lz3L+AjGHm6McjDHrpZ4dyr35jD8q1i3G4JwPvvjN3Flh4wY0UHuZSfIHRo5WSGRh8
         y/Zrzemj7HMNAd/oH/jcSXWz6J6qJjHgmyZBpxhyy00Lb7Qn1KZjH8CHDwaGmcK5TOJL
         x0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777744068; x=1778348868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Sdq3JzLsc9tOiGCfNLlG328lVE4YzzkQ7bmxmR1Wfc=;
        b=FGK23sqseO1qRX6JinrZPblBUkusQoCKk6dY54u/93HEhTMWXetQlh4VmbNI+EHOLZ
         QlFnxxdJmYImpk4LqnFODb+/8KlJfhRRKEHGoFdzNjLFVvldN86yA8fx/UHRfZLJVaS5
         cCktRAQXIM6KMVKJYrjxCbilYAJJJQEBx6VTDuWrmp0XVOjvKWNWqS4ZagtRUkb0JiAK
         yPHEYca0q1A9/eDWD1uELFQqADxTeDbtuI44IKY6WhDY0TjMLDDRE167he8H7cf9n7I6
         Yha9KCF+Vt3zkMzALclKU5qnlr+cBB5edTjkMoNEywj5cOQMu/5AMW0RUobi5gKtoXsz
         27jQ==
X-Forwarded-Encrypted: i=1; AFNElJ9x9ukHAyK4CAS/5uyFm2h/2xxrBywx4h40QfYZfPuKMZsbg/tSvim2w4VrlTUbes+lZufxsydvq1Lj8U9h5wTd2/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFwRLkORYP9RcbxOdPWq+XwNG80dhbJDWkWMnjYGFCGx2S2lFn
	/nmVd6Mp3BGFTSnIulXhXaod0gMPpkuyGQgC8rL2b2GWdXjty402+G3VxDXzwJ9O
X-Gm-Gg: AeBDieut7GKkt6bX9McH0LYDdDwsKmrCtGDbws9gqGoyBbGh9M48Er1AVS0zfoE4nkp
	0Q8PPFco5qDwoITcfHpgaP3HJlsw7cheqXAhd6HmJh8ZP5wFo/nYtJeQIx5xHciONPUe5n8AJti
	pvuChcjRbhl8IBwLKgciusM/+kfSIqtgjk09PXB3MeBeckHNycF9Lwqg17wD7D3c3CYoM2CDvcN
	0SRiiDue4/PFxb0vaFclpc7JKBYUNXB7ZIoa8pRvYHdb3XSrG9DXnLaNOWVIPr5HQu/OVR5cESH
	Ebsa2AIp5/bLPK7cBvnl8uvNiG3oDtdnjTnK8zsmJkxmGCeGmdaz+blfT16YLq1QXF9SHh4HkSY
	vlPA7xsju0P6z+z0glKfLHOBsTQw1UmqlVv3TR4FCjExkcZ5qZoAnyWh0QaoygUIGh+FG4NN1gj
	6OewFlLY0uO6Qhhd5JnMQlk3KgehgLBqqdom6W77qtjGv9V+ql8oB79Q==
X-Received: by 2002:a17:90b:55cf:b0:35e:5051:fb18 with SMTP id 98e67ed59e1d1-3650ceb4dd5mr3788325a91.26.1777744068175;
        Sat, 02 May 2026 10:47:48 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40f2:1006:8b0f:1d09:e45f:6c1f:c75b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebf2affdsm7748851a91.8.2026.05.02.10.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 10:47:47 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH] tracing: Switch trace_recursion_record.c code over to use guard()
Date: Sat,  2 May 2026 23:17:41 +0530
Message-ID: <20260502174741.39636-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch mutex_lock()/mutex_unlock() to guard().
also drop the ret local variable and return directly.

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 kernel/trace/trace_recursion_record.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_recursion_record.c b/kernel/trace/trace_recursion_record.c
index 784fe1fbb866..bac4bc844ccd 100644
--- a/kernel/trace/trace_recursion_record.c
+++ b/kernel/trace/trace_recursion_record.c
@@ -180,9 +180,8 @@ static const struct seq_operations recursed_function_seq_ops = {
 
 static int recursed_function_open(struct inode *inode, struct file *file)
 {
-	int ret = 0;
+	guard(mutex)(&recursed_function_lock);
 
-	mutex_lock(&recursed_function_lock);
 	/* If this file was opened for write, then erase contents */
 	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		/* disable updating records */
@@ -194,10 +193,9 @@ static int recursed_function_open(struct inode *inode, struct file *file)
 		atomic_set(&nr_records, 0);
 	}
 	if (file->f_mode & FMODE_READ)
-		ret = seq_open(file, &recursed_function_seq_ops);
-	mutex_unlock(&recursed_function_lock);
+		return seq_open(file, &recursed_function_seq_ops);
 
-	return ret;
+	return 0;
 }
 
 static ssize_t recursed_function_write(struct file *file,
-- 
2.43.0

