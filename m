Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3984189F56;
	Fri, 14 Feb 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553539; cv=none; b=sgUBXmDjIFBHtXoHTYy/VMPNQR8JENYqzyLQZX2rwcQhvy6SO+xRAw11ZqaAIPD2ylahUakGt3HZEFdHOKaKhEHzKDHLkF1voErGOKnMoeES1DfQ3OjgEKRR0R8nP7/eqeQMwXMDcegwNTuV9/HoYmT59Xdc6oUyAyBRViz1Fy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553539; c=relaxed/simple;
	bh=5w9szdovW8cw1e9MFI/dUwdT88FpwDXhmAb9Exjhm/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgtRUp+rkVjbusUP38j/b6yAzSQYYhXjkBxBRezUQ9+KjeZIDjjRN38zzuZa0pQLMw2GTBb89qJS87EcVLjrGGXYirj2WUyOWo9PBO9GiWFNoUZqjqawcr1YGNrqee/leNuLKuQidqZHQnmJj/ltdJ0jqWd2XY4ADgPoZo6i8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekw46s9r; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekw46s9r"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394829ef0fso21551675e9.0;
        Fri, 14 Feb 2025 09:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739553536; x=1740158336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qftA7qwwF/BZn/LdSqftv264JIM5F1LnaZcnD09P8xM=;
        b=ekw46s9r5dTgrhbYP/E231Z3Yu3J3U6lqNhYH0cy3RyuQge1ByPPn5VtqARezvGDMz
         +O2KPQ8b3ENcxUx8Gnd2U3w2Ccxwslv4f4PlrnYeYxVTOH/+BqtKkOv8OtC5hVEyzlAs
         V+OvYqTV2H8GoOgM7qiik7mAB+ga6e8F2flDz3szV/qtVahU0wIAB8JbhMP/LPzRI2bl
         0R9JU2tgwSk68CWN6oVuK3rPbREwk4RaAJoQV4WPbNkrUO/CiBVDnc4RQK/C/v9w31F+
         pICdMhQwjIrnnkIW4h1UTnyOgjfbpeLAQLDFVeKvr0AwSLVxeiwGMzIUqc47/blKT/sk
         vC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553536; x=1740158336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qftA7qwwF/BZn/LdSqftv264JIM5F1LnaZcnD09P8xM=;
        b=exmim29tb7Ccwp5NArMjEAH7z2M/f4UmJg6lIXYKVEeM9nqN7cjFnDQ9B1GCAF+T3U
         jXgXVLVfQPK5eBQkvvK4Msum6tSjVsHhTWx5cwEez5npC9FDRZV6OCye5iEj/otY6uFD
         g36PGxrVQ7FKTbvKYdJ81o3PrISSf/az7/MndkqAips/yEAGjh+vuPDj0hRFkcfoxwy5
         gBWyIUwA0llht9AnMFX5squD/Kj2g9Ut8Qa73pdreWizgq+z8ALG/BL/ACKlhaoAl961
         lrAK6X1xsgKI0ZXerewFYAwikzk85l8BOmU8dF+ki0qRG3t227IL8znWvOM4IYHPukgn
         d3qg==
X-Forwarded-Encrypted: i=1; AJvYcCUcCjbttc/MT861fNfjaopJ0VPf4W00VZkIrtJixPhELPKEhVXTXH6MIZ7SAVXYqPgjug4xPj1Ea/ieG/MZIXsXQQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxin9DRYTYFl8SjkcwSE7NKFdbzm3VT1lcq3YBgXAUINmruxdYE
	08E8vRXVAxoeYPDThlZTTv8pp0FwgPhenCXT7+OBvEUFvsr4QVpuHkoBbQ==
X-Gm-Gg: ASbGncuE8g782uCGTOPYcXUmLYTzvJftxuutAejUigBOFS0oS1daSrLjH5uUb/ti/qT
	ZEPWXvll0ZSKufkgqXccQg6MlsIudbOa6TJy1MhLRuXmgaklJMTNbjN+CMFAvqCRZ7aVXJ/6ZN1
	LSkDwhH7M7fl9B330VKeJKPZ48VJoyhv+dxP16TqygTxg50TgsVe2QTS16gw7Iy0yrx9qYE5/2d
	Q8QOROtVst6vnjuVbEz+4HF4uSYBkZWK/3/bF2HBvLpq2fLY1ONAyw/CXAPkAsezMpHBN/ly5o3
	WBYLvdnqIBq5s/iVSHtq6iFVTPBCcaSImVn7XQlfBwjUZe0pIzDqlw==
X-Google-Smtp-Source: AGHT+IEp/tZRt2esZ1kk2Dq8pQD5WsnQsKzzbXY2N+EmI+m6c/RyUNFNBV5zCEQOY16uueZq3sg5Bw==
X-Received: by 2002:a5d:5889:0:b0:385:faf5:ebb8 with SMTP id ffacd0b85a97d-38f24f2ba56mr9980582f8f.7.1739553535998;
        Fri, 14 Feb 2025 09:18:55 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd2csm5263225f8f.30.2025.02.14.09.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:18:55 -0800 (PST)
Date: Fri, 14 Feb 2025 17:18:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v2] tracing: Do not allow mmap() of persistent ring
 buffer
Message-ID: <20250214171854.50adf509@pumpkin>
In-Reply-To: <20250214115547.0d7287d3@gandalf.local.home>
References: <20250214115547.0d7287d3@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 11:55:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
....
> The reason was that the code that maps the ring buffer pages to user space
> has:
> 
> 	page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
...
> But virt_to_page() does not work with vmap()'d memory which is what the
> persistent ring buffer has. It is rather trivial to allow this, but for
> now just disable mmap() of instances that have their ring buffer from the
> reserve_mem option.

I've recently fallen foul of the same issue elsewhere [1].
Perhaps there ought to be a variant of virt_to_page() that returns an
error for addresses outside the kernel map.
Or even a fast version that doesn't check for places where the cost
of the additional conditional would matter.

Even a kernel panic for an unchecked NULL pointer would be easier
to diagnose than the current situation.

[1] In my case it was dma_alloc_coherent() using vmalloc() when an iommu
is enabled and then the wrong things happening when I try to mmap()
the buffer into userspace (offset in both the dma buffer and the user file).
I do need to check that the iommu is honouring the buffer alignment.

	David
