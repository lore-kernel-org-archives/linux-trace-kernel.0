Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5991EB55
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711702195; cv=none; b=q9g7eHl1vOw25Uy2Fkqz737LUFOe1bNrQTS2b+GRUVyOWSSZfOCUs/N0/otLBZAQ+7b6RasLAHP/85X0nU2zROStirxaAiIwT5PaNlulmQ2ztWKUyviXC7c78hiuKY5uDFP3R820Q2XcUAJ9z7Cbx0U37iq+QyrmazVqZCmAD0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711702195; c=relaxed/simple;
	bh=GaeEMsrHz+PrP7d1zJIk8hqL385oYyVvwqx6QMsImGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhCRbxF/tQTPch+1SQolP21Ygzhzs0vNoPyolqpxXy/es1/zPs2COl/1s3v2engVHB4W5zuMYaOMIq8GD4kiapaZ+ja3QaEn3HM8fCkoMsAASmuhFW2oi0hFPsc44QBpbeD219lpIty1jiXc5zVBUCfsQlB6bWYbpwOuwpm5VrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shhQn3kq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shhQn3kq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41549a13fabso42845e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711702192; x=1712306992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaeEMsrHz+PrP7d1zJIk8hqL385oYyVvwqx6QMsImGA=;
        b=shhQn3kqIunEkIRty6KgzC0ZnVH+h0+7aA1fSbTfsjGZEEihVkv5WqNSs5UgBtHtlY
         XGnQOvkTFkM9gtCaEg87d0EwfTrgjRqsIBM9Sr5deJPzkH0YvPU4lp2JIIrzwGHaD+WL
         AEEAllMwVgGHbTtvjjMOUFHxSu6bmFPHbSPlHSxVpi2XFHbPeGvshTXKu/z3PzQeMUVN
         f/zs3waC5jVEV96tTbS7DJSDAo9kNmFLN6CRSQlaBSHPFQV+71g7+1zgV5AiTVl/+aCZ
         MqdDWWJgbP0QZpKEacZTeQgXSsPU47dIy8MBKkzKcCNdmAXu9f1Ute6eq1qCMrxPe9JM
         qgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711702192; x=1712306992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaeEMsrHz+PrP7d1zJIk8hqL385oYyVvwqx6QMsImGA=;
        b=kCcjQqsieHHIX/GbJCPX/XSqujXWKAiiZ/eyOpicmp5jM6Fo2tWRg4LjOjkRCgRRFC
         ynLty61+i5kIYrt+wgU/uiVt9wFQ3JZnHKg1/GEd30XZ5LpdPQLOmp70Szd5Vez7Wqko
         UJo00ufv04ouF8CxF5GeSAAo2M2FnXPLhVqDJYKAqJF9OE2nhyOTLbAGPd/2F/84NFIJ
         2XJ63MuBaRS2dvy5coCthMGESWSdHpvbXZQMvq7ePGY6m86jvHSdiYigMsckgpOdOCm1
         EALj+S6K6fNOFBbBP0nBRnUf9IdcPC6Kprc+BPAVUWe39wUrOhbMS2EL3HMY9+FVxs+C
         qzuA==
X-Forwarded-Encrypted: i=1; AJvYcCWP78ZKvjoL1DRj9a760HNRXM0IdebhsKj4ZcJ6WRVCQ3T6E6FneIlhijl7IYT7MKf0Fkoe5dIk5QC8c7Xl9zPsKNT3Q/xDbHWwXwZbaoEW4GVW
X-Gm-Message-State: AOJu0YzCV78Fnd6W4kbqKY25rMtEBhj0EbzbI8ZhLQam8DIjwT74QsOy
	oUq65oLsOm/j5b3TCKoSyfYD192w7NzyLLCTHJd+vAO2d0CHxNckywxEmRtc0iTK9iIbBfjSvZS
	QgvfU3EpWL6CK7JkHjjMFgqbPwE+CA9Mimc0g
X-Google-Smtp-Source: AGHT+IHYD/9+DvCGCINj0BByAQNTV4lM4E97uy60WOhJb7WslP2bDB1AAT/D0KgrBzt0PXsxBlUXnqcDhBc5WzRch/Y=
X-Received: by 2002:a05:600c:1c99:b0:414:daa3:c192 with SMTP id
 k25-20020a05600c1c9900b00414daa3c192mr150324wms.0.1711702192012; Fri, 29 Mar
 2024 01:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329034243.7929-1-kerneljasonxing@gmail.com> <20240329034243.7929-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240329034243.7929-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 09:49:33 +0100
Message-ID: <CANn89i+Z-C1ZDOtd+R4yDwDF_rX2cPDCaJqw8Wi4L_t8ACPCWw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Introducing entry_saddr and entry_daddr parameters in this macro
> for later use can help us record the reverse 4-tuple by analyzing
> the 4-tuple of the incoming skb when receiving.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
