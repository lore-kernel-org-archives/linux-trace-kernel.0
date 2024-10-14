Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE61154BE2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896275; cv=none; b=kqAJtKTErm7gxo2QgXIUMTaebUpyuA4rsWdxb/tgyBOhtqe3B1dKP+huMBe/fi8tcIoC9YLDWmJEZJEtCwE2FXkODYXeML2SigKKGqGguyTzEN1Slplv7BOedgr+khkS22GvhAgyzzO622ZBLcryPPgXK53gvMJ637dY19STPS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896275; c=relaxed/simple;
	bh=oIiQmayO/M0rscDY2JPYBUNFS9Gh1tN1sxn9bgN2BLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGw74+JGvbFoHNF9qEjssB32MFnlX/vAPJ7ECS4lazSBrgPveFN7IASrgDw4ylp5sOIrMggpCnwZRzNJr8A820LF85FV+ijWsiq8rLr9cI1kVERrKh7+W/yOtdEDwWJbR53fDJEyHoZ2wgaCbzkZrKxnjacKPhmhxWYRcTSTIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvSDwrOq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvSDwrOq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728896273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIiQmayO/M0rscDY2JPYBUNFS9Gh1tN1sxn9bgN2BLU=;
	b=RvSDwrOq0FQ+hKfkmFxUCuogTIZGudPIA5R+lruC6stfviqVI9NGW+IHrAcD5frFH7tOpM
	ASwFBmyM2bdIrOoOkKW4bhTtwMDc0lwIqY6ov/rwhWnJF0QcnPYzyfevLQVWnOzM8TXsh4
	CAf1gPfRdwq6sUJQFIE46savUNHI6VA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-QJHekHEuNqaBgs-QhsrRWw-1; Mon, 14 Oct 2024 04:57:50 -0400
X-MC-Unique: QJHekHEuNqaBgs-QhsrRWw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a004bfc1cso78892366b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896269; x=1729501069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIiQmayO/M0rscDY2JPYBUNFS9Gh1tN1sxn9bgN2BLU=;
        b=LbMBZgY8FOWRUjEE5Qt1AOiq1TSzML2nUDHCPFAUvfko2Z5X4h0sdAEC8QGzQWehxp
         P53O0suGWaFtEL73kgXJZrDDjVdlWQVuksWCT3ecoVavX227yQUGesSi08y+1sS6wZ/X
         Es4JsfG99svcRerDJmdZAVZsNNyzNg7975Txuc0DLVLdEfJyGRcTrc27fFe97PljhpWO
         nzzBKUjIQfLNfkNRR0DIEa6Dv0IumVgu07AfkEzFM7bjPPJW3rlC5IsqtnYlz5jkGmFj
         uOPv4ioeQOmuZ3nt19ZykoIWaGKnhDJRzKVUTw6+Kisk+p5VFYpFacfkQccFGYAs70Oa
         cp4g==
X-Gm-Message-State: AOJu0YxydbGWdfEa9dmztUPhToCSrTKsoLnStgffOKJhW7XPdlzW2FGT
	RBvRreXrEYUmuMz3rI9MBOaZx5Nv0fl+eFReByJ60ZdtnemwzK8emuFGW7+WN7yZHirYFfJP+qG
	vBvQ5vMFupymeMyROwM29S1TvSa4DCLXWejYuXgfAoNNpS/Je6X91ZdLj0aZiK9SFbIYxuDsFIf
	/l1jMBt4yzdC5AUfkg4QDfiLkL+IGVnkF8iumtv4NJ7fSU
X-Received: by 2002:a17:907:2ce6:b0:a99:ff70:3abd with SMTP id a640c23a62f3a-a99ff703c38mr334453666b.31.1728896269118;
        Mon, 14 Oct 2024 01:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPAQSthAxdUlKLMrCSRaNSm0eV4krUcbONfq7qXqZ01cmONSYTgFBnYa5QptEtUa4rzWI36TnTtiDiMv2dcHE=
X-Received: by 2002:a17:907:2ce6:b0:a99:ff70:3abd with SMTP id
 a640c23a62f3a-a99ff703c38mr334451966b.31.1728896268776; Mon, 14 Oct 2024
 01:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011121015.2868751-1-tglozar@redhat.com> <20241011132356.28c48902@gandalf.local.home>
In-Reply-To: <20241011132356.28c48902@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 14 Oct 2024 10:57:38 +0200
Message-ID: <CAP4=nvR+RML-=owASqjqQvhn1ernCP5QtREcPU=FLiOZ5G-RBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtla/timerlat: Make timerlat_top_cpu->*_count
 unsigned long long
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com, lgoncalv@redhat.com, Attila Fazekas <afazekas@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 11. 10. 2024 v 19:23 odes=C3=ADlatel Steven Rostedt <rostedt@goodmi=
s.org> napsal:
>
> Thanks, I'm applying these, but could you or someone else create a test
> directory in rtla and even rv that tests this code. I just examine it and
> run some basic operations, but I have no idea if it is really working or =
not.
>
> Having a utest directory or something would be really beneficial. That wa=
y,
> I can at least run that test before I push it up to my tree.
>

Yeah, we definitely need that, ideally to test expected behavior for
each common set of command line options. That would prevent unexpected
changes, like the recent defaulting to userspace threads requiring -k
to be used together with -U, otherwise, -U has no effect (because -u
is added by default). I'll look into that.

Tomas

