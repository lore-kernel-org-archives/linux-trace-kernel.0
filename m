Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B3274B5A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753434841; cv=none; b=MxvCTmiwZprfL6wWp+oIvh2krPum0NvBWLQXbVgEEHyhzHw+U/Y45fA8FvMi5B4FCnAA4xJ9oXGqxiqp0Yy/OaKInzDyKC5PUXFDxK4U1IqFxOMITYxJgsJkbrqQdC2+aaIOt5uSG3aCzWR6NkLC12B7/upYwWobkIeOnzzsUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753434841; c=relaxed/simple;
	bh=cUyg1SkNBxbS54LqH20gfKt7ycihR9zZ00+Od8G44+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wwi+5Q7wN54s/OY830tKrqvymHUotxjpByD4e8W17QyTDEedra22UsoefMEwO85fqqxVp5YhD+J1TqgDmNJOVp9ZYKRV+/zhjkf3xxob1Q1tPRM1+h3Qn6/tv/SL39QYF4lcukXH5denxscXTtiCElhgcEq7zhQSSf77tF72DW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPR+zhtq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPR+zhtq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753434837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JydGIle7+KIUgbdtBYbE6AFRK1qmMolB16FeEOA/Yzg=;
	b=KPR+zhtqMgxluoKAfwacRiiIgmRR89NAzh+1fdVug2K61SR8ATUF5ngd5m6gSgEFpPynHR
	QUmZcGf3p6/kq1kviYxQiRL5nE8xkQemF15686G8P2wPywxHYf6JZibvvGiFu1DgKpInei
	DkZf9+f3DvuC3pZB1UcQQPuDP0KIMmc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-aGutkyZPNPC1rbN7fTQcxA-1; Fri, 25 Jul 2025 05:13:56 -0400
X-MC-Unique: aGutkyZPNPC1rbN7fTQcxA-1
X-Mimecast-MFC-AGG-ID: aGutkyZPNPC1rbN7fTQcxA_1753434835
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae6d6b8eacbso151962266b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753434835; x=1754039635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JydGIle7+KIUgbdtBYbE6AFRK1qmMolB16FeEOA/Yzg=;
        b=GIz4EMZP2cR0bl9J3MUFKZ7PPz+UzuASi7y0t9gil0Ks3WWbp0PIrnCUt9zxY3gQJa
         PjBSJLvRPCg2NObOLmW/oMG64Dg9P/JPeQd1SqJrqe/yk5bpdTUue+XC04dus3emf8gx
         eAyenzs3MMZfDIL8plDVV/34V2pUBHcdKLxoZw4dTCR9kRm5idm0B8Tn6onfAVGX6DGk
         M/vCgeZ0KxG3wYFlVGHINlliR6LqLoJcf74dFuLnJPIhWdyv6fnpSMFb6API89W1hH8u
         XxFXsj/pHB7JO0iztH3KQgBPkvGRe9D/SMM/Yn4O2wA5Xjs7Sy4Vjza2xyXnGtXHl/d6
         irbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbDMV8p0EtNwpwOemEw76ptOv0bVif1BL+TIFzB2KhW886SlhLzcDDotTSLLGYqMJA18o4t8YUO3x09WS8fo79mYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzeswsboRXP9WAU4xvQ4oWs4iwEXQfjqrYOCi8UhmVZRwTp/n
	qmSIsmvNVcvEAYRwORpqC5hBhlxBr0psw43EZBSoKTtQaPrHTa8fq0zVhDicbad77q25iiwUZqL
	FLBLRZSYToFBNHW6fR/xcLqXqxDB6mU8mGn+rjdnekded704iFOT5SboSU/fnX/GQ2wryOII5GF
	qFmI47xe7sG6cf5VgLt9cHFLB4yN5d3NEAxEU33LSf3I/dOTJx
X-Gm-Gg: ASbGncsboClxZkpah9AmqcTQkHIAVXLaHbebMzBkIjYiUwnrlv5jMDTtURQJMFC5yws
	drzh9YV9cXCD14KY+w06B3pMmpuHMkMOdgEo2+o0gz7Rh/JDgAh4v0un6YHsgek6cHrAJfcxCqP
	kLxdsEWbfIno9mupmwCPO0P1yBRzd4ls0bPzL3WrhZBjEGsjY0S64=
X-Received: by 2002:a17:907:869f:b0:adb:23e0:9297 with SMTP id a640c23a62f3a-af61c6b913fmr140269566b.17.1753434834769;
        Fri, 25 Jul 2025 02:13:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTpH7eehWGEJJmFeTf+Td/G4IxZvXvweyFMbHchaLdc5IGS9b+k1MYrJRBTxvLHA9m4a++NsLGQ3PTlEI/B3g=
X-Received: by 2002:a17:907:869f:b0:adb:23e0:9297 with SMTP id
 a640c23a62f3a-af61c6b913fmr140266766b.17.1753434834329; Fri, 25 Jul 2025
 02:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723015233.173630-1-ipravdin.official@gmail.com> <20250724095627.572c1cff@batman.local.home>
In-Reply-To: <20250724095627.572c1cff@batman.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 25 Jul 2025 11:13:43 +0200
X-Gm-Features: Ac12FXwqtYT-kICQMGWTXZpELDsse6D6d7kSh7SWGB9TkFKXpKIy-t5EXJV3ZDA
Message-ID: <CAP4=nvQde7JcbhR56--4EfEsJ+F9oL4WBCRcLaOqfV1MZ-XvjQ@mail.gmail.com>
Subject: Re: [PATCH] rtla: clarify trace option syntax in documentation and
 usage help
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ivan Pravdin <ipravdin.official@gmail.com>, bristot@kernel.org, corbet@lwn.net, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FFMcvHCmKbtoZobXK8qSvvLMTZFl-w6xusI1JEZPzxE_1753434835
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 24. 7. 2025 v 15:59 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> On Tue, 22 Jul 2025 21:52:33 -0400
> Ivan Pravdin <ipravdin.official@gmail.com> wrote:
> > Valid usage:
> >     - `-t[file]`
> >     - `-t=3D[file]`
> >     - `--trace=3D[file]`
> >
> > Invalid usage:
> >     - `-t [file]`
> >     - `--trace [file]`
>
> I wonder if the better fix would be to make the above valid?
>

Definitely. There is also another case where only =3D syntax is
accepted,  C/--cgroup. In my opinion, both are confusing, and both
should accept =3D as well as space. I even had some trouble with the
latter as it fails to parse silently and looks like the cgroup setting
code is not working.

Tomas

