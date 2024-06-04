Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A00149DE9
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522233; cv=none; b=dAiAonK5kVoYZCexJuMJ6DtxBlHPwlehnob9JPi52w9dZP/G/tDcl7WZju5/tihIoDtNCYTkxd5ImNotQL4T2smuZKZZV3+UaJKqb0C4IS0UOz/g7+bcwEJCrnrgJfn5SLowV03cjg71/CcYB9MGtZTqQEkFrdBAtZTEA5wjHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522233; c=relaxed/simple;
	bh=wPLeSDOvdCECXcFpAN4ZDJ3MlHpY5M0TsqlTmyIL1Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SusrS/G6ldlMz0aT5rgAUPYgw34ruwh0plM6JsRXbtG3d17e4qeM5+ku6b5cFyU0wWsDXelmVhWmWPWnLL6KIz5CuOaJkLmWZBG12VKcpzEqW/stoFUzf3hZPlEku44J3i6jcxFDljqOpolfyh/bPk2hp4LtJHNFHhTRs4kE3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPOs20eu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPOs20eu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717522230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ymw5zXDic4congoakqXbMR2mGlryQF0NO8XZGs40oY=;
	b=jPOs20euN/2usv/MtpH/Do5osRoA1zu25VeTP5zC38cLqu3hqDjHOY26f1iJ0eNtmWssvW
	Enfz8ZE9sGaRQFoZaGoi5HbrrCZcV9hWL+n8tBmYPQ06SB8TAUqHKz+tfT9IstWPpMakL1
	i1nl0XteqrO12/a/tzP14XhyZXWLEMg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-UTBLbiXUMcm3-8CrjlTiew-1; Tue, 04 Jun 2024 13:30:28 -0400
X-MC-Unique: UTBLbiXUMcm3-8CrjlTiew-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a68c5f8f523so146350966b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717522227; x=1718127027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ymw5zXDic4congoakqXbMR2mGlryQF0NO8XZGs40oY=;
        b=Hw7VUGgXEkD6eYLWYlnk8wf2DTQ2sRXcryumZUImK6Cjfi9NP+PKg0x2HEkeNz1YzF
         F8KqJ1favw8/JTJBqzEbIuH6KFp+UfT8D8i73RpKoBCpUEGMq0KMWoHnIF51PFloWnkc
         mVuckFObls7s0xT9LanZB+E1PY2AVIj4DovxgTjP+PsEVERDehVQIWI6bE1QBnFEVn6F
         05H7zIMtkFvKmGVGaUMaboH1XNf6/Bz5rnxZoWnwoy1S+djJxVDJZb3XXExfi2EkgCx/
         aJcdmglRTwhxBq2IqzgrCkzWfSijfW8qWbAJkc5+8T/yN3wCMiVcnDAssnDOh3e98Qtj
         Q0kg==
X-Forwarded-Encrypted: i=1; AJvYcCVCW2mz3Ba9eJj6lQoR8iJzhm2auQ1/PklOnybBxTPl18X+ru5VwwdxxnEsvYmfO9nk7EaMwEkrSFTlAzaDnMunaKbCuSBh3fdg9jGQKQzQ4AjS
X-Gm-Message-State: AOJu0YzvlEEqmQJ6ESXzRsoZuTOJgTvzJvdZiHmua8i29vTY/Zx4qZpw
	cya7C3iUrDi0VexB672J7tN4HQfj1YeUlprLYWz5P/1JYfFtPTywKzyWc8L5krtG2UFgg8kIzuX
	czpszzrg/bQxd2M40o57TphgMNsnxMFDeY3yNbie83wIzPmj7XiWfcz2UH67XUJ+EsDcgrw==
X-Received: by 2002:a17:906:79d0:b0:a66:19cc:167f with SMTP id a640c23a62f3a-a69a000e331mr13083266b.59.1717522227367;
        Tue, 04 Jun 2024 10:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0ar9GRGBnY+hZrCfLEQSve+fGeR8qjjudoxWp43R2pMbqvRAKs1C9heXH+rYJnXPqGJx2jQ==
X-Received: by 2002:a17:906:79d0:b0:a66:19cc:167f with SMTP id a640c23a62f3a-a69a000e331mr13081166b.59.1717522227015;
        Tue, 04 Jun 2024 10:30:27 -0700 (PDT)
Received: from [192.168.0.161] (host-87-11-37-195.retail.telecomitalia.it. [87.11.37.195])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a69089e774csm325115166b.8.2024.06.04.10.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 10:30:26 -0700 (PDT)
Message-ID: <245df412-42f3-4a76-894c-b3481661f7b4@redhat.com>
Date: Tue, 4 Jun 2024 19:30:25 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Metin Kaya <metin.kaya@arm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
 <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
 <20240604123745.71921f39@gandalf.local.home>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240604123745.71921f39@gandalf.local.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, pt-BR, it-IT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 18:37, Steven Rostedt wrote:
> On Tue, 4 Jun 2024 17:57:46 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> On 6/4/24 16:42, Qais Yousef wrote:
>>> -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
>>> +	    (wakeup_rt && !realtime_task(p)) ||  
>>
>> I do not like bikeshedding, and no hard feelings...
>>
>> But rt is a shortened version of realtime, and so it is making *it less*
>> clear that we also have DL here.
>>
>> I know we can always read the comments, but we can do without changes
>> as well...
>>
>> I would suggest finding the plural version for realtime_task()... so
>> we know it is not about the "rt" scheduler, but rt and dl schedulers.
> 
> priority_task() ?

rt_or_dl_task() ?
rt_schedulers_task() ?
higher_than_fair_task() ? (this is bad haha)

I am not good with names, and it is hard to find one, I know.... but something
to make it clear that dl is also there becase rt/realtime is ambiguous with
the rt.c.

-- Daniel

