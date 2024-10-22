Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF2194ADB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588195; cv=none; b=uxuhl/TpmF3AdLWnmSSXlD4pARAQsbNyh6fz4nP3d5Ouf754Fy4ABKNlJDSImwg8pUZECJp/olCgzSVV1im85K2jNNlvjFL/jUrNfw8AyiWkMX4AZ74ZzBXNKFMn8mrHoaqxPSUy5rNmaGWD7iWZoLMMuaEq8gdfr508sL6Hal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588195; c=relaxed/simple;
	bh=onbB6NTEGbtETR16Bw8yrA119icc13jj5Zs4wciGCjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gIiiRvPX8soY9YXna0IBxKRcjf2GHkn282qoouZBu+hlZYureGEmInsMSIaVql2PQqHIB0koriPmNpnmi+DyDEQO6ikthTVYfjJLNZUn92B3HAPVoJ/adW0TbJEVagzNevmuaKFbE4oHYD0pDFuHTGpWs7/PC+ywkflZeWaq2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qw56ULCE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qw56ULCE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315baec69eso49569615e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729588192; x=1730192992; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+zYJT24q3NB3II869fQeZh/ZYIP8Ozy9w36ooMVjpg=;
        b=Qw56ULCE7t6QImZH2ojGxs0MMMLNtfvV2MZTnhYKmCl61Aiq+iueD0HunoDrG5Qzto
         QEJ9w5rqdQgKU99ga8CbYP1hqJ4WQdt9PyhyxPpZ5D/X71/zGCQ75DNS6AkYXWAqHDPf
         DPI+WViO+cC2NP99B3dBISmon8Wgz+3kK4B0niCMR7P2/UNdeI7ux0aPjO5HXR4m6svN
         d039v5PX7+3tez12qOQdrJ2pQtQmNcbjCVc+nICmHbUwEG4x29k9ncu4Tyl8pJUSpKdN
         XIA/4JiBBT1hHaqsVCRF8wEjixx73A3xLLcb0ntDL1d1NgsWBVG//dvfwNMYeK8qt4AU
         W3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588192; x=1730192992;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+zYJT24q3NB3II869fQeZh/ZYIP8Ozy9w36ooMVjpg=;
        b=q35H1izb6YNELkOugaxCCqROLGL9OJJhA4ion19tgmIb+2nGv9p1xtujYKOKELzqyk
         jAanXFQ4yVzz5m5XDJI/1fgjOaWLpLlk72bOpY/lB2mo4mams2phzSpQ1KRjH24jMm8W
         rqdEEv9MMi4LUK44s/yytSziY7r1jPlWSZ29hEtFLl2VlfSqYgiir6tJSwrxqUBoYrBK
         4dNcg+aFDm7m3DKfku5x/P5HquzuhACUXTR/5HyBgDGlLGDhLkTs+PBciFFjRRSBvdC6
         misi4+MqPgndKvnB6jsN3nLyFvVFPbBXg8Ao1VZvHUoNUprrvlZhEJHWlTZuZP4appds
         MtNQ==
X-Gm-Message-State: AOJu0YxTyY0oLDuLPzoXLOzLnesueVsuCeSBtdT8H0UMdBNJrE4WPGMM
	y+AsRgEWBaqh33V8vAcYLHIcYS1Cp8RcEY9nllZGDrA9luduqQFaEo7zbR1eV9M=
X-Google-Smtp-Source: AGHT+IE0Uaq/WHJpZwF9COkSLonslbr6iJTZY/hC+moVZMgPmLc6bpWjqdMN5HrmCLaYMsVUoKHQ+w==
X-Received: by 2002:a05:600c:1c95:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-43161655ff1mr117571385e9.15.1729588191771;
        Tue, 22 Oct 2024 02:09:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94405sm6175350f8f.88.2024.10.22.02.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:09:51 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:09:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] ring-buffer: Limit time with disabled interrupts in
 rb_check_pages()
Message-ID: <d51fd42f-9fc7-4b0b-aae3-ee8bfd909d69@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Petr Pavlu,

Commit 1f1c2bc9d075 ("ring-buffer: Limit time with disabled
interrupts in rb_check_pages()") from Jul 15, 2024 (linux-next),
leads to the following Smatch static checker warning:

	kernel/trace/ring_buffer.c:1540 rb_check_pages()
	warn: ignoring unreachable code.

kernel/trace/ring_buffer.c
    1501 static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
    1502 {
    1503         struct list_head *head, *tmp;
    1504         unsigned long buffer_cnt;
    1505         unsigned long flags;
    1506         int nr_loops = 0;
    1507 
    1508         /*
    1509          * Walk the linked list underpinning the ring buffer and validate all
    1510          * its next and prev links.
    1511          *
    1512          * The check acquires the reader_lock to avoid concurrent processing
    1513          * with code that could be modifying the list. However, the lock cannot
    1514          * be held for the entire duration of the walk, as this would make the
    1515          * time when interrupts are disabled non-deterministic, dependent on the
    1516          * ring buffer size. Therefore, the code releases and re-acquires the
    1517          * lock after checking each page. The ring_buffer_per_cpu.cnt variable
    1518          * is then used to detect if the list was modified while the lock was
    1519          * not held, in which case the check needs to be restarted.
    1520          *
    1521          * The code attempts to perform the check at most three times before
    1522          * giving up. This is acceptable because this is only a self-validation
    1523          * to detect problems early on. In practice, the list modification
    1524          * operations are fairly spaced, and so this check typically succeeds at
    1525          * most on the second try.
    1526          */
    1527 again:
    1528         if (++nr_loops > 3)
    1529                 return;
    1530 
    1531         raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
    1532         head = rb_list_head(cpu_buffer->pages);
    1533         if (!rb_check_links(cpu_buffer, head))
    1534                 goto out_locked;
    1535         buffer_cnt = cpu_buffer->cnt;
    1536         tmp = head;
    1537         raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
    1538                 return;
                         ^^^^^^
You probably intended to delete this return?

    1539 
--> 1540         while (true) {
    1541                 raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
    1542 
    1543                 if (buffer_cnt != cpu_buffer->cnt) {
    1544                         /* The list was updated, try again. */
    1545                         raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
    1546                         goto again;
    1547                 }
    1548 
    1549                 tmp = rb_list_head(tmp->next);
    1550                 if (tmp == head)
    1551                         /* The iteration circled back, all is done. */
    1552                         goto out_locked;
    1553 
    1554                 if (!rb_check_links(cpu_buffer, tmp))
    1555                         goto out_locked;
    1556 
    1557                 raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
    1558         }
    1559 
    1560 out_locked:
    1561         raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
    1562 }

regards,
dan carpenter
