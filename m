Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD52E1F05
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791934; cv=none; b=E0NNuz08ZYwAzxOy/CNZu6tn9S77++QwLkcKNWwPtN49/98Fnx2AimNW9QbU7A/k6QvB5+9/4KABhwAhh7vz0AOd+3MBtGmvWpZmkZFoHtNlGHs++C0nVlGzscwWeRs3vnwwpzHJXBxiMUSZp4qeVHucYIXmd+/5W3bfT9X/7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791934; c=relaxed/simple;
	bh=5/SnjsgkA/UaUZ3JC4oigWQ1yxAHzclLIHuSLceWJP4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lzY6rSMtqKRLjV0h89AZuUMgDl+4AIwlRMBCRFw67G/HpzfYKur6iYf41NFbFJOKIKe0ywo7UtUn3XGIbhSPxZGhhQV5rV3KBVYo2fhda4OUIiicO/X+UOx69iNXRQ1XATxXhevFis3AFMr1gsc95rrqJ8/++1AiRNy6woB69jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqh18Mtm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqh18Mtm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755791931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/SnjsgkA/UaUZ3JC4oigWQ1yxAHzclLIHuSLceWJP4=;
	b=cqh18Mtm3R3gGdYoEqJ7dmbfPn2b1JRS/v5OZ98ie1ddN22lI+7ujcdH4bmf122x8p1Tfj
	MTkCJld1iRGoa2VLP9jGq4OtXZ7jZ0bFxW5CUd3abH8rvZh957aiHwL+upAK04hQ7K/jjH
	OkWggCwPfDknK49ilEAtCVQL4PG1fKU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-I5jCegpIPKGf5gsXuObysA-1; Thu, 21 Aug 2025 11:58:50 -0400
X-MC-Unique: I5jCegpIPKGf5gsXuObysA-1
X-Mimecast-MFC-AGG-ID: I5jCegpIPKGf5gsXuObysA_1755791929
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61a2c951211so1224742a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791929; x=1756396729;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/SnjsgkA/UaUZ3JC4oigWQ1yxAHzclLIHuSLceWJP4=;
        b=aq/0vNcZWIb6u+j90WrSuiAjHlqXKFs7+Ie4/CzELNlNuO2tp0tuS2jNJYG7KuHm+L
         wKDWJ+pUeJWYymFQtaJzCwiKcBIB6+ZuhvG8fn+q8nWGGlu4f/aHz4QvSzragUAm8Aj0
         ipeF6rKjDAlzDxzpRTplLUEH64Ke0fXrPHUGX7aCG0+VmFKzyl6y4o6ZXnr3L4PI28GL
         IJnd5afkbi4NH35JmabeF+XeAJmwB1Gl95uohuci21D6bvcvb0XTKgk4incxwcvC0AdM
         Pg7tp+P5g4EdS5lazWfmOJsPOsWRefqBw1vh3QJ7bIc737Ob7kNLEU5vq7PqIH5xobtW
         Wcgw==
X-Forwarded-Encrypted: i=1; AJvYcCXhzX6VGzHwBMDZx+ehD/L9CONzJD4Or9UNcBYE+lxLYj1wIVtY0/tUDNUpBQtDzYYyzWkhstqjhXEkL++CIh0j6zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBnPWD6qoU+J3WluaxfBQoIbifdijBuH6DyNJWf/KggAo0WoRn
	k1AZwq9pngqoLxz30r269anuGcsF+OQscE9BKJfwR7ZiSqu+nxU5dHbYpf8hWLW1Yc9YRIdAGsP
	0CmCjZx3gPW8tPKCNfWsIzTTmdFL4f1X/LnPv8HtyJ6jCP7x6QTqwwGP9/eO/EXrVoh75iSnqHw
	==
X-Gm-Gg: ASbGnctsMvlmBfzt8U09BdAa3vZ1Yor/uBcuEzLofc7j55Cnekp59WtirtRiGXp+usZ
	8gO53OzyMO3eTZaErPu36xhHGmECAzLTba1qINhU6sMqB+q28tttfaF/lW256Ojk43ixCXHr9LR
	sia8TmxV6480yzoGYf90bdiceC/X2Lhh7iq8SyzBAca3bKBdTgRiSu9zQLwvImB0gc8CSsajY8t
	86TTSmqFYA1GnlE7WAebcXaSHGIlo5KwxK9RY29sgQXTS+yO1RVWJbuBpW0ujFwWGZrWEA67cHl
	bkmVhbedCxebwGYU4CKFK+HKJYE/I9Jslc2b7A==
X-Received: by 2002:a05:6402:27c7:b0:617:eb8d:283b with SMTP id 4fb4d7f45d1cf-61bf87358b6mr2481416a12.26.1755791929355;
        Thu, 21 Aug 2025 08:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp+TbWBjRz/vgVIUh4CpqYS7mcK0j2z1ICJqJZjorEFJDVQ4M9TuP25ILrNA9TDvFL68e5cQ==
X-Received: by 2002:a05:6402:27c7:b0:617:eb8d:283b with SMTP id 4fb4d7f45d1cf-61bf87358b6mr2481403a12.26.1755791928945;
        Thu, 21 Aug 2025 08:58:48 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.134.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c1851ee65sm1045a12.13.2025.08.21.08.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 08:58:48 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:58:45 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Message-ID: <a3a7da4d-abec-4318-b326-39d55eb9bc30@redhat.com>
In-Reply-To: <20250821151520.nc0hALIW@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com> <20250814150809.140739-10-gmonaco@redhat.com> <20250821122210.B9iAsUFG@linutronix.de> <a87d09f61a873778fe9f737ea4ab7c62dc43e950.camel@redhat.com> <20250821151520.nc0hALIW@linutronix.de>
Subject: Re: [RFC PATCH 09/17] verification/rvgen: Allow spaces in and
 events strings
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Correlation-ID: <a3a7da4d-abec-4318-b326-39d55eb9bc30@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ruK1cjh4aYeE0OYIPMzO3ZAGnrLNBBPPAkix3nPZ-ZA_1755791929
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2025-08-21T15:15:36Z Nam Cao <namcao@linutronix.de>:
> We could also rewrite the parser using ply with a well-defined grammar an=
d
> tokenizer, like how the LTL parser is implemented. Doing it this way woul=
d
> be easier to validate as well, because the grammar would be mostly
> copy-pasted from the specification.

Good idea, I can look into that and see how hard it's going to be (I'm not =
familiar with ply, but I see it's well documented).

>> Do you have specific examples of what doesn't work?
>
> Two things that I can remember:
>
> =C2=A0 - breaking long lines
>
> =C2=A0 - C-style and C++-style comments
>

Yeah those could break some assumptions (and they shouldn't), especially th=
e line breaks.. And supporting it in the current parser may make it just ug=
lier..

Thanks,
Gabriele

