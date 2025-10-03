Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAD22759C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475242; cv=none; b=BnATdF7Q0tgmwQuWIsAw043OAc9/yBYHc0xuE0kac2iHK4TuzuvTa1BhqQqp4tsXYbZb+7jjI0nUylE+FbOMnIPjb+lQ/QmAp1T/OmA+nf6yxJQmMQJjm586YQBxWSpLES27zuVn4O0zCiwt5M0NLktItPWmBKBxI2mfbCYdWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475242; c=relaxed/simple;
	bh=NmBarXdprph0Ea9BqhLbnDit9HvUdKIbTKXdxSGKLqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR8yQCkHX3VXE5hq69ofnAe+yMsnE+Cj+dlq8Z9Fj5xH03z1LqRjQyJKKimRFm2/6HAaNzB/8GDR9o3Hsd1U/SOcJW/p8o+IToq9uvToQ6kh+kCWSv1HtVeifqLqM9uWwfNcIOPW3G4KcEqDNLmO1MgLyjE/0WV5ftKZI+tYpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LkYpphNw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LkYpphNw"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b43a3b1ae1fso34294566b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Oct 2025 00:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759475238; x=1760080038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oJsClXNUdjNS3IHTnmCIDO3oNqk4uGp8NgO3dHySVY=;
        b=LkYpphNwNAbETbOGIbWmZZmyFtUGSOAp8LMFKwpGi26mMwVb/d3IrhjMm7Ri4/kKga
         uI3rNze6Ff8rgVzc/fkSrjaSxAluUQR7MiZnrGn6i8r+PTq/ugw2vbIrAqHE8DtZuuMz
         uVN16AaShzAccnaEqkHsX8wi8Ja7PZhlvD0L7pJf/UReWlSJciGzg06mwNFqGHgkwEkJ
         fhlYuH/hIo3BgPihv8DmkslEROtIDD1jL/VxO614CoPYLsRIg3LX1mVLqVMQwVuQl8iw
         qraFs1oA3iv57UGvDvLwj/cRSygsh5O9ZBhvx1e9fjB74TsPN/j0rKMotE9z7YDzwzmC
         s+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759475238; x=1760080038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oJsClXNUdjNS3IHTnmCIDO3oNqk4uGp8NgO3dHySVY=;
        b=LLVmukl/Wj9qwCzPuIIxwJg5CbD9NN6RT9Ks43PUKwCg8EdREriS7maYryQVhn15kI
         uuXV5BBY1ZCCtqvf/80j2ufJcMXnZb7lLHdogHmVo5JJm0vmRPL2NrmbJtp/PnywwZ3F
         VlJ8uG1bJENhKFwUMbF1caWLUZpaD9U2fxw8Hds9/e/Q3SskSznYz4petggNnYVGFJ1o
         rlBouCDZvsn8hJpAT3Xa2IHCrRsJlctKHYvMa3u2eFfGGsVX51TXFFqC51oKR2TRYQiS
         YUysOK+l9wmD4kOFWABPUzOFUquWZFN82KJBnCGM4ZrmUn31OKkB0ITa4yRE/WbF52nv
         mZOA==
X-Forwarded-Encrypted: i=1; AJvYcCViY1Ae8eOS0jpMFAY5iLO3R+9jCvJ+3Bkxjn5QcLz4GwQjlZgf0lLUc8jRd8EmLeOsPifFxhxuMxBE6nZceeZXPBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgn76eGD+er55gNZM8BjW4qpMvsSdbKRT0n+eMlGaYoqsflw7j
	elaCR6XORRMc76rUrt+yr4QYRXc/soQlblno//pfdndm1c9BWqDJ+4PWVUfHL49yATLYdfZUKu5
	//kv6
X-Gm-Gg: ASbGncu0dpvR7YBoSgj0c7FLvRe18siV5EnUT2yz8b17o3mjziFAxr8n7Jxqiv4tLYB
	1MxC0nQ7Es4SdEdxy8hFw1niZ55df6S6tcZ1y21KC0oZiJ4J36Yi3sE8mi5zCCmuKJWzJVOe5hF
	2+tjIUH72Ns1f8/hIvh49OyFTmhcjp/sKfxG0L0UtZjGZSl6awvraemb5tSKsuyfGqPq/ADvq+U
	LRS49TgDIev9X9c+Y5VF61Z8ZVHm482TRvg9ESzaVCZ0TzHUu/MPSRTZ2rcvsg+3eDnE0tnMXew
	iQFjN5Gqzd7crvVgcmwVQcN0LCUl1omTj1ITLJluU5gk/8YgygrQj1fNtzHSPFAGXUZWWW/UiUo
	FWbk/AHFi3ETN0A40IDYoHYlXpPRqoyZ2kBelnaMaf5jhQ1A+LFdEkls7TlD2ihWDyDgPSAZv1l
	EMWLgYhnrCsAehgTtlyxGEmWRaJZh24m+D16OaZy+8fuAfj+t5gBRi
X-Google-Smtp-Source: AGHT+IFHgcgAxKrBEwL/rl1KkiwB5iUsa34TbQ1eqD87gj7Bd+hJwtRTUeDPma+saazo3hj9xNIPCw==
X-Received: by 2002:a17:907:94c8:b0:b3d:6ec6:9e88 with SMTP id a640c23a62f3a-b49c295f869mr130567666b.7.1759475238345;
        Fri, 03 Oct 2025 00:07:18 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4d9f5sm375183666b.66.2025.10.03.00.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:07:18 -0700 (PDT)
Date: Fri, 3 Oct 2025 09:07:08 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Anderson <sean.anderson@linux.dev>, Robin Murphy
 <robin.murphy@arm.com>, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix direction in dma_alloc direction
 traces
Message-ID: <20251003090708.7951d755@mordecai.tesarici.cz>
In-Reply-To: <9505e149-29e3-4fc2-ac71-898e88492667@samsung.com>
References: <CGME20251001061047eucas1p1f96a848ff2643b48179dd3e55959da7e@eucas1p1.samsung.com>
	<20251001061028.412258-1-ptesarik@suse.com>
	<9505e149-29e3-4fc2-ac71-898e88492667@samsung.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Oct 2025 09:00:13 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> On 01.10.2025 08:10, Petr Tesarik wrote:
> > Set __entry->dir to the actual "dir" parameter of all trace events
> > in dma_alloc_class. This struct member was left uninitialized by
> > mistake.
> >
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")  
> 
> Applied to dma-mapping-for-next (for v6.18-rc1) branch. Thanks!

Thank you for maintaining the code!

Petr T
