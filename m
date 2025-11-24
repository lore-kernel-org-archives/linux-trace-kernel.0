Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9C277CB8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Nov 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984847; cv=none; b=qsFgBfztsGzNBT7DXX0Lf05zpIuir1zZHn1JFn+zkAOa6xfA/nE995Wc3tqA4tq8IDozOUnqUIPK0MjSbHlbxytofa6cHqE8/8O6YR3eTcVNu8AcjEfFa7iJX6shWkKIBr+aNK/4+ON1ZM7DWbjMLGpbQutSFGjhiN3Wbfie6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984847; c=relaxed/simple;
	bh=XbgeaJufvZOCu71c/hyXkBnKNAO3Zd+UU2KPV8r0AOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYGvUxWCp+2VScm1lCsbw70eQwNbJFqgT2oRiZMbhSA678gfXCgxdHm/JcrONQMgLBPDIgbXmwkl2bDGJtcLmjGE9cIp3lnbq/+F7TVmpe3ln3JgVjpls4ZTDLZQp0B2/HyhAL9LhQ2QBCk0Lmh6/2OLbP5pPngvdGLa5Wn2Zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INdACTxC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INdACTxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763984844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RulUO8h7N74qOPzxYJePWepmD8It7qYUJSmDj8b6sWk=;
	b=INdACTxC/wJpbEUjXYwaoX2q4DmQyoI085MP7Bewmum5pNyn95HUE2CUeQzMW1Wc0KxDq7
	JYWoqYYpRxIIKS8eP2BPAQBzwQmL8gTF664HM/L+GmLiiSRHGpQONIqu4ai5oHaHGo/2wG
	s8nHdqFHzx3st3mdwHcuS8b6NNK6c2Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-gf3ml973M5O3wc71UCiCkg-1; Mon, 24 Nov 2025 06:47:21 -0500
X-MC-Unique: gf3ml973M5O3wc71UCiCkg-1
X-Mimecast-MFC-AGG-ID: gf3ml973M5O3wc71UCiCkg_1763984840
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b739f418149so250017866b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Nov 2025 03:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763984840; x=1764589640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RulUO8h7N74qOPzxYJePWepmD8It7qYUJSmDj8b6sWk=;
        b=XfG+Jfe/k+ip6wJ9UwhPOqgd229aOasm+b0FEpPm5XbPtyrGCjhL+xFrYsS+Qxezje
         upYRUVs5VmLCD3fT2ugTp1KM8CZGj10rXsnTVuGqqQf6JUKeEGQJ8tDNlanXpRY5CB9F
         lCJD9lfS7GOXuLetbmCqjp8pgERI+So/wtnD9kXlWHu8wXWNSXl8EgTlvOvBSQ6Sc2+r
         YmLVd14vrpMuy6HICZIcmznWeuBPISAA1oM3SwbX13oyfMvD8jk9mQtxUL/UGZGNepvc
         VppYvRYLygzTY50jMTbtaAFq9nB5Drb4ryD6f7YL1WhspFgAxzACot5JAM2jR+1HcFvO
         UEQw==
X-Forwarded-Encrypted: i=1; AJvYcCXL6EQIMINItOHXyCu09LsPPDBs3FiReFMiQUEU/sG8bLDEMAhWZi+yrDym1iMMSgiFxN5f5MmzWyMiHbDSCIN5Fr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ImNkGn2OpMszlH++CBxmmFYFTa/GTkMgFEbiMpfi0G+Ow0J4
	EfjVT+VM3A7nRmSRMXpD5e83AfGOj9g+6JqXnWdcieBY+Jm438q9KemHHr8dLh+ClVdqmzfDPH8
	vMNWEX/rskzDi6gVEgrmiOcj2oYPG4Gj9X2uIwaoa0YG9PQt9zBZMO314hrwlD607Vgsicy5rF1
	56HKlgn2NXZyv5idUrdNx/5eQXhtV7XxwBWRFI5uBXc75mJozn
X-Gm-Gg: ASbGncuDVTM2pbU1EiZyepyfMR6fmyqjxw9nBjAaDNGGKPNqF+G1tdAwlBBMOHx4nuv
	8wC1FsjgECuM8I/JXNgQi7bnJW1w5yAi7ea3b6YXj0IUxo5e+CTDpBWXyhBiVo85VQgaA/0U5FA
	Tn0QqgjATOVJp+9Q3O5hWt+MC73vmctxq4VCctGv2NPAwQQYuI2+8JtpgnvNAGzzaU7nlMZhcOA
	udz3vgiEGigNlOwmj4OTReR
X-Received: by 2002:a17:906:c156:b0:b73:9152:606b with SMTP id a640c23a62f3a-b7671547f58mr1196128866b.21.1763984840270;
        Mon, 24 Nov 2025 03:47:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHiLfAdTehBze6NzVIWf500bAeJ/deTryFeofN7SvSOicorzCxeXAWkw6XfrkbdCYFBiNtZa+zuqcEZzByOgk=
X-Received: by 2002:a17:906:c156:b0:b73:9152:606b with SMTP id
 a640c23a62f3a-b7671547f58mr1196125466b.21.1763984839859; Mon, 24 Nov 2025
 03:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002123553.389467-1-costa.shul@redhat.com>
In-Reply-To: <20251002123553.389467-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 24 Nov 2025 12:47:08 +0100
X-Gm-Features: AWmQ_bnTwtFjAXd0JTQkPon9OlB2gQl1jBr7_gdCQCudU_HEXe52xFWTjTI9RFk
Message-ID: <CAP4=nvShNb_+f-J6c1hpQgxN=pa0DhoW2QwZf8EFyinAMKXegg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] tools/rtla: Add for_each_monitored_cpu() helper
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 95dDIJrEqhdJGXISTzeiuOQ9OiQb1CLKXQ63o9wVOUc_1763984840
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 2. 10. 2025 v 14:36 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
> +#define for_each_monitored_cpu(cpu, nr_cpus, common) \
> +       for (cpu =3D 0; cpu < nr_cpus; cpu++) \
> +               if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitore=
d_cpus))
> +

There is one case where this form of macro is not ideal. Consider this code=
:

if (something)
    for_each_monitored_cpu(i, nr_cpus, &params->common) {
        do_something()
    }
else
    something_else();

Here, since the macro includes an "if" statement, it will eat the else
block (see [1]), and something_else() will be executed for all
non-monitored CPUs (which might be zero times, or many times, instead
of just once, as one would expect). This would not happen for the
other for_each_* macros used in the Linux kernel, since they do not
include an if.

This can be fixed by moving the if to a function called from inside
the for loop:

static inline int next_monitored_cpu(int cpu, int nr_cpus, struct
common_params *common)
{
   for (cpu +=3D 1; cpu < nr_cpus; cpu++)
       if (!common->cpus || CPU_ISSET(cpu, &common->monitored_cpus))
           break;
   return cpu;
}

and then defining for_each_monitored_cpu() macro like this:

#define for_each_monitored_cpu(cpu, nr_cpus, common) \
   for (cpu =3D 0; cpu < nr_cpus; cpu =3D next_monitored_cpu(cpu, nr_cpus, =
common))

Nevertheless, I took the patch already, and it is still better than
repeating the same code multiple times, so this is for a future
improvement.

[1] - https://en.wikipedia.org/wiki/Dangling_else



Tomas

