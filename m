Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258EC5B21A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772086592; cv=none; b=o3DPwl1iq0ZFtQNiOCqcz8rUbvFUBoDA0xDdH1xgE2OHB/lNd/N+GplxbQSRuZhE4OZZxMdrHqA97WH80H3vQt6O3QASaf7ERf3vfnpn24hW9dcS5vD1ddciy4zlxh5n3AyDxVEj0vs6HfALikVSYaj6ADUSZziqV977Z8w0oLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772086592; c=relaxed/simple;
	bh=gQRNeW4ft0gFKhKbwTz2keH31pgJ1PNycC8IFQZMZqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXYWfp1MXKK4rqb0C+5JUjf7AImjPURUnCaHAtuPBYOiP9Rf7S+PlP+fEVXOiTq6MOM6nzSMLoG+a82qiAE393TGJ42l2GNvlfJwvUKkKROsspzHGGHUGmKuIaO53NzLZy/p1dthtTzHByGRAs/cyGqCPVVVwC/5muhLQrzcuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1xEOyS5; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1xEOyS5"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2aaf43014d0so3985775ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 22:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772086590; x=1772691390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRH7AfBbqMczgcFi+HCMFGoB2Bde/32W26hoYAOL7bs=;
        b=M1xEOyS5eFM7Emdym0ePPK5w/gIXzaPQzaC7KUvzPcD4iUiAejBxNTkF9iUNCtHdPw
         py68QihMYSj/EUQdiSUhufi0L5M67awwRguXz2t9AfiZbMuv9gqZwHjt99ROiegiR0Ah
         72dz8QKARkHwSGMQyHPYMJwp0VVMdXJ+FHxNIRhpIdwNeJjxWrH0nVPyXmb0NdVjOMXi
         Do4x6ewwMAT9i2Oxj0xdH0NvZTk5D8AQduA5olJykqyOadAd30x0XhrCKKhEG3BntYPL
         rBY84j+9qkoofkstVzz2z0YbLCPzoWi2PE0HL9Vl/utKWafnTtDJFlOLhoH3EUe3Yr3v
         wokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772086590; x=1772691390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GRH7AfBbqMczgcFi+HCMFGoB2Bde/32W26hoYAOL7bs=;
        b=avYHzfXRaQpLWHY+0/6ZlCXsovXyYn/AMjXYIZ2cl2hHKnKU8g0fkzu4WWiVSQdbj3
         6qDGNyCk6IY+MKxyZ4x3jhWdIyxn/7vLdWmvCaMGEP7WSf3XcITAb9BeDqdJSJozZ5MQ
         fuhEjg7j/EZj5z6a4/ahOjmlW2zq8ATv2yzY5/LH1nZMCGBH85KXngQQM2XVYL8HjY+3
         lwa17GepTudLcdeo16ut5eBMCS3kCkuKFCgT5r8x4ht3PzTsj+tNw5H3FvwY8UOAFoX7
         YZWVHncJwLokfIRWKmsMKMEhoiPVpjZOOrh8F4jrjyS4vz4o+IN9yZI9rvXyXB78z3Zg
         ZCfw==
X-Forwarded-Encrypted: i=1; AJvYcCVRuf3Gs0mIaBstuMk+rzhAbn9uBBdVPrR6qes2FJAXRdKTdZ0sx7DisXRdT67PZH708jj2DqEs42+JTijGJ/hshKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4n5aKWdbPauFGZxcHQMqdPqINfIM0acUNNR7+4p7xXg4Ktan
	031GGNbl3UB7U9qVTxAvWUDoHvtUt7l3RB6fTKZ+FJxg/ktdPdnrJ+1UlG7cpitAtjc=
X-Gm-Gg: ATEYQzxS9pNdh4BUiD72P2hTKjs90FByN/j726pN1G8m3b+oX4TP0YHRl/zE352wBx9
	lJKTjXbaTlsH3J7mRbSvjSDiz4fyMs4hstNuEyS5SQJMIewA0MBBgfBH7i8UgK0E881tznFdCwC
	L1U4KLJ0S1WS03wAhwN6I9TfMhyDYaKcs0wzohFZoU1cpqzZlgYkNslljf8gB/cz06SnkNZW+6s
	CMapobQQx7lVZR4nHJl1RQ5vzSmHO2Q9y/ICypl4d54wkP+J+737O4IZsbgm9I52hLuDqopmjth
	sKv8pziBvKu6z56ZGQBKddwruHhZfi+/TWqV246Dabl3TtgP71ZsCvU8Z+tOoTowsv5qSJlA/Zm
	T09TBbninRB0tnbBsfyyQej3k5ymkL7Xt2RDO2vE42EFpAgLRUPa4kjMfOaHTlGOztg6n1Lmfz2
	SHMYJM0Yaf2ROtnb1jarOJdNX2x+5wO0h930CSNBJTM/iW0CgvnA==
X-Received: by 2002:a17:903:3545:b0:2aa:d333:ce86 with SMTP id d9443c01a7336-2ad743e297amr173828085ad.6.1772086590478;
        Wed, 25 Feb 2026 22:16:30 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfab58c4asm14198855ad.0.2026.02.25.22.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 22:16:29 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (3)
Date: Thu, 26 Feb 2026 14:16:25 +0800
Message-Id: <20260226061625.30751-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <699fc6d3.a00a0220.21906d.0073.GAE@google.com>
References: <699fc6d3.a00a0220.21906d.0073.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 23de3719f495..c74ba9c8c98e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8251,12 +8251,14 @@ static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
 		return ret;
 
 	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file, vma);
-	if (ret)
+	if (ret) {
 		put_snapshot_map(iter->tr);
+		return ret;
+	}
 
 	vma->vm_ops = &tracing_buffers_vmops;
 
-	return ret;
+	return 0;
 }
 
 static const struct file_operations tracing_buffers_fops = {
