Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF746E007
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Oct 2026 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450062; cv=none; b=FyKCp7Gl9ir6kb2EmR3LdRhkkmSQsKzeeFv2mM2/u6rxkrS7pMH/E8F9/I+8XF8z2MGJX/twCVVFHEFGWgLkyk8NejSeBPJUF5HGBpJvnhmdbmkSmBy5pOI/c6KIReG3FP9jDey4PvVkqUWY9bgyuo+4aFA9MQVF8zBqfmpa0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450062; c=relaxed/simple;
	bh=8ydDEYv5AKam0+ZngwjECz9j3WRSUp33maFDDjjH8mM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WVuiEnHMDDhYrVlsnW09VzHA/eStDYdHtbOxQL7Nxh2sjZvPzmsjtb4p23AYEOo9WYcY6lB8YfOfaLvfxJ5VkMB/sBUQBglz2XLe5ZUesmTCWkt10ExUjLAJRRxv0I/rwqiJG0W/prGNJMDyzxGzLwl4zL9JLZT1aCQcXsgi8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEY91oNy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEY91oNy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791450060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ydDEYv5AKam0+ZngwjECz9j3WRSUp33maFDDjjH8mM=;
	b=HEY91oNyLgtWzdvnuJnHVXfGAiY+ksMHGOP3q04RipWxA40x+6kv1gLsChYxtotTmLE4yl
	RdAWeZ58KUBSZIpOJDUTY2Q1Uq2ADm032wG+b1mc9LYS/+jcUiinpQ/44AHQ3iyJDvAkgh
	rqGDUjKcQM5Pco35DrQe+7472iuaoR8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-qu5dD1jvMR26VUt6gGnR1w-1; Thu, 08 Oct 2026 05:00:59 -0400
X-MC-Unique: qu5dD1jvMR26VUt6gGnR1w-1
X-Mimecast-MFC-AGG-ID: qu5dD1jvMR26VUt6gGnR1w_1791450058
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1612c4b80so47924815e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Oct 2026 02:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791450058; x=1792054858;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bubMmErBBviwm0SDj7HwGRRwgU0dS+pqJdsiw3r0uFY=;
        b=u//SsDD/jDlJUl6Sx/ovexfMgPX0O54VQLZSw+5e/RNdHyjLTUsmGBvYMy25k5TJOz
         L4HI0tFQ5lVkMUNs+GqdKSzRniNWNtwJcG4jkN9F1cd/pP3yb+9FIIjauEnJhD4M5LCJ
         lS1ySmSSCn+4U8vt7YW2NRpXZyldbvBly7Xf1O45u1B7B5zu9eGfGOb3XlajcGlctMbi
         2IBaMpH/IXYa8G0nxZtk6M7CB53qPPgzncze5aYVLjmSpX4wAaVRVo8+xlsNOVQVxNV8
         WhfhsjSp9cgLHWpvxmn6KYPkELI2r3GGX3yP2R6Bv+yKWgvrb9QHeXw129jG4EfRrm9Y
         HCKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwa3LAX+wigD5oF06OLkJ5LMAniTXUNIpcIMbknr/kym0WjmKh8dEowfCZ2Asl6mEqjU1ChyL6yMq0IELlAxo6/jyg=@vger.kernel.org
X-Gm-Message-State: AFuF++nF9aG+y8ApTsxR7KdzadUMpNFXh85Vho4ZSYE4Gc+ga/3tbhbv
	LrvfDNQf1BnuArAWvwKnxNfT5qnD3CJTECG7lz2QK0q4cySWn0eV1sUKFi6esSjFKwsnrVqnjXq
	Fb7pLxaXFZPhx7MqK1CpQmWn3GAe5utXv5vSLuUL6Gw63s5Zm2auQXl9lO9jguhFNiSoeRM22nQ
	==
X-Gm-Gg: AYBFou2IHzzeDA62uMDkPZ0JhOURmD/fxYhukl21lD0UIJtylzoeAucgKal0nKmK5aE
	q8q7EOJsHYd57cv198BU/He2HTkOdN24nDdMTnOTC2Fhopbtzsy0EZii+C3z0nRxqQxp5zhyTep
	L9nTnDyNfXrWLEkqvE4endsrYmKEAg528U/KvR+1c12TWVV6O0zMQcqUmutDSwkD2ki/SSEn5rh
	DIS0BnN6MXp00FNEMInbQNqmdnwu2rm9wbLjGhjDuaxxg3dbk2zUk3a6UYWckf1Rk0phWyAzVTo
	UwAuoWTBANOmiH9NrykmhCr4OukFdVJzLZZlN+zydlL2ZOe8DXPeXn8fiEGdiTPLLNQ70zU97h5
	esF9rvLxr8ADiJOlV+fR0ID8XPcn3Pmric0cS
X-Received: by 2002:a05:600c:548b:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a18045f729mr85522855e9.29.1791450056556;
        Thu, 08 Oct 2026 02:00:56 -0700 (PDT)
X-Received: by 2002:a05:600c:548b:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a18045f729mr85522395e9.29.1791450056135;
        Thu, 08 Oct 2026 02:00:56 -0700 (PDT)
Received: from ehlo.thunderbird.net (mob-5-90-15-200.net.vodafone.it. [5.90.15.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3d3eesm11480317f8f.53.2026.10.08.02.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 02:00:55 -0700 (PDT)
Date: Thu, 08 Oct 2026 09:00:54 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_09/15=5D_tools/rv=3A_Copy?=
 =?US-ASCII?Q?_stripped_bpf=5Fatomic=2Eh_from_libarena?=
In-Reply-To: <87ld89wtrx.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-10-gmonaco@redhat.com> <87ld89wtrx.fsf@yellow.woof>
Message-ID: <4F009BB7-58C2-4AB1-8FEF-61FA4B5281A2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BRsGVFNt2tKghNTDSMs_tpYffCw5z_3TmQY_9f1tNGQ_1791450058
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 7 ottobre 2026 12:59:46 UTC, Nam Cao <namcao@linutronix.de> ha scritto:
>Gabriele Monaco <gmonaco@redhat.com> writes:
>> Add bpf_atomic.h including atomic read/write macros like READ_ONCE() and
>> try_cmpxchg(). This version is a stripped down copy of the one currently
>> present in selftests/bpf/libarena.
>
>Instead of this, what do you think about using C11's atomic stuffs? I
>prefer standardized stuff when it is an option.

Mmh, I'm not too familiar with them, but they wouldn't be drop-in replaceme=
nts as far as I understand. I'd need to use C11 atomic types and that would=
 diverge further from the kernel implementation.

Ideally I wouldn't like to copy libarena's implementation but I couldn't fi=
nd a cleaner way to include it.

I'm going to look into that more carefully though.

Thanks,
Gabriele

