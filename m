Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4201FF7D7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659788; cv=none; b=CtOQyZzS026zt3rcBMptQryIj9NUkKHd8TaRV8uY4Ft/r4Aj58h25LTeQNGJJQZ0XvzoLA8u43+YTwXW7sI2LHbVwy+ocr6AsD4ls6BWwRELvwqb7U2WtD0zXmtHbfI2Zl/8GcqPzpELDtzwSSAQjVYKQKLiD5+tGvjTRFluwKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659788; c=relaxed/simple;
	bh=Ot4LFi7LbWmwt0mguA3UZcXFThUWLrjK4CdZFD8cIbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sbWPIBIqbhcFcFJlqI9P2Yr2q3ZAxviYfoyEvrWMo5k+F9jkAxNuN6IMv18RTm+VMTbSsRb5b9XpTAb/d4GJHjopNl33YKXP2M9rFJUOEUeMazHzMtHTDIiJtE0WkLU170tXxGMyxRPI60fX9inW2aDj9cBsDYM+FysOKaofx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VAvlyFQ9; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VAvlyFQ9"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430da72d67bso33396355ab.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761659786; x=1762264586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6wbtY81dSRy9MRbXywZEcg+tILFhq9XFH05X9o3f84=;
        b=VAvlyFQ9QQRCC425AO4NJAsc73DdyHCfXLA7v3qOhxD2Binv7rT4nf1djxCGLv7RfC
         Ltzfjaf+fcGdxLmgm6ncMsN8PIQAJ5WOsWRNyhkXVXk5dwWc3nnh7HOK5neY9nDxDhUO
         15dAR5CRKhJYiZctZ7/ji/hnfS702Ishkf2/0UYQ6cLEDnpil1loi20pURkjSMqZB9UP
         gjajbI1g0Fkv5gk1oVzZQmGe8g4zRi9RTj63uy0ZweJEY0kV2wVhaBIE2CFEPD5VFzsG
         icIb5fJo/HTKPRodfUHuNsFqHRIKv92m6SC1d3k+ha8Y9BTnIFxDchtc8y2dAa61aBoF
         VrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659786; x=1762264586;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6wbtY81dSRy9MRbXywZEcg+tILFhq9XFH05X9o3f84=;
        b=Mhq/RzzmVNKATo/Z9domEPVivp0+0/M8i2X1UvMfqCGZF0g1i8vwfHfO2aWzUAs3gg
         yRseWNdMWqRUEWfWqHju6VwSttMsLxU/qHYoCHQ0lO4Sg3psUqQ5m//EvPbraltpLC+Z
         bb8VR1Ll0y0U6h01j+SfMI2mEVSuqK0BwH3zsyWLxurhvpDzAJ5PHuKwRIXyxPNMEInO
         HdlsmVV0h2Zev4kpp7U0H0pxSHJtWzeL0nRKXm0iuIKSaFGXqTkLHTBb0b9IxzcEjFb1
         eazPOGIna/RxBymWpCcxr15YkAl4N9ILPVJ0AtFBKz0YqfexRxGcCQLAKuvekyvJjjAR
         9UvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoegfP/kYBPoYYTcz86VvRUcL0++kvVYzutuZoCPp3EwmKCiwfHHnckddWo8UyKSDU+eD5ZBCHhwFQwG0s8uBlM5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCuYGELvGHE6WAJOAKdXihX2tY7Z0rOAA8S60fx9iLUOmbRcQ
	J44mOvA4oJtE9tjuA24k6a25Tk3g6JNC15Jng7HkO2StYUZthDNpzxzBY+/deo9ghrU=
X-Gm-Gg: ASbGncvtya+dVWkDhrKnbRXxn1YAS7s40nAnicmJ3uIvTqXlEgdC4yhYxhguQJOqAJw
	vUvnHK0JPQRbSUwYYJcEt5zY/dnUjFiq82IyIwpPQ9n0eTQFMKW0+AkOiRR22Kzh8gj5yY9jM3V
	t/ztH4LppILolFKo7P0Pfyzm3ujJ3+6jGPX80HsLLj760LWzmUnDzCuk9nVcWpdTsl/DRO23uPb
	3S10Q+fzv/0L9oiOhLtHXhzxYJwqwIQTSJDZMMIymfKeQDvGkvNVKYoKTpGUIWoh0LLGdVCXBqo
	J+ezMtOhkkdPgtMPaoGtYoCo3VC7ZvaF2k3cO/BqO9vUEO3Kd7MITPSpDRNLKXlKSQpdkxPoIJf
	RwJh6pXFyofhW6BUfdwAAvr5AHsWz0owLKPEWgRairFEUSBILMLG+IgPwAbxBH6dnIY0=
X-Google-Smtp-Source: AGHT+IHpi9fcig8I/C6rD2AJbhQFmZg/nFKgIfZMbtIO4JewhOuBYnH/9ejDEE9esj3af+RKBhxDGQ==
X-Received: by 2002:a05:6e02:1749:b0:431:d83a:9ca with SMTP id e9e14a558f8ab-43210421462mr40304595ab.12.1761659786327;
        Tue, 28 Oct 2025 06:56:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f6714f2esm42905325ab.0.2025.10.28.06.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:56:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes.Thumshirn@wdc.com, 
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 martin.petersen@oracle.com, dlemoal@kernel.org, 
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
 syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com
In-Reply-To: <20251028024619.2906-1-ckulkarnilinux@gmail.com>
References: <20251028024619.2906-1-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH] blktrace: use debug print to report dropped events
Message-Id: <176165978538.275475.690120789162912071.b4-ty@kernel.dk>
Date: Tue, 28 Oct 2025 07:56:25 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 27 Oct 2025 19:46:19 -0700, Chaitanya Kulkarni wrote:
> The WARN_ON_ONCE introduced in
> commit f9ee38bbf70f ("blktrace: add block trace commands for zone operations")
> triggers kernel warnings when zone operations are traced with blktrace
> version 1. This can spam the kernel log during normal operation with
> zoned block devices when userspace is using the legacy blktrace
> protocol.
> 
> [...]

Applied, thanks!

[1/1] blktrace: use debug print to report dropped events
      commit: 4a0940bdcac260be1e3460e99464fa63d317c6a2

Best regards,
-- 
Jens Axboe



