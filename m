Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382423C8A0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299380; cv=none; b=bPzNU10BOJ+LeIDEWf10MYb/UC3EleNqLI/qfbu/rHkrxNMtASo0ocUauNQYKxwcSq+5+D5gg+ZLhUBBBtHFYjtPVj33381hrUkW1igllDK/rFm1/1pAHiSUlBZy9eIdMCRxOK7H/dR7j6xXnnmvFlWS3viUMscL5X41U1DK6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299380; c=relaxed/simple;
	bh=EsZHnwMiJYPfidoSqF4cLJPZLMaFXC7b5B5xbjHh7PY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTIRxQWllGx90kttpnm7+rolyRROvHnkbvX6sMau5aS52mz2/LyqVOd+1b/mJ60TR2naCQBrWaXpC1K7A4kthXbXh+Qnq4p59rGVUyHPpqpjfMEZV6aJ1w9YnY9WJBkwEKzN9Ebyle1uvLYuvzVZQfantVQTwteCdj8xppjepV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BlqlWdUp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BlqlWdUp"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f973b37c5so1066485a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759299377; x=1759904177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2mgRUvHIwDUBa1m0CHFDPXrUsPClCypgfwL+/TQDD4=;
        b=BlqlWdUpTt1i0e9rEdsqx42INF5MhP5s32JHeZBPn6O2TJQTkHG1QQwSpKNP8ZBzbM
         XvA5dOAmKjlx+nHD7PEGcimFsFDZOxMeYd8aXo3QT+yDtkIJGzY9TXlyji5fk6pGvN2q
         ZZ00vkxuVnJj/T62MYTED9aONJZ2cwLJa+jrmqxE4BNWbuDAVXErOQ29JklFE+3l47/4
         pkGKVHqEDEMo+dNC4MWkp2nqD07mq1+jB1av7ypGYAF6qUNwvF4RiHgzpoHSANOduaPx
         1CF8TlkZ8HRke9SfL2zw+Yobr/YHl1X5eq5GlPsqegdTNNF6/MLgqKY8kwYEeH9SwLLw
         FzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299377; x=1759904177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2mgRUvHIwDUBa1m0CHFDPXrUsPClCypgfwL+/TQDD4=;
        b=dsuVL8M7ulyvm/E3EZErVfv4GdKUZeF9N8vU0h+OO9i1CjapdwZ3QZ2SA0oxbHhwI8
         ABb/KYyRKdjqPTdPL6P6mwwJsY05/v5tag/fYq08V5cCbptsBM3nHqmYVsTxcOFiDQuK
         m2FqiWQPkmdjwnTKY6Is88fyZm5Yb1g8d2zsJ9cdtN9Et/HWU+frL9koLOyk+u4ZANUd
         qRM1JjImytwBzmtpBfIeAiS3xq7R9JoYHpKg2gWBL98oFAQml0+WEaLQ5naRJt5eJq1Q
         7EVR8wjGDkUB6gyXw9ApIoD3CiH274bDvb+bA5btZT22Wul/tNINhjfP8kcp2rPszS9X
         X8jA==
X-Gm-Message-State: AOJu0YxQ5ShfsdnXz/e0Q6L2sVkF0Vo0xRBGmzXCzDPJ12CR6qKyAzJc
	5mPZCWBuWYNDfHPwaACEiaERpbp9d2uqJUCEth0FZmlRgNd/CX4Q3/eKeTGN8JeM77o=
X-Gm-Gg: ASbGnctx2EgEm8Xz4iYkmlcAlXWqqiLw8ygF9W5Bry6PiO5/Fyls/IyY8pnjn8CtkOP
	J5VxCACoKLTYe22ACbKvR9GElORHSaAQzRoO4GFDatlv+yilnfkm26cVX/jwl8hjrrkqmFHWZ59
	icL29CUqfrzJW4GrnhCV+mW5sQMCBKdjjwOTglbc0gXuF172SyG03PvKtZG4NLEKFMoVhQAAr1f
	G3kYVcR2uAKEqXcMNsCyKl3l47lFEE7+2cofr5eO6lmVuBKLAAGEfVqjzrmrgltzprAzz8CMB3h
	id754H/Nl2Ow8XlnzXOW9EXIECEQ+/512v8ZoYl+YBRL8rBb+q8yJqrfDmLef6TH0vCZBlj34D7
	w4GK9eoj8A82doUEVht6odxdfdDS/3Dh5v5ZP7TZskX9hskcxIPkXHPOsipuFqUIMJ4Z9HgwrdN
	VnD9UUiFkpSUN75L4mDXkvwS7/HW4M5I6BQGExiTOiMujG5C+Au07N
X-Google-Smtp-Source: AGHT+IFQWcwToJXtlmVcxmZdWqb+p7usl4TzaktlGgv885VDmhxQ95bwd+azkuh9E8Say4Z2rE5kaw==
X-Received: by 2002:a05:6402:348a:b0:634:cc8a:5428 with SMTP id 4fb4d7f45d1cf-63678c4357dmr1386965a12.2.1759299376749;
        Tue, 30 Sep 2025 23:16:16 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634c4b96ff6sm8623357a12.46.2025.09.30.23.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:16:16 -0700 (PDT)
Date: Wed, 1 Oct 2025 08:16:05 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Anderson <sean.anderson@linux.dev>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix direction in dma_alloc direction
 traces
Message-ID: <20251001081605.4f86a6cf@mordecai.tesarici.cz>
In-Reply-To: <20251001061028.412258-1-ptesarik@suse.com>
References: <20251001061028.412258-1-ptesarik@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Cc: stable@vger.kernel.org

(One day, I'll finally remember, I promise.)

Petr T

On Wed,  1 Oct 2025 08:10:28 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> Set __entry->dir to the actual "dir" parameter of all trace events
> in dma_alloc_class. This struct member was left uninitialized by
> mistake.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")
> ---
>  include/trace/events/dma.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index d8ddc27b6a7c8..945fcbaae77e9 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -134,6 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
>  		__entry->dma_addr = dma_addr;
>  		__entry->size = size;
>  		__entry->flags = flags;
> +		__entry->dir = dir;
>  		__entry->attrs = attrs;
>  	),
>  

