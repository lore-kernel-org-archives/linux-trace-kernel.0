Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C3F285065
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536778; cv=none; b=Wgl9ulWgGRo5fR5uCK+bILWXKqGspXbaSwfxaIxL+mmUPLTVcdvjQI+KjxAa1J+KJidHwkQmO1Rm68Q2dG7pdfO0IkR9048jXvkez9WqayqLu+IbKZz9m9NLZuTqRZdqOfxMLUvVjBoWx+i2mH7t0b+bQLb9P6Me0SbOcoc55+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536778; c=relaxed/simple;
	bh=x+816UkHLyRvuKb/oS0wEATvXuUn8rJpVOodqIFEeMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K9vQwvr/68RVS7nxCcWLVMf4lAznEKvXKc4Vd0FvsIW44z5OKsaMUD0DdD5vy0FP5G3vygvObFYBtVsei044LtggISYVqS9ksZd+Qzbv6opr6DAXIPCvEVf1S0ku8rafzcSNmLrfXTH5IE3ONB36urqczS1nW/LpcmXL/rUgndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZGGHLS8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZGGHLS8"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso3010922f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758536775; x=1759141575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+816UkHLyRvuKb/oS0wEATvXuUn8rJpVOodqIFEeMc=;
        b=UZGGHLS8RzxzIYOJz14wa0Eps5Am9v47sUtvODWN9ztOA7i+2O46SYemocthYKD1tA
         wc8meh7BMPsTs1R09TCUthWNYwh7eyq3xajkUhfUmCCpOl/YpoBt1xeS+8JC328wkHxo
         EgmK/R6HDM9VJZP3cEo4ys7/Cp+q3O1xJf84NxcE6GJtNQc554ErykTCSzUwraKEVG4y
         uB9NS13PKjuuImTEjECN3I1MjqCTTq0P/rUZ60gaVmxwupxPc2dk07mVphNNU79u6bnt
         IyO7RmyxGBFB9LXMF6NVRd/UkZM0f9P/WJMezBe1Nv7KVKe/qVswWkpmiPZxR+ermpUl
         UXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758536775; x=1759141575;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+816UkHLyRvuKb/oS0wEATvXuUn8rJpVOodqIFEeMc=;
        b=OjHfOFcxp5Ltf5JLscQLqEpJRKlSDLlzaHz5LT69STi7DVjJib/SmuYfsmk8SxOt2l
         pfEP5QZ4LBNSUenarl+hKP4evo0qy6XU4PZRXtl4MbLQWszc8HKFIzNq8PkWVaZtrUay
         MvMfnw7wiMDz8pBSdZ5Tb1yGTdexEnGKB/MLlrq3gBIuf6oUKcp+PdxUd3OeIGG5e+br
         0KeaYCgc1iuzzipo69I+s0N17FNaXLANlqhilMQ+UWz/+b6suzAEGVluwxB3UubTDOwV
         MIhvcs6tvCLPeKsF2Vh6fxSQ6dL5avp41aOis+uqDOMmDI3sxuzxzQINCXikWMMjVQQe
         rY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1vmb7FYSNeagc0xjD/A6FjXt1vkFCsVPBnQeyP92Svjc0F3wiY2aLruY7E2BdE9meonXQZrUgF1KdZ2w8xVYkNSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykTjw0YKdfoDEFIDHT2m9rHZHca6mpdzztvF1AOfxtNognCG2K
	XZKy1U8wCzEwWnmGVTrcNrsb/1WK4+nEOMZEccmpo59+bXnJaRgGRC6JPtluEak=
X-Gm-Gg: ASbGnctY/C4+IiwpDofbz0ZMw/YBhXynY+4cQ9Zxul376Rj2l0XeoDzBibo2hiFTlJy
	UPTOOdPXnTOiEjAyVggaczrUbAU/j4+Et8sEVq9Ji6eXR3vO/aHmBwYazQP1tMzwbkvPM3jjhnt
	Uw+vfmP3q4HwCozZGeuAk4byJLtLeSb1ztQ/fNT3si6ugqVQ0WFT+/eeNuIiIJ8bnSyVB0A9Pu6
	/dXAwE+EOMLJIOpe//ZHj8doNPz2M48COXhtplzHPk6gOPE5I/NvuUQ/OzoXHoJ/3WZ+9wPGqFu
	SNgZbJwGRTSBScRI08oe9QyF9I+85T0AZmwFBopBRnMt0JqdxKLQFMMp8uLSvhnaQ9aBajRpPD6
	sV1WwcEVkRvrXJGqwNWiz06dRvI/4uxhvNg==
X-Google-Smtp-Source: AGHT+IGT/XCP8Ckm3XZbHQrxLORq8ZdI8TPKN9zhYtRcdj/W4jZuRUzrBpAEGg+mxMwsGndI+Mm1hw==
X-Received: by 2002:a05:6000:2001:b0:3f8:e016:41b5 with SMTP id ffacd0b85a97d-3f8e01647f7mr4697830f8f.14.1758536775291;
        Mon, 22 Sep 2025 03:26:15 -0700 (PDT)
Received: from vova-pc ([85.94.110.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f0e28c83d6sm13845992f8f.56.2025.09.22.03.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:26:14 -0700 (PDT)
Date: Mon, 22 Sep 2025 12:26:12 +0200
From: Vladimir Riabchun <ferr.lambarginio@gmail.com>
To: ferr.lambarginio@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mark.rutland@arm.com, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] ftrace: Fix softlockup in ftrace_module_enable
Message-ID: <aNEkRDSIce6HTGT9@vova-pc>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMQD9_lxYmphT-up@vova-pc>

Friendly ping.

Best regards,
Riabchun Vladimir
