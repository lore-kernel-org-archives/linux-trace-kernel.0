Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7613121C184
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377463; cv=none; b=c9E4tu3ebtwyQ3N4Ds4Z2YbFQHAdY6GUONB7pbfB5i7bDj7tRk8xAu7vH+cEQWtuVBkPUAyY6JOPL1hElxjkOxwK/PojWdnmddFPIHexsTZ21sUoaujb7/sv5f6XhI3xbB1nPGhbufACSPsXva69Jlg1REpvp6YrlIfEIJ+tWAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377463; c=relaxed/simple;
	bh=PGYonKGyaMFSCfv/S5Qgyq0Ie5dVTihFme0wevOqbyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4XNdEjlFW04CA5sFT5G+OqkQmogKmt3wyfDUL+xPdPmj7piNgOt2zOs53MlnxflT9rh7wW5TpFwBQJfEJfdfpiCkAuWjXa02jFnNvEUZltkLh8JNS/y3A3kIPEadpggHTyHSI+CA3l1oBtkCE32nDNUDns7b8DFOh3jvC3FXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rs9mahRf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rs9mahRf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754377460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGYonKGyaMFSCfv/S5Qgyq0Ie5dVTihFme0wevOqbyo=;
	b=Rs9mahRflMIyhhWasKmqNofwe9iQ+9C7NMU+H2CW1MLHcvb+X9wnUEg8Ip+DIQQmQzHgJf
	LHLNuALKdzC7u0k7C8E+/tYfK7fnUdiSx22dxeahaxpH3ASMe3uRBQNC/J7SwnHg9VGYN4
	X3K1IYGQCsV46zSV/Y7MFFB2Y6cxWDc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-dOao5vo2M3WMwrwu5TMyaA-1; Tue, 05 Aug 2025 03:04:18 -0400
X-MC-Unique: dOao5vo2M3WMwrwu5TMyaA-1
X-Mimecast-MFC-AGG-ID: dOao5vo2M3WMwrwu5TMyaA_1754377458
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad56a52edc5so392244466b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Aug 2025 00:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754377457; x=1754982257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGYonKGyaMFSCfv/S5Qgyq0Ie5dVTihFme0wevOqbyo=;
        b=qOiHI5EjMLvUQ+WBqHZDTgnG3iEqRdEpUUhr8CRVoZxAlkbK7rVrAPiDspZY9E3diw
         n1b77Y6kJGn+s1uK9+3cQAiXw/3tS7jb6sw6KhuISf7GIgKMvPxPvvjyesUSIylEiJ+2
         G1U5V1vyAoW1A9Tn/sc+8QE0BLPjHq79GM4PGe1tOnOAUzOe9iKIsAn8+/6uRJHKmhTr
         fj7YF5mAObVX7KbrpF++RzZvTAkbVob/kHo9Z07TAZv/cZmB2u5lTFMwfYtOOj15NZzn
         2AMzXLGkXSnA9ij9Tlb+PHV/GVq3zRB7IZYOenZsASo0+WJqo4QMJn40kHyg/0RKSccq
         PZow==
X-Forwarded-Encrypted: i=1; AJvYcCXLrvkTn09S9KxXhlFldRZd95mFKpQGOHGnJp8XoRdqnESIBztG+oVdsgPn22Iys/tsMyuixva5E8rIIY846Ur+JnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rAd4wNsM5VqjjSqI8TnokuUQN4LlaJCrqVweXVcJqTajOOgj
	NBIp29VdPTZyH8g+3gLsuLolTxgLrjZC0KJgyVySMuwKYw5eVVCrMgUCdmcIMGBtUXRtVtpxP5Q
	bQcXgO8tvzXViSIx2qYlwA40ZyyB3qmh0go4Ha0j24OvNkryURk/IGGyLkKFzP1LiruPZWl/GiY
	RN2K2APEwMvZHK+bwz/lR6jmKfsH7MckxUM83dlu7ZU0R+AT/W
X-Gm-Gg: ASbGncshE+/nk+6U5MKT3KwPcn86EvckUoK7Y+AMTjr9cfUN+dx1F6iCmpvVc5nIGof
	3TRMFizSjJm6lIeWBwvLCPpQIJEOUCBimR2Loz2ElZBYN5sPOcE05rsz6UVUKeemb8wmDKJqtBJ
	OVUoUps1niWC/Zi73UmWv/v8ulxUvj1frXdIBp93OtGhCFJT5vmMhAZcA=
X-Received: by 2002:a17:907:3f2a:b0:ae3:8c9b:bd61 with SMTP id a640c23a62f3a-af93ffa2d63mr1238255466b.12.1754377457465;
        Tue, 05 Aug 2025 00:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMbyK9gScuElH5NpUEMJ41EUPRyaWEQ72uvHWKJnSabm/rqvUckY7aYInaqvU/TD5yzgsTDQ1Qxrs3ymnlCVE=
X-Received: by 2002:a17:907:3f2a:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-af93ffa2d63mr1238253166b.12.1754377457043; Tue, 05 Aug 2025
 00:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726072455.289445-1-costa.shul@redhat.com> <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
In-Reply-To: <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 5 Aug 2025 10:03:40 +0300
X-Gm-Features: Ac12FXzlcHTYAnu-YG9PepEFtGlUSJiRNcUXl9U2QsYIFClYRFSRgHj4wuksd2s
Message-ID: <CADDUTFzWBkrKx6=fOMXp=y5cyecOvWLx5jZG6m3BMTAvL067Wg@mail.gmail.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into shared structure
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: in_3b83jTNb6JnS566VGpkce5imKTC6eseNeAQNVeYI_1754377458
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Aug 2025 at 21:18, Crystal Wood <crwood@redhat.com> wrote:
> If you want, I could rebase that on this and use container_of() to for to=
ol-
> specific params... but then that adds complexity with the top and hist-
> specific params, most of which are common between timerlat and osnoise
> (and not merged by this patch).
I=E2=80=99d appreciate it if you could rebase your patchset on top of this =
one.
This patch is just the first; I=E2=80=99ve intentionally kept it minimal to
ease integration.
My goal is to refactor rtla and submit a series of follow-up patches
to reduce code duplication.

> So we might want to just keep it simple with one big struct.
This is a god object anti-pattern.

> new common.h if we want to keep the actual-osnoise-tracer stuff
> separate
I agree with the new common.h and separating things out.

-Costa

