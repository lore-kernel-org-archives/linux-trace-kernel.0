Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051121D5146
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590344; cv=none; b=CzZAnFCAamjk7zg3SghWYrKH3y741nFzil49XWnuy6U5f8tH6h+3ZawzOwYyAQqwwxav1T8fIrXnupK8qAKZ81GEW8YoJEGY778Iz7dbk5BUdZlN83H9ObiK0l/F9wq1Rf0qgX12fbiLaKAGwE+9br2CGXNChMX7DmHJN/TkBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590344; c=relaxed/simple;
	bh=vU7YIeqeNnP2WZniRMFC46l0QlmEBf+apmlt516M9/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA0FwlshHBCzsz81Vr3tBwTrZ9tVNSevwaJY6ZZAQvWDsBPpAeOQM/lh0WFfK1jqxlTUqd9OyFbnXFXcs0kZ8qQLgietyX0rL0mIUPSsncfWYzewhxKueSoePqm2WweXgj3LN9d7l56Cu83RvEQAL+v67QX/LQ2skTlnSPFiQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRDBpeG5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRDBpeG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757590341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uv9xgEOBHqilZta2Ov9hEM6jLUDZQaOycayp6o0rFY=;
	b=fRDBpeG5neSF8OMp52p9TdEoXTePBC5l+88laz0EMLQIIfmzGMHR0nLqcQvfoB4aFe00NO
	30Jjy8QBoo0OZObDP/+R4wbaPxhwZ5R9NblVup4IS2CmQt7DNmK26zC5H+d3mqdfsjFGnl
	zBPmHHx1FJ3CKtXPqo+xvLXYM5v62W0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-j9NGrcu-P8689H6nzcj5bQ-1; Thu, 11 Sep 2025 07:32:20 -0400
X-MC-Unique: j9NGrcu-P8689H6nzcj5bQ-1
X-Mimecast-MFC-AGG-ID: j9NGrcu-P8689H6nzcj5bQ_1757590339
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afe81959e5cso62342666b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757590339; x=1758195139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uv9xgEOBHqilZta2Ov9hEM6jLUDZQaOycayp6o0rFY=;
        b=r+LgDWwzMwusLRKjjGUCBH9vb3yR/geA+M1xCWKfTc/MyTSC9J/EmVAABSUV3oFpao
         O7B5TgVXuyiNemzeSfpckVfLgn0/m3K9oR7JuL7JHAX+ckxA43BCy1tfOZ6SWaSfu7yE
         j9ApBn7RucrwPT84Wc4HzRGCHEpznBr8n7Z3aKB4LMsqeBnBO3Lc4UZqA+KXD4EM67lf
         VSNg/PL7BNgDDD+iaPgpYpLvfmc7kTcTH6Jr/ae4k72MpsoDcoUhFPAwxpG3C83kLcq9
         OYfQbncCRK2IqM8i83UmOG5uOpUisHgqkT6y9oA/LxBjrxhihm4ZauZHi2oqV/XGdh4e
         fOTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaiIz0vMLmiML1NkToXeHaw1cn/rMUkO7iRt6/xZ6Rv1FIFSMRLYAdJ5K6j3AQb3Y8m8csXpZfaKew2tA6xUgMSfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQXp+sgP7UXWHKKH/S3qlaLWyDjS9xSePhxm1SpGbSPrxggeu
	5iu1kvIB9wnW3vDnCpL/YyZHmVbsqJNKeybsz9VntgWJFkMk+fC43vMgima3yXBJL90PqKOZSHP
	ywQKHx64wTU3NmdDNNu0aHocvhs7OwQpB3y68W0AJeun3SFRZ5eJkR67tZYSabYfowOCByLbweR
	PTZaCJGN4n1lnMF+FaodueO+ZwrmcgEpMKbrgZ9RelkBfdAqQS
X-Gm-Gg: ASbGncvtGqFK3vZEEPBmFcm9g7+NMO8tDFyQGbaRE9v4ZIYK013a0W3UKRAQVwJy65E
	scS9XeFELeyuZ9M3D5ZIfQMjwLg1mWNdVX32GBMTnz91YnfwFm2WzJUzppYK2Jg2KT7sMs2RJkz
	u1UJX3nzXYADykGjiRq4U=
X-Received: by 2002:a17:907:3c8c:b0:b04:59c4:d90 with SMTP id a640c23a62f3a-b04b16dec24mr1845701266b.46.1757590339239;
        Thu, 11 Sep 2025 04:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtryqqhK5XPWAJhTYmS3Rl3cuFSHJKIBlPP4B+UZlUQID8WzNfFKtrFMbWlVE4yUsMN7bd8dbWKx+GhAt6xWU=
X-Received: by 2002:a17:907:3c8c:b0:b04:59c4:d90 with SMTP id
 a640c23a62f3a-b04b16dec24mr1845699266b.46.1757590338837; Thu, 11 Sep 2025
 04:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757034919.git.ipravdin.official@gmail.com> <e4a61cf3416c9b2a2c4952cbc93b4b05a7c3a37e.1757034919.git.ipravdin.official@gmail.com>
In-Reply-To: <e4a61cf3416c9b2a2c4952cbc93b4b05a7c3a37e.1757034919.git.ipravdin.official@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 11 Sep 2025 13:32:07 +0200
X-Gm-Features: Ac12FXwHkQLXa0LpbeudjoMzTGDDC_VEcWtyIxBvhBzukc22YS3jY0V4NabCWWU
Message-ID: <CAP4=nvTWmoZ8FvoLJK6R4ZJ+LW_4pp2WDcKqBNBt7pLjVfL0zw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rtla: fix -a overriding -t argument
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BAFYXmVwT2oEeAv31UKLaFDQPNSUDRZlKFy-3S5Njyg_1757590339
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 8. 9. 2025 v 4:06 odes=C3=ADlatel Ivan Pravdin
<ipravdin.official@gmail.com> napsal:
>
> When running rtla as
>
>     `rtla <timerlat|osnoise> <top|hist> -t custom_file.txt -a 100`
>
> -a options override trace output filename specified by -t option.
> Running the command above will create <timerlat|osnoise>_trace.txt file
> instead of custom_file.txt. Fix this by making sure that -a option does
> not override trace output filename even if it's passed after trace
> output filename is specified.
>
> Fixes: 173a3b014827 ("rtla/timerlat: Add the automatic trace option")
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>

This part is good, the only problematic bit was the clear_terminal stuff.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

