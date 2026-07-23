Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977943E9D2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813307; cv=none; b=e++KvGKejc55iuQIGEOTtGiqwbpsbgDxuluse76NUVZyAam3S+vrOEmc+8zeBIKxmObuuUXEqdlz60dWzV/75SGKcb/MBstCSey2u0HV6cvSFvtw2BIZJszOd4S19bqbchCeUDgIIt9d7upjCWtDZSuBCbYrw80dKdjA8q9Ahds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813307; c=relaxed/simple;
	bh=meCy6+ILzHKaChTbBgrCY9EAdFk6pYJw/3pYzTzFG6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTnFveV7RZfcSzW3t9AmNyIOuLRxowLYWHedGDcfNMzzdvsPjEwvQgEaQ8SeiSmHrH9tjD4Y6ddoibqdyPAaZUcmg+d22dv51FplXuBY+tst5Gm7DZh6mS5+RjI0XcBbEQ+4pQIWOKx0cY7FtSoEx2uBOhO8eQZ5KvL9Jp0keT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ryw4wiJU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ryw4wiJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784813305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=meCy6+ILzHKaChTbBgrCY9EAdFk6pYJw/3pYzTzFG6o=;
	b=Ryw4wiJUp7msxyxuROq2IeGBypCeCQAqrJDdq/bfn6d8tGViouT3Mh7tKp0OEah3HzqI7k
	cjjqdSTdO7Me+iT8Y4kHMiI2iG4B6SW6ZAFUkEf1pwl7hLxOd87UJNjyG2tPUwMfwN2/9y
	nyCezN3TRCfnWe6q+An6A/Bveb/BXeE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-JkLMIHZvOWGl4FqKGdCWew-1; Thu, 23 Jul 2026 09:28:23 -0400
X-MC-Unique: JkLMIHZvOWGl4FqKGdCWew-1
X-Mimecast-MFC-AGG-ID: JkLMIHZvOWGl4FqKGdCWew_1784813303
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4956b4cfe19so5451245e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 06:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784813302; x=1785418102;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=meCy6+ILzHKaChTbBgrCY9EAdFk6pYJw/3pYzTzFG6o=;
        b=MBEZspb3OZVBn0kAUjV8u52QS+xOHd2SydrrYHnNlYIHgrRXBM71wvLVpkClyVwYCe
         q9E+y7sBxmms7HnoHAwZKibIpff2+2Y3SrgHamcm0xpdG6kSnAMT47nejRPXkaErWj4f
         2xoRq9C5LelvTwYGEa8UD4t15Gn8+YtI7BRlAxZtFYdqfmuX4hoSpyKKvRLty7mMYVut
         fKxOHZGkhoPHzmrBKvNkgsxq+mGsRBUFzapM18MkH00WoewQWsqySx55uav1LQ/5cJOH
         e6pBBPHhZezXZPIsi97Mnm8ZB9A1J1BLf6dLri+7JAmwqoFCpVkhFH2XnLszYLPHOOiv
         7qKQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUuGz2vg3rE3URmbTnO63RKJKZ+IokT1UuTri3p8bpqCxqIYLl333LonnrwWLM8w6kJ7Q510HTOCG02OewsRvfFCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFSuBzZFacBF3P1iiCvtYpgMPsS+CKMx3mcXzaL98aRvnsVHG
	/YkgYuCTCFdqBFbBu/4A3lZACZyo6IhN1OEuRTI/rVREu8Pc3tWXA4yjoRt8BMOIEUM3WhfDIOS
	ncZBDBVjfaYbstu81ZVYC7vepcP5APw+8lfzuAgmkxb27P6XX977rK3aMH4Vuse6bT/Su1J+/tQ
	==
X-Gm-Gg: AR+sD11Y0WEN81fG8xhx1P/i7YL9edUteOQaoZOnaTdwug8j0SRPnfaZZfxcZiJrfHG
	balqrXXTKWibu4jEK7e6gbD+vUAx0gzWAzd/EDa/riUjVttMZgYGq/+iNGJYW0DPCN6prCvuZUV
	9odHNzvQGUSp8ks0l2abcOkVPEVHgJGYWnpTIgY3hGlMBipfWDQ0AEzo9DCGr43zZozrWpeYjd3
	JoVaoCtiSvS+rsumN9Aq4Wkm543eNkccbKJquGL0VXZTg7V5dHqQVRt5R8wleJGvacNLZbZfCWY
	8+dyNhRp3G8OszUPkJiQRnIJVdUbbBulHoyUQdqTD5Mjen9Ilu3DmvDphOVBaV7HeNuexA8LPri
	jtk2hMKz1g8C3DcxhtcakJs9rGH86DFV5twBxwNYwO6JFWmNqqOKyk28Oh4EP9A==
X-Received: by 2002:a05:600c:c053:b0:495:4a34:16d9 with SMTP id 5b1f17b1804b1-49573d28624mr22073405e9.31.1784813302618;
        Thu, 23 Jul 2026 06:28:22 -0700 (PDT)
X-Received: by 2002:a05:600c:c053:b0:495:4a34:16d9 with SMTP id 5b1f17b1804b1-49573d28624mr22073255e9.31.1784813302256;
        Thu, 23 Jul 2026 06:28:22 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c66cebsm14855226f8f.30.2026.07.23.06.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 06:28:21 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur
 <jkacur@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 2/6] rtla/osnoise: Record IPI count in osnoise top
In-Reply-To: <CAP4=nvSsYuibT7Oq-hAF9b=dZx==FcR1bK5d3zNmYcWgAZmCGQ@mail.gmail.com>
References: <20260715154553.2020891-1-vschneid@redhat.com>
 <20260715154553.2020891-3-vschneid@redhat.com>
 <CAP4=nvRHyJr9vTm0oJe5Pp_nSa25De_zLB3P3hvUpofaKeVZrA@mail.gmail.com>
 <CAP4=nvSsYuibT7Oq-hAF9b=dZx==FcR1bK5d3zNmYcWgAZmCGQ@mail.gmail.com>
Date: Thu, 23 Jul 2026 15:28:19 +0200
Message-ID: <xhsmhzezhj0ng.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sOFbGyW-1pPC05NS775LNVOWpPRjYYzCqsUvg1PWj9I_1784813303
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/07/26 13:32, Tomas Glozar wrote:
> =C4=8Dt 23. 7. 2026 v 13:32 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.=
com> napsal:
>> >
>> > This uses the newly added -i cmdline option.
>> >
>>
>> This is now named --irq, right?
>
> s/irq/ipi/
>

Woops, yes indeed, rebase fail!

>>
>> Tomas

