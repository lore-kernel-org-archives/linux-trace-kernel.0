Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AA1F4E47
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076193; cv=none; b=WgRZABAZB/bG/++UUfOuNzDnc4LXZ5iLMMFqj0T6Dga4goj2YApJ126mQmQ8oDRGXhMziJ/fofX4WRaPLkJei/nk+dgsbDelfykp7bJQ+aRMmZMbOiB7aGoACHXmjhYVNawmJK6W6DB/Lm003PA7ZQLqp7jA288jqwePPtOYlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076193; c=relaxed/simple;
	bh=khm4EmiNLvGmRMgrSmpd/+IhomwQbvLQADR2d7d1yWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzPlhLTnyzbvYVPA+YVjF3MplrvUGFa6EZe9q7vv3I8qou/WhPxpOJYyVXqkS3yHGWOjtR7apwodwhJ5DiGi05yEPqfqbMDOLK5WotwrzwvscE9foZFGHx/xYUBSM0WF+wNh0oxGEVup84c0CewbZKuHTx87Eb1cE1wXDKZL13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDuvt8+M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDuvt8+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741076191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUgMRCAGZlkwZvHjUKYfD/4Ww4ioNcC9Etu6fPpviRs=;
	b=gDuvt8+M/HwB7GuxXtlNRrDufsIysx8XIKr53hhAEMo5vAoSLl8NL9TVP9zl6IdStFz7cv
	b7yo5UtE/6v+3wpSJc+qIqZQXR/wAFlGwFkl3VCOq7mvpMohv+PGjfio751QG37yztaTHQ
	fg1IA12Ac3IUtwoX1NqXcr26jIWeiek=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-t-tjLVJaNAOeMzYVR75eVw-1; Tue, 04 Mar 2025 03:16:24 -0500
X-MC-Unique: t-tjLVJaNAOeMzYVR75eVw-1
X-Mimecast-MFC-AGG-ID: t-tjLVJaNAOeMzYVR75eVw_1741076183
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abec83a498cso515767666b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741076183; x=1741680983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUgMRCAGZlkwZvHjUKYfD/4Ww4ioNcC9Etu6fPpviRs=;
        b=bP9K2ttTUOnROm8gKlXZ9ve+KVdATLoFG+BRdPS1oRIFHaj+BAV4uDt12B650PrurH
         czqF7jSW0EQCn6z3aOJCbBY4PsyounTV4f86PcRthwLnQJzMEO6y5j4MuGUB3w1GR4ht
         semGj1lpt4TqCozFq8z34uxSZam3fxfmeKDa+fi7P3eQYaa7onvJ6Cc3yF+fHIHNH/DS
         P146qzxRJANdaXXBg1t96mG9DsdXWquHOeXEZ4zFv7ud6KoAjtFJUdxxLdIdz+8fBSTB
         CZQ4AHnbkEnvSJi0BTkYcy56/itWEI5/X28b1p2OD6RPTRNiXX6tMO8ELK7EDVPDZ/Ya
         7iJw==
X-Forwarded-Encrypted: i=1; AJvYcCWDDsJgBNZa7FruG2KiWMJA8/4HwZkGjqcbc8HS7xBB+4EzmFYF2ZEy6FMhrRMsVAgyyVqq50CWAzIZuLLJX//D4lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzsnIugf0wnKfPAYoW8/JeEPlWgPchmgtcu990kJsYYOthCM4s
	dW840tz6iiAO+XTEYNdK08Jt3zlQb8GYTIG+2rxOeq+0VB8IyRUaQsW+5JqkQxy6ToH1ZAAGNBX
	N0k461UHV48YqpI5Y6WXkXU1owHrp71Z4dRUlT4Jt77DRMwCm5rMWlpQwk/N0W3ddX6KepFpUlZ
	eRT8DfiDZdIIMtK0NuqEgBgt7RwBhvdrK8XKKpwiuWkUwWI6nefSdWWb4B2A==
X-Gm-Gg: ASbGncvTOv0lxiSM8afnCu2HkEWLonwJ5LDIWXg6FA6CcVPjZse/BDw/1rJ0Horh9RT
	pWS15KMEdFQkpY7qqqlw2MyWEH32rg6WYsKsgLY0P9yAL+VAlkplZRrp8skEUtc+WYFAQHlQP
X-Received: by 2002:a17:907:3e20:b0:ac1:ff43:82ae with SMTP id a640c23a62f3a-ac1ff43873amr34733866b.2.1741076182968;
        Tue, 04 Mar 2025 00:16:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjiPfIdcB3OCzKh+jh3HKi8FlpNQ6//YB5I9MwloiSuoOecfrDnAbXgaxiSFT6VO8pWV9ho14eLU+RwbcuDRQ=
X-Received: by 2002:a17:907:3e20:b0:ac1:ff43:82ae with SMTP id
 a640c23a62f3a-ac1ff43873amr34731666b.2.1741076182612; Tue, 04 Mar 2025
 00:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com>
 <20250227200623.60f20571@gandalf.local.home> <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
 <20250303150351.28007ad1@gandalf.local.home> <CAP4=nvQ9pXYtihL7HTTRK=EzUEubtWbxDr78JswksSo-wa7zYw@mail.gmail.com>
In-Reply-To: <CAP4=nvQ9pXYtihL7HTTRK=EzUEubtWbxDr78JswksSo-wa7zYw@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 4 Mar 2025 09:16:11 +0100
X-Gm-Features: AQ5f1JrVUoV-90UKowSRdIKpA9oMwx4TT4SouneOst-Pd5TOz4Zdk6JbARKYjBo
Message-ID: <CAP4=nvTCVLa5MzBbJVz=S_ZiDoJ2hY-8fM+uRnGgumi0sFivWA@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PD8o3Dr6xRXhuHhFqMpGDPwlDmRnLVMjWRtUdWqDLwc_1741076183
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 4. 3. 2025 v 9:00 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com>=
 napsal:
>
> So we need to stop tracing here, before we save the trace, if we want
> to do that. Perhaps combining this with the cleanup patch [1] and
> doing the stopping in save_trace_to_file would make sense?
>

Also, the patch will also save the trace if running with -a and the
threshold was not violated, which is not what one usually wants, e.g.:

$ rtla osnoise top -c 0 -q -a 10000000 -d 5s
                                         Operating System Noise

duration:   0 00:00:05 | time is in us
CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max
Single          HW          NMI          IRQ      Softirq       Threa
d
 0 #4           4000000        37712    99.05720       10998
555        7624            0         4011           34           2
4
 Saving trace to osnoise_trace.txt

I believe it would be better to add a new option, something like
--force-trace, that would be used to save the trace even if there is
no threshold violation. -t/--trace and -a could then be used with the
same semantics as before.

Tomas

