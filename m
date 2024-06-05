Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A9BA37
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596467; cv=none; b=hX1bUPUVf/KjDT/NYU/RcmpBPiG0Rj1Y4E2BanUga8/PIQzNSPTIWTUZ0toc1pAfWyGhRchR82/AQZ8z3PDeutk9gwkqnvRqiSsjyoe3tLTMjFlXhCIqIkCDrlhzTtVpvdzDMzK8HT9Wwf0tr64cmqppNumRu1AG0+ZuikJFsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596467; c=relaxed/simple;
	bh=G1kz/PRN23+QpsWh23o6YWf2s2yCUPcJwpFAPBnT3k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMUXEc4dF4ZOb67vH9E166TmGyKwjg547auqYXdvtUCgQ/KuyzsJFSDCOq8dCSijeXjdnuPVpFj7+QagidY8j1hsoMFit4fxiRxFo796EIlJ8ttFqWi+BCmSZCei8pZ/2NDSPYbctNur8QlhGKkZaJA1D75MoxhjnczgbsZTn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bo3og+LZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bo3og+LZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717596464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEkSv/wkJy5gIacDcugoCBVPAdCY8hqPso/BOhBGtKA=;
	b=Bo3og+LZ6qp0bWdyPa4yfT3rWaEAmn7vOq7g87ZjuirFC0pOGxalc+F6t5uk6qlalipRLs
	NWWJRLhP4HuiBn7MGRWBaaZeLVzNY4Qo59AL/YBGr1fUfnhRdPBh4uIzUM3XpfC+8nIFg2
	O0YJBRPzVki6rzPgdaJdiYRrVjRgm7E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-UHUqbULvPZORoDOEotkvXg-1; Wed, 05 Jun 2024 10:07:41 -0400
X-MC-Unique: UHUqbULvPZORoDOEotkvXg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52b9267d9d6so3086271e87.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717596460; x=1718201260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEkSv/wkJy5gIacDcugoCBVPAdCY8hqPso/BOhBGtKA=;
        b=sNMUYjP14zyLeH0D+rzcuXRhfc39KT25kF6QArcnoCHKUhbBr6IXMl5zCjBcp3kvz1
         5oh7XZymUvPeidtKQquFeaB2vGTQ5PaLkPElHYZsee7J9jRZlzFXwUTWXSOiH5GgiSfI
         JUH+D9spJkuEHHZIEJxHEO5Sott9xqW46b1rQQiGOM2+is3WAZEvXkKeHBfgik65ZKSQ
         jFyaJD18/P+HXvkq6f/qfSbeuD0Ejrttv/NciLpWBcgwhrorHQ34OuhZae/U2QvSa2N8
         ABuxa/jyHW20b9hgzE0ixflvu6ZcGXtSm0zRyOfNTcWwn0mrUDqzOnK9jqGk1eGdOdYb
         Hxvg==
X-Forwarded-Encrypted: i=1; AJvYcCXIqAYUrnAGwFJnJY5O/QCyAnIr3ARwSlCchgAz0PPAFx8wVTYDgGkybPtXLFsIpFHVm0s4KstXVwHWJAxS7GUSsg92rkHmqFND6/qnomTq+VAj
X-Gm-Message-State: AOJu0YwFA2858RQXZnyx9NWGhqT4pRpqp+TEn8W+nG51q3fgnB3zEiX4
	JiQwxuloFVEAFG4Fdi6xZE3JsCZPmOFQJ533cWMEJcpTM/24InyBniSQ78hpkwFWZ52GC8XqlFx
	l/MYnUngOpUPUI4wW7TGqowUPYmIfTnMIlYJHu5XRz63eMcS2AldB2I/Eito5DUDOGeoaBA==
X-Received: by 2002:a05:6512:3e1e:b0:521:cc8a:46dd with SMTP id 2adb3069b0e04-52bab4ca688mr2447054e87.11.1717596459955;
        Wed, 05 Jun 2024 07:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWQkEGTiF2US910j6qATuYv6PWll++dJZVRQ+oWbzvMc1eD4nMBj6V7rtuZUfVx9VVE5M1nw==
X-Received: by 2002:a05:6512:3e1e:b0:521:cc8a:46dd with SMTP id 2adb3069b0e04-52bab4ca688mr2447030e87.11.1717596459494;
        Wed, 05 Jun 2024 07:07:39 -0700 (PDT)
Received: from [192.168.0.161] (host-79-23-6-148.retail.telecomitalia.it. [79.23.6.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e6b5cdf8sm559531466b.81.2024.06.05.07.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:07:38 -0700 (PDT)
Message-ID: <af031e33-74db-40ba-abdd-ef1bf32e4caf@redhat.com>
Date: Wed, 5 Jun 2024 16:07:37 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
To: Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
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
 <20240605132454.cjo4sjtybaeyeuze@airbuntu>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240605132454.cjo4sjtybaeyeuze@airbuntu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, pt-BR, it-IT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 15:24, Qais Yousef wrote:
>>> But rt is a shortened version of realtime, and so it is making *it less*
>>> clear that we also have DL here.
>> Can SCHED_DL be considered a real-time scheduling class as in opposite
>> to SCHED_BATCH for instance? Due to its requirements it fits for a real
>> time scheduling class, right?
>> And RT (as in real time) already includes SCHED_RR and SCHED_FIFO.
> Yeah I think the usage of realtime to cover both makes sense. I followed your
> precedence with task_is_realtime().
> 
> Anyway. If people really find this confusing, what would make sense is to split
> them and ask users to call rt_task() and dl_task() explicitly without this
> wrapper. I personally like it better with the wrapper. But happy to follow the
> crowd.

For me, doing dl_ things it is better to keep them separate, so I can
easily search for dl_ specific checks.

rt_or_dl_task(p);

would also make it clear that we have both.

-- Daniel

