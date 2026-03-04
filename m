Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDD35B62F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638865; cv=none; b=jgxO2Rta5sQ22lJwugU9Ng+D5uzo3vzUUjSIAFphVTp4tkPfmKjxxocAwvF2HKFfuPYVZJ0wUm7+ilh/ZtNsza8Maq2S6/5ZtPJOsXROtiOrr8yUm5pVSbo9grUfNEGRJXfhmJ7eLSEDhB7aeBq1yrpusg5hIOtMA1u2qJyjpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638865; c=relaxed/simple;
	bh=eXXO3JvNT25eAlvx+ZS1k4YSqotW72Hu288sNSHskyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRsRJFsa+NkBU7AlPrhlR1MPXRN/B+PAaTBfW7n2dgzFaZSqCSlQYyKc8cNnrgjKaqtODjZNxJI0dTzO+/7gRkn3NfONknDQRP3mID+IYSSNQGjGPUtQvSBBcEkEM8txSlTDbQ5oZWMpAufOuCpGeZPiuObpeoVHqr3Gd16dMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bj69SkMc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj69SkMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772638863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eXXO3JvNT25eAlvx+ZS1k4YSqotW72Hu288sNSHskyA=;
	b=bj69SkMcxNyZsb2GYum95ljwFmxWXl0vdXZFD3DC++tTtEHeACq0//mZHpWSCpjj7z7CJ0
	1Po3Ej6Mw67hcZqZt8GoaeecWbPP55G74Osvw0zbJ6GAlLZscx98EyoMVRg5yRDASbBI8X
	azjhyBJNkYboTMllfxYrU2tYydw5nZc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-rDeSZUO3OkaXD1CT22UgaQ-1; Wed, 04 Mar 2026 10:41:01 -0500
X-MC-Unique: rDeSZUO3OkaXD1CT22UgaQ-1
X-Mimecast-MFC-AGG-ID: rDeSZUO3OkaXD1CT22UgaQ_1772638861
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8fa5744b82so706628266b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 07:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638860; x=1773243660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXXO3JvNT25eAlvx+ZS1k4YSqotW72Hu288sNSHskyA=;
        b=QL7epiZMOvuuQ/IgMxnORXLpzFA8RlqsU2VWtDt143r7BTAeiQNKdx7YcyJXOWBBIE
         oewUbconYnRzozf5qjgPUjo3Ji8OUmRabbAnHDoKd9ytA+1sMGPJyJcE/g3i5dHzfjX1
         rBUeN+CwXjweDuQTgzUgsSkovEEX3cugf5DKUgyecEDjuwWNn6VIyhLwsx17TfodIvcC
         UvXUfqpFNp1Q+lGToB14RK0qoaX08S+x1tjqUVDLi5q8xLXrjrSOPwo5s4kvqstkWDuG
         WxYNnP6Z2eH6A6gezJ6FlH3bYn2CHn4rInFiOtiTb3ROfdtRxzGtuTQHx/907WD6asOP
         e66A==
X-Forwarded-Encrypted: i=1; AJvYcCVJxkD0gD/fgYVvauirw5TQHxk0Xn1WePVczP1QQX/CG3X6ep2S3F7EHWsY/RyNc0NYlW/ZaZVJuQQ6GkvwJUcesJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8Q4alXI5giFxGw8PvTF3r3QwVuT3QBfRlnD3GeXBB7LBkqgS
	FsPJ9Gc5ASdrX7VKOPjoLEtxSXUZum4uE2KP+fa3UjWgS9MuwIc6OFALMb6bZIaSQ4Vvw87JG3k
	iZBhXeFCWOUDkv1B8aBXUiQyAVdFxDd/HDyPK21yt/f7Vx+58RVKX8j/041tEJ7KknQNSVrMsrJ
	jdczlMnqVeKXE++qvXPi06voFKjkl3fywolUGypixcy5enNCqe
X-Gm-Gg: ATEYQzwPHe9W5vJ0P6X6DHrrJ9t/iHQDnjfYGU9Gwla6AYG01RJEi5Xu2uvqN+O1LSl
	KXL9CkLv3x04T/K2v3u3obpCLIzvlDpiOle/GySOJeWCnWd0LKYU2TGMPPRVRxpmZRAbAFgeRmL
	QNDAgXJtgOyrDSxfZpr3kVtgU0divErVuyN4jxc0g0xUj5Yo2mZdr4tl/AcMWT4RTluLmDiL3Wb
	70hbBOO14tSxq+xVODscJXXx2ZAH1MOOL6k4nQ=
X-Received: by 2002:a17:907:2d87:b0:b88:5158:d106 with SMTP id a640c23a62f3a-b93f154b56dmr149630166b.52.1772638860354;
        Wed, 04 Mar 2026 07:41:00 -0800 (PST)
X-Received: by 2002:a17:907:2d87:b0:b88:5158:d106 with SMTP id
 a640c23a62f3a-b93f154b56dmr149627166b.52.1772638859819; Wed, 04 Mar 2026
 07:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213115234.430232-1-costa.shul@redhat.com>
 <20260213115234.430232-2-costa.shul@redhat.com> <CAP4=nvQ8xFr2mD4z01e656hfE9btiFRu8xrqHiR0zGkDYsiVSQ@mail.gmail.com>
In-Reply-To: <CAP4=nvQ8xFr2mD4z01e656hfE9btiFRu8xrqHiR0zGkDYsiVSQ@mail.gmail.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Wed, 4 Mar 2026 17:40:24 +0200
X-Gm-Features: AaiRm50Tx4kP75HvOGffhYU5EKa7DmQTxYEcq3WXv3ktKFx9Pt5RNfV9InaLVl4
Message-ID: <CADDUTFwD6i=JJCSSndFK=XHG5YrL3gnW95EMQEQmOM9HCs4tDA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tools/rtla: Consolidate nr_cpus usage across all tools
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZDFjS0uO6WhBFyb6mzwFa_bXwnZN24TpZIqDDZHSBrk_1772638861
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 16:59, Tomas Glozar <tglozar@redhat.com> wrote:
> This should be updated on top of the unit tests patchset [1] to also
> include and initialize this global variable in tests, right? Without
> that, unit tests fail to compile with undefined reference.
>
> [1] https://lore.kernel.org/linux-trace-kernel/20260119105857.797498-1-costa.shul@redhat.com/

The unit test has not yet been approved. Which patch would you like to
approve the first?

