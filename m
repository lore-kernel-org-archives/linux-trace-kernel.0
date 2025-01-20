Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065A21DF996
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jan 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375280; cv=none; b=S7gN6zqOd4knrUiqX9jmo0SjLT50FnzWGQ6Lkj1FR/TMyxX1pjPocKo4UDyCBrRSiJPEJRqhblcG6lijj+zcXY/SK4WbrfGn9gAvLJrjIvU2Qbj3P3cR5rUWIfZ+QeCll8OhX36wODg0bVJrkTU1gUNoEEtsFdRf6ern9q/gfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375280; c=relaxed/simple;
	bh=oBaJqwEucv75azJYIBargREP9bboBki1+wuF4YGKVTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iP3rBam2KzJdeXgpPcLQDDu3IMVHzyK5pP7pTq4I35VYp9f0fbaXu7X6E4gm317IzKcmtQ49NPRTg5zPQO3uE2urLuJKBMjMHC6MnCmgzUJ+RXBy15dy/GUUlWkhMcvhPX3K21+sZ9HNIMaxkuQ1t4LWLqRGB+SuZHvjYzh29kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5m0cCUF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5m0cCUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737375277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBaJqwEucv75azJYIBargREP9bboBki1+wuF4YGKVTw=;
	b=V5m0cCUFrLyQbM3UdRtSFEz1S8UI40epRFc7SFkekaB1UFN8jPD4xKKUuX0BYcF6GlzR8O
	3i1chFKMmmHNR3oLgbUVNmDdRDlwjoI1m9jBBsve6J/EEawiEo4ljdCRQik9C+Pj51IZFS
	9CrT1cPXZwHRPs9BIMGsWxWW4FSI+As=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-LSXIta4_PIiltN1n-x3pjA-1; Mon, 20 Jan 2025 07:14:36 -0500
X-MC-Unique: LSXIta4_PIiltN1n-x3pjA-1
X-Mimecast-MFC-AGG-ID: LSXIta4_PIiltN1n-x3pjA
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aafba50f3a6so351710166b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jan 2025 04:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737375275; x=1737980075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBaJqwEucv75azJYIBargREP9bboBki1+wuF4YGKVTw=;
        b=KR4A4Om4bhurj5tqxGrfI6DOfjgZtXMhJ7eWMZQPP1sFq/8d3Hr1qF+nGQaECz9Y0Y
         sY78Z1uABmh8FP1fEg+csvPP3zx1fnIeiwjbuLT/N414RE3IRLz3ponYIAiTUhYFZaS6
         R59m2q3bhuv7Wr/irX/+iiTawUcHUuQFmeQJ/n9A1piQU8n5d4pUgY0L15knvyb6s3Xu
         R7/y+yFmu7xqa0+845dRynsZKBTh6WsDQWybwakw85D9hQQ+H5KCSv0mATfe42ihC890
         np3MUSzYEgNkXYX52nyMbCnkCLw4oDn6a1QCZEIQf/BPAbJy5yWcqH2UMMWtvCJF//Bl
         l3AQ==
X-Gm-Message-State: AOJu0YxsM73P+XgDF+aIn0aq5QaN10Mw8uLXQ5Op4NVVtqNz0X9WE9mD
	LQxKuHnHwZOlwrjc+Q8IXVdNc8qllT+wDqfvgp3L+18gqzmpGOwROZRZu2OuFODrY0DKE41w8wO
	43/H2GlTVsOBq2rWrolpXCiWEdoz3NbD2z22ovW8vYAaiiPWACFUhbihRoLTLBCw/4JhKqIN9AE
	bAkr4i9Q14V6lCLSqiKDFkKqmeH9IGD8hGHBVivOhf7W6F
X-Gm-Gg: ASbGncsfrj3IzxBybOcQZYYeM/sh+zTBdSsRL9oGtM4WHPtUpXmUC1HvpiA3sDzMlog
	uuK9cBZZditZB8xmVPNdqvdtrrSlxpe8CDZYPoEFJ+ApmTX+8fXNTLaNfGAN9lr+CCFWcvFvg8/
	SxfhNHwh0=
X-Received: by 2002:a17:907:1c93:b0:ab6:3173:fd2e with SMTP id a640c23a62f3a-ab63173fdb4mr67668566b.44.1737375275500;
        Mon, 20 Jan 2025 04:14:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF32m1zsZM6IkAChM98QzBL4lfIP3LVrwTHKuyq0N8aZiO6ppp9rEKLR4KPwzkIEX75sDL70+aVhvvugbKz5M=
X-Received: by 2002:a17:907:1c93:b0:ab6:3173:fd2e with SMTP id
 a640c23a62f3a-ab63173fdb4mr67666866b.44.1737375275192; Mon, 20 Jan 2025
 04:14:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109133852.360122-1-tglozar@redhat.com> <20250116201808.3c8721c1@gandalf.local.home>
 <CAP4=nvRm8Sp4n0J1oWS6D-KbzQ-KeE4eW1cw9CZ8mU-Woi78+g@mail.gmail.com>
 <20250117160254.4a366149@gandalf.local.home> <CAP4=nvR4an1nzBvPyYv3YBY0Cu=fNwTkEN0_q63JxNAi6799mg@mail.gmail.com>
In-Reply-To: <CAP4=nvR4an1nzBvPyYv3YBY0Cu=fNwTkEN0_q63JxNAi6799mg@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 20 Jan 2025 13:14:23 +0100
X-Gm-Features: AbW1kvaMvKfk-1IbBURLIs_k8IirkuKrYf51cWAd1aW3Wx01Mk4UlzN1r4WM3V4
Message-ID: <CAP4=nvSmApcoPisThQPXXFPMsdNcvLe8oTcXrB=56XWUuGnYsA@mail.gmail.com>
Subject: Re: [PATCH] tools/rtla: Add basic test suite
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Chang Yin <cyin@redhat.com>, 
	Qiao Zhao <qzhao@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tZf1Dd1_funEkwkh2FYH6QBbi5k9xP3Al2kQVjJUcyk_1737375275
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 20. 1. 2025 v 8:38 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com> nap=
sal:
> It's likely that you have NO_OSNOISE_WORKLOAD set. The default value
> is OSNOISE_WORKLOAD; rtla relies on it not being set, and rtla
> timerlat -u resets it to the original value after it ends, so usually,
> everything works. But it breaks either when you set
> NO_OSNOISE_WORKLOAD manually or when rtla timerlat -u crashes (and
> fails to set it back).
>

I just realized that the tests are not running rtla timerlat with -k
and upstream, it has been defaulting to user threads for a long time,
so that's probably not it.

