Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3C346E5A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360004; cv=none; b=PYRe1tGmKoesJQKP4pvtG6/69UWq6BLzZLCugvGB4biDykUJJDFb0/uOKKf7vfvm4c0ArrqEw0Vj4yCk0kgh2L841f/1D856oTyCYPQRiiMsZcRMzFYqahjMuoRuMMYLmBQbpZ5GUTXmpqr6vDWelLiSQk7IQbDwcJPgomCVfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360004; c=relaxed/simple;
	bh=jWnnU2GAmGy56FDiHBeXBrscnH0kfpAc22pKr7Qeghk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddvrOX+fkhgV18ztsLM69XcJo2rA0qVz0sKid2CGMbFoRd4435YAQGJF6UR9WjtRH/4CI6ijXvPNInO5gqYoM21klsjiakNcjWyM5VbBBixkxxUnbBSaj0GJPjepD9lOaf+H3rIPCRoRqxpzQqL3+T0t+qC45fpZms2lUxntf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbxL3vAl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbxL3vAl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777360002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWnnU2GAmGy56FDiHBeXBrscnH0kfpAc22pKr7Qeghk=;
	b=ZbxL3vAlyoygkV+HaA3uF04MxDOWg6JJXYMAok2+PLYscsH7U34v4jLebDM1dTYnYrALZB
	54p22waliRjweL+BgCI54NQegQU1BelTTbDUifUnQmQHzmIWYWTCIfTS1e7RgafdAB5U1f
	6dRt6Ti1aBYreCMtAuKO0lF5rUu+LjQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-lixrJF_cNMewk5iBaS0s-g-1; Tue, 28 Apr 2026 03:06:41 -0400
X-MC-Unique: lixrJF_cNMewk5iBaS0s-g-1
X-Mimecast-MFC-AGG-ID: lixrJF_cNMewk5iBaS0s-g_1777360000
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fae95c82cso211357461cf.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 00:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360000; x=1777964800;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWnnU2GAmGy56FDiHBeXBrscnH0kfpAc22pKr7Qeghk=;
        b=ldXr9RPOYDeU+8ei309CnrbutixyWRqTwIZfpRg+riWzXYpO8LoK1SlBTAAyeSQGNK
         PpHVuGCAsy9BlEkfafb5vVIF3riouFGx8CZOIViL4LZQw+qqwkyCw/HgRL9ouWNphIY2
         dStGWAPeR8V9sbNZxf5XOSC7bWPXYYk4s8RQOpvZtYzqy/6ntm8+rhsv4OyxX961ElcA
         H7A19LxIjkvuoEt4UJndrpkT5eusljKZDRY4kipbs9YOiwp+IMc/yQG75rJesx4PIwnq
         XUm1+qh/XhYrpHd+XqZCl/NYRlACcvXGFws+D8fnssV3r3nSMrVIcsMxJzNrgbI1diEo
         rVVg==
X-Forwarded-Encrypted: i=1; AFNElJ/S++ICc0mOVGzwCqu5UDFQzyH4XMqldoTfMOnPUdblarNRK8TZZZp8z0i0vggmE8V2OCyGnGMhgHEsAUbhHxIqwaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU90j3IyWzC9SqoJiG6rvoOanu0CIL+Mfv/hbc9mX7BHgSSCBm
	W3NVoyEQe6fug/H+O+1XdpVLkDZhSBFPvRM7yP7t7mLhVQoPbA0x21WMRIx/XpBxmckjlM7TL0D
	/GnAgHKdqx2pQsVLZ/7eVGmWGE9WerG8PE4zqzXkE1YRKFXeaWH7uBSdODTkkOvHJni1z7GX1lg
	==
X-Gm-Gg: AeBDievYgxzIepJVy1CZi0BCSrvFZVZ0n39S/ThExt9lmI2ALybQwYOzkslvCHAaMUz
	oAgkaoL1E5VAti3aG6GItdo9mgPtOor5lVYjyGU9di6/i4XtSI7pJYgTqy9KggJhs7RAQXyE3un
	CPZ0povR3wO8WY5W36sCOrBb3JZ83jUjJPF91lYC6HH+CHhs/j4EdsFn7RH4MP+IPm1ZdsXbDHX
	wwHDgBq/zWjlCg8aad5tlFd+fFUPbd3Maqzcs9JvS/+fY2j1DIAh6iriG2ouV+auW5QTpORKPwK
	FU0wwEWpfdFqvZAXd/0sfQlTwZ0jItA43MBQbZxvbDsuN1lxKIAN6beCCtKnQiS8RWleDZhxjTs
	gyv6gwuKXQ43aBA8HRPJ4BwY02V8twdeZIpky
X-Received: by 2002:a05:622a:4d06:b0:50d:9033:f2ec with SMTP id d75a77b69052e-5100e1db2fdmr23108311cf.50.1777360000224;
        Tue, 28 Apr 2026 00:06:40 -0700 (PDT)
X-Received: by 2002:a05:622a:4d06:b0:50d:9033:f2ec with SMTP id d75a77b69052e-5100e1db2fdmr23108031cf.50.1777359999774;
        Tue, 28 Apr 2026 00:06:39 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5100db89c03sm11207781cf.27.2026.04.28.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:06:39 -0700 (PDT)
Message-ID: <75eeb7196b3e65b4b5d5144f87aabd8b57793ebc.camel@redhat.com>
Subject: Re: [PATCH v2] Documentation/rv: Replace stale website link
From: Gabriele Monaco <gmonaco@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>,  Jonathan Corbet	 <corbet@lwn.net>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: matteo.martelli@codethink.co.uk, skhan@linuxfoundation.org
Date: Tue, 28 Apr 2026 09:06:35 +0200
In-Reply-To: <f841e9f6-9d0b-4e10-a930-fdd74a74b9b9@infradead.org>
References: <20260427131709.170505-2-gmonaco@redhat.com>
	 <f841e9f6-9d0b-4e10-a930-fdd74a74b9b9@infradead.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fzhH_C1SuTsaATvvQFgNQ-_eJMxlfXpjL-IGAEOAWkE_1777360000
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-27 at 09:50 -0700, Randy Dunlap wrote:
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for the ack!

> although I don't care for the "J. Syst. Archit." abbreviation.
> Does JSA use that? Not that I can see.

That's the citation format I got from semanticscholar.org , it's indeed
a bit ugly but it's apparently the ISO 4 abbreviation [1].

Not sure if it would be neater to just use JSA which looks more
official.

Thanks,
Gabriele

[1] - https://dblp.org/db/journals/jsa/index.html

