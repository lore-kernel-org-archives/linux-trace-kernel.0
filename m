Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22810A36
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596331; cv=none; b=Op1bQMTvcCX14T7WRuFe9l78JrV5PBQ1S4oTjuWjZl5BLtFAauakyncBxLehJKJaTAK+THD3mPZXydGcScE/PjZhwO306Nd2H+OFXwnfEqYwDD3clyAASxGT0IOCTEYA1d+xSOBDkm0NQ78RRYYmLryZRBwedklHY0O/3NaGc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596331; c=relaxed/simple;
	bh=J2kQ4wQoNvDj4NE3mHtx5/BMuZd20qs1tyhxegM305Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4fVrfG3hWtcazvyem/Sc0ZxBJYZ0FR5yGh8K59KKgZlPS6rOBaLKdn2qyonxRXO3tzrOLmaMwtC2RsHuzwXrVOtQUYiBwbu4e26WzvODYdjzuv6eYq0h6c/3GJ6tHZJ7knr6ISWyV/DRujkHx7SqRDKBoJBLPTSGRxnk7RIyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYgF/4W3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYgF/4W3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717596328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnAjRPdPslLKR6RQzu2pBmXnTD4p4gc93G0q5GXgtK8=;
	b=GYgF/4W3t6HhZMA7j0hbcgv6t0Q23+3SlQu9Z4TPWVl1WblnU1GdcuW7OuHPz2EzdlfbV5
	gqna9P55slFr3XvJwIxdu0qr/revjtmRuTH1eqyKSvsH3WTbUDbrKTVV5hBW7a2WFed0u0
	OwmIkggVpSbIsZiZrz95k7t9Ni1VJPw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-r84grGbaMYKr-7PMXNYDtA-1; Wed, 05 Jun 2024 10:05:27 -0400
X-MC-Unique: r84grGbaMYKr-7PMXNYDtA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52baa2e4ab1so1376966e87.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717596325; x=1718201125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnAjRPdPslLKR6RQzu2pBmXnTD4p4gc93G0q5GXgtK8=;
        b=ZZeks+49uy+CY5aWiEi0xUUfJ9GvB2fAa91iu7YQsnCV5DsV0BIcupd0RoqGK+hEMi
         zmUrTV6ooYYxWBPf2APQPtUj+SfN3FsOi1BxWGV18Iu1TRHIoO8QpTAJFpCwxZa6M9lq
         96nMKoPI2tDAU17zhQv2kz4OnvZs0wpq1c+YQZ2W1cdsx3ueUGjkLuANK+DBfo4YqFJX
         09vYbbyn3Qsfe58m5zfADTXbUsOkutgUBtvZetXQu4WPH1gzVIFqVavJVr2KtKcKUWvR
         V+QSQmkGUQyZbL17W2AsmPgiu2ryr+5wrn2w6FygKoQ9z5+8MuwjcSvfZydbcveF9kUp
         FfrA==
X-Forwarded-Encrypted: i=1; AJvYcCXdLP2uZAg/uMNfdDnf52Hpwfu4A7V98RnmgiC4TxDwRi4o5XG1ijE2I9ULvNbKxT4a8ZAxkJmN5iJjWWXwj0nEHR21rX7vv02G8wMfSmATxj2/
X-Gm-Message-State: AOJu0YzOHAalih22U+2X9W4ItCPj9DAQ2zr4JcjZRE6Sk9J2ky6q/VP+
	0SHa056wMTxepm00DJDz87GWKt2crT3pc+Zj7Uo3AV7/Vu3O1Mbcjw5sjP857u6CNrBWd6l6LxW
	cGrusXZBLwgZqAIFmosRCJo8s7dFCFsBIIDhHe9J+uI8ixR/CsTnWi8m5+9Rts7OkEe5LsQ==
X-Received: by 2002:a05:6512:3e5:b0:52b:4ae8:46d9 with SMTP id 2adb3069b0e04-52bab4ca6d4mr1891849e87.5.1717596325736;
        Wed, 05 Jun 2024 07:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC7EdqZjYrmyMx/USwVrnIBDKTdRMVW5oYpkXPFLx7eROHA0u1LtZeLxEwCYBnW4Z+lNhiRA==
X-Received: by 2002:a05:6512:3e5:b0:52b:4ae8:46d9 with SMTP id 2adb3069b0e04-52bab4ca6d4mr1891750e87.5.1717596321944;
        Wed, 05 Jun 2024 07:05:21 -0700 (PDT)
Received: from [192.168.0.161] (host-79-23-6-148.retail.telecomitalia.it. [79.23.6.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a681c4f2b6fsm777163266b.144.2024.06.05.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:05:21 -0700 (PDT)
Message-ID: <9f21c8e5-1103-44fa-82bd-cf608f8a96f6@redhat.com>
Date: Wed, 5 Jun 2024 16:05:19 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Metin Kaya <metin.kaya@arm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
 <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
 <20240605093246.4h0kCR67@linutronix.de>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240605093246.4h0kCR67@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, pt-BR, it-IT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 11:32, Sebastian Andrzej Siewior wrote:
> On 2024-06-04 17:57:46 [+0200], Daniel Bristot de Oliveira wrote:
>> On 6/4/24 16:42, Qais Yousef wrote:
>>> -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
>>> +	    (wakeup_rt && !realtime_task(p)) ||
>>
>> I do not like bikeshedding, and no hard feelings...
>>
>> But rt is a shortened version of realtime, and so it is making *it less*
>> clear that we also have DL here.
> 
> Can SCHED_DL be considered a real-time scheduling class as in opposite
> to SCHED_BATCH for instance? Due to its requirements it fits for a real
> time scheduling class, right?
> And RT (as in real time) already includes SCHED_RR and SCHED_FIFO.

It is a real-time scheduler, but the problem is that FIFO and RR are in rt.c and
they are called the "realtime" ones, so they are the first to come in mind.

-- Daniel

>> -- Daniel
> 
> Sebastian
> 

