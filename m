Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CEF324B0A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341685; cv=none; b=Heso1rcw0iORnMt3mP6661fwenAsKqHFZneKUgXR2lNO+TuqsPUoOofZrtLV4qjFC13lRzEeKulm+sx3cn78buwAWlUNQ7cCqhIwGGcOp4Ynrj33R3N7B75yHjDNJtGI9mCFZXtH/no/mkF2rYISSF8Pc1MaT+KbcMXarB+2+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341685; c=relaxed/simple;
	bh=LFZYRedxA/dOfRqaPpVPaG9kpYZqtR6uMO2q1QSkh70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVLnieJHoP9lUTojHx4amOVc1Tjw71I5zx7BC3a7Y5kewK0EMkom/2vX6f0MF9rkJCW8lUXAkuQfbz04in/U123rgnK+Hn8DwPuYK0mUwH5aRoWlcGfJ4mfcb7r1Mcu3kTgx0Dm+G7AIaYj9wZpn4tVCuI24UZqgHjbLJCN0JL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFS5++CU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFS5++CU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768341683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFZYRedxA/dOfRqaPpVPaG9kpYZqtR6uMO2q1QSkh70=;
	b=aFS5++CUlgtnmMGiNpAaV5pqp7jsAPp9VYgWxmmpLnsHru/ecoE8gQ3JHGTpno0GlaGc4R
	YjZfTJ2Q0sViKWztniFsxvzj6qTUWRyC+rHNAQ2ZY+EwnuQekRCdGgo77Twofy9w7igpiA
	15TbxmZy133Zz8GAEp8TFRDT39OYFBk=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Sh9TLQpUNqm7fbh6nco3bA-1; Tue, 13 Jan 2026 17:01:20 -0500
X-MC-Unique: Sh9TLQpUNqm7fbh6nco3bA-1
X-Mimecast-MFC-AGG-ID: Sh9TLQpUNqm7fbh6nco3bA_1768341680
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6455711052dso12699954d50.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 14:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768341679; x=1768946479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LFZYRedxA/dOfRqaPpVPaG9kpYZqtR6uMO2q1QSkh70=;
        b=RQ1TOfSsXD15lpCd+6+4WATQFLRU4K0bOXWQkLcbZmPxPhwBKgYfUlJVKgjgpwQfi4
         KA42Lrb5hraKgvXdNZqw89JKnTOTGQ0IdWdcp6+HcGsdIzwq7pvPhKoIMv7VsSxZxolq
         45+Qz3rptb5+Lf551SOWt9uXeEiQLWrKqGwSHwLEV1Lkf82w8AAQmKkv3GwBRnKM2A1a
         K7vTlgXCj0kJJN6AMN0vkJdQtMioWCZU+j4RKyrF8W0R/xNDvx9pIdEIUnw8LtSCola6
         J9xg9b8bb73VWcnJ4+cwhZb1RWxvUiIfm6zV76kcKopNnTMnTdA/BwHzbxFstkNzKPJC
         Y4nA==
X-Forwarded-Encrypted: i=1; AJvYcCURldn6W9mVYV5DAEZ+eke8xq/jF6gsCLXgbdcPwwjP9+Njs19yTGG+1sU3mfsn3tlrYqEAqfyb/G41A2sSb18pHUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMB5uZ9AQ7mWppaTVl+4rumaSPW3YKQf5joXhApQdBoF4W/S+
	XSey1DRZpaWT1Vo9j5V+ySHIhGAv2j0zNlY5XMw5K0cCzh0biAFizWQD5V26pi88hPDJMVVbBAh
	bY45wNnhqjx315RgRDbE6LU9vhB1AeMvNJVWNkApm2k5n2vOqJqmYpm5Xdr/V8yvDqQDfeKyt43
	/E0zxsWcbEuMT+lImXBJEI1UPLHY+CYotDsFnOudQ0LJLOxpgw
X-Gm-Gg: AY/fxX4UaiTunnGZ+AzOcd5Nv3NeV15e8U1ULd5IO1Nn2E6yb0usa8uiMigkj1jVXQ1
	Uk7YwdYyuxlOp+wVYVlg7S/6qQyNkLAfU38RNNo/VtLi2rEpTkrnH1YrWcfnETpYgX+XdZw4Vp8
	1d6YnNrV5mSQu6cVJyUyQAD+FC0k2Ctlb54b3CTzexgDq9+ktMWy0JxU0Vnk3jbGG8AUs9/aZSc
	p8818Q7
X-Received: by 2002:a53:e21b:0:b0:63f:55de:63cc with SMTP id 956f58d0204a3-64903b0533dmr47264d50.31.1768341679494;
        Tue, 13 Jan 2026 14:01:19 -0800 (PST)
X-Received: by 2002:a53:e21b:0:b0:63f:55de:63cc with SMTP id
 956f58d0204a3-64903b0533dmr47240d50.31.1768341679129; Tue, 13 Jan 2026
 14:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201174627.23295-1-npache@redhat.com> <e54b6ade-e2a0-4a68-93c4-23af85479567@lucifer.local>
 <4cfb49a2-f0fc-4796-83a6-91db3a0f2a97@kernel.org>
In-Reply-To: <4cfb49a2-f0fc-4796-83a6-91db3a0f2a97@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Tue, 13 Jan 2026 15:00:52 -0700
X-Gm-Features: AZwV_QhqB272ApR0iCFfYvM28UwTr7qE89tJbFmOhDFMYK8UOvjuB2zu6RzyXUE
Message-ID: <CAA1CXcCP6yrYNAWjo2vsXC959Yi7GPq11uWB-eEv-Qvv+zmw7A@mail.gmail.com>
Subject: Re: [PATCH v13 mm-new 00/16] khugepaged: mTHP support
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PY-pYGaJT9Xs5-lMvZPvu15WnRJTZCdYMdu5D_tMAwM_1768341680
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 6:57=E2=80=AFAM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 1/8/26 18:19, Lorenzo Stoakes wrote:
> > (Sorry for multiple mails replying to same, lei/lore are broken again s=
o my
> > setup isn't working properly).
> >
> > I tried to fixup the conflicts here to run tests locally but there's to=
o many
> > and I messed it up.
> >
> > Could you please resend this series rebased on mm-unstable please?
>
>
> And maybe send out the two cleanups that can be applied earlier separatel=
y?

Yeah I can do that. I'll just add a `dependent line` when I post the v14.

>
> --
> Cheers
>
> David
>

