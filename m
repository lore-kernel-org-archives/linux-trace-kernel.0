Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6EB79C8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096617; cv=none; b=lGG5S7Y4lmfa1Hb6t5YMBss5J40oRQbXi7BGuUrumat0ueQqOpivwGxmpKHjYwt2+NCaO+V8rQYEoq2X8GEtx0EcVtnjyIVHk/IrliMFjtQ60wct/kRNX3Fml93BP7EHxt6yJnBxuBr7w4zUQhQAw4SQ8SD06epSrHSUHkX0ftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096617; c=relaxed/simple;
	bh=wU35Bt/W4Th7ebj0fz6w+yPys0fnerf+0iDw45DCtn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNoKVmoDisQEEk5YiqRItevm/5CDDATfn+RfPPiu1qmel+i0JIGskBRbk1tq2rx0dUdhvEyv0Dm05/vmTzsQmfkg0ikhBN1V4NmXS3xYhHtCekuGdbbKffqLPeQyr+4+E3JT1ztI3BAY6hfGoYa3hDCpkcogO9HMNoadeKMTd6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMuskOP3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMuskOP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718096615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLWHA3e+iEuCixJwfkXomh9A2UOMcv37vtzmFIMouF4=;
	b=ZMuskOP3Jz5MEbp7zANbK8GNZ0HGVu/IrdhjxsxeUD2DQDWIhp7KzP8A8ipebsrVcXMUrj
	aBR+n9SsYYk16SVV3ZYlHGb7GXrqcx00uwDrizhzomHsqqt1OraKIDePxhkG0uZD5f867G
	Tr4xojdo89E6dXIemGlCrUZdm4VjbDI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-A5s-gBHpPjuDmQAUXFidwg-1; Tue, 11 Jun 2024 05:03:29 -0400
X-MC-Unique: A5s-gBHpPjuDmQAUXFidwg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57c748dd112so556689a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718096608; x=1718701408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLWHA3e+iEuCixJwfkXomh9A2UOMcv37vtzmFIMouF4=;
        b=nAfOnT96E4Nibj/LFDu8AW2m9ZLD+7KT1oeRRVihHSdPPsjpW2T9OfXyPWjS9nLy1h
         eJynxmD8zesDISLUywfo8SZculetoCZXdGhDAh1ampsVRpWkS4PHeXoR344+zjAdh0a7
         dWKjvjPgWgdQ/XezpzDEB28haWkC96MaZu6MpZ3ywy1fP5kFv87vL9KlY4QlKLhWoi3y
         JXvfoN7XaRnokTIA7J+99q3RFqS4WbNmveAe9r6+AdaT6GwnpdY64Ie8L+/xRM9pHTSG
         9JftN1PpQdunOQHI0eHbeRfF6JiMcH6aqMIZIObDnqJ/PzcehI/vSSrz/pNmWWE9bZdz
         bnBg==
X-Forwarded-Encrypted: i=1; AJvYcCXQWCT3HMFtCeJDClOcDZPbGP1NeOfKbUdonU+MEBRXBKF/T6cuUSiPul8rk7NJlhfJ4ZMmMdJr7MJd6igwJHxu/71koYr2vsRJkqn9Cjzo4pF7
X-Gm-Message-State: AOJu0Yy0tzEG3P+m4avWJThDcONiSycdzUvAJHIbsF/qiiwTaDPVLkqf
	eZqLk+mwV/pdjyjD27YCy9Z170UzPBN6esQ/Bfo/cgeixx6oD0OmADOm4rvBV2eYW8IbDfGR5rm
	RIjhg4AANAVQ5n1PS/l2YxQljURSSj20X1g/ndco4nB7WQLdqatiTwT2WDkdO+ZI2MfUAFg==
X-Received: by 2002:a50:8a82:0:b0:57a:33a5:9b71 with SMTP id 4fb4d7f45d1cf-57c50972f28mr9752094a12.33.1718096608136;
        Tue, 11 Jun 2024 02:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBNv7S2oEwkt1dYa7oWJiEJQJtRTwaghusj5MnBn4EV1Sy+PsswgNz9xRNTlMZV4hQSAwwSQ==
X-Received: by 2002:a50:8a82:0:b0:57a:33a5:9b71 with SMTP id 4fb4d7f45d1cf-57c50972f28mr9752074a12.33.1718096607760;
        Tue, 11 Jun 2024 02:03:27 -0700 (PDT)
Received: from [192.168.0.102] (host-95-245-118-97.retail.telecomitalia.it. [95.245.118.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae11a98csm8905551a12.48.2024.06.11.02.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 02:03:27 -0700 (PDT)
Message-ID: <b5f84790-8036-44cf-bfd9-0a43269a26d9@redhat.com>
Date: Tue, 11 Jun 2024 11:03:25 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] sched/rt: Rename realtime_{prio, task}() to
 rt_or_dl_{prio, task}()
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Metin Kaya <metin.kaya@arm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240610192018.1567075-1-qyousef@layalina.io>
 <20240610192018.1567075-4-qyousef@layalina.io>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240610192018.1567075-4-qyousef@layalina.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, pt-BR, it-IT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/24 21:20, Qais Yousef wrote:
> -	if (realtime_prio(p->prio)) /* includes deadline */
> +	if (rt_or_dl_prio(p->prio))

that is it... no thinking, no recall, no comment, no confusion...

-- Daniel.

