Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764D17A587
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010929; cv=none; b=GKPI0HNIXIATHsh2l1d0rNLeZBJTgBi0YpFhyaBF/W+1tq2amkZ3tkreyZPkwaBkfVDcD9SG7vsJ1e276TowIBZQ/kQj07FMkhkd++TUBSKPGydlxnxy2vVsYN37btW3PHvMO60FXMT+xq0zFzErKZx977byabaTHPrQxA8q4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010929; c=relaxed/simple;
	bh=nOrLYdaQKWbCBzur09331cdOZ260WekYtYvlyXlVvNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M+Cgjvyn6uPP+e4WuY8s29uwKQ9SDYtDPayAceugkQfCeOqaf1ieuJh8RoVRr9LF980gVhxAIoFdwpICPP7oI4S2yKmrufQ+umw8xTlRzbZSsRyEMzFbMGzi+249GLyPMrqk/sJGvQXuIAI1tV3+dikWeG/4GZNrYHogfGalunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7QCLfwU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7QCLfwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720010927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2MEP5KBKlMKx9T4CmY7WwoI0xWCk7Wv3Ry4wWTTbIMQ=;
	b=P7QCLfwUcz3mg2A5ElG0ooCZzvadMZYJQAY+KS5kE9t26MDPBMjQjMeIVsODzCMY0DCEJe
	Ep41J0lxy3oVja+gVxtNGpFAqxAWuEZ+B4IoZ6kbPZ0+Ce8G1w7kNVvkv7sURdc29q/d8S
	McbqP4YFFDZhyIzrpg868ivJMZwIMfI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-tBHi2sSAND2wkIGZdF7H7w-1; Wed, 03 Jul 2024 08:48:46 -0400
X-MC-Unique: tBHi2sSAND2wkIGZdF7H7w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee890f0cecso2347431fa.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010924; x=1720615724;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MEP5KBKlMKx9T4CmY7WwoI0xWCk7Wv3Ry4wWTTbIMQ=;
        b=kv6H0JcMhI2CbqmpHOJe3TP2CNT802mhabNnBehWn26L8YVzh80ZGtqm001HplaBm2
         6m0vUIhnstbnwqv0twQWv6Bt6VPpNz8ryGjlHM2013jSLcwCCqWIaedHBUe7tn3UoK0T
         iBxbpnsTYbcSO/sSNSLvGMVFm+Eg4SytybKNGPpigL5WfovV3S9IW0eb5MMVjGqayrFc
         9GfDuq2QRJlAudUI/NP5kPGacku/eXKyYJXJtXXwL6BtWNv0+LoqwD98hT/WS28XbAXV
         Bp71ViZJvaPtSCJAHlNQe4KQuJm71lSUiUYBzYcfUglQAtqDV0cBLOGvBriiNcUxt86A
         1fTw==
X-Forwarded-Encrypted: i=1; AJvYcCWaRr5mRWTipp2sL4s8fs6g9hiz9N03RsdVZrGRWInF8N/z2fmWHFbmTx66mg843fyddnawdgACJDLr8CIn9JQ8Bub9iAiJs6k7il2SCeFxud9i
X-Gm-Message-State: AOJu0YzA2ECj2uK0Mv1URW8z+GLgwQFc4KpN0MKs+QdpwsajHFUz9TVH
	xUQx/PCfw62Zrghyt3Fr9lITrlnhM/Iitn22jTstkUjgGwBAp8Ovx7DSTDsAM6fO/NB8S3/Kw4i
	RLwElXayG6k4fNSUwsxhF0r/4OPJGu5zJlFJPCazgc1VccmK/UYEcqgGCk0WVM5mm7vkqFw==
X-Received: by 2002:a2e:a7c2:0:b0:2ee:45f3:1d13 with SMTP id 38308e7fff4ca-2ee5e704e51mr78433961fa.47.1720010924676;
        Wed, 03 Jul 2024 05:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5TqWKFAuIwTILcZtQfViw3L54aF8RKuLImctjrV+bIlLQQRnHKZJF7c8esvbcZCiclXd1w==
X-Received: by 2002:a2e:a7c2:0:b0:2ee:45f3:1d13 with SMTP id 38308e7fff4ca-2ee5e704e51mr78433691fa.47.1720010924256;
        Wed, 03 Jul 2024 05:48:44 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8cd8sm15773145f8f.27.2024.07.03.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:48:43 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, seanjc@google.com
Cc: pbonzini@redhat.com, seanjc@google.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
 nsaenz@amazon.com, linux-trace-kernel@vger.kernel.org, graf@amazon.de,
 dwmw2@infradead.org, pdurrant@amazon.co.uk, mlevitsk@redhat.com,
 jgowans@amazon.com, corbet@lwn.net, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, amoorthy@google.com
Subject: Re: [PATCH 00/18] Introducing Core Building Blocks for Hyper-V VSM
 Emulation
In-Reply-To: <D2FTASL4CXLN.32GYJ8QZH4OCR@amazon.com>
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <D2FTASL4CXLN.32GYJ8QZH4OCR@amazon.com>
Date: Wed, 03 Jul 2024 14:48:42 +0200
Message-ID: <87ikxm63px.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Nicolas Saenz Julienne <nsaenz@amazon.com> writes:

> Hi Sean,
>
> On Sun Jun 9, 2024 at 3:49 PM UTC, Nicolas Saenz Julienne wrote:
>> This series introduces core KVM functionality necessary to emulate Hyper-V's
>> Virtual Secure Mode in a Virtual Machine Monitor (VMM).
>
> Just wanted to make sure the series is in your radar.
>

Not Sean here but I was planning to take a look at least at Hyper-V
parts of it next week.

-- 
Vitaly

