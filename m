Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA89199FB0
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 May 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746267884; cv=none; b=qO23WCwZYk6wrVigQy8JiGMQzlK6rttoWCSzc6F1MCT+1wvgQjsSkCDhX0CgliU6BByLA1gvOcPMA/l2fp1qtokd6d1EpOkMlpneGw5v30amQB1PAVgWnN32wLirK3IYxfCwzih8IFjWNc1+M9OYkP67ItOsU6boRBEjCMjcRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746267884; c=relaxed/simple;
	bh=0qCQqJmGg8nHWn43651G41ZQZWqTiD0gQV2dJT64BtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dM38amr9h5j2q1b0/JJjjg5C/6mzPqidS9ljKcvcbGdP/zcQ03Bxwc79sF7aNFOzVzF6kA65cmoryP9cnzMs+Mb11HqF0VI+1jHciOX7b3k9MQ3TU8DMcpfOUMERbDMdZwBuvAy11P/SQ5V6JpDBLPKa1wqkY7db8BVn5TOE6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Zw62AhbW; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Zw62AhbW"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54b10956398so3181577e87.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 May 2025 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1746267881; x=1746872681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0qCQqJmGg8nHWn43651G41ZQZWqTiD0gQV2dJT64BtU=;
        b=Zw62AhbWcIIpboxR+cLFIIEHMQ+SC755mqWxOUPHfYqHIowCO2fLUhCOilnQ2KLOhL
         pFcdx+1E1nXdD5oT9OJhpYYPxF2KgqXad7bKm8x+Gk7txWALOmsn2U67h1JlsYP4xBND
         u4XjzCAvQr7kn8TpXmetcTgOAUxEUPv8PwLEd6pwyKpRPj2f7a8yVVbjVr7sP+zc/4wD
         ng+kQcQnuF0T99QqnXQZzEvYOGYbRuTZ2PtRiaZXkCyk/cVMRwlZPuQan9k9npzUGgSR
         2wBrtidpqgfcLHnVbdrLQi6oFxINId/1oyr4MITBIPefexm8O1Drk/cZoLgZcUkk0IoL
         y9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746267881; x=1746872681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qCQqJmGg8nHWn43651G41ZQZWqTiD0gQV2dJT64BtU=;
        b=OPOSK6Yy5l3dieucKQm5hPGxzIggKVWKvfDTTzf46CfhCiD0wrn+FR7jPX0jw/Txi8
         hBXkKO7zj6OIL3NKXe8rpYgdlih79ljDPb505SoSeJKGEZvdPHYhAO0989LpyMWeduQJ
         f14DLMKvROfTkSra7d/F5M735WSeevKYWZbVF6FhsLR67fXAzXy7NE7I0I1B3+6OR7Bt
         Y16OWVlMy6SJZYLLYNQrUKarEIc0gHclqL4mSzTvws7yXOsfyMW+/ZCQDlGtbFjTusXn
         T6CR9T9wYwqs/j+2HD8qlsBDoKeU8OXIHvPjuWVHyvm33ADZYShWmXpgUv3W1fwsDbqH
         rB0g==
X-Forwarded-Encrypted: i=1; AJvYcCW1xOFNGFz7ocE65dS1RAKW11PCHNZEE5i/AAR2+pDk2GDVTVxAXCqS3/GFnXjVezvCeH3Jksfk6Fh0pGBo/3b27z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIskBo0Qoba00KY/v9Jpd/HxLqKX56GjdPiM3/SFCr/TfounYt
	UApFeHJ3nNtxzlfKKurMHS0ln+ZxE97feW98SFyVBHWRSP5ztJknECFYqmFMGSVfdVZtoOqGxlH
	VgLQeFrFSjLjDOsKv5Zx7UmJvI7bZ4dwk8iSeM/IdYP+htRx95Q==
X-Gm-Gg: ASbGnctjV3p6TB7Wn+TFz2ZcJFPC4wfQp8FF+c5+hUEqVrigspuS1+Wtxcuy81lA7EU
	J8rtfkmXafkmQ/TQ/aSyee36Q4LqdmoHeqcJKZY4knwemwxTFQlJV73dHt2mqOiXhIDHMxWZa4t
	hmy2OtLFLT7GCtuhU11oQ/JJlLZSV9GN6ukLKzzAAMoqSCg/AOj7YjQs9o
X-Google-Smtp-Source: AGHT+IG5XLjqIeeIPwFlKAkJ3dRCAbqrk9r6ZoG99ElKCSQBWM4Y8aLZBVuXKoVEWRVAq7zXzUH1hRJ/eiftMHR/LTI=
X-Received: by 2002:a05:6512:3b94:b0:549:8c0c:ea15 with SMTP id
 2adb3069b0e04-54ea79f9549mr3087948e87.0.1746267881065; Sat, 03 May 2025
 03:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
 <20250326001122.421996-2-s.gupta@arista.com> <2025032553-celibacy-underpaid-faeb@gregkh>
 <20250325203236.3c6a19f4@batman.local.home> <20250325203723.53d3afde@batman.local.home>
 <2025032554-compile-unlivable-0fb4@gregkh> <20250325204731.24f26003@batman.local.home>
 <CABEuK16RdmvpbK5CpcuYrzdo_1GK-8eUkmb5x1BKk9bPcw3weA@mail.gmail.com>
In-Reply-To: <CABEuK16RdmvpbK5CpcuYrzdo_1GK-8eUkmb5x1BKk9bPcw3weA@mail.gmail.com>
From: Sahil Gupta <s.gupta@arista.com>
Date: Sat, 3 May 2025 05:24:30 -0500
X-Gm-Features: ATxdqUGwOKdIo-Q4V5eiLmHPD-F7dzkF0pGs7QY1PB2DuRqDOrWoKS6Y9LdDxOA
Message-ID: <CABEuK14WgiKDLW-Zdz+RPsgpHXA-VK+Cp1u_Qd5EBo2eRb3npg@mail.gmail.com>
Subject: Re: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64 mcount_loc
 address parsing when compiling on 32-bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>, 
	Kevin Mitchell <kevmitch@arista.com>
Content-Type: text/plain; charset="UTF-8"

Just wondering if this backport is still going to happen. I know this
is fairly bottom of the barrel so I wouldn't be surprised if it
doesn't.

Sahil
