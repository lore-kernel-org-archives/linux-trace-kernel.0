Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC159199EAD
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503624; cv=none; b=M0dNWh4trTMLP/13LgG50QB+2IVu3DE+xO2C1bqr+p9/538cPnIxbGUs6F5mtp0nLamLaZWMMERFXo+uu4yJwUmF3iAKhuo1ubY3nKi4yvbOS5D2YuVQ5vqoyalmDMSsMMPfAsYVC6I9TTjp7mZ/jQgz/6UVI0ZDQpclMwrAR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503624; c=relaxed/simple;
	bh=4nJtT0eByBpmmlqV8mf77eY46G8vbRGQvMMyJIfFa2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2eEnB03nfuro4utSVEZc02QPRZZPacWN+JqgKmb/EGJX85TUgfRDDb2W2/sBpXcQypaF+VnzFN1D35x/fuWM7NBuqF5P28S/xRAc2s9bgdjlO2cF2vk7vyO4cLMMavqwEXwxlIs7HMEy1Nt5YalkN0wuONdgaR+f7j4YVMRkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctcOsr2z; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctcOsr2z"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47fde295992so1766862f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787503621; x=1788108421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ZF6HUGQYWvBUACVOKONbBRQQpsYWeEt/fKmrPzcNd4=;
        b=ctcOsr2z/R+JRBIwogX2QZBRCa1XQokGcjKMYqrvZwX4qOGvf8zUPEC+ZQ1UpqcSgN
         VpgBAZjep0QM8rxzl3kpCWVuHD7aD3o5OpGvbL7vg3MkH3qih9ef8UkI2twA1DG3SyCU
         JeoydYU2UM+bpcvzkBKPX0QYB7A40IOWXv2ifGU9kidkcOhPkqARTJQdIMfKc/HIx7Ri
         q4lFdiBZERWNWhR+FJJyBjZColY5s0j8hqe4Wd34sRkH68KyNkpxuSJjforgtZvrust/
         Q5E6z2TUauD5qi37KGEsSI8V1G5wuBX3UzxoQ4gFA/fxAoo/NTqOoP5IAFFV6WPctNXc
         Ffew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787503621; x=1788108421;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZF6HUGQYWvBUACVOKONbBRQQpsYWeEt/fKmrPzcNd4=;
        b=iXlRBeRIsr7sputc0jphkTVzYXJQYDJJIVbfCVR5nd6rNAn6Big/7cPnVoYenbdpnS
         08+racSlAE8ZqetFRT5MWtVKqgLkoAP66LnO565SrESG/Hpi56KYdxQYycmYrrOA4uI6
         4vgZz6JHgz0m3qFXVo5/dVNNoZMkpw1LzNly2q5HgLKUVoq6EMaNv6xYsPlnEHvzHs1Q
         2pinHcHBPab1e9xNxgCRoWs85dMFy+MS6qAoCr3Vz3NFfN+HFy/xcQkX0oOibWGgrDlG
         Y5oC/xC929aHyY+dtliAczM4rv/FHiWDMVR19k0iR+Gs/+tm1JArHoqWhpCE7tsi/ikL
         n4ZA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5fG7md8cGpPqg/wUsat3DPU9c31EvYQ5LkjOtcz3VbaN56xyfslrOQUJVRXzicc2vvdCBihT1L124FEpweSvNiWA=@vger.kernel.org
X-Gm-Message-State: AFuF++lv7AbLvYrdLBP1oSc4HaqvqEgd9jCyuhX78advFWPcfx8iYF/S
	pLXHwYZDyePuUCv1qG3Wm2wK4egDC0gWYeNs5fOzewA+725Z7vK2zJAy3Jj/OSpIKg==
X-Gm-Gg: AR+sD12cPLWteoPLm8QAsZRx/kAz7cyZyLITEJcPGdxjA9JhIetR7DoiSZyH20LJky2
	X38P1/cfDFYkTU79EisL3uoZntkJLGKc7QJlOu+IN3HbCUOKhw9jTz1ksKCN6jIjJYJAMyuAjpk
	JQ17n+5CvLD4V6J2SCJJKCfEZc6t5yb7QSVC/j/wD7zlyJpnhu16HRhbHFlTBtGqAQNTN+SDLnk
	lERwZjSE/VEDbK30LlRzdyvL6Q2v+OPdu0m41YYZSiKojgSqomoq4Db5zCCzlDfiO8TGMeLLKrw
	n79HwQ++5Prb9vQLIzaK8rN9UvNHUdcI9yHiwxT18jAF/ZDC1+B6QOOePscUMlbNmwTlIBWKLKP
	dhjeo93awqqc0yofMZVgWtLgnD+7taJ/nvH3R/ZrJD+JVKY0V10uuN2apfBOl56jGNejiAZUcIF
	nPm/gBKy23Egur091s0pyTcmz1y2JIkIawI0kKzmUU0mbQj3AyBOCk4KZDVqI9CM0udzqwmdftK
	p+xg05AEWINuhGMWrCsEo1UXg==
X-Received: by 2002:a05:6000:3104:b0:47f:8554:a341 with SMTP id ffacd0b85a97d-482b784c4bbmr35989706f8f.13.1787503620630;
        Sun, 23 Aug 2026 09:47:00 -0700 (PDT)
Received: from google.com (78.207.190.35.bc.googleusercontent.com. [35.190.207.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9bfd2bbsm5538099f8f.18.2026.08.23.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:46:58 -0700 (PDT)
Date: Sun, 23 Aug 2026 16:46:55 +0000
From: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 6/9] arm64: Enable the execmem ROX cache for module
 text
Message-ID: <aosj_1LChfLM8xaz@google.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <20260822135323.795946-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260822135323.795946-17-ardb+git@google.com>

On Sat, Aug 22, 2026 at 03:53:28PM +0200, Ard Biesheuvel wrote:
>From: Ard Biesheuvel <ardb@kernel.org>
>
>Wire up the existing support for the execmem ROX cache on arm64, so that
>it will be used for module .text and .init.text regions. This will be
>relied upon by a subsequent patch in order to allocate those regions
>from a single chunk of memory.
>

Until Mike lands his changes [1] on set_direct_map, enabling ROX_CACHE on  
ARM64 would cause a permission fault when the same part of the direct map is
used again (the RO flag is not properly stripped off after an execmem cache
clean).                                                                    
                                                                            
[1]: https://lore.kernel.org/all/20260823-execmem-set-vm-perms-v0-2-v2-0-b013a37d84b3@kernel.org/
                                                                            
Best regards,                                                              
Adrian  
