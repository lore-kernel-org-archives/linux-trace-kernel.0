Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD294A33E1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641957; cv=none; b=eE1gWYosCTLKc6ZH1OfT1/dKm2lfhPZ1V74Uj9QxooACe2luY6+o1rsaKy+Tg8WE2zEIWdGkd8mUQnaAhpTxhHJZmmnkFzjIU+C67KuAJP9CzoYho/R0WBaLSHsxQA8ZldmJPiqkcNA+L/96qIb0BPXn9ZNuylwMTrmOZMwPT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641957; c=relaxed/simple;
	bh=OArQ9c4MMcXgH9+Tw78yQqP/z7XON/wM/5m8ONyG1G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoCIM2iI1cxNTqwe+nVyJMYTNjdVuXfrrIm91M3Xp/OTWH2YBDAt7bixTvve77AYSuD4/AEklO0+uU1DgrioWFcyaLskUPC4YCHeuC2mw2l3FwoMlc67Q0Ie1UwL8Rq4rmhgpaCPbCFPvphZ1qWQ9V34r+Zo137ELrr/hKUZDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNeKMI9G; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNeKMI9G"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47fe89fb333so35049f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786641952; x=1787246752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vel6XA2+zNnsnhR1zxSk3iAl4F9DLTFaOpNJqTCaJik=;
        b=UNeKMI9GXcc8W/qWNsbuuAaJbt1tEBkvh9XQCWS7K7aTUTlI9apyRFy9+LwP2mC8W1
         FPuFeXL2dV/IdrspuXsibXLhz7VQaxJ9qzcammvBA6XewWm4j9/qkPfiY+V7LPlC4+WT
         1LzQMTtfoiNbc/htyX1FRSdWhnxKZy5s8W35fUSVFl58H26dXeITeVP/dTgY809Q13Ll
         diUoGqoiZ2YKdrY8kV+JJaSxLSPOp6AW3lnR8biMQrEZy3NhFSZgddepij/JK8qS1I7a
         iDXq2JZaFzPU7J342NFluYMZC7rmjryFozdch6HhQXN0syGvce5To0jNd9RWNa0CF/nQ
         OgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786641952; x=1787246752;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vel6XA2+zNnsnhR1zxSk3iAl4F9DLTFaOpNJqTCaJik=;
        b=Z3e1R8El+SdSLEcZ2nzQjn0IfkpakIrJdtsQEm7KRFQRMRv2eK1k6D965RtxI3ercB
         u3G7evQeokZBjPXJ1bXwPOiFDpz8wv0lhzaA8EYY92bX8+DKez6l7PgwabhFA6Xk66Re
         RUYJvpJSyZxlRYfRicezhhQTTBRqvrcww8xV8CdJEywlaZnYmaQW6OY8pgPYgucNLP5J
         ZSogAcTnZMRlJ1vE0iNpGiyEjElPpBK5mil+1NfsTezmfgtF/YEw0/IHBP0JktRXTBhV
         sTyAzMEzt6ES5wS93q/zDRxzQqGtxPBEyLMtkXxEW0paVpXvydt0ZKR1kIcrCnA6B5eK
         xAlg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+WROE1VHbgRxooPoLcmvl7zDz0Jqz/GUKIFfRyoj/EUd/MBg+7vG4qE0cdWKYivY159vTtCdR+siOyl8iYEbEmh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjrpGhTnjWodjiZ8oHv0WTVpceVYlYeT8GBRmRdYIYfUvyATb
	Np0fP3jkWaNhOU5sGaoLfXfG/lCU8exsNHr7rt/OsJaW4fe5lqkOoO6i7kH4WrhpYg==
X-Gm-Gg: AR+sD11zMDCPZ5Ulb+LD5ihbY56N+v98hrNbTVVdIs95cUDxye+B2ip4QMeTk4iLKOv
	qWjotPAZsBq/PSBNT8o8B4MzxTL2PhzpQT0a5KJlDX1EgaGJTQppgLnJa24y1L3U7q9MbFUf2mL
	uAX5ZfmevDiJqUuGbMkVvWgfKJXCY65qfaaFvdZNIj6Ids1wYhBY09NUBjDM/UUsAyx4HmVyLKR
	Rt7FY4bGC9jyRX3Mrlg7x8X94J7rHBfFSns0dBerMrlJZusXxFPdFNd5IvGpl3GIvf0lrVfXS7u
	2DlvaIEFOvxTe6Qf87DzS7o+UaSesKJ5i95/xaaeEkeZt68rqaWP2qFBmvqII6Q5JLqa+aSlFf2
	1WoKXNN70fmwMC4XGAaPEZ47o0SCpYdRNzkI4glJn/oCG1hXxOGsUGE8IiIfCQnGI65v5/FtLdB
	OVlbF+U2I5/MDWb2Tlf32c3bprIrLibYJd00TzY5BP/4t9+CgM+ARqOq1SdVCgWa2VU9ZFAHNCk
	zIoJACQfxB8h1wS/tDKe9Ahv+Xye90k
X-Received: by 2002:adf:e58d:0:b0:481:512c:4a7c with SMTP id ffacd0b85a97d-48159cc05bbmr9051714f8f.9.1786641951349;
        Thu, 13 Aug 2026 10:25:51 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2005bcsm935600f8f.6.2026.08.13.10.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:25:36 -0700 (PDT)
Date: Thu, 13 Aug 2026 18:25:32 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH 0/1] ring-buffer: Fix sub-buffer order updates and
 free_page leaks
Message-ID: <an3-DCFFkOo4LSR5@google.com>
References: <178663776361.475864.7685868697103378735.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178663776361.475864.7685868697103378735.stgit@devnote2>

On Fri, Aug 14, 2026 at 01:16:03AM +0900, Masami Hiramatsu (Google) wrote:
> Hi Vincent,
> 
> Here is my patch to fix the race and free_page problem.
> Let's see what Sashiko says for this.
> 
> Thank you,
> 
> ---
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
> 
> Masami Hiramatsu (Google) (1):
>       ring-buffer: Fix race between ring_buffer_subbuf_order_set() and readers
> 
> 
>  kernel/trace/ring_buffer.c |   35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sorry I am not sure to understand what is wrong with that series I made here?

https://lore.kernel.org/all/20260813131152.3589632-1-vdonnefort@google.com/

-- 
Vincent
