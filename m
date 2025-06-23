Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D422A1D4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jun 2025 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721870; cv=none; b=DntuB8oLlMJcHshzYArfXteIzO+eNfmEAyKyvX8ESEpbhK7fNyHc1XUaL1gZEx6kG6L30K2kFtdAU84GbEUpAe9JHbUiyNbWDGYUS6GhfJbyknd3ukBTDLqtvCQ3Y+9/RQ2gW5CRYkWocP7EVGIqaREkcD5XvzS+3lxdcZ8Me94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721870; c=relaxed/simple;
	bh=2U8MyFaiOscy6PTDWkSipIRny5s+XSGVuWIKEpHk3+M=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=oGe2xHvhlYwIqo/0czKlztJuRkXLEItb14b79uU2/wiUXKfIx3tzTApuynsbN+ks4AFXRYD8M9b965C7Af6n7i7AQZHur4S0lWOW8sXsKHlNvMjM0NIeyOxT+YQiA0NCWVCE18VFy5YQ3bA3vLJYnDCH1UK0esQDYzutuhm0jfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=cy+zTdJQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="cy+zTdJQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748feca4a61so2627583b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1750721868; x=1751326668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcKF/Hbk3n0gfb5f/PYKJg7t66HvAlh7Py7W/Nz9PVM=;
        b=cy+zTdJQG7M/KTuEj1KR4Mu/wrPpa4WRMty++k0kH1nwDPmd+yutAdPRZrfaoQWWcJ
         XxcCzd58w2lD+ub1qtimvquSjBCqcHQ37D7htTHDhsYkpjATpdA2+xGOfCyM+OtKkjPp
         yBtN8PprVfGnxuDbmJt40oDZDnOGccU2yn3QqbWjhX4EGGPmLu233C2BF3/A2dVHQWwl
         Ppo5HMzUh8fXRccoIundoACMV9YS9cZbxUXB1losscSO09PLPwturw1kaJcgedq2YLgv
         9xrR0SY2pIIVBok6N5mhYD0A18IqlMepDTv9AajB7ZBCUtkw7D6IGojCOV1O9zg0evwN
         9t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750721868; x=1751326668;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcKF/Hbk3n0gfb5f/PYKJg7t66HvAlh7Py7W/Nz9PVM=;
        b=jO5gQvu5mZNcK2JrnvlCMji8JtmHvYeJI+kvyYNWpab7i9IkpPeE+Kd3/SdaYE8bhc
         rUVgynX/ubxcfelf1myIUuDHUwbQWR+EGHgfdDAuG6tGbOcda/xQ79EcI3FtRKV1jMA+
         qlMVDySFehdF6Zs4V69zatpCvWhMLv5Pf44bmbSWcpxx1M62yY2PpMw42rdQ6cR+srRe
         /kt4ZM93tv9AGQJ+2M+wVfsRuE1CrWGaZwU4W3S4l6A/e+DI6h8dEXey2X+EOeZ9FJEe
         T+i8EcpBNS8FRlwNfH/Jxx0z4CbwndD+vDDn9Y/2pdC85J+cMkFaFVDUeW16VZLLvIK4
         FKcw==
X-Forwarded-Encrypted: i=1; AJvYcCVACNA91m8TQXPnG4wl0krFmzThCXTo6+c6YUz08smov7zw7dyHrFWQ/xy5IFHXEcdnOFxqqWczChRnGl+KX/BNpC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybWUqHVDquIGsdpSnWXropIUncdTJzWZ0DBc0PsVk5sMbOuouK
	dIT2JKTP8Q+OjJGF2w9Jg1hMJa/BM6KheVfB2R3y8kKPANdE5BUMgXkKA/ED+J4R5cU=
X-Gm-Gg: ASbGncveZih3bhfsqawBjcK79JoKuTWk1eRLgVESn88D4UeVuiIGDm323+LN/qCewrT
	uNaGeQbSfggSC8AnZg7CGae9ebNHDZvdEX8awrtouUDwHYLK2ixsujSHm11bQY1FH4wek/MJAzx
	xsDCfdBUNqab9QtEwKP0zDHdHOrU7DAX+f3XQ0Naxiqu2aVM9cO8iY2m9tyKogwDCZMFrJkkVhh
	HLrRW1tkqlJ6mliM0+GHAWzD5kuQARqB4Vf+UKTZx6cYr+ANAeqDqqcV01JxZnl+/edz2KIghIt
	ohLp/k6IZe2B15XIqQdFfgPJl3y7goH1y3CN7lpotvTxNqzH3xEMxM+PmIND
X-Google-Smtp-Source: AGHT+IGAs3OuSAJDQHn2hdz8UrtA7+3G/pgzK3avyjgKR8NhPk0epLLLozqMdrMjxB8LM0T2Jjjpmg==
X-Received: by 2002:a05:6a00:18a4:b0:742:aecc:c46d with SMTP id d2e1a72fcca58-7490d5c1af4mr17476048b3a.5.1750721868397;
        Mon, 23 Jun 2025 16:37:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:8d10])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-749b5e08cfbsm284749b3a.18.2025.06.23.16.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 16:37:47 -0700 (PDT)
Date: Mon, 23 Jun 2025 16:37:47 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jun 2025 16:37:46 PDT (-0700)
Subject:     Re: [PATCH v10 15/19] riscv: mm: Add page fault trace points
In-Reply-To: <8ec7721c8c300ee99d5ec0782558c7689b7ec203.1749547399.git.namcao@linutronix.de>
CC: rostedt@goodmis.org, gmonaco@redhat.com, linux-trace-kernel@vger.kernel.org,
  linux-kernel@vger.kernel.org, john.ogness@linutronix.de, namcao@linutronix.de, alexghiti@rivosinc.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: namcao@linutronix.de
Message-ID: <mhng-393F61AC-2A36-46DD-A969-D7EB83A7FFD5@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 10 Jun 2025 02:43:40 PDT (-0700), namcao@linutronix.de wrote:
> Add page fault trace points, which are useful to implement RV monitor that
> watches page faults.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>

Sorry if you were waiting on me.  I'm assuming you want to keep these 
together.
