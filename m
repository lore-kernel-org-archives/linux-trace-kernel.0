Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95633FE3C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058522; cv=none; b=mt/oRTZQMfb+PNh3Dr8iqWh9fWL1GaBUJhBsYcI/SZWSeBZcGJNZ+XyDxj9Yub/uMU4Xp2x3f9cbSrpyHLYjA9V0L2c+Il9ltFpmud2yHHops9dtUgx8jnV0i1QCuYfR2/Q8u3oBSHljCwjfjnDKidJqZBtUeJroXPNfQ7QX2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058522; c=relaxed/simple;
	bh=s4TtaTJObWg6v2NnNlDOilsD8aDDDmFj9Vyxed3bMVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lF8rQgLC3xS8uL95zBWaYpb1mb/xhCxUteA8p2c1l2MPOZ+jNh8MBEOXNw9cOBZlWdWI7U3gBn7O/kLTm22sbhoK/UgZRoSIw26yEZxMwtQt+veYjS6X4Qlan3q1RkH+UEnF1zp6ki7GjevJzwZHZWGvyD3NIfBwR3Kz2Qx9hSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K01kwPJQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K01kwPJQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4TtaTJObWg6v2NnNlDOilsD8aDDDmFj9Vyxed3bMVg=;
	b=K01kwPJQc+le/mY8nobAHV5beh3HvQlUr3CSUqeZrQnIWpI7Vz7hSScEsgH9JgXMFt2XZk
	qV7FcyfnZR+0pkWSfFlTCLCrRt9SHtmg8LDZw8oQ+t+zESTByROfB2CFP6XMT2ffYtfoeK
	zbOpTQ9MraUJb8G7+uhW8nMUdgwJw7s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-rvrH9imJMGK7FqyAOdfymw-1; Tue, 21 Oct 2025 10:55:10 -0400
X-MC-Unique: rvrH9imJMGK7FqyAOdfymw-1
X-Mimecast-MFC-AGG-ID: rvrH9imJMGK7FqyAOdfymw_1761058509
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b3cb0f2b217so747615766b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058509; x=1761663309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4TtaTJObWg6v2NnNlDOilsD8aDDDmFj9Vyxed3bMVg=;
        b=xQm9naIWMv+PN0vrRq86QlX2rnrXBm02UuorTTZu2vEi7NNnM1i8tHlpjiG0GtLFlJ
         svCf2lzylhavI4EjZjtydXEIaXHbolfqRdny8r2QSO5ck9zGR4JIvere0jM/xzt0rpSy
         EXdc9i3Ugqm3LvaLKs6BRAhWyuc7Znc5L2+BOIioCU8xK5SbP1j2wqn5qYT/to5iJ1VZ
         ZZxafLzaFmuoOmOINrfGgUSYNGe9HeKvU59P8mp/0xlTeClKJrIbrqlTbSd8ywSPx7lK
         N35jtwrF6EmEfIw9sPSq6CS16sUkuq41Gx2j7t4Ych+WPKulZl31rU1v2981J0I9cyOi
         MhNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+mM3ribhQxbiq0TIkiMvPM6C8Y8ZLuhM1HJWl1gelgqHNDZzvhcgtXJqYnWpc+DlHWPnObbZnrUWgg3E3yB4YaAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI82hrRtlDDYIBjvRJFqiJXsmDznAViQbTr9pp95ugehaHlQx5
	ywqML73bHlYGEYJggzfxpI5OXs1eNGezzZ0JtSw/LnZEhR4T5jfKMcRtTR4beHQh92Z3VY90Oxf
	Mi/Gx3T67RBN3SszpmNMPUJ0fE1XY90xTNdI0bO5O/eI6I02FSvVsoeNjvMp3DjKJKHGQUdqM60
	hulqf0NWtL/lgH9DfwsJk9cz7VPO3bioshT/vhOOIWejTJnPI8
X-Gm-Gg: ASbGnctLMHQACY6yk7Lda0iERRK1JKezorUfEBBF7r7HobkpD+Pl378LxjY/FQW8pHg
	1R7zbKzc3gaSjyCVTaXqtojXsbzj/0fG61FqV2mZc9UqBrBVp2cjBUSvnfcO8/pUcTOfl6z/SK3
	BTUM2eoQtjiRck9B3aS2UVtIVrfkYVLBnMJkkajmHC7+nlWRklTwS0tg==
X-Received: by 2002:a17:906:c145:b0:b57:78fa:db48 with SMTP id a640c23a62f3a-b6474f185a3mr2004348066b.51.1761058509048;
        Tue, 21 Oct 2025 07:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEneTZGyCeocsHDx/X60tO2qfCq18ai/V5BM3x9iJuhQM7iS2gxGsIzRT59aOph6KtUQDfrMxvnJbr+Tvd9Qds=
X-Received: by 2002:a17:906:c145:b0:b57:78fa:db48 with SMTP id
 a640c23a62f3a-b6474f185a3mr2004345366b.51.1761058508702; Tue, 21 Oct 2025
 07:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017144650.663238-1-tglozar@redhat.com> <20251017144650.663238-4-tglozar@redhat.com>
 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
In-Reply-To: <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 21 Oct 2025 16:54:57 +0200
X-Gm-Features: AS18NWAt4omziUwJi5neVONqyuvXqoNnsk6zlx8UZex_lIgKReoEJhYe9U30Le4
Message-ID: <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d7S6dZvusarHafWdBykRf28wGWjnZdg_RdXHvI_tV-Y_1761058509
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 20. 10. 2025 v 19:53 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> na=
psal:
>
> We should have the makefile build this, and add a test that uses it.
>

I agree. I tried to use the example, but it would be also good to
check if the BPF program was actually executed.

That is hard to do reliably for the current example, as it writes into
the global tracefs instance, which might conflict with another user of
the same instance. I will write another BPF program that will create a
map instead, and a script that will check the map value via
--on-threshold in the test.

Tomas

