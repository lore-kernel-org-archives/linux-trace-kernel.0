Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C12EC0A1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Feb 2026 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770808570; cv=none; b=iMQxmnwOOuF5PH16bFBvEGz453Qyd5j5RQQViQFn4HtwqXcokbdCKEKqiRoM7sB6jbiG5qz8fMQcZs6iUGtKyVe4MgDmSLKyjroxJ95K9QeEek5sK3F4ItwQl8nyzsIwR5WvRa6zFpXDfaaV+Z7fpCyawE1uR26avUQ+SWu6+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770808570; c=relaxed/simple;
	bh=jkBtG/j8ZN/4okd84k0jEU3hNy0M3wj/2JyT74HxgkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZGKI8f5Cz5vuyd8R47Sh/avapqVoVZvNUSqV4DTZACodP7r4HJas+HswAZ635df09LsTm4lp1M9OQiWb2FtPf3tUQQn/Fa3ZFDz1g5JEpO0vD/0xT7lWXeKcebkw/A1dLEWLe065B8fpxhu/VBGo347JOoxwP3Kj//TxQzybcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUfGaCtt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUfGaCtt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770808568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkBtG/j8ZN/4okd84k0jEU3hNy0M3wj/2JyT74HxgkE=;
	b=eUfGaCttYmhV7mnvTUpFcr7HjnLqPzKkI2VQGhkGwnoE6F1pjhocvzQqzi/SbDqx3Ok9nP
	lAgvXi/Ca4Bt32MDi50FZqv7efOIqGmg3o4DwUxt+F8psl3HbgIy5JHjrLEuWUuTZDie2z
	UIxzOHPIObitZwznTc8bJ2oOra+CNKA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-rZZOBgd0Olu1ene_zGXRAw-1; Wed, 11 Feb 2026 06:16:07 -0500
X-MC-Unique: rZZOBgd0Olu1ene_zGXRAw-1
X-Mimecast-MFC-AGG-ID: rZZOBgd0Olu1ene_zGXRAw_1770808566
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8db7f340b3so257964566b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Feb 2026 03:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770808566; x=1771413366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jkBtG/j8ZN/4okd84k0jEU3hNy0M3wj/2JyT74HxgkE=;
        b=n5SAYJZ9MB2zRoipijAqnT7+HVl5yOQr1xaWg9DHWozDrVWR1/rS3R+bBxWViMaSuW
         SwPkcKIEP6JR4oEwb2l+YGosMgIZMXUigj8bkzXUDs13Vjjj7Vgl5tuEemhE6A2TfBSi
         DL929vzxPQQyvXiDXenuFbXY9hEI3lfugRrYnGXVqnoaXlCUIGY6bhW9kBfIf0VgyFAV
         mroWrR+xIs1EeB6/PI78Vz4zKocIHQs5xHWyaGfUJ2DdsqVtqvf7XCEb7QO6DG5KHFIw
         bYyH0TJH5D6/bFWWU3xssmJDppdFGRqhHETGY2wAA2qF82L/sidR0MQeZh9hmrdZuMmS
         6WQw==
X-Forwarded-Encrypted: i=1; AJvYcCWraQrzR8URsQgs3vIQ4NxlK96k4IJI0P8Sb4h+Wm5uTprpMAMJG2tJYW13/oR1YU/MrAsef/ZX1R8rwZyyaCjiHeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzhQzEIEtgVSs24l+gEIZP7uxuXt6gXdSf5UzfzW/q2vJ2fVP7
	q9JF35/pgtFYwZ57yGBDlhsTammObkPPjRw/cElvhQvaAW9oWn+SahpPCz953dU6YDxq4yuBFxg
	zEk5QwQfwzjhKGmDmSyHehIf8ehxcN/uOXI7dkKURqwZSrexpa6RoUJxSDj3EzjGG2xpDKynHCL
	9jUk+Lrh41lLzezKGimdBzFSPU73/spI5z1HQnDR9aLxYVgb9u
X-Gm-Gg: AZuq6aJVAgbAnrog4+kwlC/TNrjcGMSYb9KsEQglvXxAEWDaRAnzTzv9Kbll+kSHPoq
	zrZ0wHtbboUNXFVfyCmqX9uhe+jQirt6A6NAvs7SGiA0nx5iJfdFWqWdYM7G4Q56joCSlJ2eUyP
	TzNcPZFi60gVbq25eQxh3AA2GFWVpAxhfN6VU6elDovLFtPZyaP+c4OF9QdLPxR42IyFFQwINvB
	RRR
X-Received: by 2002:a17:907:3c8e:b0:b8e:a126:66c2 with SMTP id a640c23a62f3a-b8edf38e6ecmr1063988466b.45.1770808565967;
        Wed, 11 Feb 2026 03:16:05 -0800 (PST)
X-Received: by 2002:a17:907:3c8e:b0:b8e:a126:66c2 with SMTP id
 a640c23a62f3a-b8edf38e6ecmr1063987166b.45.1770808565588; Wed, 11 Feb 2026
 03:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209092436.2899888-1-costa.shul@redhat.com>
 <20260209092436.2899888-2-costa.shul@redhat.com> <aYxhtrJ8cw7SNOJy@fedora>
In-Reply-To: <aYxhtrJ8cw7SNOJy@fedora>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 11 Feb 2026 12:15:54 +0100
X-Gm-Features: AZwV_QjrgosTOG9OQk2nFpenxiJARU16IxGo0YBJgtdrPcEO2NsfIFEDJSnp6AU
Message-ID: <CAP4=nvQp4J_PRbbNNxy6FErcgFF4Qmn3ty0N2HcDSQG5isLiKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tools/rtla: Consolidate nr_cpus usage across all tools
To: Wander Lairson Costa <wander@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Crystal Wood <crwood@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rSzuBeg9WerPLCryxnzxHOCamWsFNGbKdibiM49CW2Q_1770808566
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 11. 2. 2026 v 12:03 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> > `#pragma once` in timerlat_u.h is needed for pre-C23 compilers to avoid
> > redefinition errors.
>
> Isn't it necessary for C23 compilers?
>

C23 allowed struct redefinition [1] to enable template-like macros. As
a side effect, including timerlat_u.h twice does not break anything,
in C23 only. But the Linux kernel supports building with lower
standards of C, so it has to work there, too.

Tomas

[1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3003.pdf

