Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9326561E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Dec 2025 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766991656; cv=none; b=bbfpfx11gTsooJGXpsz1qWpSbiVi4ArcCYkx0bHgrc9MbUE3aJpEVdorNUJlYQFCPcgVUrb8skvXuthM/T5IWLjDSXFpf3TxevtPAI2/PogLhviXQemQcl5rDFQk0fwiW3uqjex2SKLKTYEjAjg94aijTuFH5GoHbWCW+FGPeNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766991656; c=relaxed/simple;
	bh=t8OcG2twO/nrzWxVIrhkWMvBJQ/Zx/Os/S+s48QKCNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O43kuTnd3Hs47gyc3/J+/HIte8Ca7h9fuTf/m8Ac8xurt1bqgi0Sm2ZQ601Gj9dSzfa23FpkcJUmUoeTBNKmNza4qKCj66CvJiuUUlxVr8HIusoNHEDnHX0eY/sexK7DVv39Q/Qw4wD6vFBCLUP+nDMes6n5RrEiClqJBYYH9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8MBgbym; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8MBgbym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766991654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t8OcG2twO/nrzWxVIrhkWMvBJQ/Zx/Os/S+s48QKCNc=;
	b=R8MBgbymyCFXxYpFjri6djiOeQk9ieexe2NQMsky3o6sE2VXe0r4EfEJ74QFYS0aeviloW
	kihnJnkV4HqM1mh6SLDhbhoX7MYkNSqsyNEHwooPRGH1RbGjMa2Xo8AEBdwktpJIu1J7qY
	k1qF7bwZ41hvul23+HPcDFXzOwZvHBE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-HRyf4ugRM826fespeV1qJg-1; Mon, 29 Dec 2025 02:00:52 -0500
X-MC-Unique: HRyf4ugRM826fespeV1qJg-1
X-Mimecast-MFC-AGG-ID: HRyf4ugRM826fespeV1qJg_1766991647
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so39911875e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Dec 2025 23:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766991647; x=1767596447;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8OcG2twO/nrzWxVIrhkWMvBJQ/Zx/Os/S+s48QKCNc=;
        b=MAAIYcAqAlzFf30Fq7pn5KsWyCqSEBITlfMvI85SNidwN76thknL8YcwndFOwiMbC5
         FXEYunk+qmVRpo9bx4sT71Ug+5vj5DqoRonPIsPJ7mcER9R54Z4p7USjDp9bHbtNCW/J
         jW9yAmwiD2GxK1eRjBRc5bYg+OHmHAMF0fgOriBKfefVFW/nz0yvMScmhM3MoNAmJvSK
         v2PAdm6vHqnFsjOQYIwEH50YNi4EHvdDa1M7zXYOfQGO6tm1xkdIwJT+MRVpoOeIwsJv
         mM7TpcaBH9JpjGmEPAb+sR9+nfXfQyJR57wMJQ4W4lwUFSJmWGzKxaYrCj7BjVe4OVlm
         0INA==
X-Forwarded-Encrypted: i=1; AJvYcCUGWvhZNnobZNQ0HoRsoG6czA/+iylA9IUjPljG1z5US+Xo/Idmlb401LnIrnj004hssx7+2tEOlzdtlTLi6Vdbzek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6XKPS3mpiiA+p2CpVddX/K33QAQLlBb+V9QJFwQLWMDgC/9O
	TV9u85stZOn0oOxVPMg+NeVaVK8Hnx44KINksWGsR/HBBHPgqMYEZKWdXSdEVRAAQyqCh+SofEF
	b4WhB4BssIMGt1sNWHfHGNPxCpFkeTjz6SKe+sb1SgXtLKWMHMRK0KVadqOa1Xw7qM/8e30bdJw
	==
X-Gm-Gg: AY/fxX6Kex2/p1k0wGIvqmrxVJPIQzxpUkSfyHXE2goUMKyTmxUrFS+fThnG5w4fdHI
	T70lCq0l4j1BeYDkN6CcEwFGmx9I631hiQA640ZFiqf6cgzBChDqDewvwHcsf+/iMaFCOHCfkqM
	iryXUGgnJonC2JMt82vZX7CwsJkI+epW4SmxY2ImPMEGouLjy1+qv32a35UVArtbe9j8Gp+wKRx
	noQt9VozptJpGB3vfZgbH1zhrgkRmMvJX82PFOw1OOUCo1R5CDj8qP77MCBxLIXlaT5AKgr5klz
	DLypyVNofqHBWSmUKLdn+Td4Pa4ADnlzU4pUPzGIhFXi3k9qx+1Uae3IF1sf6qGV5glqRy7hYb0
	ZIl11HgOdDHFHfrB9nYunbQH2x7eOiEYwtzjeWGNDJ+BgN9uwG1vkf9uzDlkT6PzqmYZ4orL+n4
	y1Gy1g5kJi
X-Received: by 2002:a05:600c:1d1d:b0:477:abea:9023 with SMTP id 5b1f17b1804b1-47d19577fb8mr332907655e9.9.1766991647284;
        Sun, 28 Dec 2025 23:00:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmFC/mzoVHhr44ireW2o9YalzKlM0MsJyH2BzxwmYl5AR9TFxemVezBupGB3gx7MCpUqcDFQ==
X-Received: by 2002:a05:600c:1d1d:b0:477:abea:9023 with SMTP id 5b1f17b1804b1-47d19577fb8mr332907295e9.9.1766991646898;
        Sun, 28 Dec 2025 23:00:46 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3af6dbdsm232499725e9.19.2025.12.28.23.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 23:00:46 -0800 (PST)
Message-ID: <765e80ba6895985aadafc5c1bfe8a361575252f2.camel@redhat.com>
Subject: Re: [PATCH v3 12/13] rv: Add deadline monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 29 Dec 2025 08:00:44 +0100
In-Reply-To: <87y0mr9vaw.fsf@yellow.woof>
References: <20251205131621.135513-1-gmonaco@redhat.com>
	 <20251205131621.135513-13-gmonaco@redhat.com> <874ipfbay7.fsf@yellow.woof>
	 <87y0mr9vaw.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BNN9UQkHCyRYz7G2ybfLlJ833AepqVYQW6q-Atryq1c_1766991647
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-25 at 08:58 +0700, Nam Cao wrote:
> Nam Cao <namcao@linutronix.de> writes:
> > There are some helper functions that I am a bit uncomfortable with
> > (e.g. pi_of, is_dl_boosted, dl_is_implicit, ...) because they are
> > relying on implementation details of deadline scheduler which can be
> > changed. So ideally this patch should have an Ack from the scheduler pe=
ople.

Thanks for the review!
I'm going to ping scheduler guys some time after the holidays.

> Think about this again, perhaps we should move all these helpers to
> include/linux/sched/deadline.h instead? The scheduler people must be
> aware of these functions, and maintain them. I don't want a situation
> where the scheduler people make changes, and something else (which they
> do not know exist) breaks.

That's a fair point, I just copied those functions from kernel/sched/deadli=
ne.c
but that's dirty indeed.
Going to try exporting them to deadline.h and see if no one complains.

> Ideally, non-scheduler code should not look at private fields of
> scheduler's structs.

Yeah, one may argue those modules shouldn't be doing what they're doing wit=
h the
deadline entities. To be fair those modules are quite dependant on the data
structure implementation, but the alternative would be to maintain a set of
getter functions which might as well break.
Or at least I don't see a better way.

Thanks,
Gabriele

