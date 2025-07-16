Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78025CC64
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679369; cv=none; b=U+vt38SPvBjmII3TsnVH6lW6KC9O8L6AaOZakWr62t8TNIh9TeiHpNkog9Vbsy65JD1tDdOMmivtaxdehGmVYahOuZU/M9ntM2kbHvju5KlAeSlSOTIT1kDeZwOmwDsopinAfUs6V0em912w/+Tibp9SqdwAqA/IfmtzFxixmWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679369; c=relaxed/simple;
	bh=06qVea3kBdVTlMvKU0MAOweuO+1RupDtDA0/7gEsO44=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=UOTHW8OVx1nv178SVIq84wm+JJOFR+LCeSXcT7XijjR74HpgyA01nB9W8OVySN8BDiuW4ajushuJ81UGeqQb5H7RVBZvftL38aEVW2H1ezifG8vFi4/VwchGxztcNI1tDf1bM7PNxLxepo7UR6uqn0ihn8oDovKNJo2C1PW6xsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=M8BB3X+F; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="M8BB3X+F"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b390d09e957so7078866a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1752679365; x=1753284165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4vl3Ek2bHdxNr4E5QFSQW0xOn72vkMZt86TovXCUIE=;
        b=M8BB3X+FXAkJU7kpHWxgIUPGcFTLY7/eUEFOvOmUmxrouC67tJ2RdGG95+5ikxei1r
         3rNvuTjjDqliYmGvWV3sXoEhjghaCCDtRuuROfz5hJvEN6o/c4gbmHwNEPPxYvtFZW20
         1LmsbZRupMg09KcGJK9sENc0wxB2lvOdXw3OWughukX8CSUli/E1IADyZBTHTZygh4gR
         SX/I0UBXYb1qILP4nDK2xFvbDiqoIIPVScyYsxSy6vhAtyPF4mdx7Y6s//bUaD4xOQb/
         iilGUPo1v8wUBdAtY2zY5wQpGFVIH0+8BmkJKXBeK1b3Tleq3dZ8W4j/n5H5gY7U4zNT
         FCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679365; x=1753284165;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4vl3Ek2bHdxNr4E5QFSQW0xOn72vkMZt86TovXCUIE=;
        b=Fvb1DTUmaa9X+hxeucC/awc0y+0+x+SRAu1nO2rnW64wWL8OGz8Q9oJsj0T5LI1y2N
         9et6qWyHJAHNruagLaTajPI8dhq9bpl28ajOV5k7sElY2uRbyIx9EBp7GYW0YKOBzizu
         Kmgch9/Rf2dKhacF2vKR5PMNdjMibqlDp1VUMCy9aPVKLFVRyRugw60YUHinaO+lXbKY
         dcPakpeybWQeHea5uGnXTMBjdYCaTCmBqx7yjQX9tuPec1WKlap2fGSn7qMuYlsYmeFz
         b8a6nvqJhbTuxrMxaRHy36F+5Zxpv8S68ordej9K5Jck2vuqwultjsGd+33A/IeDX1b9
         PWNg==
X-Forwarded-Encrypted: i=1; AJvYcCX1CSR5jXHCDZ+/I6wVeVOG0IihUHeOK4PrEvsGUqUxriM+c1Q64GhAARptk1E60Osebiunxe5XeduWYxzsPM6RqIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqu1xOEcmfyVdQlZSFu0jvRsAH7UVEuE99a//4K1tGfwt8nScI
	vbgkxNPMioNHQPQyJsW90T0RtIcZcTI9ubHZ98Sf2TPK7rUpNTqI8vbLJPr3exPjvhk=
X-Gm-Gg: ASbGncsYl/MyIKKxfjEI/XP4AlBaQLyeJWXJXQzI9DvkPAY2JF95r4NL+0ebAj6w316
	QtXphFNAfxNY2I+NNqlva90Pk/YI+kEKpyU+xGDBG5rNfTE+cPtcJFvVt3wfUxxyYTekjuaF0ch
	fok+6Rtas6kIWCTwF58oDDuv9rlm7IdCUIURs6VNYKcPm+w3MRIuYnSjGQUz+EYoVDJHQDho9Iu
	DKRu3wJ9BNYAk1/0J0X7JkOCPb+UZ1/vXMrpuV1Rt1hc7R0akBasDaZZrqNhx+YlyBY4m3cvHii
	MzqTDLTdZllSIbhkgvA99a+8juH4XOpX5D/mqSPEZB/rsDf5XA5kTbb9ensqbg4P8kqjdCXVthM
	YSmawJrfAMehCPH2ajhZH
X-Google-Smtp-Source: AGHT+IEUK5YxYWi+V5YGljb21gJhlrrSTSaF6hPULhP4e3D+hleSH74OxqsThIvkIQTiAsvoJfkRVQ==
X-Received: by 2002:a17:903:290b:b0:235:f45f:ed55 with SMTP id d9443c01a7336-23e2b44525emr13611865ad.1.1752679365284;
        Wed, 16 Jul 2025 08:22:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:b02a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de43227acsm129073585ad.124.2025.07.16.08.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:22:44 -0700 (PDT)
Date: Wed, 16 Jul 2025 08:22:44 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Jul 2025 08:22:15 PDT (-0700)
Subject:     Re: [PATCH] riscv: ftrace: Properly acquire text_mutex to fix a race condition
In-Reply-To: <20250709124536.4ce3a90b@batman.local.home>
CC: alexghiti@rivosinc.com, mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>,
  linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  rabenda.cn@gmail.com, wangruikang@iscas.ac.cn, ziyao@disroot.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: rostedt@goodmis.org
Message-ID: <mhng-E799444F-E3F5-4100-B236-45026970E1A5@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 09 Jul 2025 09:45:36 PDT (-0700), rostedt@goodmis.org wrote:
> On Wed, 09 Jul 2025 07:12:47 -0700 (PDT)
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
>> >  #ifdef CONFIG_DYNAMIC_FTRACE
>> > +void ftrace_arch_code_modify_prepare(void)
>> > +{
>> > +	mutex_lock(&text_mutex);
>> > +}
>> > +
>> > +void ftrace_arch_code_modify_post_process(void)
>> > +{
>> > +	mutex_unlock(&text_mutex);
>> > +}
>>
>> IIRC there's a reason we don't do it this way, we had (or had tried to)
>> have it before.  It's been a while, though, and I'm just having some a
>> coffee so may I'm just wrong...
>
> Yes, because it caused issues with stop machine[1], but if you are no
> longer using stop machine, this should be what you should do now.
>
> [1] https://lore.kernel.org/all/20220310045454.672097-1-changbin.du@gmail.com/

Thanks.  The v2 staged for the tester, should show up on fixes soon.

>
> -- Steve
